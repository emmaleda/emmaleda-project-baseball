# Simulation of the San Diego Padres 2019 Baseball Season

<!-- badges: start -->
<!-- badges: end -->

Emma Grossman and Leah Marcus

## Baseball

The primary objective of the project is to simulate the 2019 season of the San Diego Padres based on a simulation of their batting lineup. Our secondary objective is to compare our simulation of the Padres' 2019 Season to a simulation in which their best hitter, Fernando Tatis Jr., is not removed from the lineup (as he was in the 2019 season) and see if the Padres would have made it to the Playoffs with his help. To simulate this, we generated many random variables from a uniform distribution and compared those to player's OBP: this determined if they made an out or a hit. We then simulated the base each player made it to, and multiplied these vectors together to get 0's if a player got out and 1, 2, 3, or 4 representing the base they made it to if they got a hit. We calculated the hits obtained per inning and compared this to their adjusted average runs allowed in the 2019 season to determine if they won or lost; then, we repeated this 162 times to represent a season and simulated 250 seasons to come up with the average games won for each objective.

## Organization

Required packages are `tidyverse` and `here`.

The code to view the functions that simulate the Season is in [R/simulation-functions.R](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/R/simulation-functions.R) and this file must be run first. To run the simulation, head to [results/results.R](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/results/results.R); the code in this file takes a while to run. 

The final results and graphs can be viewed [results/plot_and_mean.md](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/results/plot_and_mean.md)

The functions created for this simulation are `game_won(data, OBP, First, Second, Third, Home, avg_runs_allowed)` and `season(data, OBP, First, Second, Third, Home, avg_runs_allowed)`. In the file [results/results.R](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/results/results.R), we have provided the data frame and appropriate arguments for the Padres' 2019 season, but this can also be used to simulate a game for another team, as long as the necessary info has been provided. `game_won()` should be used to simulate whether a team won or lost a game and `season()` should be used to simulate games 162 times for the desired team. 

## Presentation & Report

Our PowerPoint can be found under [presentation/Baseball Simulation Presentation.pdf](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/presentation/Baseball%20Simulation%20Presentation.pdf).

Our written reeport can be found ...
