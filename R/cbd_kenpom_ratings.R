# requires kenpom authentication
#' @export
cbd_kenpom_ratings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/ratings?'

  cbbdata:::execute_endpoint(base_url = base_url, ...)

}
