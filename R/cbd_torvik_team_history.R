#' Four Factor Team Histories
#'
#' Returns a tibble with four factor team his
#'
#' @returns Returns a tibble with four factor history.
#' @param team team
#' @import dplyr
#' @import httr
#' @importFrom withr local_options
#' @importFrom rvest read_html html_table
#' @importFrom readr parse_number
#' @importFrom janitor clean_names
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_team_history(team = 'Duke'))}
#'
#' @export

cbd_torvik_team_history <- function(team) {
  suppressWarnings({

    local_options(HTTPUserAgent='CBB-DATA') # in case user on windows

    # prep team name for url
    team <- gsub(" ", "+", team)

    data <- read_html(paste0("https://barttorvik.com/team-history.php?team=", team)) %>%
      html_table() %>%
      pluck(1) %>%
      clean_names() %>%
      # clean the cols.
      separate(coach, into = c("coach", "more"), sep = "(?<=[a-z.])\\s*(?=[0-9])") %>%
      separate(more, into = c("seed", "finish"), sep = ",") %>%
      separate(rec, into = c("ov_rec", "conf_rec"), sep = "[\\(\\)]") %>%
      mutate(across(c(5, 7), ~trimws(.))) %>%
      mutate(
        seed = parse_number(seed),
        across(c(1, 2, 4, 9:22), as.numeric)
      ) %>%
      rename(
        "two_pct" = 20,
        "two_pct_d" = 21,
        "three_pct" = 22
      )
    return(data)
  })
}
