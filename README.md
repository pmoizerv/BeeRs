
<!-- README.md is generated from README.Rmd. Please edit that file -->

# BeeRs

<!-- badges: start -->
<!-- badges: end -->

The goal of BeeRs is to explore beer related datasets

## Installation

You can install the development version of BeeRs from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("pmoizerv/BeeRs")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(BeeRs)
## basic example code
```

## Data

The data come from Kaggle

- [Beer production per
  state](https://www.kaggle.com/datasets/jessemostipak/beer-production)
- For the shinyApp
- Map with filter option by year, state,…

## Function

The main function is `almost()` that compute the mean with an increased
variance with increased beer consumption up to 9 beers, then sleeps…

## Map

Dynamic map showing the the percentage production of beers across the
states.

## Workflow

``` mermaid
flowchart LR
  A[GitHub repository, ✅]  --> B[Get data✅]
  B --> C(Process,\nfilter,\ntidy the data✅)
  C --> D{Merge the\ndatasets✅}
  D --> E[Create beeRs packages✅]
  D --> F[Create shiny app, to do]
  E --> G(Containing tidy and merged dataset)
  F --> H(Showing US map with statistics)
```
