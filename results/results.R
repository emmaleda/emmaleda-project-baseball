
devtools::load_all()

library(tidyverse)

seasonsim <- map_dbl(1:250, ~season())

ggplot()+
  geom_histogram(aes(x = seasonsim), col = "yellow", fill = "brown") +
  xlab("Wins in a Season") +
  ggtitle("Simulation of the Padres 2019 Season")

mean(seasonsim)
