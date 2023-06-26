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
