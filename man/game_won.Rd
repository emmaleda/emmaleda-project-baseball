% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulation-functions.R
\name{game_won}
\alias{game_won}
\title{Did They Win the Game?}
\usage{
game_won(data, avg_runs_allowed)
}
\arguments{
\item{data}{dataframe with 9 rows; Must have columns named "OBP", "First", "Second", "Third" and "Home" in which the values are probabilites;
the probabilities provided in "First", "Second", "Third" and "Home" should add to 1 for each player}

\item{avg_runs_allowed}{a numeric value that is the average runs allowed by a team per game}
}
\value{
The value is a double, either zero or one, in which zero indicates they lost and one indicates they won
}
\description{
Did They Win the Game?
}
\examples{
game_won(data.frame(OBP = c(0.354, 0.289, 0.334, 0.310, 0.304, 0.321, 0.283, 0.321, 0.235),
                              First = c(0.7416, 0.6241, 0.7442, 0.7402, 0.7405, 0.7355, 0.7098, 0.7951, 0.8465),
                              Second = c(0.1005, 0.1348, 0.0977, 0.1422, 0.1450, 0.1419, 0.0933, 0.1220, 0.1080),
                              Third = c(0.0335, 0.0071, 0.0093, 0.0098, 0.0229, 0.0065, 0.0000, 0.0195, 0.0000),
                              Home = c(0.1244, 0.2340, 0.1488, 0.1078, 0.0916, 0.1161, 0.1969, 0.0634, 0.0455)),
                             avg_runs_allowed = 4.87)
}
