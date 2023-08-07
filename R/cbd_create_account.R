#' Register for a CBBData Account
#'
#' Allows a user to create a CBBData API account to retrieve an API key
#'
#' @param username Username
#' @param email Email
#' @param password Password
#' @param confirm_password Re-enter password
#' @export
cbd_create_account <- function(username, email, password, confirm_password) {

  url <- 'https://www.cbbdata.com/api/auth/register'

  resp <- httr2::request(url) %>%
    httr2::req_body_json(
      list(
        username = username,
        email = email,
        password = password,
        confirm_password = confirm_password
      )
    ) %>%
    httr2::req_perform()

  if (httr2::resp_status(resp) == 201) {
    # return confirmation
    return(cat(cli::col_green('Account registered! Use `cbd_login` to get your API key.')))

  }

  else if (httr2::resp_status(resp) != 201) {
    return(cat(cli::col_br_red('Incorrect username or password!')))
  }

}
