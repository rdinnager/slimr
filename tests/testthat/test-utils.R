test_that("get_os returns a valid platform", {
  expect_true(get_os() %in% c("windows", "linux", "osx"))
})

# test_that('slimr_which returns a valid path or ""', {
#   slim_path <- slimr_which("R")
#   if(slim_path != "") {
#     expect_true(file.exists(slim_path))
#   }
# })

test_that("%+% and %+n% work as expected", {
  new_string <- "skleepsers" %+% "spleenmatrix"
  new_string2 <- "calamity" %+n% "strain"
  expect_type(new_string, "character")
  expect_equal(nchar(new_string), 23L)
  expect_match(new_string2, "\n")

})
