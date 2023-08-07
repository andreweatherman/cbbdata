#' Year-End T-Rank Ratings
#'
#' Pulls year-end T-Rank ratings and adjusted efficiencies from 2008-Present.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, `year`, or any
#'   other data column.
#'
#' @export
cbd_torvik_ratings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/ratings?'

  cbbdata:::execute_endpoint(base_url = base_url, ...)

}
