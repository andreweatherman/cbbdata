#' Day-to-day KenPom Ratings
#'
#' Historical KenPom ratings + rankings from 2012-Present.
#'
#' Requires KenPom authorization. You can authorize with
#' `cbd_kenpom_authorization`.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, `year`, or any
#'   other data column.
#'
#' @examples
#' \donttest{try(cbd_kenpom_ratings_archive(year = 2023))}
#' @export
cbd_kenpom_ratings_archive <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/ratings/archive?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
