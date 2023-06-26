#' @export
cbd_login <- function(username = Sys.getenv('CBD_USER'), password = Sys.getenv('CBD_PW')) {

  if (username == '' | password == '') {
    cbbdata:::first_log_in()
  }

  url <- 'https://www.cbbdata.com/api/auth/login'

  # try-catch to return error response
  tryCatch({
    resp <- httr2::request(url) %>%
      httr2::req_body_json(
        list(
          username = username,
          password = password
        )
      ) %>%
      httr2::req_perform()
  }, error = function(e) {rlang::inform(message = 'Invalid username or password!')})

  api_key <- resp %>%
    httr2::resp_body_json() %>%
    purrr::pluck(1)

  # set as environment variable
  Sys.setenv(CBD_API_KEY = api_key)

  # return confirmation
  return(cat(cli::col_green('API Key set!')))

}
