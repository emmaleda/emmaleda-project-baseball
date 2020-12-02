
devtools::load_all()
devtools::document()

library(tidyverse)
library(here)

seasonsim <- data.frame(season = map_dbl(1:250, ~season2()))

write_csv(seasonsim, here("data","seasonsim.csv"))
