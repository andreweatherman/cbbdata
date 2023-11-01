#' CBBData Team Database
#'
#' Pulls team matching dictionary + logos, colors, and wordmarks.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function.
#'
#' @examples
#' \donttest{try(cbd_teams())}
#' @export
cbd_teams <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/data/teams?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
