#' Barttorvik Player Season Averages
#'
#' Pulls final player season averages from 2008-Present.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `year`, `team`, `player`,or any
#'   other data column.
#'
#' @examples
#' \donttest{try(cbd_torvik_player_season(year = 2023, team = 'Duke'))}
#' @export
cbd_torvik_player_season <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/player/season?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
