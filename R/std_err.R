#' Sum squared with variance
#'
#' @param x Numeric vector
#' @param N Number of beers
#'
#' @return The sum squared based on almost instead of the mean
#' @export
#'
#' @examples
#' x <- c(2,2,3,2,1,2,3,4,5,2)
#' sum_squared_deviations(x, N = 0L)
sum_squared_deviations <- function(x, N = 0L) {
  almost_mean <- almost(x, N)
  tmp <- (x - almost_mean)^2
  sum(tmp)
}

#' standard deviation based on almost instead of mean
#'
#' @param x Numeric vector
#' @param N Number of beers
#'
#' @return The sum squared based on almost instead of the mean
#' @export
#'
#' @examples
#' x <- c(2,2,3,2,1,2,3,4,5,2)
#' std_dev(x, N = 0L)
std_dev <- function(x, N = 0L) {
  n <- length(x[!is.na(x)])
  SS = sum_squared_deviations(x, N)
  sqrt(SS / (n - 1))
}

#' Standard error based on almost instead of mean
#'
#' @param x A vector of numerical values
#' @param N Number of beers
#'
#' @return A value corresponding to the standard error
#' @export
#'
#' @examples
#' x <- c(2, 1, 5, 3, 5)
#' std_err(x, N = 0L)

std_err <- function(x, N=0) {
  n <- length(x[!is.na(x)]) # calculate the length of the vector
  if (n > 2) { # <- only compute standard error for vector >= 2


    out <- std_dev(x, N) / sqrt(n)
  } else {
    out <- NA
  }
  return(out)
}
