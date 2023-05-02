#' @export
cbd_kenpom_team_schedules <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/kenpom/team/schedules?'

  data <- cbbdata:::get_cbd_file(base_url)

  # filter data if arguments are passed through
  if (length(cbbdata:::get_args(...)) != 0) {

    # build expression strings
    expressions <- cbbdata:::build_expressions(data, ...)

    # filter
    data <- data[eval(expressions)]

  }

  return(data)

}
