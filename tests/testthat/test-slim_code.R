test_that("loading and unloading slim globals works", {

  suppressWarnings(slim_load_globals(c(p = 2, g = 3)))
  expect_true(exists("p1", where = rlang::global_env()))
  expect_true(exists("p2", where = rlang::global_env()))
  expect_true(exists("g1", where = rlang::global_env()))
  expect_true(exists("g2", where = rlang::global_env()))
  expect_true(exists("g3", where = rlang::global_env()))
  expect_true(exists("sim", where = rlang::global_env()))
  expect_true(exists("self", where = rlang::global_env()))

  expect_true(exists("parent1", where = rlang::global_env()))

  slim_unload_globals()

  expect_false(exists("p1", where = rlang::global_env()))
  expect_false(exists("p2", where = rlang::global_env()))
  expect_false(exists("g1", where = rlang::global_env()))
  expect_false(exists("g2", where = rlang::global_env()))
  expect_false(exists("g3", where = rlang::global_env()))
  expect_false(exists("sim", where = rlang::global_env()))
  expect_false(exists("self", where = rlang::global_env()))

  expect_false(exists("parent1", where = rlang::global_env()))

  suppressWarnings(slim_load_globals(0, sim = TRUE, self = FALSE))
  expect_true(exists("sim", where = rlang::global_env()))
  expect_false(exists("p1", where = rlang::global_env()))
  expect_false(exists("self", where = rlang::global_env()))

  slim_unload_globals()

})
