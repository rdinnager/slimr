## Generate R Documentation Stubs for SLiM 5.x
## This script generates R/slim_lang_v5.R with complete roxygen documentation
## Based on data extracted from SLiM 5.x RTF documentation files

library(stringr)
library(dplyr)
library(purrr)
library(tidyr)
library(glue)

cat("=== GENERATING SLiM 5.x R DOCUMENTATION ===\n\n")

# ------------------------------------------------------------------------------
# STEP 1: LOAD EXTRACTED DATA
# ------------------------------------------------------------------------------

cat("STEP 1: Loading extracted SLiM 5.x data...\n")

# Determine project root
if (file.exists("build_5/all_methods_data.rds")) {
  # Running from data-raw
  project_root <- ".."
} else if (file.exists("data-raw/build_5/all_methods_data.rds")) {
  # Running from project root
  project_root <- "."
} else {
  stop("Cannot find extracted data files. Please run extract_from_rtf.R first.")
}

build_5_dir <- file.path(project_root, "data-raw/build_5")

all_methods_data <- readRDS(file.path(build_5_dir, "all_methods_data.rds"))
all_properties_data <- readRDS(file.path(build_5_dir, "all_properties_data.rds"))
slim_lang_intros <- readRDS(file.path(build_5_dir, "slim_lang_intros.rds"))

cat("  - Loaded", length(all_methods_data), "method sets\n")
cat("  - Loaded", length(all_properties_data), "property sets\n")
cat("  - Loaded", length(slim_lang_intros), "class introductions\n\n")

# ------------------------------------------------------------------------------
# STEP 2: SET UP CLASS ABBREVIATIONS
# ------------------------------------------------------------------------------

cat("STEP 2: Setting up class abbreviations...\n")

# Class abbreviations (from v4, with additions for new v5 classes)
class_abbrs <- tibble::tribble(
  ~class_name,        ~class_abbr, ~class_internal,
  "Initialize",       "Init",      ".Init",
  "Chromosome",       "Ch",        ".Ch",
  "Community",        "Co",        ".Co",
  "Eidos",            "E",         ".E",
  "GenomicElement",   "GE",        ".GE",
  "GenomicElementType", "GET",     ".GET",
  "Haplosome",        "Hp",        ".Hp",      # New in v5
  "Individual",       "In",        ".I",
  "InteractionType",  "IT",        ".IT",
  "LogFile",          "LF",        ".LF",
  "Mutation",         "M",         ".M",
  "MutationType",     "MT",        ".MT",
  "Plot",             "Pl",        ".Pl",      # New in v5
  "SLiMEidosBlock",   "SEB",       ".SEB",
  "SLiMgui",          "SG",        ".SG",
  "SpatialMap",       "SM",        ".SM",
  "Species",          "Sp",        ".Sp",
  "Subpopulation",    "P",         ".P",
  "Substitution",     "S",         ".S"
)

cat("  - Configured", nrow(class_abbrs), "class abbreviations\n\n")

# ------------------------------------------------------------------------------
# STEP 3: DEFINE ROXYGEN TEMPLATES
# ------------------------------------------------------------------------------

cat("STEP 3: Defining roxygen templates...\n")

# Template for Initialize and regular functions (exported)
func_template <- "
SLiM method <<function_name>>

Documentation for SLiM function \\code{<<function_name>>}, which is a method of the SLiM class \\code{\\link{<<class_name>>}}.
Note that the R function is a stub, it does not do anything in R (except bring up this documentation). It will only do
anything useful when used inside a \\code{\\link{slim_block}} function further nested in a \\code{\\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a full SLiM script.

Documentation for this function can be found in the official SLiM manual at \\url{https://messerlab.org/slim/}.

<<params>>

@aliases <<class_name>>$<<function_name>> <<class_abbr>>$<<function_name>>
@family <<class_name>>
@return An object of type <<return_type_desc>>. <<ifelse(return_singleton, 'Return will be of length 1 (a singleton)', '')>>
@details <<description>>
@section Copyright:
This is documentation for a function in the SLiM software, and has been reproduced from the official manual,
which can be found here: \\url{https://messerlab.org/slim/}. This documentation is
Copyright © 2016-2025 Philipp Messer. All rights reserved. More information about SLiM can be found
on the official website: \\url{https://messerlab.org/slim/}
@author Benjamin C Haller (\\email{bhaller@@benhaller.com}) and Philipp W Messer (\\email{messer@@cornell.edu})
<<ifelse(class_name %in% c('Initialize'), '@export', '')>>
<<ifelse(class_name %in% c('Initialize'), '@examples', '')>>
<<ifelse(class_name %in% c('Initialize'), '## This just brings up the documentation:', '')>>
<<ifelse(class_name %in% c('Initialize'), paste0(function_name, '()'), '')>>
#..<<function_name>> <- function(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>) {
#..  <<class_abbr>>$<<function_name>>(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>)
#..}"

# Template for Eidos functions
eidos_func_template <- "
Eidos method <<function_name>>

Documentation for Eidos function \\code{<<function_name>>}, which is a method of \\code{\\link{<<class_name>>}}.
Note that the R function is a stub, it does not do anything in R (except bring up this documentation). It will only do
anything useful when used inside a \\code{\\link{slim_block}} function further nested in a \\code{\\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a full SLiM script.

Documentation for this function can be found in the official SLiM manual at \\url{https://messerlab.org/slim/}.

<<params>>

@aliases <<class_name>>$<<function_name>> <<class_abbr>>$<<function_name>>
@family <<class_name>>
@return An object of type <<return_type_desc>>. <<ifelse(return_singleton, 'Return will be of length 1 (a singleton)', '')>>
@details <<description>>
@section Copyright:
This is documentation for a function in the SLiM software, and has been reproduced from the official manual,
which can be found here: \\url{https://messerlab.org/slim/}. This documentation is
Copyright © 2016-2025 Philipp Messer. All rights reserved. More information about SLiM can be found
on the official website: \\url{https://messerlab.org/slim/}
@author Benjamin C Haller (\\email{bhaller@@benhaller.com}) and Philipp W Messer (\\email{messer@@cornell.edu})
#..eidos_<<function_name>> <- function(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>) {
#..  <<class_abbr>>$<<function_name>>(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>)
#..}"

# Code for class methods (internal, not exported)
method_code <- "#..<<class_name>>$<<function_name>> <- <<class_abbr>>$<<function_name>> <- function(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>) {
#..  ?<<function_name>>
#..}"

# Code for Eidos methods
eidos_method_code <- "#..<<class_name>>$<<function_name>> <- <<class_abbr>>$<<function_name>> <- function(<<paste(arg_data[[1]]$arg_name, collapse = ', ')>>) {
#..  ?eidos_<<function_name>>
#..}"

# Template for function parameters
arg_roxy_template <- "
@param {arg_name} An object of type {arg_type_desc}. {ifelse(arg_singleton, 'Must be of length 1 (a singleton). ', ' ')} {ifelse(is.na(arg_default), '', paste0('The default value is \\\\code{', arg_default, '}.'))} See details for description.
"

cat("  - Defined roxygen templates\n\n")

# ------------------------------------------------------------------------------
# STEP 4: DEFINE GENERATOR FUNCTIONS
# ------------------------------------------------------------------------------

cat("STEP 4: Defining generator functions...\n")

# Function to generate documentation for a single method/function
make_slim_function <- function(func_table, class_name, class_abbr, template) {
  # Generate @param tags
  if (nrow(func_table$arg_data[[1]]) > 0) {
    params <- purrr::map_chr(purrr::transpose(func_table$arg_data[[1]]),
                             ~glue::glue_data(.x, arg_roxy_template) %>%
                               stringr::str_wrap()) %>%
      paste(collapse = "\n")
  } else {
    params <- ""
  }

  # Generate full documentation
  func_txt <- glue::glue_data(c(func_table, list(class_name = class_name,
                                                 class_abbr = class_abbr)),
                              template, .open = "<<", .close = ">>")

  # Convert to roxygen comment format
  func_txt <- func_txt %>%
    stringr::str_split("\n") %>%
    purrr::map(~stringr::str_wrap(.x) %>%
                 stringr::str_split("\n") %>%
                 unlist() %>%
                 paste0("#'", .)) %>%
    unlist()

  # Extract and clean function code section (marked with #..)
  func_section <- stringr::str_which(func_txt, stringr::fixed("#'#..")) %>%
    range()

  if (length(func_section) == 2 && !any(is.na(func_section))) {
    func_txt[func_section[1]:func_section[2]] <- func_txt[func_section[1]:func_section[2]] %>%
      stringr::str_remove_all("(#'#..|#')")
  }

  # Collapse into a single string
  paste(func_txt, collapse = "\n")
}

# Function to generate documentation for all methods in a class
make_class_funcs <- function(method_table, class_name, class_abbr, template) {
  methods_list <- purrr::map(seq_len(nrow(method_table)),
                             ~method_table[.x, ])

  methods_txt <- purrr::map_chr(methods_list,
                                ~make_slim_function(.x,
                                                    class_name,
                                                    class_abbr,
                                                    template))
  paste(methods_txt, collapse = "\n\n")
}

cat("  - Defined generator functions\n\n")

# ------------------------------------------------------------------------------
# STEP 5: GENERATE METHOD DOCUMENTATION
# ------------------------------------------------------------------------------

cat("STEP 5: Generating method documentation...\n")

# Set up method generation data frame
method_make_df <- tibble(class_name = names(all_methods_data)) %>%
  left_join(class_abbrs, by = "class_name") %>%
  mutate(func_template = map(class_name,
                          ~if(.x == "Eidos") eidos_func_template else func_template)) %>%
  mutate(method_code = map(class_name,
                          ~if(.x == "Eidos") eidos_method_code else method_code))

# Generate documentation for all methods
all_methods_txt <- purrr::pmap_chr(list(all_methods_data,
                                   method_make_df$class_name,
                                   method_make_df$class_internal,
                                   method_make_df$func_template),
                                   ~make_class_funcs(..1, ..2, ..3, ..4)) %>%
  paste(collapse = "\n\n\n\n")

cat("  - Generated documentation for all methods\n\n")

# ------------------------------------------------------------------------------
# STEP 6: GENERATE METHOD CODE (INTERNAL)
# ------------------------------------------------------------------------------

cat("STEP 6: Generating method code (internal)...\n")

# Generate internal method code
all_methods_code <- purrr::pmap_chr(list(all_methods_data,
                                         method_make_df$class_name,
                                         method_make_df$class_internal,
                                         method_make_df$method_code),
                                    ~make_class_funcs(..1, ..2, ..3, ..4)) %>%
  paste(collapse = "\n\n\n\n")

# Fix wrapping issues with assignment operators
all_methods_code <- stringr::str_replace_all(all_methods_code,
                                             "\n\\<\\-",
                                             " <-")
all_methods_code <- stringr::str_replace_all(all_methods_code,
                                             "\n\\$",
                                             "$")

cat("  - Generated internal method code\n\n")

# ------------------------------------------------------------------------------
# STEP 7: GENERATE PROPERTY CODE
# ------------------------------------------------------------------------------

cat("STEP 7: Generating property code...\n")

# Template for property assignment
properties_create <- "{class_name}${property} <- {class_abbr}${property} <- '{property}'"

# Function to create properties for a class
create_properties <- function(property_table, class_name, class_abbr) {
  if (is.null(property_table) || nrow(property_table) == 0) {
    return("")
  }

  purrr::map_chr(purrr::transpose(property_table %>% dplyr::select(property)),
                 ~glue::glue_data(.x, properties_create)) %>%
    paste(collapse = "\n")
}

# Set up property generation data frame
property_make_df <- tibble(class_name = names(all_properties_data)) %>%
  left_join(class_abbrs, by = "class_name")

# Generate all property code
property_txt <- purrr::pmap_chr(list(all_properties_data,
                                property_make_df$class_name,
                                property_make_df$class_internal),
                                ~create_properties(..1, ..2, ..3)) %>%
  paste(collapse = "\n")

cat("  - Generated property code\n\n")

# ------------------------------------------------------------------------------
# STEP 8: ASSEMBLE FINAL OUTPUT
# ------------------------------------------------------------------------------

cat("STEP 8: Assembling final R script...\n")

# Header
header <- "## This file was generated automatically by data-raw/build_5/generate_slim_lang_v5.R
## DO NOT EDIT BY HAND

## Documentation for SLiM 5.x API
## Auto-generated from SLiM RTF documentation files

"

# Combine all sections
r_script <- paste(header, all_methods_txt, "\n\n\n\n", all_methods_code, "\n\n\n\n",
                  property_txt, sep = "")

# Clean up text (handle special characters, smart quotes, etc.)
r_script <- r_script %>%
  # Replace control characters that unrtf uses for quotes/apostrophes
  str_replace_all("\u0019", "'") %>%  # EM control char -> apostrophe
  str_replace_all("\u001C", '"') %>%  # FS control char -> left double quote
  str_replace_all("\u001D", '"') %>%  # GS control char -> right double quote
  # Replace smart quotes with regular quotes
  str_replace_all("[\u2018\u2019]", "'") %>%  # Smart single quotes
  str_replace_all("[\u201C\u201D]", '"') %>%  # Smart double quotes
  # Replace en-dash and em-dash with regular dash
  str_replace_all("\u2013", "-") %>%  # En-dash
  str_replace_all("\u2014", "-") %>%  # Em-dash
  # Replace non-breaking space with regular space
  str_replace_all("\u00A0", " ") %>%
  # Replace special characters found in RTF
  str_replace_all("\u00A9", "(c)") %>%  # Copyright sign
  str_replace_all("\u00D7", "x") %>%  # Multiplication sign
  str_replace_all("\u00BC", "1/4") %>%  # Vulgar fraction one quarter
  str_replace_all("\u00BD", "1/2") %>%  # Vulgar fraction one half
  # Remove any other control characters (excluding tab, newline, carriage return)
  str_replace_all("\u0013", "")  # DC3/XOFF control char

cat("  - Assembled complete R script\n")
cat("  - Total length:", nchar(r_script), "characters\n\n")

# ------------------------------------------------------------------------------
# STEP 9: WRITE OUTPUT FILE
# ------------------------------------------------------------------------------

cat("STEP 9: Writing R/slim_lang_v5.R...\n")

output_file <- file.path(project_root, "R/slim_lang_v5.R")
writeLines(r_script, output_file)

cat("  - Wrote", output_file, "\n")
cat("  - File size:", file.size(output_file) / 1024, "KB\n\n")

# ------------------------------------------------------------------------------
# STEP 10: VALIDATE OUTPUT
# ------------------------------------------------------------------------------

cat("STEP 10: Validating generated code...\n")

# Try to parse the file to check for syntax errors
tryCatch({
  parse(output_file)
  cat("  - ✓ Generated R code is syntactically valid\n\n")
}, error = function(e) {
  cat("  - ✗ ERROR: Generated R code has syntax errors:\n")
  cat("   ", conditionMessage(e), "\n\n")
})

cat("=== GENERATION COMPLETE ===\n")
cat("\nNext steps:\n")
cat("1. Review R/slim_lang_v5.R\n")
cat("2. Generate internal class data (R/sysdata.rda)\n")
cat("3. Compare with v4 to identify breaking changes\n\n")
