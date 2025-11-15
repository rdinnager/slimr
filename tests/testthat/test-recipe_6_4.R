test_that("Recipe 6.4: Genomic structure, Part IV (Custom display colors in SLiMgui) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_6_4.R", package = "slimr"))
  result <- slim_run(recipe_6_4_script)

  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))
})
