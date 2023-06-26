#' @export
cbd_torvik_player_season <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/player/season?'

  data <- cbbdata:::get_cbd_file(base_url)

  return(data)

}
