test_that("Recipe 16.3: Clonal haploid bacteria with HGT works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_16_3.R", package = "slimr"))

  # Run the recipe (may take a while for HGT to combine mutations)
  result <- slim_run(recipe_16_3_script, capture_output = TRUE)

  # Verify success (either fixation or timeout)
  expect_equal(result$exit_status, 0)

  # Check output - read from output_file if needed
  if (length(result$output) > 0) {
    output <- paste(result$output, collapse = "\n")
  } else if (file.exists(result$output_file)) {
    output <- paste(readLines(result$output_file), collapse = "\n")
  } else {
    output <- ""
  }

  # Should have either "fixed" or "no result" message
  expect_true(grepl("fixed|no result", output))
})
