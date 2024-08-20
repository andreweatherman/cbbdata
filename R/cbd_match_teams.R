#' Generate a team matching dictionary
#'
#' A utility function that returns a named vector to be used as a matching
#' dictionary.
#'
#' @examples
#' \donttest{try(cbd_match_teams()['Duke Blue Devils'])}
#' @export

cbd_match_teams <- function() {

  teams <- cbbdata::cbd_teams() %>%
    dplyr::select(-c(arena_lon, arena_lat, espn_logo, espn_dark_logo, logo, wordmark, color, alt_color, primary_arena, capacity, arena_elevation, arena_elevation_rank))  %>%
    tidyr::pivot_longer(-common_team)

  team_matching <- teams %>% dplyr::pull('common_team') %>%
    rlang::set_names(teams$value)

  return(team_matching)

}
