#' Get T-Rank, WAB, KP, BPI, SOR/SOS, and NET in one tibble
#'
#' @examples
#' \donttest{try(cbd_all_metrics())}
#' @export
cbd_all_metrics <- function(...) {

  # get trank and net // this takes a few seconds as it hits Barttorvik and not the API
  torvik_net <- cbbdata::cbd_torvik_current_resume() %>%
    dplyr::select(team, conf, trank_rating = barthag, trank_rank = t_rank, trank_off = adj_o,
           trank_off_rank = adj_o_rk, trank_def = adj_d, trank_def_rank = adj_d_rk, trank_tempo = adj_t,
           trank_tempo_rank = adj_t_rk, net_rank = net, wab, wab_rank = wab_rk)

  # get kenpom
  kp <- cbbdata::cbd_kenpom_ratings(year = 2024) %>%
    dplyr::select(team, kp_rating = adj_em, kp_rank = rk, kp_off = adj_o, kp_off_rank = adj_o_rk, kp_def = adj_d,
           kp_def_rank = adj_d_rk, kp_tempo = adj_t, kp_tempo_rk = adj_t_rk, kp_luck = luck, kp_luck_rk = luck_rk,
           w_l) %>%
    tidyr::separate(w_l, into = c('wins', 'losses'), sep = '-', convert = TRUE)

  # get bpi
  bpi <- cbd_bpi_ratings() %>%
    dplyr::select(team, bpi_rating = bpi_value, bpi_rank = bpi_rank, bpi_off = bpi_offense, bpi_off_rank = bpi_offense_rank,
           bpi_def = bpi_defense, bpi_def_rank = bpi_defense_rank, bpi_sor_rank = sor_rank, bpi_sos_rank = sos_rank,
           bpi_qual_wins = quality_wins, bpi_qual_losses = quality_losses)

  # join together and move wins after conf. name
  data <- list(torvik_net, kp, bpi) %>%
    purrr::reduce(left_join, by = "team") %>%
    dplyr::relocate(c(wins, losses), .after = c(conf, conf))


  return(data)

}
