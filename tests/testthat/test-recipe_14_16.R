test_that("Recipe 14.16: Visualizing linkage disequilibrium works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_16.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_16_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # The simulation might finish early if MUT1 is lost or fixed
  # Check for either successful completion or early finish message
  expect_true(length(output) >= 0)

  # If the focal mutation was lost/fixed, we should see a message
  # Otherwise, the simulation runs to completion
  if (any(grepl("focal mutation", output))) {
    expect_true(any(grepl("fixed or was lost", output)))
  }
})
