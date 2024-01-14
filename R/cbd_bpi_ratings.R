#' BPI Ratings and ESPN Projections
#'
#' Pulls current BPI ratings and ESPN season and tournament projections.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team` or `conf`.
#'                                                                         |
#' @examples
#' \donttest{try(cbd_bpi_ratings(conf = 'ACC'))}
#' @export
cbd_bpi_ratings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/espn/bpi?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
