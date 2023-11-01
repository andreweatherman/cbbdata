#' Get Selection Sunday Resumes
#'
#' Returns a tibble with various resume-based metrics through Selection Sunday.
#' Data runs from 2008-present.
#'
#' @returns Returns a tibble with resume-based metrics.
#' @param n Number of teams to return (defaults to 500).
#' @param min_year Minimum year to pull (YYYY).
#' @param max_year Maximum year to pull (YYYY).
#' @param min_net Minimum NET to filter.
#' @param max_net Maximum NET to filter.
#' @param conf_group Filter by conference or conference groups (accepts any
#'   conference abbreviation, 'NCAA', 'Himajor', or 'mid').
#' @import dplyr
#' @import httr
#' @importFrom withr local_options
#' @importFrom rvest read_html html_table
#' @importFrom cli cli_abort
#' @importFrom janitor clean_names
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_resume_database(min_net = 1, max_net = 5))}
#'
#' @export

cbd_torvik_resume_database <- function(n = 500, min_year = 2008, max_year = 2024,
                                       min_net = NULL, max_net = NULL, conf_group = NULL) {

  # conference group must be valid
  if(!is.null(conf_group) && (!conf_group %in% c('All', 'NCAA', 'Himajor', 'mid'))) {
    cli_abort(c('Unsupported `conf_group`.',
                     'i' = 'conf_group must be one of: All, NCAA, Himajor, or mid.',
                     'x' = 'You called `conf_group = {conf_group}`'))
  }

  url <- modify_url(
    url = 'https://barttorvik.com/resume-compare-all.php?',
    query = list(
      start = min_year,
      end = max_year,
      netlow = min_net,
      nethigh = max_net,
      maxct = n,
      conlimit = conf_group
    )
  )

  # scrape table
  local_options(HTTPUserAgent='CBB-DATA') # in case user on windows
  data <- suppressWarnings({
    read_html(url) %>%
      html_table() %>%
      pluck(2) %>%
      clean_names() %>%
      rename('games_above_500' = x500,
             'q2_w' = q2w)
  })

  return(data)

}
