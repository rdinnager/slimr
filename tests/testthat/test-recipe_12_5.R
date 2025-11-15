test_that("Recipe 12.5: Tracking separate sexes in script works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe from development directory
  recipe_file <- system.file("extdata/slim_recipes/converted/recipe_12_5.R", package = "slimr")
  if (recipe_file == "") {
    recipe_file <- "inst/extdata/slim_recipes/converted/recipe_12_5.R"
  }
  source(recipe_file)

  # Run the recipe
  result <- slim_run(recipe_12_5_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe tracks sex ratio using tags instead of built-in sex model
  # Should output sex ratio information
  if (!is.null(result$output_file) && file.exists(result$output_file)) {
    output_text <- paste(readLines(result$output_file), collapse = "\n")
  } else {
    output_text <- result$output
  }
  expect_true(grepl("Sex ratio", output_text))
})
