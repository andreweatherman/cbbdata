#' Year-End T-Rank Ratings
#'
#' Pulls year-end T-Rank ratings and adjusted efficiencies from 2008-Present.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, or `year`.
#'
#' @examples
#' \donttest{try(cbd_torvik_ratings(year = 2023))}
#' @export
cbd_torvik_ratings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/ratings?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
