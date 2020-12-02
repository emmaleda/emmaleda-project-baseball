
devtools::load_all()
devtools::document()

library(tidyverse)
library(here)

PadresBatting <- readr::read_csv(here::here("data", "PadresBatting.csv"))
seasonsim <- data.frame(season = map_dbl(1:250, ~season(PadresBatting, OBP = OBP,
                                                        First = First, Second = Second,
                                                        Third = Third, Home = Home,
                                                        avg_runs_allowed = 4.87)))
seasonsim_FTJ <- data.frame(season = map_dbl(1:250, ~season(PadresBatting, OBP = OBPFTJ,
                                                            First = FirstFTJ, Second = SecondFTJ,
                                                            Third = ThirdFTJ, Home = HomeFTJ,
                                                            avg_runs_allowed = 4.87)))

write_csv(seasonsim, here("data","seasonsim.csv"))
write_csv(seasonsim_FTJ, here("data","seasonsim_FTJ.csv"))
