#' Get Committee Tournament Sheets
#'
#' Returns a tibble with similar quality and resume metrics used by the NCAA
#' seeding committee. Data runs from 2019-present.
#'
#' @returns Returns a tibble with 16 columns:
#' \describe{
#'   \item{\code{team}}{character.}
#'   \item{\code{seed}}{double.}
#'   \item{\code{net}}{double. NCAA Net Ranking.}
#'   \item{\code{kpi_resume}}{double. KPI by Kevin Pauga. A resume metric.}
#'   \item{\code{sor_resume}}{double. Strength of record. A resume metric.}
#'   \item{\code{avg_resume}}{double. Average of resume rankings (NET, KPI, and
#'   SOR).}
#'   \item{\code{bpi_quality}}{double. BPI by ESPN. A quality metric.}
#'   \item{\code{kp_quality}}{double. KenPom ranking. A quality metric.}
#'   \item{\code{sag_quality}}{double. Sagarin ranking. A quality metrc.}
#'   \item{\code{avg_quality}}{double. Average of quality rankings (BPI, KP, and
#'   Sag).}
#'   \item{\code{q1a}}{character. Q1-A record.}
#'   \item{\code{q1}}{character. Q1 record. Home games vs. 1-30, neutral games
#'   vs. 1-50 teams, road games vs. 1-75 (NET rankings)}
#'   \item{\code{q2}}{character. Q2 record. Home games vs. 31-75, neutral games
#'   vs. 51-100, road games vs. 76-135 (NET rankings)}
#'   \item{\code{q1_2}}{character. Combined Q1 + Q2 record.}
#'   \item{\code{q3}}{character. Q3 record. Home games vs. 76-160, neutral games
#'   vs. 101-200, road games vs. 136-240 (NET rankings)}
#'   \item{\code{q4}}{character. Q4 record. Home games vs. 161-351, neutral
#'   games vs. 201-351, road games vs. 241-351 (NET rankings)}
#' }
#' @param year Defaults to current season (YYYY).
#' @import dplyr
#' @importFrom withr local_options
#' @importFrom rvest read_html html_table
#' @importFrom cli cli_abort
#' @importFrom purrr pluck
#' @importFrom tidyr separate
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_ncaa_sheets(year=2019))}
#'
#' @export
cbd_torvik_ncaa_sheets <- function(year) {

  # data only back to 2019
  if(year < 2019) {
         cli_abort(c('Unsupported `year`.',
                     'i' = 'Data only goes back to 2019.',
                     'x' = 'You requested `year = {year}`'))
  }

  # scrape
  local_options(HTTPUserAgent='CBB-DATA') # in case user on windows
  data <- suppressWarnings({
    read_html(glue('https://barttorvik.com/teamsheets.php?year={year}')) %>%
      html_table() %>%
      pluck(1) %>%
      setNames(c('rank', 'team', 'net', 'kpi_resume', 'sor_resume', 'avg_resume',
                 'bpi_quality', 'kp_quality', 'sag_quality', 'avg_quality',
                 'quad_1a', 'quad_1', 'quad_2', 'quad_1_and_2', 'quad_3', 'quad_4')) %>%
      slice(-1) %>% # drop first row // junk
      separate(team, into = c('team', 'seed'), sep = "(?<=\\D) (?=\\d)", convert = TRUE) # add seed
  })

  return(data)
}
