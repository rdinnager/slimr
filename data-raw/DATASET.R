## code to prepare `DATASET` dataset goes here
library(dplyr)

download.file("http://benhaller.com/slim/SLiM_Recipes.zip", "data-raw/recipes.zip")
zip::unzip("data-raw/recipes.zip") ## doesn't work, had to do it manually with winzip because of double quotes in filenames

files <- list.files("data-raw/SLiM_Recipes/", full.names = TRUE)

recipes <- files %>%
  grep("Recipe ", .,  value = TRUE) %>%
  grep(".py", .,  value = TRUE, invert = TRUE)

resources <- files[!stringr::str_detect(files, "Recipe ")]
resources <- resources[resources != "_README.txt"]

file.copy(resources, file.path("inst/extdata/recipe_resources", basename(resources)),
          overwrite = TRUE)

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

usethis::use_data(slim_recipes, internal = FALSE, overwrite = TRUE)

## code to generate package logo
logo_base <- imager::load.image("data-raw/logo_base.png") %>%
  imager::mirror("y")

logo_base <- logo_base[ , , , ]

logo_base <- 1 - logo_base

logo_sf <- isoband::isolines(seq(0, nrow(logo_base), length.out = nrow(logo_base)) / nrow(logo_base),
                             seq(0, ncol(logo_base), length.out = ncol(logo_base)) / ncol(logo_base),
                             t(logo_base),
                             0.5) %>%
  isoband::iso_to_sfg() %>%
  sf::st_sfc() %>%
  sf::st_sf() %>%
  sf::st_cast("MULTIPOLYGON") %>%
  dplyr::mutate(exists = 1) %>%
  lwgeom::st_make_valid()

plot(logo_sf)

grid_sf <- sf::st_make_grid(sf::st_as_sfc(sf::st_bbox(logo_sf)),
                            cellsize = c(0.005, 0.0005)) %>%
  sf::st_sf() %>%
  lwgeom::st_make_valid()

in_logo <- grid_sf %>%
  sf::st_join(logo_sf, left = FALSE)

plot(in_logo)


ggplot2::ggplot(in_logo) +
  ggplot2::geom_sf(ggplot2::aes(fill = exists, colour = exists))




