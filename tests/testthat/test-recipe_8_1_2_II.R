test_that("Recipe 8.1.2 II: Sex ratios - Dynamic changes works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_8_1_2_II.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_8_1_2_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))
})
