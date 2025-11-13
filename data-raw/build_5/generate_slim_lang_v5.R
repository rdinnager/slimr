## Generate R Documentation and Class Objects for SLiM 5.x
## This script follows the v4 pattern:
## 1. Generate class objects and source them
## 2. Generate and source methods to populate class objects
## 3. Generate and source properties to populate class objects
## 4. Save class objects to R/sysdata.rda (internal package data)
## 5. Write roxygen documentation to R/slim_lang_v5.R

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
  project_root <- ".."
} else if (file.exists("data-raw/build_5/all_methods_data.rds")) {
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
cat("  - Loaded", length(slim_lang_intros), "class introductions\n")

# Escape backslashes in description fields for Rd format
# For roxygen2 → Rd conversion, backslashes need to be quadrupled:
# Original "\t" → R source "\\\\t" (4 backslashes) → Rd file "\\t" (2 backslashes) → Display "\t" (1 backslash)
cat("  - Escaping backslashes in descriptions for Rd format...\n")
all_methods_data <- lapply(all_methods_data, function(methods_df) {
  if (!is.null(methods_df) && "description" %in% names(methods_df)) {
    # Quadruple backslashes: \\ → \\\\\\\\ (1 backslash becomes 4)
    methods_df$description <- gsub("\\\\", "\\\\\\\\\\\\\\\\", methods_df$description)
  }
  methods_df
})
all_properties_data <- lapply(all_properties_data, function(props_df) {
  if (!is.null(props_df) && "description" %in% names(props_df)) {
    # Quadruple backslashes: \\ → \\\\\\\\ (1 backslash becomes 4)
    props_df$description <- gsub("\\\\", "\\\\\\\\\\\\\\\\", props_df$description)
  }
  props_df
})
slim_lang_intros <- sapply(slim_lang_intros, function(intro_text) {
  if (!is.null(intro_text) && is.character(intro_text)) {
    # Quadruple backslashes: \\ → \\\\\\\\ (1 backslash becomes 4)
    gsub("\\\\", "\\\\\\\\\\\\\\\\", intro_text)
  } else {
    intro_text
  }
})
cat("\n")

# ------------------------------------------------------------------------------
# STEP 2: SET UP CLASS ABBREVIATIONS
# ------------------------------------------------------------------------------

cat("STEP 2: Setting up class abbreviations...\n")

# Class abbreviations for v5
# Note: Initialize, SLiMBuiltin, and Eidos are slimr-created classes (not SLiM classes)
# New in v5: Haplosome (replaces Genome), Plot
# Removed from v4: Genome (.G), SLiMSim (.SS)
class_abbrs <- tibble::tribble(
  ~class_name,        ~class_abbr, ~class_internal,
  "Initialize",       "Init",      ".Init",
  "Chromosome",       "Ch",        ".Ch",
  "Community",        "Co",        ".Co",
  "Eidos",            "E",         ".E",
  "GenomicElement",   "GE",        ".GE",
  "GenomicElementType", "GET",     ".GET",
  "Haplosome",        "Ha",        ".Ha",      # New in v5 (replaces Genome)
  "Individual",       "In",        ".I",
  "InteractionType",  "IT",        ".IT",
  "LogFile",          "LF",        ".LF",
  "Mutation",         "M",         ".M",
  "MutationType",     "MT",        ".MT",
  "Plot",             "Pl",        ".Pl",      # New in v5
  "SLiMBuiltin",      "SB",        ".SB",      # slimr-created class for built-in functions
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

# Template for methods (NOT exported, except for Initialize and SLiMBuiltin)
func_template <- "
SLiM method <<r_function_name>>

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
<<ifelse(class_name %in% c('Initialize', 'SLiMBuiltin'), '@export', '')>>
<<ifelse(class_name %in% c('Initialize', 'SLiMBuiltin'), '@examples', '')>>
<<ifelse(class_name %in% c('Initialize', 'SLiMBuiltin'), '## This just brings up the documentation:', '')>>
<<ifelse(class_name %in% c('Initialize', 'SLiMBuiltin'), paste0(r_function_name, '()'), '')>>
#..<<r_function_name>> <- function(<<args_with_dots>>) {
#..  <<class_abbr>>$<<function_name>>(<<args_with_dots>>)
#..}"

# Template for Plot methods (exported with plot_ prefix)
plot_func_template <- "
SLiM method <<r_function_name>>

Documentation for SLiM function \\code{<<function_name>>}, which is a method of the SLiM class \\code{\\link{Plot}}.
Note that the R function is a stub, it does not do anything in R (except bring up this documentation). It will only do
anything useful when used inside a \\code{\\link{slim_block}} function further nested in a \\code{\\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a full SLiM script.

Documentation for this function can be found in the official SLiM manual at \\url{https://messerlab.org/slim/}.

<<params>>

@aliases Plot$<<function_name>> Pl$<<function_name>>
@family Plot
@return An object of type <<return_type_desc>>. <<ifelse(return_singleton, 'Return will be of length 1 (a singleton)', '')>>
@details <<description>>
@section Copyright:
This is documentation for a function in the SLiM software, and has been reproduced from the official manual,
which can be found here: \\url{https://messerlab.org/slim/}. This documentation is
Copyright © 2016-2025 Philipp Messer. All rights reserved. More information about SLiM can be found
on the official website: \\url{https://messerlab.org/slim/}
@author Benjamin C Haller (\\email{bhaller@@benhaller.com}) and Philipp W Messer (\\email{messer@@cornell.edu})
@export
#..<<r_function_name>> <- function(<<args_with_dots>>) {
#..  Pl$<<function_name>>(<<args_with_dots>>)
#..}"

# Template for Eidos functions (special case - no class association)
eidos_func_template <- "
SLiM function <<function_name>>

Documentation for SLiM function \\code{<<function_name>>}.
Note that the R function is a stub, it does not do anything in R (except bring up this documentation). It will only do
anything useful when used inside a \\code{\\link{slim_block}} function further nested in a \\code{\\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a full SLiM script.

Documentation for this function can be found in the official SLiM manual at \\url{https://messerlab.org/slim/}.

<<params>>

@aliases <<class_abbr>>$<<function_name>>
@family Eidos
@return An object of type <<return_type_desc>>. <<ifelse(return_singleton, 'Return will be of length 1 (a singleton)', '')>>
@details <<description>>
@section Copyright:
This is documentation for a function in the SLiM software, and has been reproduced from the official manual,
which can be found here: \\url{https://messerlab.org/slim/}. This documentation is
Copyright © 2016-2025 Philipp Messer. All rights reserved. More information about SLiM can be found
on the official website: \\url{https://messerlab.org/slim/}
@author Benjamin C Haller (\\email{bhaller@@benhaller.com}) and Philipp W Messer (\\email{messer@@cornell.edu})
@export
#..eidos_<<function_name>> <- function(<<args_with_dots>>) {
#..  <<class_abbr>>$<<function_name>>(<<args_with_dots>>)
#..}"

# Template for internal method code (no @export)
# IMPORTANT: Assign to all three: ClassName, Abbr, and .Internal for autocomplete
# Use #.. prefix so lines are treated as code (not roxygen comments)
method_code <- "
#..<<class_name>>$<<function_name>> <- <<class_abbr>>$<<function_name>> <- <<class_internal>>$<<function_name>> <- function(<<args_with_dots>>) {
#..  ?<<r_function_name>>
#..}
"

# Template for Eidos method code
# Use #.. prefix so lines are treated as code (not roxygen comments)
eidos_method_code <- "
#..<<class_abbr>>$<<function_name>> <- function(<<args_with_dots>>) {
#..  ?eidos_<<function_name>>
#..}
"

# Template for Plot method code (prefixed with plot_)
# Use #.. prefix so lines are treated as code (not roxygen comments)
plot_method_code <- "
#..<<class_name>>$<<function_name>> <- <<class_abbr>>$<<function_name>> <- <<class_internal>>$<<function_name>> <- function(<<args_with_dots>>) {
#..  ?plot_<<function_name>>
#..}
"

cat("  - Defined roxygen templates\n\n")

# ------------------------------------------------------------------------------
# STEP 4: DEFINE GENERATOR FUNCTIONS
# ------------------------------------------------------------------------------

cat("STEP 4: Defining generator functions...\n")

# Function to format arguments for documentation
format_params <- function(arg_data) {
  if (is.null(arg_data) || length(arg_data) == 0) {
    return("")  # No parameters
  }

  args_df <- arg_data[[1]]

  if (nrow(args_df) == 0) {
    return("")  # No parameters
  }

  param_lines <- purrr::map_chr(seq_len(nrow(args_df)), function(i) {
    arg_name <- args_df$arg_name[i]
    arg_type_desc <- if(!is.na(args_df$arg_type_desc[i])) args_df$arg_type_desc[i] else "object"
    singleton <- if(args_df$arg_singleton[i]) " (singleton)" else ""

    paste0("@param ", arg_name, " An object of type ", arg_type_desc, singleton, ".")
  })

  paste(param_lines, collapse = "\n")
}

# Function to format arguments for function signature
format_args <- function(arg_data) {
  if (is.null(arg_data) || length(arg_data) == 0) {
    return("")  # No arguments
  }

  args_df <- arg_data[[1]]

  if (nrow(args_df) == 0) {
    return("")  # No arguments
  }

  args_list <- purrr::map_chr(seq_len(nrow(args_df)), function(i) {
    arg_name <- args_df$arg_name[i]
    arg_default <- args_df$arg_default[i]

    if (!is.na(arg_default)) {
      paste0(arg_name, " = NULL")
    } else {
      arg_name
    }
  })

  paste(args_list, collapse = ", ")
}

# Function to generate a single method/function documentation
make_slim_function <- function(method_row, class_name, class_abbr, class_internal, template) {
  # Extract data from method row
  function_name <- method_row$function_name
  return_type <- method_row$return_type
  return_type_desc <- method_row$return_type_desc
  return_singleton <- method_row$return_singleton
  description <- method_row$description
  arg_data <- method_row$arg_data

  # For Plot class, prefix function name with plot_ to avoid R base function conflicts
  # For Eidos class, prefix is added in the template (eidos_)
  # r_function_name is the name used for R documentation (with prefix if needed)
  if (class_name == "Plot") {
    r_function_name <- paste0("plot_", function_name)
  } else {
    r_function_name <- function_name
  }

  # Format parameters
  params <- format_params(arg_data)
  args_with_dots <- format_args(arg_data)

  # Create data for glue
  func_data <- list(
    class_name = class_name,
    class_abbr = class_abbr,
    class_internal = class_internal,
    function_name = function_name,  # Original SLiM method name
    r_function_name = r_function_name,  # R function name (with prefix if needed)
    return_type = return_type,
    return_type_desc = return_type_desc,
    return_singleton = return_singleton,
    description = description,
    params = params,
    args_with_dots = args_with_dots
  )

  # Generate using template
  func_txt <- glue::glue_data(func_data, template, .open = "<<", .close = ">>")

  # Add #' prefix to each line for roxygen
  # Lines starting with #.. should not get the #' prefix (they're R code, not roxygen)
  func_txt_lines <- str_split(func_txt, "\n")[[1]]
  func_txt_roxygen <- ifelse(str_starts(func_txt_lines, "#\\.\\."),
                              str_remove(func_txt_lines, "^#\\.\\."),
                              paste0("#' ", func_txt_lines))

  paste(func_txt_roxygen, collapse = "\n")
}

# Function to generate all methods for a class
make_class_funcs <- function(method_table, class_name, class_internal, template) {
  if (is.null(method_table) || nrow(method_table) == 0) {
    return("")
  }

  class_abbr <- class_abbrs$class_abbr[class_abbrs$class_name == class_name]

  methods_list <- purrr::map(seq_len(nrow(method_table)),
                             ~method_table[.x, ])

  methods_txt <- purrr::map_chr(methods_list,
                                ~make_slim_function(.x,
                                                    class_name,
                                                    class_abbr,
                                                    class_internal,
                                                    template))
  paste(methods_txt, collapse = "\n\n")
}

cat("  - Defined generator functions\n\n")

# ------------------------------------------------------------------------------
# STEP 5: GENERATE CLASS CREATION CODE
# ------------------------------------------------------------------------------

cat("STEP 5: Generating class creation code...\n")

# Template: ClassName <- Abbr <- .Abbr <- list()
class_create <- "{class_name} <- {class_abbr} <- {class_internal} <- list()"

class_make_code <- purrr::pmap_chr(
  list(class_abbrs$class_name, class_abbrs$class_abbr, class_abbrs$class_internal),
  ~glue::glue(class_create, class_name = ..1, class_abbr = ..2, class_internal = ..3)
) %>%
  paste(collapse = "\n")

cat("  - Generated class creation code\n\n")

# ------------------------------------------------------------------------------
# STEP 6: GENERATE METHOD ASSIGNMENT CODE
# ------------------------------------------------------------------------------

cat("STEP 6: Generating method assignment code...\n")

# Set up method generation data frame
method_make_df <- tibble(class_name = names(all_methods_data)) %>%
  left_join(class_abbrs, by = "class_name") %>%
  mutate(method_template = map(class_name,
                               ~if(.x == "Eidos") {
                                 eidos_method_code
                               } else if(.x == "Plot") {
                                 plot_method_code
                               } else {
                                 method_code
                               }))

# Generate internal method code
all_methods_code <- purrr::pmap_chr(
  list(all_methods_data,
       method_make_df$class_name,
       method_make_df$class_internal,
       method_make_df$method_template),
  ~make_class_funcs(..1, ..2, ..3, ..4)
) %>%
  paste(collapse = "\n\n")

# Fix wrapping issues
all_methods_code <- stringr::str_replace_all(all_methods_code, "\n\\<\\-", " <-")
all_methods_code <- stringr::str_replace_all(all_methods_code, "\n\\$", "$")

cat("  - Generated method assignment code\n\n")

# ------------------------------------------------------------------------------
# STEP 7: GENERATE PROPERTY ASSIGNMENT CODE
# ------------------------------------------------------------------------------

cat("STEP 7: Generating property assignment code...\n")

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
property_txt <- purrr::pmap_chr(
  list(all_properties_data,
       property_make_df$class_name,
       property_make_df$class_internal),
  ~create_properties(..1, ..2, ..3)
) %>%
  paste(collapse = "\n")

cat("  - Generated property assignment code\n\n")

# ------------------------------------------------------------------------------
# STEP 8: SOURCE CODE TO CREATE CLASS OBJECTS
# ------------------------------------------------------------------------------

cat("STEP 8: Sourcing code to create class objects...\n")

# Create temporary R script
temp_source <- tempfile(fileext = ".R")

# Source class creation code
writeLines(class_make_code, temp_source)
source(temp_source)
cat("  - Created class objects\n")

# Source method assignment code
writeLines(all_methods_code, temp_source)
source(temp_source)
cat("  - Populated methods\n")

# Source property assignment code
writeLines(property_txt, temp_source)
source(temp_source)
cat("  - Populated properties\n\n")

# ------------------------------------------------------------------------------
# STEP 9: GENERATE ROXYGEN DOCUMENTATION
# ------------------------------------------------------------------------------

cat("STEP 9: Generating roxygen documentation...\n")

# Generate roxygen documentation (for R/slim_lang_v5.R)
method_make_df_doc <- method_make_df %>%
  mutate(doc_template = map(class_name,
                            ~if(.x == "Eidos") {
                              eidos_func_template
                            } else if(.x == "Plot") {
                              plot_func_template
                            } else {
                              func_template
                            }))

all_methods_txt <- purrr::pmap_chr(
  list(all_methods_data,
       method_make_df_doc$class_name,
       method_make_df_doc$class_internal,
       method_make_df_doc$doc_template),
  ~make_class_funcs(..1, ..2, ..3, ..4)
) %>%
  paste(collapse = "\n\n\n\n")

cat("  - Generated roxygen documentation\n\n")

# ------------------------------------------------------------------------------
# STEP 10: GENERATE CLASS DOCUMENTATION
# ------------------------------------------------------------------------------

cat("STEP 10: Generating class documentation...\n")

# Property roxygen template
property_roxy <- "\\item{<<property>>}{A property of type <<property_type_desc>>. <<ifelse(property_singleton, 'It is of length one (a singleton).', '')>> This property is <<modifiable>>. \\strong{Property Description:} <<description>>}"

# Function to make property roxygen
make_property_roxy <- function(property_table) {
  if (is.null(property_table) || nrow(property_table) == 0) {
    return("\\item{None.}{This class has no properties.}")
  }

  purrr::map_chr(purrr::transpose(property_table),
                 ~glue::glue_data(.x, property_roxy,
                                  .open = "<<",
                                  .close = ">>")) %>%
    paste(collapse = "\n")
}

# Combine all class data
all_class_data <- class_abbrs %>%
  left_join(tibble(class_name = names(all_methods_data),
                   function_name = map(all_methods_data, ~.x$function_name)),
            by = "class_name") %>%
  left_join(tibble(class_name = names(all_properties_data),
                   properties_data = all_properties_data),
            by = "class_name") %>%
  left_join(tibble(class_name = names(slim_lang_intros),
                   intro_text = slim_lang_intros),
            by = "class_name")

# Class roxygen template
class_roxy <- "
<<class_name>>

Documentation for <<class_name>> class from SLiM

@name <<class_name>>
@rdname <<class_name>>_Class
@export
@aliases <<class_abbr>>
@family <<class_name>>
@details <<intro_text>>
This class has the following methods (functions):
\\itemize{
<<ifelse(!is.null(function_name) && length(function_name[[1]]) > 0, paste0('\\\\item{\\\\code{\\\\link{', function_name[[1]], '}}}') %>% paste(collapse = '\n'), '\\\\item{None. This class has no methods.}')>>
}
This class has the following properties:
\\describe{
<<property_list>>
}
#..NULL"

# Generate class documentation
all_class_data <- all_class_data %>%
  mutate(property_list = map(properties_data, ~make_property_roxy(.x)))

class_roxies <- purrr::pmap_chr(
  list(all_class_data$class_name,
       all_class_data$class_abbr,
       all_class_data$intro_text,
       all_class_data$function_name,
       all_class_data$property_list),
  function(class_name, class_abbr, intro_text, function_name, property_list) {
    roxy_txt <- glue::glue(class_roxy,
                           .open = "<<",
                           .close = ">>")

    # Add #' prefix to each line for roxygen
    # Lines starting with #.. should not get the #' prefix (they're R code, not roxygen)
    roxy_lines <- str_split(roxy_txt, "\n")[[1]]
    roxy_with_prefix <- ifelse(str_starts(roxy_lines, "#\\.\\."),
                                str_remove(roxy_lines, "^#\\.\\."),
                                paste0("#' ", roxy_lines))

    paste(roxy_with_prefix, collapse = "\n")
  }
) %>%
  paste(collapse = "\n\n\n\n")

cat("  - Generated class documentation\n\n")

# ------------------------------------------------------------------------------
# STEP 11: ASSEMBLE AND WRITE R/slim_lang.R
# ------------------------------------------------------------------------------

cat("STEP 11: Assembling R/slim_lang.R...\n")

# Combine documentation sections
r_script <- paste(
  all_methods_txt,
  class_roxies,
  sep = "\n\n\n\n\n\n\n\n"
)

# Clean up special characters
r_script <- r_script %>%
  str_replace_all("\u0019", "'") %>%
  str_replace_all("\u001C", '"') %>%
  str_replace_all("\u001D", '"') %>%
  str_replace_all("[\u2018\u2019]", "'") %>%
  str_replace_all("[\u201C\u201D]", '"') %>%
  str_replace_all("\u2013", "-") %>%
  str_replace_all("\u2014", "-") %>%
  str_replace_all("\u00A0", " ") %>%
  str_replace_all("\u00A9", "(c)") %>%
  str_replace_all("\u00D7", "x") %>%
  str_replace_all("\u00BC", "1/4") %>%
  str_replace_all("\u00BD", "1/2") %>%
  str_replace_all("\u0013", "")

# Write to R/slim_lang.R
output_file <- file.path(project_root, "R/slim_lang.R")
writeLines(r_script, output_file)

cat("  - Wrote", output_file, "\n")
cat("  - File size:", file.size(output_file) / 1024, "KB\n\n")

# ------------------------------------------------------------------------------
# STEP 12: SAVE CLASS OBJECTS TO SYSDATA.RDA
# ------------------------------------------------------------------------------

cat("STEP 12: Saving class objects to R/sysdata.rda...\n")

# Create slim_classes lookup table
slim_classes <- class_abbrs

# Save all class objects as internal package data
# Note: Must use individual object names, not a list
usethis::use_data(.Init,
                  .Ch,
                  .Co,
                  .E,
                  .GE,
                  .GET,
                  .Ha,      # New in v5 (replaces .G)
                  .I,
                  .IT,
                  .LF,
                  .M,
                  .MT,
                  .Pl,      # New in v5
                  .SB,      # SLiMBuiltin (slimr-created class)
                  .SEB,
                  .SG,
                  .SM,
                  .Sp,
                  .P,
                  .S,
                  internal = TRUE,
                  overwrite = TRUE)

# Save slim_classes as external data
usethis::use_data(slim_classes, internal = FALSE, overwrite = TRUE)

cat("  - Saved class objects to R/sysdata.rda\n")
cat("  - Saved slim_classes to data/slim_classes.rda\n\n")

# ------------------------------------------------------------------------------
# SUMMARY
# ------------------------------------------------------------------------------

cat("=== GENERATION COMPLETE ===\n\n")

cat("Generated files:\n")
cat("  - R/slim_lang.R: Roxygen documentation (", file.size(output_file) / 1024, " KB)\n", sep="")
cat("  - R/sysdata.rda: Internal class objects\n")
cat("  - data/slim_classes.rda: Class lookup table\n\n")

cat("Classes created:", nrow(class_abbrs), "\n")
cat("Methods documented:", sum(map_int(all_methods_data, nrow)), "\n")
cat("Properties created:", sum(map_int(all_properties_data, nrow)), "\n\n")

cat("Next steps:\n")
cat("1. Verify R/slim_lang.R loads without errors\n")
cat("2. Test that class objects work with slim_load_globals()\n")
cat("3. Run devtools::document() to regenerate .Rd files\n")
cat("4. Run devtools::check() to verify package\n")
