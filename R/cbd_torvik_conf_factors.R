#' Four Factor Conference Splits
#'
#' Split conference-wide four factor data on a number of variables.
#'
#' @returns Returns a tibble with four factor (and other!) data.
#' @param year Chosen year
#' @param venue Game venue ('all', 'home', 'away', 'neutral', 'road'). Defaults
#'   to 'all'.
#' @param game_type Game type ('all', 'nc', 'conf', 'reg', 'post', 'ncaa').
#'   Defaults to 'all'.
#' @param quad Quad. rank of game ('1', '2', '3', '4', 'all') and quads are
#'   cumulative (games <= quad selection). Defaults to 'all', which is all games
#'   (all games Q4 or "better"/"lower").
#' @param top Games against Top X opponents. Defaults to 0, which is "all"
#'   games.
#' @param start Game start date (YYYYMMDD format).
#' @param end Game end date (YYYYMMDD format).
#' @import dplyr
#' @import httr
#' @importFrom withr local_options
#' @importFrom cli cli_abort
#' @importFrom readr read_csv
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_conf_factors(2023, start = '20230101'))}
#'
#' @export
cbd_torvik_conf_factors <- function(year, venue = "all", game_type = "all", quad = "all", top = 0, start = NULL, end = NULL) {

  suppressWarnings({
    # default PC user-agent gets blocked on barttorvik.com
    local_options(HTTPUserAgent='CBB-DATA')

    if (!(is.numeric(year) && nchar(year) == 4 && year >= 2008)) {
      cli_abort("Enter a valid year as a number (YYYY). Data only goes back to 2008!")
    }

    cbbdata:::validate_input(venue, c('all', 'home', 'away', 'neutral', 'road'), "Please input correct venue value (see details)")
    cbbdata:::validate_input(game_type, c('all', 'nc', 'conf', 'reg', 'post', 'ncaa'), "Please input correct type value (see details)")
    cbbdata:::validate_input(quad, c('1', '2', '3', '4', 'all'), "Please input correct quad value (see details)")

    # convert args. to url naming conventions
    v <- switch(venue, all = "All", home = "H", away = "A", neutral = "N", road = "A-N")
    t <- switch(game_type, all = "All", nc = "N", conf = "C", reg = "R", post = "P", ncaa = "T")
    q <- switch(quad, '1' = "1", '2' = "2", '3' = "3", '4' = "4", 'all' = "5")

    # build url
    data_url <- cbbdata:::generate_trank_factors_url(year, q, v, t, top, start, end, conf = 1)

    # set vector w/ header names // I don't know what some of these columns are referring to
    data_names <- c("conf", "adj_o", "adj_d", "barthag", "drop", "wins", "games", "efg", "def_efg", "ftr", "def_ftr",
                    "tov_rate", "def_tov_rate", "oreb_rate", "dreb_rate", "drop2", "two_pt_pct", "def_two_pt_pct", "three_pt_pct",
                    "def_three_pt_pct", "block_rate", "block_rate_allowed", "assist_rate", "def_assist_rate", "three_fg_rate",
                    "def_three_fg_rate", "adj_t", "drop3", "drop4", "drop5", "year", "drop6", "drop7", "drop8", "wab", "ft_pct", "def_ft_pct")

    data <- read_csv(data_url, col_names = FALSE, show_col_types = FALSE) %>%
      setNames(data_names)

    data <- data %>%
      mutate(losses = games - wins) %>%
      # reorder cols.
      select(conf, games, wins, losses, adj_t, adj_o, adj_d, barthag, efg, def_efg, ftr, def_ftr,
                    oreb_rate, dreb_rate, tov_rate, def_tov_rate, two_pt_pct, three_pt_pct, ft_pct, def_two_pt_pct,
                    def_three_pt_pct, def_ft_pct, three_fg_rate, def_three_fg_rate, block_rate, block_rate_allowed,
                    assist_rate, def_assist_rate, wab, year) %>%
      arrange(desc(barthag))

    return(data)
  })

}
