# cbbdata 0.3.0
- Added [`cbd_bpi_ratings`](https://cbbdata.aweatherman.com/reference/cbd_bpi_ratings.html) to pull current ESPN BPI ratings + rankings, SOR/SOS, and tournament projections.
- Added [`cbd_all_metrics`](https://cbbdata.aweatherman.com/reference/cbd_all_metrics.html) to source Torvik, KenPom, BPI, SOR/SOS, and NET in one unified tibble.
- Added [`cbd_match_teams`](https://cbbdata.aweatherman.com/reference/cbd_match_teams.html) to build a team-matching named vector.
- KenPom authorization is no longer needed for [`cbd_kenpom_ratings`] (these ratings are public).

# cbbdata 0.2.0

- Removed `gt` table functions and moved to [`cbbplotR`](https://cbbplotr.aweatherman.com/articles/getting_started.html).
- Added [`cbd_add_net_quad`](https://cbbdata.aweatherman.com/reference/cbd_add_net_quad.html) function to automatically retrieve NET rankings, join them to data, and calculate quadrants.

# cbbdata 0.1.0

- Beta release; formally "announced" package via Twitter.
