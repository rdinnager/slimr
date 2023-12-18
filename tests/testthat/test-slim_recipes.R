test_that("Retrieving SLiM recipes works", {

  recipe_2 <- slim_get_recipe(2)
  expect_type(recipe_2, "character")
  expect_snapshot(cat(recipe_2))

  all_recipes <- slim_get_recipes()
  expect_length(all_recipes, 190L)
  expect_type(all_recipes, "list")

  some_recipes <- slim_get_recipes(c(1, 45, 53, 132))
  expect_length(some_recipes, 4L)
  expect_type(some_recipes, "list")

  expect_named(some_recipes, c("4.1", "9.2", "9.7", "15.20"))

})

test_that("All SLiM recipes can be converted to slimr_script objects properly", {

  slim_scripts <- list()
  slim_recipes <- slim_get_recipes()

  recipes_using_files <- .slim_assets$recipes_using_resources
  #skip_on_ci()
  #skip_on_cran()
  #skip_on_covr()

  for(i in seq_along(slim_recipes)) {
    #print(i)
    slim_scripts[[i]] <-  as_slimr_script(slim_recipes[[i]])
    expect_s3_class(slim_scripts[[!!i]], "slimr_script")

  }
  # slim_scripts <- purrr::map(slim_scripts,
  #                            ~slim_script_remove_output(.x))

  skip_on_ci()
  skip_if_slim_not_installed()

  for(i in seq_along(slim_recipes)) {
    if(!i %in% recipes_using_files) {
      expect_snapshot(print(slim_scripts[[i]]))
    }
  }

})
