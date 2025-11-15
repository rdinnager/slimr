test_that("Recipe 12.2 II: Lethal epistasis II works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe from development directory
  recipe_file <- system.file("extdata/slim_recipes/converted/recipe_12_2_II.R", package = "slimr")
  if (recipe_file == "") {
    recipe_file <- "inst/extdata/slim_recipes/converted/recipe_12_2_II.R"
  }
  source(recipe_file)

  # Run the recipe
  result <- slim_run(recipe_12_2_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates dosage-dependent lethal epistasis - only double
  # homozygotes (A/A + B/B) are lethal. Double heterozygotes can survive.
})
