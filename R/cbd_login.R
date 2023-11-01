#' Log-In to CBBData API
#'
#' Retrieves a user's CBBData API key.
#'
#' If you are unsure on how to edit your `.Renviron` file, pass no arguments
#' through the function; it will walk you through the process and create a
#' persistent log-in. Else, pass your username and password through the function
#' to log-in for the current session only.
#'
#' @param username Username
#' @param password Password
#' @import httr2
#' @importFrom rlang inform
#' @importFrom purrr pluck
#' @importFrom cli col_green
#' @export
cbd_login <- function(username = Sys.getenv('CBD_USER'), password = Sys.getenv('CBD_PW')) {

  if (username == '' | password == '') {
    cbbdata:::first_log_in()
  }

  url <- 'https://www.cbbdata.com/api/auth/login'

  # try-catch to return error response
  tryCatch({
    resp <- request(url) %>%
      req_body_json(
        list(
          username = username,
          password = password
        )
      ) %>%
      req_perform()
  }, error = function(e) {inform(message = 'Invalid username or password!')})

  api_key <- resp %>%
    resp_body_json() %>%
    pluck(1)

  # set as environment variable
  Sys.setenv(CBD_API_KEY = api_key)

  # return confirmation
  return(cat(col_green('API Key set!')))

}
