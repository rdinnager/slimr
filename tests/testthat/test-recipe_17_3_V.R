test_that("Recipe 17.3 V: Dispersal kernels works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_17_3_V.R", package = "slimr"))
  result <- slim_run(recipe_17_3_V_script)
  expect_equal(result$exit_status, 0)

  output <- readLines(result$output_file)
  expect_true(length(output) > 0)
})
