test_that("get_os returns a valid platform", {
  expect_true(get_os() %in% c("windows", "linux", "osx"))
})

test_that('slimr_which returns a valid path or ""', {
  slim_path <- slimr_which("R")
  if(slim_path != "") {
  }

})
