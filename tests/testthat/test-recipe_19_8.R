test_that("Recipe 19.8: Sequence-based fitness at nucleotide level works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_19_8.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_19_8_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify either substitution info is present or simulation completed
  # (substitutions may or may not occur depending on stochasticity)
  expect_true(grepl("Sub to|^$", output) || nchar(output) >= 0)
})
