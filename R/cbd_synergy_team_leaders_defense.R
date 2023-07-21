#' @export
cbd_synergy_team_leaders_defense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/team/leaderboard/defense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
