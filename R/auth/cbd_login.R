
cbd_login <- function(username, password) {

  url <- 'http://www.cbbdata.com/api/auth/login'

  resp <- httr2::request(url) |>
    httr2::req_body_json(
      list(
        email = username,
        password = password
      )
    ) |>
    httr2::req_perform()

  if (httr2::resp_status(resp) == 200) {
    api_key <- resp |>
      httr2::resp_body_json() |>
      purrr::pluck(1)

    # set as environment variable
    Sys.setenv(CBD_API_KEY = api_key)

    # return confirmation
    return(cat(cli::col_green('API Key set!')))

  }

  else if (httr2::resp_status(resp) != 200) {
    return(cat(error_format('Incorrect username or password!')))
  }

}
