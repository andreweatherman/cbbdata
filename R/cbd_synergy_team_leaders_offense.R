#' @export
cbd_synergy_team_leaders_offense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/team/leaderboard/offense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
