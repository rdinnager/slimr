test_that("Recipe 19.1: Simple neutral nucleotide-based model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_19_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_19_1_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from output_file
  output <- paste(readLines(result$output_file), collapse = "\n")

  # Verify nucleotide-based mutations are in output
  # Nucleotide-based mutations should show nucleotide changes
  expect_true(grepl("Mutations", output) || grepl("#OUT", output))
})
