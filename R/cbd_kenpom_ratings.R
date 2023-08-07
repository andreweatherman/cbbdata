#' Year-End KenPom Ratings
#'
#' Pulls year-end KenPom ratings and adjusted efficiencies from 2001-Present.
#'
#' Requires KenPom authorization. You can authorize with
#' `cbd_kenpom_authorization`.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, `year`, or any
#'   other data column.
#'
#' @export
cbd_kenpom_ratings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/ratings?'

  cbbdata:::execute_endpoint(base_url = base_url, ...)

}
