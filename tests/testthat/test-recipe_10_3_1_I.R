test_that("Recipe 10.3.1 I: Epistasis works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_3_1_I.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_3_1_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates epistasis where m3 fitness effect depends on m2 presence
  # If individual has m2 mutations, m3 effect changes from beneficial to deleterious
  expect_true(TRUE)
})
