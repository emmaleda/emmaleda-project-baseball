
devtools::load_all()

library(tidyverse)

seasonsim <- map_dbl(1:100, ~season())

ggplot()+
  geom_histogram(aes(x = seasonsim))

mean(seasonsim)
