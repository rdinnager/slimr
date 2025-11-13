# Debug script to check generated method assignment code
library(dplyr)
library(purrr)
library(stringr)
library(tibble)
library(glue)

# Set project root
project_root <- here::here()
build_5_dir <- file.path(project_root, "data-raw/build_5")

# Load data
all_methods_data <- readRDS(file.path(build_5_dir, "all_methods_data.rds"))
class_abbrs <- tibble(
  class_name = c("Species"),
  class_abbr = c("Sp"),
  class_internal = c(".Sp")
)

# Define template
method_code <- "
<<class_name>>$<<function_name>> <- <<class_abbr>>$<<function_name>> <- <<class_internal>>$<<function_name>> <- function(<<args_with_dots>>) {
  ?<<r_function_name>>
}
"

# Get one method from Species
species_methods <- all_methods_data[["Species"]]
test_method <- species_methods[species_methods$function_name == "addSubpop", ]

# Create func_data
func_data <- list(
  class_name = "Species",
  class_abbr = "Sp",
  class_internal = ".Sp",
  function_name = "addSubpop",
  r_function_name = "addSubpop",
  args_with_dots = "subpopID, size, sexRatio = NULL, haploid = NULL"
)

# Generate using template
func_txt <- glue::glue_data(func_data, method_code, .open = "<<", .close = ">>")

cat("Generated method assignment code:\n")
cat(func_txt)
cat("\n")
