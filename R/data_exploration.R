library(dplyr)

Beers_production <- read.csv("/Users/kinlan/Downloads/Beers_Data/beer_states.csv")
us_state <- read.csv("/Users/kinlan/Downloads/Beers_Data/us_state.csv")

######################################
beers_dat <- Beers_production |>
  left_join(us_state, by = "state") |>
  # A barrel of beer for this data is 31 gallons
  # A gallon is 3.78541 liters
  mutate(barrels = as.double(barrels),
         gallons = 31 * barrels,
         liter = 3.78541 * gallons,
         type = case_when(
           type == "On Premises" ~ "Permises",
           type == "Bottles and Cans" ~ "BottlesCans",
           type == "Kegs and Barrels" ~ "KegsBarrels"
         )) |>
  dplyr::select(- c(barrels, gallons)) |>
  pivot_wider(names_from = type, values_from = liter) |>
  mutate(state_full = tolower(state_full))


##########################################
dat <- beers_dat |>
  group_by(state, state_full) |>
  summarise(Value = mean(Permises)) |>
  ungroup()

states_map <- map_data("state")

ggplot(dat, aes(map_id = state_full)) +
  geom_map(aes(fill = Value), map = states_map) +
  expand_limits(x = states_map$long, y = states_map$lat)
##########