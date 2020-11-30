# Simulation of the San Diego Padres 2019 Baseball Season

<!-- badges: start -->
<!-- badges: end -->

Emma Grossman and Leah Marcus

## Baseball

The primary objective of the project is to simulate the 2019 season of the San Diego Padres based on a simulation of their batting lineup. Hitters can be represented individually by a Bernoulli random variable, where p will equal the probability of not making an out (so p = on base percentage). The simulation will represent whether a player is successful in not making an out, which will be translated to runs scored per inning. To depict an actual baseball game, the individual simulation will need to run 9 times, once for each inning, and stop once three failures (outs) are recorded. Each game simulation will be run 162 times to represent one simulated season. A win will be recorded for each game if the Padres score more total runs than they allowed per game on average plus one in 2019 (5.87 runs).

## Organization

The code to run the simulation is in [results/results.R](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/results/results.R), the code to view the functions that simulate the Season is in [R/simulation-functions.R](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/R/simulation-functions.R)

The final result and graph can be viewed [results/plot_and_mean.md](https://github.com/ST541-Fall2020/emmaleda-project-baseball/blob/master/results/plot_and_mean.md)
