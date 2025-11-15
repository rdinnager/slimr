test_that("Recipe 15.9: Litter size and parental investment works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_9.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_9_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Should have output with population size and litter size info
  expect_true(grepl("individuals", output))
  expect_true(grepl("mean litter size", output))
})
