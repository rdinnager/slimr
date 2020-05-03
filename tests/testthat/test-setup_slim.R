test_that("slim_call is of correct form", {
  slim_call <- get_slim_call()
  platform <- get_os()
  expect_type(slim_call, "list")
  expect_length(slim_call, 2L)
  expect_type(slim_call$call, "character")
  expect_type(slim_call$args, "character")
  expect_length(slim_call$call, 1L)
  if(platform == "windows"){
    expect_length(slim_call$args, 2L)
  } else {
    expect_length(slim_call$args, 1L)
  }
})
