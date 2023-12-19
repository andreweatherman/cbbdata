#' Get Current Tournament Resumes
#'
#' Returns a tibble with current NCAA Tournament resume data
#'
#' @returns Returns a tibble with the following columns:
  #' |**Column**   |**Description**                                                     |
  #' |:--------|:---------------------------------------------------------------|
  #' |seed     |NCAA Seed                                                       |
  #' |team     |Team                                                            |
  #' |conf     |Conference                                                      |
  #' |barthag  |Barthag rating (prob. of beating average team on neutral court) |
  #' |t_rank   |Barthag rank                                                    |
  #' |net      |NCAA Net rank                                                   |
  #' |elo      |ELO rank (Barttorvik)                                           |
  #' |resume   |Resume rank (Barttorvik)                                        |
  #' |wab_rk   |Wins Above Bubble raking                                        |
  #' |wab      |Wins above/below bubble team expectation                        |
  #' |quad1    |Quad 1 record (current)                                         |
  #' |quad2    |Quad 2 record (current)                                         |
  #' |quad3    |Quad 3 record (current)                                         |
  #' |quad4    |Quad 4 record (current)                                         |
  #' |adj_o    |Adjusted offense (points per 100 possessions)                   |
  #' |adj_o_rk |Adjusted offense rank                                           |
  #' |adj_d    |Adjusted defense (points allowed per 100 possessions)           |
  #' |adj_d_rk |Adjusted defense rank                                           |
  #' |adj_t    |Adjusted tempo (possessions per game)                           |
  #' |adj_t_rk |Adjusted tempo rank                                             |
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

  # get actual net with full teams (not all teams in tranketology)
  local_options(HTTPUserAgent='CBB-DATA') # in case user on windows
  current_net <- read_html('https://barttorvik.com/net4cast.php?conlimit=All&now=1') %>%
    html_table() %>%
    pluck(1) %>%
    clean_names() %>%
    select(net = now, team, quad1, quad2, quad3, quad4)

  # scrape table
  data <- suppressWarnings({
    read_html('https://barttorvik.com/tranketology-now.php') %>%
      html_table() %>%
      pluck(1) %>%
      clean_names() %>%
      filter(!team %in% c('', 'First Teams Out')) %>% # throw out row sep.
      mutate(team = trimws(gsub('[*0-9]', '', team)),
             team = trimws(gsub(" FO| NO", '', team))) %>% # clean team name
      rename('wab_rk' = wab) %>% # rename wab col. to join on actual wab value.
      mutate(across(-c(team, conf), as.numeric)) %>%
      full_join(current_net, by = 'team') %>% # add current net
      left_join(current_ratings, by = 'team') %>% # add on trank data
      select(seed, team, conf, barthag, t_rank, net = net.y, elo, resume, wab_rk, wab,
             starts_with('quad'), starts_with('adj'))
  })

  return(data)

}
