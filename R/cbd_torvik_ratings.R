#' @export
cbd_torvik_ratings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/ratings?'

  cbbdata:::execute_endpoint(base_url = base_url, ...)

}
