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
#' @param include_postseason A boolean representing whether conference
#'   tournament and other postseason games should be included in the simulation
#'   (defaults to FALSE).
#' @import dplyr
#' @importFrom httr modify_url
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>%
#' @importFrom lubridate month
#' @examples
#' \donttest{try(cbd_torvik_season_simulation('Duke', 2023, date = '20230101'))}
#'
#' @export
cbd_torvik_season_simulation <- function(team, year, simulations = 10000, date = NULL,
                                         include_postseason = FALSE) {

  cbbdata:::check_key() # ensure user is logged-in

  if(is.null(date) & lubridate::month(Sys.Date()) %in% c(11:12, 1:4)) { date = gsub('-', '', Sys.Date() - 1) } else (date = cbbdata::last_sim_dates[as.character(year)])
  

  url <- modify_url(
    url = 'https://www.cbbdata.com/api/torvik/season/simulation?',
    query = list(
      key = Sys.getenv('CBD_API_KEY'),
      team = team,
      year = year,
      date = gsub('-', '', date),
      num_simulations = simulations,
      postseason = include_postseason
    )
  )

  data <- fromJSON(url) %>%
    mutate(simulate_date = as.Date(date, format = '%Y%m%d'),
           simulations = simulations,
           team = team,
           year = year)

  return(data)

}
