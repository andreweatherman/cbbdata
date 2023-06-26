#' @export
cbd_kenpom_team_schedules <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/team/schedules?'

  data <- cbbdata:::get_cbd_file(base_url)

  return(data)

}
