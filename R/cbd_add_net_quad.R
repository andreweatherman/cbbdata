#' Add Net Rankings and Quadrants to Data
#'
#' A utility function for adding current NET rankings and quadrant boundaries to
#' data.
#'
#' @param df Data frame to alter
#' @param net_team_col A column of team names which should be used to match
#'   against current NET rankings
#' @param net_col The name of your NET column (or the name to call the new NET
#'   column)
#' @param location_col The name of your game location column
#' @param add_net Should NET rankings first be added to your data? Set to FALSE
#'   if you already have NET rankings and reference that column name in
#'   `net_col.` Defaults to TRUE.
#'
#' @export

cbd_add_net_quad <- function(df, net_team_col = opp, net_col = net, location_col = location,
                     add_net = TRUE) {

  # convert string inputs to symbols
  location_col <- ensym(location_col)
  net_col <- ensym(net_col)
  net_team_col <- ensym(net_team_col)

  # if add_net is true, grab net rankings and join to data on net_team_col var.
  if(add_net) {
    net_data <- cbd_torvik_current_resume() %>%
      select(!! net_team_col := team, !! net_col := net)

    # join over the data on the `net_team_col` variable
    df <- df %>%
      left_join(net_data, by = as.character(net_team_col))
  }

  # define quadrants
  df <- df %>%
    mutate(quad = case_when(
      .data[[net_col]] <= ifelse(.data[[location_col]] == "H", 30, ifelse(.data[[location_col]] == "N", 50, 75)) ~ "Quadrant 1",
      .data[[net_col]] > ifelse(.data[[location_col]] == "H", 30, ifelse(.data[[location_col]] == "N", 50, 75)) &
        .data[[net_col]] <= ifelse(.data[[location_col]] == "H", 75, ifelse(.data[[location_col]] == "N", 100, 135)) ~ "Quadrant 2",
      .data[[net_col]] > ifelse(.data[[location_col]] == "H", 75, ifelse(.data[[location_col]] == "N", 100, 135)) &
        .data[[net_col]] <= ifelse(.data[[location_col]] == "H", 160, ifelse(.data[[location_col]] == "N", 200, 240)) ~ "Quadrant 3",
      .data[[net_col]] > ifelse(.data[[location_col]] == "H", 160, ifelse(.data[[location_col]] == "N", 200, 240)) ~ "Quadrant 4"
    ))

  return(df)
}

