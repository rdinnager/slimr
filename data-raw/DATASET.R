## code to prepare `DATASET` dataset goes here

download.file("http://benhaller.com/slim/SLiM_Recipes.zip", "inst/recipes.zip")
zip::unzip("inst/recipes.zip") ## doesn't work, had to do it manually with winzip because of double quotes in filenames

recipes <- list.files("inst/SLiM_Recipes/", full.names = TRUE) %>%
  grep("Recipe ", .,  value = TRUE)

recipe_name <- basename(recipes) %>%
  strsplit(" - ", fixed = TRUE) %>%
  sapply(function(x) x[1]) %>%
  gsub("Recipe ", "", .)

recipe_txt <- lapply(recipes, function(x) readr::read_lines(x) %>% paste(collapse = "\n"))
names(recipe_txt) <- recipe_name

order_frame <- dplyr::tibble(name = recipe_name) %>%
  tidyr::separate(name, c("num1", "num2", "num3"), convert = TRUE, remove = FALSE) %>%
  dplyr::arrange(num1, num2, num3)

recipe_txt <- recipe_txt[order_frame$name]

slim_recipes <- recipe_txt

usethis::use_data(slim_recipes, internal = TRUE)
