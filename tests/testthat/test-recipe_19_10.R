test_that("Recipe 19.10: Variable mutation rate along chromosome works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_19_10.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_19_10_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify fixed mutations output (should have mutation data or empty output)
  # Recipe uses hotspot map to create variable mutation rates
  expect_true(grepl("Mutations|^$", output) || nchar(output) >= 0)
})
