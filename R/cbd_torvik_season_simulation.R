#' T-Rank Season Simulation
#'
#' Run a simulation to determine how many games a team is projected to win using
#' their schedule at any given date in the season.
#'
#' @returns Returns a tibble with simulation results.
#' @param team Team to predict with.
#' @param year Year to run prediction on.
#' @param date Date of game and must be a consecutive string in YYYYMMDD format
#'   (defaults to current day).
#' @param simulations An integer representing how many sims. to run (defaults to
#'   10,000).
#' @import dplyr
#' @importFrom httr modify_url
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_season_simulation('Duke', 2023, '20230101'))}
#'
#' @export
cbd_torvik_season_simulation <- function(team, year, date, simulations = 10000) {

  cbbdata:::check_key() # ensure user is logged-in

  url <- modify_url(
    url = 'https://www.cbbdata.com/api/torvik/season/simulation?',
    query = list(
      key = Sys.getenv('CBD_API_KEY'),
      team = team,
      year = year,
      date = date,
      num_simulations = simulations
    )
  )

  data <- fromJSON(url) %>%
    mutate(simulate_date = as.Date(date, format = '%Y%m%d'),
           simulations = simulations,
           team = team,
           year = year)

  return(data)

}
