test_that("Recipe 14.1: Relatedness, inbreeding, and heterozygosity works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that heterozygosity was calculated and printed
  expect_true(any(grepl("Mean heterozygosity", output)))

  # Extract heterozygosity value
  het_line <- grep("Mean heterozygosity", output, value = TRUE)
  expect_true(length(het_line) > 0)

  # Verify that heterozygosity value is numeric and reasonable (between 0 and 1)
  # Extract the numeric value after "="
  het_value <- as.numeric(sub(".*= ([0-9.]+).*", "\\1", het_line))
  expect_true(het_value >= 0 && het_value <= 1)
})
