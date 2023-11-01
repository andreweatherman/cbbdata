# synergy player offense
cbd_synergy_player_offense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/player/reports/offense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# synergy player defense
cbd_synergy_player_defense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/player/reports/defense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# player leaderboard offense
cbd_synergy_player_leaders_offense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/player/leaderboard/offense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# player leaderboard defense
cbd_synergy_player_leaders_defense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/player/leaderboard/defense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# synergy team offense
cbd_synergy_team_offense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/team/reports/offense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# synergy team defense
cbd_synergy_team_defense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/team/reports/defense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# synergy team leaders offense
cbd_synergy_team_leaders_offense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/team/leaderboard/offense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# synergy team leaders defense
cbd_synergy_team_leaders_defense <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/synergy/team/leaderboard/defense?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}

# player shots (not synergy)
cbd_player_shots <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/shots/shots?'

  data <- cbbdata:::get_cbd_file(base_url)

  return(data)

}
