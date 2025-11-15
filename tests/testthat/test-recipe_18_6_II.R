test_that("Recipe 18.6 II: Coalescence with deferred scheduling works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_18_6_II.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_18_6_II_script, throw_error = FALSE, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output
  output <- paste(result$output, collapse = "\n")
  expect_true(nchar(output) > 0)

  # Should see either COALESCED+FINISHED or NO COALESCENCE
  has_coalesced <- grepl("COALESCED", output)
  has_finished <- grepl("FINISHED", output)
  has_no_coalescence <- grepl("NO COALESCENCE", output)

  # Either both COALESCED and FINISHED, or NO COALESCENCE
  expect_true((has_coalesced && has_finished) || has_no_coalescence)
})
