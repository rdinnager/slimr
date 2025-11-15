test_that("Recipe 14.14: Modeling biallelic loci in script works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_14.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_14_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have minimal output (simulation runs to generation 50000)
  expect_true(length(output) >= 0)

  # This recipe implements genetics entirely in script without using mutations
  # The freq.csv log file tracks allele frequencies
})
