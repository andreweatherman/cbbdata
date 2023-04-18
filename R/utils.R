# function to get user parameters as a list for `httr`
get_args <- function(...) {

  args <- rlang::list2(...)

  return(args)

}

# build requested url
get_url <- function(base_url, ...) {

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

        data.table::setDT(dt_table)[, date := fasttime::fastDate(date)]

      }

      return(dt_table)

  })

}


# function to perform url building and data retrieval
execute_endpoint <- function(base_url, ...) {

  parsed_url <- cbbdata:::get_url(base_url = base_url, ...)

  resp <- httr2::request(parsed_url) %>% httr2::req_perform()

  data <- resp %>% httr2::resp_body_json() %>% cbbdata:::to_dt()

  return(data)

}
