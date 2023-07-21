#' @export
cbd_torvik_game_box <- function(...) {

  base_url <- 'https://www.cbbdata.com/api/torvik/game/box?'

  data <- cbbdata:::get_cbd_file(base_url, ...)

  return(data)

}
