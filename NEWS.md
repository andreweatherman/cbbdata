# cbbdata (development version, 2024-07-20)
- Added [`cbd_net_archive`](https://cbbdata.aweatherman.com/reference/cbd_net_archive.html) to pull daily NET rankings, along with KenPom and Torvik ratings, from the 2023-24 season. This endpoint will update throughout the 2024-25 season. Prior data might be added in future versions.
- Added [`cbd_ap_rankings`](https://cbbdata.aweatherman.com/reference/cbd_ap_rankings.html)

# cbbdata 0.3.0
- Added [`cbd_bpi_ratings`](https://cbbdata.aweatherman.com/reference/cbd_bpi_ratings.html) to pull current ESPN BPI ratings + rankings, SOR/SOS, and tournament projections.
- Added [`cbd_all_metrics`](https://cbbdata.aweatherman.com/reference/cbd_all_metrics.html) to source Torvik, KenPom, BPI, SOR/SOS, and NET in one unified tibble.
- Added [`cbd_match_teams`](https://cbbdata.aweatherman.com/reference/cbd_match_teams.html) to build a team-matching named vector.
- KenPom authorization is no longer needed for [`cbd_kenpom_ratings`] (these ratings are public).
- Added [`cbd_torvik_team_schedule`](https://cbbdata.aweatherman.com/reference/cbd_torvik_team_schedule.html) to query team schedules

# cbbdata 0.2.0

- Removed `gt` table functions and moved to [`cbbplotR`](https://cbbplotr.aweatherman.com/articles/getting_started.html).
- Added [`cbd_add_net_quad`](https://cbbdata.aweatherman.com/reference/cbd_add_net_quad.html) function to automatically retrieve NET rankings, join them to data, and calculate quadrants.

# cbbdata 0.1.0

- Beta release; formally "announced" package via Twitter.
