# function to create an account for cbbdata
# one account per email, only; will fail if re-using email!
# password is securely hashed in the database and is not exposed
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
