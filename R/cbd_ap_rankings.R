#' AP Poll History
#'
#' Pulls AP poll history from 1949-Present
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, or `year`.
#'
#' @examples
#' \donttest{try(cbd_ap_polls(team = "Duke"))}
#' @export
cbd_ap_rankings <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/rankings/ap?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
