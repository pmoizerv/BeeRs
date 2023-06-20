#' Standard error
#'
#' @param x A vector of numerical values
#'
#' @return A value corresponding to the standard error
#' @export
#'
#' @examples
#' x <- c(2, 1, 5, 3, 5)
#' std_err(x)
std_err <- function(x) {
  n <- length(x[!is.na(x)]) # calculate the length of the vector
  if (n > 2) { # <- only compute standard error for vector >= 2
    out <- sd(x, na.rm = TRUE) / sqrt(n)
  } else {
    out <- NA
  }
  return(out)
}

