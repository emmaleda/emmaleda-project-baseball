# Simulation of the San Diego Padres 2019 Baseball Season

<!-- badges: start -->
<!-- badges: end -->

Emma Grossman and Leah Marcus

## Baseball

The primary objective of the project is to create an accurate simulation of the 2019 season of the San Diego Padres based on their average batting lineup. Our secondary objective is to simulate their 2019 season as if their best hitter, Fernando Tatis Jr., had not been injured halfway through and replaced with a worse hitter. We want to see if having their star player thoughout the 2019 season would have improved their record and possibly allowed them to make it to the playoffs.

## Organization

Required packages are `devtools`, `testthat`, `tidyverse` and `here`.

The code to view the functions that simulate the Season is in [R/simulation-functions.R](R/simulation-functions.R) and this file must be run first. To run the simulation, head to [results/results.R](results/results.R); the code in this file takes a while to run (approx. 12 minutes - we did try alternate variations of code to speed this up, but their is a lot of code to run when simulating a baseball season and ultimately this was the fastest when timed with `bench::mark`). 

The final results and graphs can be viewed [results/plot_and_mean.md](results/plot_and_mean.md).

The functions created for this simulation are `game_won(data, OBP, First, Second, Third, Home, avg_runs_allowed)` and `season(data, OBP, First, Second, Third, Home, avg_runs_allowed)`. In the file [results/results.R](results/results.R), we have provided the data frame and appropriate arguments for the Padres' 2019 season, but this can also be used to simulate a game for another team, as long as the necessary statistics have been provided. `game_won()` should be used to simulate whether a team won or lost a game and `season()` should be used to simulate 162 games for the desired team. 

## Presentation & Report

Our PowerPoint can be found under [reports/Baseball Simulation Presentation.pdf](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/reports/Baseball%20Simulation%20Presentation.pdf).

Our written report can be found under [reports/Final Project Report.pdf](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/reports/Final%20Project%20Report.pdf).
