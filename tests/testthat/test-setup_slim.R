test_that("none-existent platform throws error", {
  expect_error(setup_slim(platform = "none"))
})
