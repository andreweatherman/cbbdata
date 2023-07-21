#' @export
cbd_synergy_player_leaders_offense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/player/leaderboard/offense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
