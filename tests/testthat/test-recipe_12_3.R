test_that("Recipe 12.3: Simulating gene drive works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe from development directory
  recipe_file <- system.file("extdata/slim_recipes/converted/recipe_12_3.R", package = "slimr")
  if (recipe_file == "") {
    recipe_file <- "inst/extdata/slim_recipes/converted/recipe_12_3.R"
  }
  source(recipe_file)

  # Run the recipe
  result <- slim_run(recipe_12_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates CRISPR gene drive with homing mechanism
  # Should output either "FIXED" or "LOST"
  if (!is.null(result$output_file) && file.exists(result$output_file)) {
    output_text <- paste(readLines(result$output_file), collapse = "\n")
  } else {
    output_text <- result$output
  }
  expect_true(grepl("FIXED|LOST", output_text))
})
