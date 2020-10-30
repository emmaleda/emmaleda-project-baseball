# Simulation of the San Diego Padres 2019 Baseball Season

<!-- badges: start -->
<!-- badges: end -->

Emma Grossman and Leah Marcus

The primary objective of the project is to simulate the 2019 season of the San Diego Padres based on a simulation of their batting lineup. Hitters can be represented individually by a Bernoulli random variable, where p will equal the probability of not making an out (so p = on base percentage). The simulation will represent whether a player is successful in not making an out, which will be translated to runs scored per inning. To depict an actual baseball game, the individual simulation will need to run 9 times, once for each inning, and stop once three failures (outs) are recorded. Each game simulation will be run 162 times to represent one simulated season. A win will be recorded for each game if the Padres score more total runs than they allowed per game on average in 2019 (4.87 runs).
