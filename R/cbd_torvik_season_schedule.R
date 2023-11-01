#' Barttorvik Season Schedules
#'
#' Pulls season schedules from Barttorvik
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function.
#'
#' @examples
#' \donttest{try(cbd_torvik_season_schedule(year = 2023))}
#'
#' @export
cbd_torvik_season_schedule <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/schedules?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
