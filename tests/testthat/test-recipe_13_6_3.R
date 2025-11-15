test_that("Recipe 13.6 III: Disruptive selection works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_13_6_3.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_13_6_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Recipe outputs phenotypes and final QTL details
  expect_true(length(output) > 0)
  # Should contain "Phenotypes:" header and values
  expect_true(any(grepl("Phenotypes:", output)))
  # Should contain numeric values (frequencies and effects)
  expect_true(any(grepl("[0-9]", output)))
})
