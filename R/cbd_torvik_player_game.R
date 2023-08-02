#' @export
cbd_torvik_player_game <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/player/game?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
