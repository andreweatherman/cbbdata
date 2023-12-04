#' Get Current Tournament Resumes
#'
#' Returns a tibble with current NCAA Tournament resume data
#'
#' @returns Returns a tibble with current resume data, including NET
#' @import dplyr
#' @import httr
#' @importFrom withr local_options
#' @importFrom rvest read_html html_table
#' @importFrom janitor clean_names
#' @importFrom purrr pluck
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_current_resume())}
#'
#' @export

cbd_torvik_current_resume <- function() {

  cbbdata:::check_key() # ensure user is logged-in

  # get current ratings to join on more info to table
  current_ratings <- cbbdata::cbd_torvik_ratings(year = 2024) %>%
    select(team, t_rank = barthag_rk, barthag, adj_o, adj_o_rk, adj_d, adj_d_rk,
           adj_t, adj_t_rk, wab)

  # scrape table
  local_options(HTTPUserAgent='CBB-DATA') # in case user on windows
  data <- suppressWarnings({
    read_html('https://barttorvik.com/tranketology-now.php') %>%
      html_table() %>%
      pluck(1) %>%
      clean_names() %>%
      filter(team != '') %>% # throw out row sep.
      mutate(team = trimws(gsub('[*0-9]', '', team))) %>% # clean team name
      rename('wab_rk' = wab) %>% # rename wab col. to join on actual wab value.
      left_join(current_ratings, by = 'team') %>%
      select(seed, team, conf, barthag, t_rank, net, elo, resume, wab_rk, wab, pwr,
             starts_with('adj')) %>%
      mutate(across(-c(team, conf), as.numeric))
  })

  return(data)

}
