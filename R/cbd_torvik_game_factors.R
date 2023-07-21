#' @export
cbd_torvik_game_factors <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/game/factors?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
