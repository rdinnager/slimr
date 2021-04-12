test_that("SLiM executable can be found (if SLiM is available on system)", {

  expect_type(slim_is_avail(), "logical")

  skip_if_not(slim_is_avail())

  slim_dir <- get_slim_dir()

  expect_type(slim_dir, "character")

  slim_call <- get_slim_call()

  expect_type(slim_call, "list")
  expect_length(slim_call, 2L)
  expect_named(slim_call, c("call", "args"))
  expect_type(slim_call$call, "character")
  expect_type(slim_call$args, "character")

})

test_that("Windows WSL can find SLiM", {
  skip_on_os(c("mac", "linux", "solaris"))
  expect_identical(system2("bash", c("-c", "'test -e /usr/local/bin/slim'"),
          stdout = TRUE, stderr = TRUE),
          "blah")
  expect_identical(system2("bash", c("-c", "'ls /usr/local/bin'"),
                           stdout = TRUE, stderr = TRUE),
          "blah")
  expect_identical(system2("bash", c("-c", "'echo $PATH'"),
                           stdout = TRUE, stderr = TRUE),
          "blah")
  expect_identical(slim_is_avail(), "blah")
})
