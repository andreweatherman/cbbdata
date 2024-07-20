#' Daily NET Rankings
#'
#' Pulls daily NET rankings along with other metrics from the 2023-24 season.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `team`, `conf`, or `year`.
#'
#' @examples
#' \donttest{try(cbd_net_archive(team = "Duke"))}
#' @export
cbd_net_archive <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/etc/archive-net?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
