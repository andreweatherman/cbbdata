# function for users who have not stored their user or pw in their .environ file
first_log_in <- function() {

  # set theme for emphasis
  cli::cli_div(theme = list(span.emph = list(color = "green")))

  rlang::inform(
    message = c('We notice that this is your first time logging into `cbbdata`. \nThis process will require restarting your R session. \nDo you want to continue [Y/N]')
  )

  continue <- tolower(readline(''))

  if (continue == 'y') {

    rlang::inform(
      message = c("For persistant log-in, please store your username and password inside your .REnviron file in the following form:",
                  i = "CBD_USER = YOUR_USER",
                  i = "CBD_PW = YOUR_PASS",
                  "Ensure that your username and password are NOT wrapped in quotations. Once you have set your credentials inside the file, please type any number into the console."),
      use_cli_format = TRUE
    )

    rlang::inform(
      message = c(cli::cli_text("Do not forget to {.emph SAVE} the file.")),
      use_cli_format = TRUE
    )

    # open r.environ file
    usethis::edit_r_environ()

    Sys.sleep(8)

    rlang::inform(
      message = c(cli::cli_text('{.emph Remember to type any number into the console once you have saved the file!}')),
      use_cli_format = TRUE
    )

    finished <- readline('')

    if (!is.na(as.numeric(finished))) {

      rlang::inform(
        message = c('Did you save your .Renviron file and ensure that your username and password are formated as instructed above [Y/N]'),
        use_cli_format = TRUE
      )

      saved <- tolower(readline(''))

      if (saved == 'y') {

        cli::cli_div(theme = list(span.emph = list(color = "red")))

        rlang::inform(
          message = c(cli::cli_text('{.emph Your R session will now restart. You will now be able to log-in with `cbd_login`.}')),
          use_cli_format = TRUE
        )

        Sys.sleep(5)

        # restart session
        .rs.restartR()

      }

    }

  }

}

# function to get user parameters as a list for `httr`
get_args <- function(...) {

  args <- rlang::list2(...)

  # if no arguments are included, pass return_all as TRUE
  if(length(args) == 0) {

    args <- append(args, list(return_all = TRUE))

  }

  return(args)

}

# build expression string from arguments
build_expressions <- function(data, ...) {

  args <- cbbdata:::get_args(...)

  # get valid arguments
  valid <- args[names(args) %in% colnames(data)]

  # build expressions
  expressions <- purrr:::imap(valid, ~  deparse(rlang::expr(!!(rlang::sym(.y)) ==  !!.x ) )) %>%
    purrr:::reduce(~ stringr:::str_c(.x, .y,  sep=" & ")) %>%
    parse(text = .) %>%
    magrittr::extract2(1)

  return(expressions)

}

check_key <- function() {
  # log-in user if they are not already logged in
  if (Sys.getenv('CBD_API_KEY') == '') {
    cbbdata::cbd_login()
  }
}

# build requested url
get_url <- function(base_url, ...) {

  # log-in user if they are not already logged in
  cbbdata:::check_key()

  parsed_url <- cbbdata:::get_args(..., key = Sys.getenv('CBD_API_KEY')) %>%
    purrr::pmap(list) %>%
    purrr::map_chr(~ httr::modify_url(base_url, query = .x))

  return(parsed_url)

}

# function to coerce list to data.table
to_dt <- function(data) {

  suppressWarnings({

      dt_table <- data.table::rbindlist(data)

      # convert date to date format if present in columns
      if ('date' %in% colnames(dt_table)) {

        dt_table <- dt_table[, date := fasttime::fastDate(date)]

      }

      return(dt_table)

  })

}

# function to download .parquet file from url
parquet_from_url <- function(url){
  rlang::check_installed("arrow")

  load <- try(curl::curl_fetch_memory(url), silent = TRUE)

  if (inherits(load, "try-error")) {
    cli::cli_warn("Failed to retrieve data from {.url {url}}")
    return(data.table::data.table())
  }

  content <- try(arrow::read_parquet(load$content), silent = TRUE)

  if (inherits(content, "try-error")) {
    cli::cli_warn("Failed to parse file with {.fun arrow::read_parquet()} from {.url {url}}")
    return(data.table::data.table())
  }

  data.table::setDT(content)
  return(content)
}

# function to perform url building and data retrieval
execute_endpoint <- function(base_url, ...) {

  parsed_url <- cbbdata:::get_url(base_url = base_url, ...)

  resp <- httr2::request(parsed_url) %>% httr2::req_perform()

  data <- resp %>% httr2::resp_body_json() %>% cbbdata:::to_dt()

  return(data)

}

# download parquet file from API call
get_cbd_file <- function(base_url, ...) {

  parsed_url <- cbbdata:::get_url(base_url = base_url, ...)

  data <- cbbdata:::parquet_from_url(parsed_url)

  return(data)

}

# attribute to luke benz for ncaahoopR
benz_attr <- function () {
    rlang::inform(message = c("PBP logs are provided by `ncaahoopR` and Luke Benz.\nHis package can be downloaded with:",
                              i = 'devtools::install_github("lbenz730/ncaahoopR")'),
                  .frequency = "once", .frequency_id = "benz_attr")
}

# validate input function
validate_input <- function(input, valid_values, message) {
  if (!(input %in% valid_values)) cli_abort(message)
}

# function to generate url for trank factors
generate_trank_factors_url <- function(year, q, v, t, top, start=NULL, end=NULL, conf=NULL) {

  parsed_url <- httr::modify_url(
    url = "https://barttorvik.com/trank.php",
    query = list(
      year = year,
      revquad = 0,
      quad = q,
      venue = v,
      type = t,
      top = top,
      begin = start,
      end = end,
      conyes = conf,
      csv = 1
    )
  )

  return(parsed_url)
}

