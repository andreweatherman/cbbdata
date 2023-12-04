#' T-Rank Season Predictions
#'
#' Returns projected tempo, points per possesssion, total points scored,
#' and win percentage for any team schedyle at any location back to the 2014-15
#' season using Barttorvik's formulas and data.
#'
#' @returns Returns a tibble with game predictions.
#' @param team Team to predict with.
#' @param year Year to run prediction on.
#' @param date Date of game and must be a consecutive string in YYYYMMDD format
#'   (defaults to current day).
#' @param include_postseason A boolean representing whether conference
#'   tournament and other postseason games should be included in the simulation
#'   (defaults to FALSE).
#' @import dplyr
#' @importFrom httr modify_url
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_season_prediction('Duke', 2023, '20230101'))}
#'
#' @export
cbd_torvik_season_prediction <- function(team, year, date = NULL, include_postseason = FALSE) {

  cbbdata:::check_key() # ensure user is logged-in

  url <- modify_url(
    url = 'https://www.cbbdata.com/api/torvik/season/prediction?',
    query = list(
      key = Sys.getenv('CBD_API_KEY'),
      team = team,
      year = year,
      date = date,
      postseason = include_postseason
    )
  )

  data <- fromJSON(url) %>%
    mutate(date = as.Date(as.POSIXct(date / 1000, origin = "1970-01-01", tz = "UTC"), format = "%Y-%m-%d"),
           simulate_date = as.Date(date, format = '%Y%m%d'),
           year = year)

  return(data)

}
