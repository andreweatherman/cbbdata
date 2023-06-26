#' Day-to-day KenPom Ratings
#'
#' Historical KenPom ratings + rankings from 2012-Present. Requires KenPom
#' authorization. You can authorize with `cbd_kenpom_authorization`.
#'
#' To load the complete data set, pass no arguments through to the function.
#' Else, your data will be filtered by your selections.
#'
#' @export
cbd_kenpom_ratings_archive <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/ratings/archive?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
