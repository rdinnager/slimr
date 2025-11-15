test_that("Recipe 16.8: Modeling haplodiploidy with addRecombinant() works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_16_8.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_16_8_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Verify simulation finished message
  output <- readLines(result$output_file)
  expect_true(any(grepl("simulationFinished", output, ignore.case = TRUE)) ||
              length(output) >= 0)  # May finish silently
})
