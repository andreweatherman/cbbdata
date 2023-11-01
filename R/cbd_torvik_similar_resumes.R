#' Similar Team Resumes
#'
#' Find which teams share similar pre-tournament resumes (2008-present).
#'
#' @returns Returns a tibble with pre-tournament resumes
#' @param team Chosen team
#' @param year Chosen year
#' @param conf_group Filter by conference or conference groups (accepts any
#'   conference abbreviation, 'NCAA', 'Himajor', or 'mid').
#' @param at_large_only Boolean to filter on at-large teams only (defaults to
#'   FALSE).
#' @param current_resume Boolean to filter on whether to use projected resume or
#'   current resume (defaults to projected resume; FALSE).
#' @param net_weight Weight to assign NET ranking (defaults to 1).
#' @param resume_weight Weight to assign resume (defaults to 1).
#' @param wab_weight Weight to assign 'Wins Above Bubble' (WAB) (defaults to 1).
#' @param elo_weight Weight to assign ELO (defaults to 1).
#' @param power_weight Weight to assign power rating (defaults to 1).
#' @import dplyr
#' @import httr
#' @importFrom withr local_options
#' @importFrom rvest read_html html_table
#' @importFrom cli cli_abort
#' @importFrom janitor clean_names
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_similar_resumes('Duke', 2023))}
#'
#' @export
cbd_torvik_similar_resumes <- function(team,
                                       year,
                                       conf_limit = 'All',
                                       at_large_only = FALSE,
                                       current_resume = FALSE,
                                       net_weight = 1,
                                       resume_weight = 1,
                                       wab_weight = 1,
                                       elo_weight = 1,
                                       power_weight = 1) {

  # build url to parse
  url <- modify_url(
    url = 'https://barttorvik.com/resume-compare.php?',
    query = list(
      team = team,
      year = year,
      conlimit = conf_limit,
      atlonly = ifelse(at_large_only = TRUE, 1, 0),
      now = ifelse(current_resume == TRUE, 1, 0),
      net = net_weight,
      resume = resume_weight,
      elo = elo_weight,
      power = power_weight
    )
  )

  # scrape table
  local_options(HTTPUserAgent='CBB-DATA') # in case user on windows
  suppressWarnings({
  data <- read_html(url) %>%
    html_table() %>%
    pluck(2) %>%
    janitor::clean_names() %>%
    select(-last_col()) %>% # throw out last column // junk
    slice(1:(n()-1)) %>% # drop last row
    mutate(across(year:seed, ~as.numeric(.x)))
  })


  return(data)

}
