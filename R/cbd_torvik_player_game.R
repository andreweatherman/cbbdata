#' Barttorvik Player Game Logs
#'
#' Pulls final player game logs from 2008-Present.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `year`, `team`, `player`,or any
#'   other data column.
#'
#' @export
cbd_torvik_player_game <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/player/game?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
