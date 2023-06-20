test_that("standard error", {
  expect_equal(std_err(c(1,2,3,4), 0), sd(c(1,2,3,4)/sqrt(length(c(1,2,3,4)))))
})
