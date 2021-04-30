test_that("slim_make_pop_input works", {
  set.seed(123)
  withr::local_file("pop.txt")
  pop_file <- slim_make_pop_input(matrix(rbinom(1000, 2, 0.25), nrow = 100, ncol = 100),
                                  file_name = "pop.txt")
  expect_snapshot(cat(readLines(pop_file)))
})
