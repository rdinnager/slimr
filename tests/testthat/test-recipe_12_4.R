test_that("Recipe 12.4: Suppressing hermaphroditic selfing works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe from development directory
  recipe_file <- system.file("extdata/slim_recipes/converted/recipe_12_4.R", package = "slimr")
  if (recipe_file == "") {
    recipe_file <- "inst/extdata/slim_recipes/converted/recipe_12_4.R"
  }
  source(recipe_file)

  # Run the recipe
  result <- slim_run(recipe_12_4_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates preventing hermaphroditic selfing via modifyChild()
  # Note: This is the old approach; modern code should use
  # initializeSLiMOptions(preventIncidentalSelfing=T) instead
})
