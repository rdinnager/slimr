test_that("Recipe 15.7: Habitat choice works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_7.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_7_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output (collapse to single string)
  output <- paste(result$output, collapse = "\n")

  # Should have output showing mutation counts in each subpop
  # Pattern: "subpop X (size): Y m2, Z m3"
  expect_true(grepl("subpop 1", output))
  expect_true(grepl("subpop 2", output))
  expect_true(grepl("m2", output))
  expect_true(grepl("m3", output))
})
