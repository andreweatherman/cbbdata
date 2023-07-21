#' @export
cbd_synergy_team_defense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/team/reports/defense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
