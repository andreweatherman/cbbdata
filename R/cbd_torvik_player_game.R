#' @export
cbd_torvik_player_game <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/player/game?'

  cbbdata:::execute_endpoint(base_url = base_url, ...)

}
