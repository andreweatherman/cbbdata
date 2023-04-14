cbd_torvik_ratings <- function(...) {

  resp <- request('http://www.cbbdata.com/api/torvik/ratings') |>
    req_body_json(
      get_args(...)
    ) |>
    req_perform()

  data <- resp |> resp_body_json()

  return(data)

}

