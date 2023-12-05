#' Render in Logo-Team HTML for Tables
#'
#' Appends a column with HTML that will render in team logos and names
#' for table plotting.
#'
#' I really hate putting team logos and names in separate columns,
#' and this helper function will add team logos or wordmarks and create
#' the HTML code to render in logos and teams in the same column for tables.
#' If you are using `gt` to plot, you must use `fmt_markdown(team_logo)` to
#' render in the HTML. Set `logo_column` to your `team` variable if you wish
#' to overwrite your `team` column with the logo HTML.
#'
#' @returns Returns data with an appended HTML column.
#' @param data Pass through your plotting data
#' @param team_column Indicate which column contains your `team` variable
#' @param logo_column Indicates the name of the HTML column
#' @param logo_type Indicate whether you want to plot logos ('logo', default) or
#' wordmarks ('wordmark')
#' @param logo_height The height of the logo or wordmark in the HTML string
#' @import dplyr
#' @importFrom glue glue
#' @importFrom rlang ensym as_string
#' @importFrom magrittr %>%
#' @examples
#' \donttest{try(cbd_torvik_ratings(year=2023) %>% head() %>% select(team, conf) %>%
#' cbd_gt_logos(team) %>% gt() %>% fmt_markdown(team_logo))}
#'
#' @export
cbd_gt_logos <- function(data, team_column, logo_column = 'team_logo', logo_type = 'logo', logo_height = 25) {

  cbbdata:::check_key() # ensure user is logged-in

  team_column <- ensym(team_column)

  # get team logos
  logo_data <- cbbdata::cbd_teams() %>% select(team = common_team, logo, wordmark)

  # create column in df. that combines the logo and team name
  data <- data %>%
    # match logo to team name
    left_join(logo_data, multiple = 'first', by = join_by(!!team_column == 'team')) %>%
    mutate(selected_logo = case_when(logo_type == 'logo' ~ logo, .default = wordmark)) %>%
    mutate({{logo_column}} := glue("<img src='{selected_logo}' style='height: {logo_height}px; width: auto; vertical-align: middle;'> {.data[[as_string(team_column)]]}")) %>%
    select(-c(selected_logo, logo, wordmark))

  return(data)

}
