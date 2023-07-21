#' @export
cbd_kenpom_player_factors <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/player/factors?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
