test_that("Recipe 4.1.10: Using defineConstant() for parameterization works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_4_1_10.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_4_1_10_script)

  # Verify success
  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))
})
