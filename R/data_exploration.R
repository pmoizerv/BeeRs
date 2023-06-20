usethis::use_package("dplyr")



data("beers_dat")
dat <- beers_dat |>
  dplyr::group_by(state, state_full) |>
  dplyr::summarise(Value = mean(Permises)) |>
  dplyr::ungroup()

#library(tidyverse)
# find the package
# states_map <- map_data("state")

#ggplot(dat, aes(map_id = state_full)) +
##  geom_map(aes(fill = Value), map = states_map) +
#  expand_limits(x = states_map$long, y = states_map$lat)
##########


