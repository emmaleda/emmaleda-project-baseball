
devtools::load_all()
devtools::document()

library(tidyverse)
library(here)

PadresBatting <- readr::read_csv(here::here("data", "PadresBatting.csv"))
seasonsim <- data.frame(season = map_dbl(1:250, ~season(PadresBatting)))

write_csv(seasonsim, here("data","seasonsim.csv"))
