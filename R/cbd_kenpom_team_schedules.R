#' KenPom Team Schedules
#'
#' Pulls the KenPom team schedule page from 2002-Present.
#'
#' Requires KenPom authorization. You can authorize with
#' `cbd_kenpom_authorization`.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `year`, `date` or any
#'   other data column.
#' @examples
#' \donttest{try(cbd_kenpom_team_schedules(year = 2023, team = 'Duke'))}
#' @export
cbd_kenpom_team_schedules <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/team/schedules?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
