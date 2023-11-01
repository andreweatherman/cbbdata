#' KenPom Player Factors and Ranks
#'
#' Returns four factor statistics and national ranks from 2002-Present.
#'
#' Requires KenPom authorization. You can authorize with
#' `cbd_kenpom_authorization`.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on `player`, `team`, `conf`, `year`,
#'   or any other data column.
#'
#' @examples
#' \donttest{try(cbd_kenpom_player_factors(year = 2023))}
#' @export
cbd_kenpom_player_factors <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/player/factors?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
