#' @export
cbd_torvik_player_season <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/player/season?'

  cbbdata:::execute_endpoint(base_url = base_url, ...)

}
