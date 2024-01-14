#' Year-End KenPom Ratings
#'
#' Pulls year-end KenPom ratings and adjusted efficiencies from 2001-Present.
#'
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, `year`, or any
#'   other data column.
#'                                                                         |
#' @examples
#' \donttest{try(cbd_kenpom_ratings(year = 2023))}
#' @export
cbd_kenpom_ratings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/ratings?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
