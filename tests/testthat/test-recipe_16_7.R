test_that("Recipe 16.7: Tracking separate sexes in script, nonWF style works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_16_7.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_16_7_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output
  output <- paste(result$output, collapse = "\n")

  # Verify that sex ratios were tracked (ratio values should be printed)
  expect_true(grepl("\\d+: 0\\.", output))

  # Verify multiple generations were reported
  expect_true(grepl("1:", output))
  expect_true(grepl("2000:", output))
})
