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
    output <- mean(x)
    return(output)
  }
  if(N > 0 & N <= 7){
    output <- round(mean(rnorm(100, mean(x), sd = N/3)), digits = 2)
    return(output)
  }
  if(N > 7 & N <= 9){
    return(paste("after", N, "beers, I am unable to calculate"))
  }
  if(N > 9){
    Sys.sleep(N);return(paste("I don't know, let me sleep..."))
  }
}
