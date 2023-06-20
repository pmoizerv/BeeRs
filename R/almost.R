#' Average after N beers
#'
#' @param x Numeric vector
#' @param N Number of beers
#'
#' @return Mean of the vector values after N beers
#' @export
#'
#' @examples
#' x <- c(2,2,3,2,1,2,3,4,5,2)
#' N <- 0
#' almost(x = x, N = N)
#'
#' x <- c(2,2,3,2,1,2,3,4,5,2)
#' N <- 4
#' almost(x = x, N = N)
almost <- function(x, N = 0L){
  if(N == 0){
    output <- mean(x, na.rm = T)
    return(output)
  }
  if(N > 0 & N <= 7){
    output <- round(mean(rnorm(500/N, mean(x, na.rm = T), sd = N/3)), digits = 2)
    return(output)
  }
  if(N > 7 & N <= 9){
    return(paste("after", N, "beers, I am unable to calculate"))
  }
  if(N > 9){
    Sys.sleep(7);return(paste("I don't know, let me sleep..."))
  }
}
###########-------
usethis::use_package("tidyr")
data("beers_dat", envir = environment())

YEARmin <- 2009
YEARmax <- 2009
YEAR <- YEARmin:YEARmax
COLUMN <- "KegsBarrels"
NumberBeers <- 0L


states_map <- ggplot2::map_data("state")

beers_dat |>
  tidyr::pivot_longer(4:6, values_to = "Volume", names_to = "Purpose") |>
  dplyr::filter(year %in% YEAR,
                Purpose %in% COLUMN,
                state != "total") |>
  dplyr::group_by(state, state_full) |>
  dplyr::summarise(AVG = almost(Volume, N = NumberBeers)) |>
  dplyr::ungroup() |>

  #dplyr::mutate(AVG = ifelse(AVG == NA, 0, as.numeric(AVG))) |>
  dplyr::mutate(Total = sum(AVG, na.rm = T),
                Percent = (AVG/Total) * 100) |>

  ggplot2::ggplot(mapping = ggplot2::aes(map_id = state_full))+
  ggplot2::geom_map(mapping = ggplot2::aes(fill = Percent), map = states_map) +
  ggplot2::expand_limits(x = states_map$long, y = states_map$lat)
