#' T-Rank Game Predictions
#'
#' Returns projected tempo, points per possesssion, total points scored,
#' and win percentage for any matchup at any location back to the 2014-15
#' season using Barttorvik's formulas and data.
#'
#' @returns Returns a tibble with game predictions.
#' @param team Team 1 in matchup (primary team)
#' @param opp Team 2 in matchup (opponent)
#' @param date Date of game and must be a consecutive string in YYYYMMDD format
#'   (defaults to current day)
#' @param location Location of game relative to `team` ('H', 'A', or 'N'),
#'   defaults to 'H' (home)
#' @import dplyr
#' @importFrom httr modify_url
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_game_prediction('Duke', 'Charlotte', '20221110'))}
#'
#' @export
cbd_torvik_game_prediction <- function(team, opp, date = NULL, location = 'H') {

  cbbdata:::check_key() # ensure user is logged-in

  url <- modify_url(
    url = 'https://www.cbbdata.com/api/torvik/game/prediction?',
    query = list(
      key = Sys.getenv('CBD_API_KEY'),
      team = team,
      opp = opp,
      date = date,
      location = location
    )
  )

  data <- fromJSON(url)

  data <- tryCatch({
    data <- data %>%
      mutate(date = as.Date(as.POSIXct(date / 1000, origin = "1970-01-01", tz = "UTC"), format = "%Y-%m-%d"))
  }, error = function(e) {
    data <- data %>%
      mutate(date=as.Date(date, '%Y%m%d'))
  })

  return(data)

}
