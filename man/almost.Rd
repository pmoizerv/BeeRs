% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/almost.R
\name{almost}
\alias{almost}
\title{Average after N beers}
\usage{
almost(x, N = 0L)
}
\arguments{
\item{x}{Numeric vector}

\item{N}{Number of beers}
}
\value{
Mean of the vector values after N beers
}
\description{
Average after N beers
}
\examples{
x <- c(2,2,3,2,1,2,3,4,5,2)
N <- 0
almost(x = x, N = N)

x <- c(2,2,3,2,1,2,3,4,5,2)
N <- 4
almost(x = x, N = N)
}
