test_that("Recipe 11.1: Assortative mating works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_11_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_11_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that FST output was produced
  expect_true(file.exists(result$output_file))
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("Mean FST at equilibrium", output_content)))
})
