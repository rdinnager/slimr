test_that("Recipe 17.6: Phenotypic competition with interaction() callback works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_17_6.R", package = "slimr"))
  result <- slim_run(recipe_17_6_script)
  expect_equal(result$exit_status, 0)

  output <- readLines(result$output_file)
  expect_true(length(output) > 0)

  # Check for phenotype output
  expect_true(any(grepl("cyc.*mean.*sd", output)))
})
