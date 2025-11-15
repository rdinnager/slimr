test_that("Recipe 6.2: Genomic structure, Part II (Genomic element types) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_6_2.R", package = "slimr"))
  result <- slim_run(recipe_6_2_script)

  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))
})
