cbd_kenpom_authorization <- function(password) {

  url <- 'https://www.cbbdata.com/api/auth/access/kenpom'

  # try-catch to return error response
  tryCatch({
    resp <- httr2::request(url) |>
      httr2::req_body_json(
        list(
          key = Sys.getenv('CBD_API_KEY'),
          password = password
        )
      ) |>
      httr2::req_perform()

    cat(cli::col_green('KenPom authorization granted!'))

  }, error = function(e) {rlang::inform(message = c('Invalid KenPom password! cbbdata account email MUST match KenPom account email!'), use_cli_format = TRUE)})


}
