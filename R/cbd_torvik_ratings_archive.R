#' @export
cbd_torvik_ratings_archive <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/ratings/archive?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
