#' Authorize your account with KenPom
#'
#' Grants a user access to KenPom endpoints if they have an active KenPom
#' account.
#'
#' Your CBBData account email must match your KenPom email. Pass through your
#' KenPom password. You will be asked to reauthorize on your KenPom account
#' expiration date.
#'
#' @param password KenPom password, NOT CBBData password.
#' @export
cbd_kenpom_authorization <- function(password) {

  url <- 'https://www.cbbdata.com/api/auth/access/kenpom'

  result <- httr2::request(url) %>%
    httr2::req_body_form(
        key = Sys.getenv('CBD_API_KEY'),
        password = password
      ) |>
    httr2::req_perform() %>%
    httr2::resp_body_json()

  if(result$message == 'KenPom access granted') {
    cat(cli::col_green('KenPom authorization granted!'))
  }

  else {
    cat(cli::col_red('Invalid email or password. cbbdata email MUST match KenPom email!'))
  }

}
