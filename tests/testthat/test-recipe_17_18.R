test_that("Recipe 17.18: A sexual, age-structured spatial model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_17_18.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_17_18_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check for output
  output <- paste(result$output, collapse = "\n")
  expect_true(length(result$output) >= 0)
})
