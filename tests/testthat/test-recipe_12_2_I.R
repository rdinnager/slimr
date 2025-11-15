test_that("Recipe 12.2 I: Lethal epistasis I works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe from development directory
  recipe_file <- system.file("extdata/slim_recipes/converted/recipe_12_2_I.R", package = "slimr")
  if (recipe_file == "") {
    # Fallback to development directory if not installed
    recipe_file <- "inst/extdata/slim_recipes/converted/recipe_12_2_I.R"
  }
  source(recipe_file)

  # Run the recipe
  result <- slim_run(recipe_12_2_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates lethal epistasis - two beneficial mutations that are
  # lethal when combined. No specific output checks needed.
})
