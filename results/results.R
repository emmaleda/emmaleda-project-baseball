
devtools::load_all()
devtools::document()
devtools::test()

library(tidyverse)
library(here)

PadresBatting <- readr::read_csv(here::here("data", "PadresBatting.csv"))
PadresBatting_FTJ <- readr::read_csv(here::here("data", "PadresBatting_FTJ.csv"))

seasonsim <- data.frame(season = map_dbl(1:250, ~season(PadresBatting,
                                                        avg_runs_allowed = 4.87)))

seasonsim_FTJ <- data.frame(season = map_dbl(1:250, ~season(PadresBatting_FTJ, 
                                                            avg_runs_allowed = 4.87)))

write_csv(seasonsim, here("data","seasonsim.csv"))
write_csv(seasonsim_FTJ, here("data","seasonsim_FTJ.csv"))
