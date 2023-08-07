#' CBBData Player Database
#'
#' Pulls side-wide player IDs and meta data.
#'
#' @param ... OPTIONAL. To load the complete data set, pass no arguments through
#'   to the function. Else, you can filter on  `year`, `team`, or any other data
#'   column.
#'
#' @export
cbd_players <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/data/players?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
