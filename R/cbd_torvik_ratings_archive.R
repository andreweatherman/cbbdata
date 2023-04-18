#' @export
cbd_torvik_ratings_archive <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/ratings/archive?'

  cbbdata:::execute_endpoint(base_url = base_url, ...)

}
