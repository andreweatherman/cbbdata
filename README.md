
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cbbdata

<!-- badges: start -->
<!-- badges: end -->

Welcome to `cbbdata`, an R package designed to grant swift and
effortless access to the `cbbdata` API, offering an abundance of college
basketball statistics and data! By harnessing the power of back-end SQL
queries and direct file transfers, this package equips you with the
essential information required to dissect and comprehend the intricacies
of college basketball. `cbbdata` empowers users with a treasure trove of data on teams, players, and games, elevating your analysis to unparalleled heights.

Getting started with cbbdata is a breeze – simply sign up for a free API
key and delve into the rich world of college basketball data. With its
intuitive interface and robust back-end capabilities, this package
stands as an indispensable asset for anyone eager to explore the depths
of college basketball analysis.

## Installation

You can install the development version of cbbdata from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andreweatherman/cbbdata")
```

## Registering for an API key

An API key is free and easy to obtain by using the official `cbbdata` R
package. To register, simply pass a username and password to the
`cbd_create_account` endpoint. As of April 24, 2023, there is no way to
retrieve a forgotten password. So don't forget it!

``` r
# to register
cbbdata::cbd_create_account(username = 'xxx', password = 'xxx', confirm_password = 'xxx')
```

To obtain your key, pass the same credentials to the `cbd_login`
endpoint. Your API key will then be stored as an environmental variable
in your R session.

``` r
# to login
cbbdata::cbd_login(username = 'xxx', password = 'xxx')
```

## Available Data

`cbbdata` provides broad access to leading college basketball resources. The benefit of using `cbbdata` is two-fold: 

1. It provides batched data; no need to scrape thousands of pages for a complete picture.

2. `cbbdata` uses common naming conventions for players and teams, making it easy to join and compare data from different sources. 

`cbbdata` is continuously growing and adding more resources. Available resources include:

### Barttorvik

...

#### Data

Unless otherwise noted, all data is available back to the 2007-08 season.

##### Ratings:

- Year-end T-Rank (`cbd_torvik_ratings`)
- Day-to-day archive back to 2014-15 (`cbd_torvik_ratings_archive`)

##### Player:

- Game logs with box and advanced metrics (`cbd_torvik_player_game`)
- Season averages with box and advanced metrics (`cbd_torvik_player_season`)

##### Game:

- 

### KenPom

...

#### Authorizing with KenPom

The `cbbdata` API services select KenPom data but *requires* authorization to access. Attempting to hit KenPom endpoints *without* authorization will return a 403 error. To curb account sharing, your `cbbdata` account MUST use the same email across platforms but your password need not be the same. As more resources are added, this rule might be relaxed to accommodate users who have separate emails. Once authorized, your API key will immediately grant you access to KenPom endpoints.

You only need to authorize once per user. Your KenPom subscription expiration date is then logged, and you will be required to re-authorize at that date.

You can authorize your KenPom account by passing through your *KenPom* password to the `cbd_kenpom_authorization` function.

``` r
# to authorize with KenPom
cbbdata::cbd_kenpom_authorization(password = 'xxx')
```

#### Data

Unless otherwise noted, all data is available back to the 2000-01 season.

##### Ratings:

- Year-end KenPom ratings (`cbd_kenpom_ratings`)
- Day-to-day archive back to 2011-12 (`cbd_kenpom_ratings_archive`)

...

- Player four factor averages back to 2002-03 (...)
- Team schedules and results (...)

##### Other:

- Referee ratings and game logs back to ... (...)

### ESPN

...

#### Data

...

##### Play-by-Play

Play-by-play data is generously provided by the `ncaahoopR` package, authored by Luke Benz. His package includes a number of incredibly useful functions, which are not archived here. No list of must-use R sports packages is complete without `ncaahoopR`.

`cbd_espn_pbp` returns extensive PBP data back to ...


