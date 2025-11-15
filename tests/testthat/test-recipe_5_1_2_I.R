test_that("Recipe 5.1.2 Part I: Exponential growth works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_5_1_2_I.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_5_1_2_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Output file should exist
  expect_true(file.exists(result$output_file))
})
