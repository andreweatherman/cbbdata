#' @export
cbd_players <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/data/players?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
