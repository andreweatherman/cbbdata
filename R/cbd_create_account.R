#' Register for a CBBData Account
#'
#' Allows a user to create a CBBData API account to retrieve an API key
#'
#' @param username Username
#' @param email Email
#' @param password Password
#' @param confirm_password Re-enter password
#' @import httr2
#' @importFrom cli col_green col_br_red
#' @export
cbd_create_account <- function(username, email, password, confirm_password) {

  url <- 'https://www.cbbdata.com/api/auth/register'

  resp <- request(url) %>%
    req_body_json(
      list(
        username = username,
        email = email,
        password = password,
        confirm_password = confirm_password
      )
    ) %>%
    req_perform()

  if (resp_status(resp) == 201) {
    # return confirmation
    return(cat(col_green('Account registered! Use `cbd_login` to get your API key.')))

  }

  else if (resp_status(resp) != 201) {
    return(cat(col_br_red('Incorrect username or password!')))
  }

}
