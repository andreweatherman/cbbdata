#' Day-to-day T-Rank Ratings
#'
#' Historical T-Rank ratings + rankings from 2015-Present.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, `year`, or any
#'   other data column.
#'
#' @examples
#' \donttest{try(cbd_torvik_ratings_archive(year = 2023, conf = 'ACC'))}
#' @export
cbd_torvik_ratings_archive <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/ratings/archive?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
