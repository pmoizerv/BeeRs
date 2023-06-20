test_that("almost works", {
  expect_equal(almost(c(1,2,3,4,5), 0), mean(c(1,2,3,4,5)))
})
