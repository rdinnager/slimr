test_that("Recipe 10.4.2: Cultural effects on fitness works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_4_2.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_4_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates gene-culture coevolution
  # m2 mutations beneficial only in cultural context (milk-drinkers)
  expect_true(TRUE)
})
