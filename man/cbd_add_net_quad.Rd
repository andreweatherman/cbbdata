% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cbd_add_net_quad.R
\name{cbd_add_net_quad}
\alias{cbd_add_net_quad}
\title{Add Net Rankings and Quadrants to Data}
\usage{
cbd_add_net_quad(
  df,
  net_team_col = opp,
  net_col = net,
  location_col = location,
  add_net = TRUE
)
}
\arguments{
\item{df}{Data frame to alter}

\item{net_team_col}{A column of team names which should be used to match
against current NET rankings}

\item{net_col}{The name of your NET column (or the name to call the new NET
column)}

\item{location_col}{The name of your game location column}

\item{add_net}{Should NET rankings first be added to your data? Set to FALSE
if you already have NET rankings and reference that column name in
\code{net_col.} Defaults to TRUE.}
}
\description{
A utility function for adding current NET rankings and quadrant boundaries to
data.
}
