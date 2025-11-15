test_that("Recipe 14.6: Tracking local ancestry along the chromosome works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_6.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_6_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have output about ancestry markers being modeled
  expect_true(any(grepl("Modeling.*ancestry markers", output)))

  # Should have output about beneficial mutations for each population
  beneficial_lines <- grep("Beneficial mutation: s ==", output)
  expect_true(length(beneficial_lines) >= 3)  # At least 3 populations

  # The simulation finishes when beneficial mutations are lost
  # Check that simulation ran to completion
  expect_true(length(output) > 0)
})
