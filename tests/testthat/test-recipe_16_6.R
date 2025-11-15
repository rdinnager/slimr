test_that("Recipe 16.6: Sperm storage with a survival() callback works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_16_6.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_16_6_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output
  output <- paste(result$output, collapse = "\n")

  # Verify that population dynamics were tracked
  expect_true(grepl("p1 \\(", output))
  expect_true(grepl("p1000 \\(", output))

  # Verify fixed mutations were output
  expect_true(grepl("Mutations:|#OUT:", output))
})
