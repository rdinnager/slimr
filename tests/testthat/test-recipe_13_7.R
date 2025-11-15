test_that("Recipe 13.7: Negative frequency-dependence on a quantitative trait works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_13_7.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_13_7_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Recipe outputs phenotype means over time
  expect_true(length(output) > 0)
  # Should contain "Phenotypes:" header
  expect_true(any(grepl("Phenotypes:", output)))
  # Should contain numeric values (mean phenotypes)
  expect_true(any(grepl("[0-9]", output)))
})
