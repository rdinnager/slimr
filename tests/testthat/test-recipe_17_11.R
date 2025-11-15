test_that("Recipe 17.11: Local adaptation on a heterogeneous landscape map works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_17_11.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_17_11_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check for expected output patterns
  output <- paste(result$output, collapse = "\n")
  expect_true(length(result$output) > 0)
})
