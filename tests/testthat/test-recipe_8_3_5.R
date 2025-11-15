test_that("Recipe 8.3.5: Modeling the full human genome works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Note: This is a very large genome (3.1 Gb) and may take several minutes
  source(system.file("extdata/slim_recipes/converted/recipe_8_3_5.R", package = "slimr"))
  result <- slim_run(recipe_8_3_5_script)

  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))
})
