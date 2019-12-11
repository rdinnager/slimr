test_that("get_os returns a valid platform", {
  expect_true(get_os() %in% c("windows", "unix", "osx"))
})
