
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cbbdata

<!-- badges: start -->
<!-- badges: end -->

Welcome to `cbbdata`, an R package designed to grant swift and
effortless access to the CBBData API, offering an abundance of college
basketball statistics and data! By harnessing the power of back-end SQL
queries and direct file transfers, this package equips you with the
essential information required to dissect and comprehend the intricacies
of college basketball.

The benefit of using `cbbdata` is two-fold:

1.  It provides batched data; no need to scrape thousands of pages for a
    complete picture.

2.  `cbbdata` uses common naming conventions for players and teams,
    making it easy to join and compare data from different sources.

Getting started with `cbbdata` is a breeze – simply sign up for a free
API key and start grabbing data! With its intuitive interface and robust
back-end capabilities, this package stands as an indispensable asset for
anyone eager to explore the depths of college basketball analysis.

## Installation

You can install the development version of `cbbdata` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("andreweatherman/cbbdata")
```

## Registering for an API key

An API key is free and easy to obtain by using the official `cbbdata` R
package. To register, simply pass a username and password to the
`cbd_create_account` endpoint. Your API key will be emailed to you –
make sure to check your spam folder!

*Note: If you want to access KenPom data, your CBBData account email
must match your KenPom account email*

``` r
# to register
cbbdata::cbd_create_account(username = 'xxx', email = 'xxx', password = 'xxx', confirm_password = 'xxx')
```

## Obtaining Your Key

After registering, there are two ways to obtain your key using the
`cbbdata` R package.

### By-Session Log-In:

To obtain your key for use in your current R session, you can pass your
username and password to the `cbd_login` function. This will retrieve
your key and store it as a session variable. If you restart or leave
your R session, you will need to log-in again.

``` r
# per-session log-in
cbbdata::cbd_login(username = 'xxx', password = 'xxx')
```

### Persistent Log-In (Preferred):

The recommended way to interact with the `CBBData` API is to store your
username (`CBD_USER`) and password (`CBD_PW`) inside the .Renviron file.
If you are unsure on how to do this, the `cbd_login` function will walk
you through the process. Please note that this *will* require restarting
your R session.

``` r
# persistent log-in
cbbdata::cbd_login()
```

If your API key is not stored as a session variable, `cbbdata` functions
will grab your credentials from the .Renviron file and automatically log
you in. With this method, you will not have to log-in again.

## Available Data

`cbbdata` provides broad access to leading college basketball resources.
`cbbdata` is continuously growing and the available data includes:

### Barttorvik:

Developer Andrew Weatherman wrote the popular `toRvik` R package.
`cbbdata` replaces `toRvik` and brings with it a rich collection of
Barttorvik data.

#### Metric Ratings:

-   Year-end ratings (`cbd_torvik_ratings`)
-   Day-by-day ratings (`cbd_torvik_ratings_archive`)

#### Player Data:

-   Individual game logs (`cbd_torvik_player_game`)
-   Season averages (`cbd_torvik_player_season`)
-   Season splits (`cbd_torvik_player_splits`)

#### Team Data:

-   Team splits (`cbd_torvik_team_splits`)

#### Game Data:

-   Individual game box (`cbd_torvik_game_box`)
-   Individual game [four
    factors](https://www.basketball-reference.com/about/factors.html)
    (`cbd_torvik_game_factors`)

…

### KenPom

To access KenPom data, you must have an active KenPom subscription and
your CBBData account email must match your KenPom account email; this
exists to curb account sharing. To activate your account, pass your
**KenPom** account password through the `cbd_kenpom_authorization`
function. The CBBData API will then confirm your account is active and
log your expiration date. You will only be asked to re-authorize on that
date.

``` r
# persistent log-in
cbbdata::cbd_kenpom_authorization(password = 'xxx')
```

#### Metric Ratings:

-   Year-end ratings (`cbd_kenpom_ratings`)
-   Day-by-day ratings (`cbd_kenpom_ratings_archive`)

#### Player Data:

-   Individual player factors (`cbd_kenpom_player_factors`)

#### Game Data:

-   Team schedules (`cbd_kenpom_team_schedules`)

…

## Support

The CBBData API is free to use but hosting it is not! If you find this
resource helpful, please kindly consider [supporting me and the project
on Ko-fi](https://ko-fi.com/andrewweatherman).
