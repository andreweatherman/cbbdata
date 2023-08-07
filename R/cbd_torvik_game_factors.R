#' Barttorvik Game Four Factors
#'
#' Pulls final game four factors stats from 2008-Present.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `year`, `team`, `date`, `conf`,
#'   or any other data column.
#'
#' @export
cbd_torvik_game_factors <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/game/factors?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
