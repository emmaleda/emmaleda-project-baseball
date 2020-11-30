
devtools::load_all()

library(tidyverse)
library(here)

seasonsim <- data.frame(season = map_dbl(1:250, ~season()))

write_csv(seasonsim, here("data","seasonsim.csv"))