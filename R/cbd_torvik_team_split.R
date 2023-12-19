#' Barttorvik Team Stat Splits
#'
#' Pulls final team season averages by split from 2008-Present.
#'
#' @param split The data will default to splitting on game result. If you want
#'   to split on a different level, you must specify. You can split on
#'   `location`, `game_type`, `month`, or `game_result`.
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `year`, `team`, `conf`, or any
#'   other data column.
#' @importFrom glue glue
#'
#' @examples
#' \donttest{try(cbd_torvik_team_split(year = 2023, split = 'month'))}
#'
#' @export
cbd_torvik_team_split <- function(split, ...) {

  base_url <-  glue('https://www.cbbdata.com/api/torvik/team/splits?split={split}')

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
