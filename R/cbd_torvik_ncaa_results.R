#' Get NCAA Tournament Results
#'
#' Returns a tibble with raw and adjusted NCAA tournament results by team,
#' coach, conference, or seed. Data runs from 2000-present.
#'
#' \itemize{\item PASE is the number of wins above or below seed expecation.
#' \item PAKE is the number of wins above or below KenPom expectation.}
#'
#' @returns Returns a tibble of adjusted and raw tournament results.
#' @param min_year Minimum year to pull (YYYY)
#' @param max_year Maximum year to pull (YYYY).
#' @param type Data split value, defaults to team ('team', 'coach', 'conf',
#'   'seed').
#' @import dplyr
#' @import httr
#' @importFrom withr local_options
#' @importFrom rvest read_html html_table
#' @importFrom janitor clean_names
#' @importFrom cli cli_abort
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_ncaa_results(min_year=2010, max_year=2015, type='conf'))}
#'
#' @export

cbd_torvik_ncaa_results <- function(min_year, max_year, type = 'team') {

  # type must match
  if(!type %in% c('team', 'conf', 'coach', 'seed')) {
        cli_abort(c('Unsupported `type`.',
                   'i' = 'Type must be one of: team, conf, coach, or seed.',
                   'x' = 'You called `type = {type}`'))
  }

  # build url to parse
  url <- modify_url(
    url = 'https://barttorvik.com/cgi-bin/ncaat.cgi',
    query = list(
      yrlow = min_year,
      yrhigh = max_year,
      type = type
    )
  )

  # scrape table
  local_options(HTTPUserAgent='CBB-DATA') # in case user on windows
  data <- suppressWarnings({
    read_html(url) %>%
      html_table() %>%
      pluck(1) %>%
      clean_names() %>%
      mutate(across(-2, ~ as.numeric(.x)),
             min_year = min_year,
             max_year = max_year)
  })

  return(data)

}
