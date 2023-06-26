#' @export
cbd_player_shots <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/shots/male?'

  data <- cbbdata:::get_cbd_file(base_url)

  return(data)

}
