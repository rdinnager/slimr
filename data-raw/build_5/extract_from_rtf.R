## RTF Extraction Script for SLiM 5.x API Documentation
## This script extracts complete API information from RTF files in SLiM's GitHub repository
## Output format matches the v4 build_slimrlang.R data structures for compatibility

library(unrtf)
library(stringr)
library(dplyr)
library(purrr)
library(tidyr)
library(readr)
library(glue)

cat("=== SLiM 5.x RTF EXTRACTION PIPELINE ===\n\n")

# ------------------------------------------------------------------------------
# STEP 1: EXTRACT PLAIN TEXT FROM RTF FILES
# ------------------------------------------------------------------------------

cat("STEP 1: Extracting plain text from RTF files...\n")

# Determine project root - try multiple methods
if (file.exists("../slim_man/SLiMHelpClasses.rtf")) {
  # Running from data-raw/build_5
  project_root <- "../.."
} else if (file.exists("slim_man/SLiMHelpClasses.rtf")) {
  # Running from data-raw
  project_root <- ".."
} else if (file.exists("data-raw/slim_man/SLiMHelpClasses.rtf")) {
  # Running from project root
  project_root <- "."
} else {
  stop("Cannot find RTF files. Please run from project root, data-raw/, or data-raw/build_5/")
}

classes_rtf_path <- normalizePath(file.path(project_root, "data-raw/slim_man/SLiMHelpClasses.rtf"), mustWork = FALSE)
functions_rtf_path <- normalizePath(file.path(project_root, "data-raw/slim_man/SLiMHelpFunctions.rtf"), mustWork = FALSE)
eidos_rtf_path <- normalizePath(file.path(project_root, "data-raw/slim_man/EidosHelpFunctions.rtf"), mustWork = FALSE)

# Check for pre-extracted text files (for faster re-runs)
classes_txt_path <- file.path(project_root, "data-raw/slim_man/SLiMHelpClasses_unrtf.txt")
functions_txt_path <- file.path(project_root, "data-raw/slim_man/SLiMHelpFunctions_unrtf.txt")
eidos_txt_path <- file.path(project_root, "data-raw/slim_man/EidosHelpFunctions_unrtf.txt")

if (file.exists(classes_txt_path) && file.exists(functions_txt_path) && file.exists(eidos_txt_path)) {
  cat("  - Using pre-extracted text files (faster)\n")
  classes_text <- readLines(classes_txt_path, warn = FALSE) %>% paste(collapse = "\n")
  functions_text <- readLines(functions_txt_path, warn = FALSE) %>% paste(collapse = "\n")
  eidos_text <- readLines(eidos_txt_path, warn = FALSE) %>% paste(collapse = "\n")
} else {
  cat("  - Extracting from RTF files using unrtf package...\n")
  if (!file.exists(classes_rtf_path)) {
    stop("RTF file not found: ", classes_rtf_path)
  }
  if (!file.exists(functions_rtf_path)) {
    stop("RTF file not found: ", functions_rtf_path)
  }
  if (!file.exists(eidos_rtf_path)) {
    stop("RTF file not found: ", eidos_rtf_path)
  }

  # Extract plain text from RTF using unrtf
  cat("    - Converting classes file...\n")
  classes_text <- unrtf(classes_rtf_path, format = "text")
  cat("    - Converting SLiM functions file...\n")
  functions_text <- unrtf(functions_rtf_path, format = "text")
  cat("    - Converting Eidos functions file...\n")
  eidos_text <- unrtf(eidos_rtf_path, format = "text")

  # Clean up artifacts from unrtf conversion
  # Remove "### invalid font number" and similar artifacts
  clean_unrtf_text <- function(text) {
    text %>%
      # Remove ### invalid font number lines
      str_replace_all("###\\s*invalid\\s+font\\s+number[^\n]*\n?", "") %>%
      # Remove any remaining ### markers that might be artifacts
      str_replace_all("###[^\n]*\n?", "") %>%
      # Clean up extra whitespace
      str_replace_all("\n\n\n+", "\n\n") %>%
      str_trim()
  }

  cat("    - Cleaning up conversion artifacts...\n")
  classes_text <- clean_unrtf_text(classes_text)
  functions_text <- clean_unrtf_text(functions_text)
  eidos_text <- clean_unrtf_text(eidos_text)

  cat("    - Cleaning control characters and special symbols...\n")
  # Clean control characters and special characters BEFORE parsing
  # This ensures property/method extraction patterns work correctly
  clean_control_chars <- function(text) {
    text %>%
      # Replace control characters that unrtf uses for quotes/apostrophes/dashes
      str_replace_all("\u0013", "-") %>%  # DC3/XOFF control char -> dash (used in en-dash)
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
      str_replace_all(fixed("{0, 1, 2, &}"), "(0, 1, 2, &)")  # Replace braces with parentheses to avoid Rd issues
  }

  classes_text <- clean_control_chars(classes_text)
  functions_text <- clean_control_chars(functions_text)
  eidos_text <- clean_control_chars(eidos_text)

  # Save extracted and cleaned text for future runs
  cat("    - Saving cleaned text for future runs...\n")
  writeLines(classes_text, classes_txt_path)
  writeLines(functions_text, functions_txt_path)
  writeLines(eidos_text, eidos_txt_path)
}

cat("  - Classes file:", nchar(classes_text), "characters\n")
cat("  - SLiM functions file:", nchar(functions_text), "characters\n")
cat("  - Eidos functions file:", nchar(eidos_text), "characters\n\n")

# Save extracted text for debugging/reference
extracted_dir <- file.path(project_root, "data-raw/build_5/extracted")
dir.create(extracted_dir, showWarnings = FALSE, recursive = TRUE)
writeLines(classes_text, file.path(extracted_dir, "classes_text.txt"))
writeLines(functions_text, file.path(extracted_dir, "functions_text.txt"))
writeLines(eidos_text, file.path(extracted_dir, "eidos_text.txt"))

# ------------------------------------------------------------------------------
# STEP 2: TYPE SYSTEM (reuse from v4)
# ------------------------------------------------------------------------------

cat("STEP 2: Setting up type system...\n")

type_legend <- tibble(
  abbr = c("v", "N", "i", "f", "l", "s", "n", "+", "*"),
  type = c("void", "null", "integer", "float", "logical", "string",
           "numeric", "any but object", "any")
)

# Function to decode SLiM type annotations (from v4 build_slimrlang.R)
collect_types <- function(arg_type) {
  obs <- str_match(arg_type, "o(bject)?<(.*?)>")
  new_arg_types <- str_remove_all(arg_type, "o(bject)?<(.*?)>")
  types <- str_match(new_arg_types, "void|integer|float|logical|string|numeric|\\+|\\*")
  types[, 1] <- str_sub(types[, 1], 1, 1)
  if (any(is.na(types[, 1]))) {
    multiple_types <- str_match_all(new_arg_types, "(v|N|i|f|l|s)")
    multiple_types <- map(multiple_types, ~.x[, 2])
    multiple_types[!is.na(types[, 1])] <- types[!is.na(types[, 1]), 1]
    types <- multiple_types
  } else {
    types <- list(types[, 1])
  }

  types <- map_chr(types, ~ tibble(abbr = .x) %>%
                     left_join(type_legend, by = "abbr") %>%
                     pull(type) %>%
                     paste(collapse = " or "))

  types[types == ""] <- NA

  objects <- obs[, 3]
  objects[!is.na(objects)] <- paste(objects[!is.na(objects)], "object")
  types <- cbind(types, objects)
  types <- apply(types, 1, function(x) paste(na.omit(x), collapse = " or "))
  types
}

cat("  - Type legend created\n\n")

# ------------------------------------------------------------------------------
# STEP 3: PARSE CLASSES FILE
# ------------------------------------------------------------------------------

cat("STEP 3: Parsing classes file (SLiMHelpClasses.rtf)...\n")

# RTF extraction removes all line breaks, so text is on one continuous line
# We need to intelligently split it based on structural markers

# Strategy:
# 1. Find all class headers: "5.2  Class Chromosome"
# 2. For each class, find property and method sections
# 3. Extract individual properties and methods with descriptions

# Split into "lines" where structure changes occur
# unrtf output already has good line breaks - we just need to clean it up
classes_text_formatted <- classes_text %>%
  # Normalize line endings
  str_replace_all("\r\n", "\n") %>%
  str_replace_all("\r", "\n")

# Split into lines
# Don't use str_trim() here because methods start with a space!
classes_lines <- str_split(classes_text_formatted, "\n")[[1]] %>%
  .[. != ""]

# Find all class headers (e.g., "5.2  Class Chromosome")
class_header_pattern <- "^(\\d+\\.\\d+)\\s+Class\\s+(\\w+)"
class_header_indices <- which(str_detect(classes_lines, class_header_pattern))
class_matches <- str_match(classes_lines[class_header_indices], class_header_pattern)
class_names <- class_matches[, 3]

cat("  - Found", length(class_names), "classes:", paste(class_names, collapse = ", "), "\n")

# Extract each class's content
extract_class_data <- function(class_idx) {
  class_name <- class_names[class_idx]
  start_line <- class_header_indices[class_idx]

  # Find end of this class (start of next class or end of file)
  if (class_idx < length(class_header_indices)) {
    end_line <- class_header_indices[class_idx + 1] - 1
  } else {
    end_line <- length(classes_lines)
  }

  class_lines <- classes_lines[start_line:end_line]

  # Find property and method sections
  # Pattern: "5.2.1  Chromosome properties"
  prop_section_idx <- which(str_detect(class_lines, paste0(class_name, "\\s+properties")))[1]
  method_section_idx <- which(str_detect(class_lines, paste0(class_name, "\\s+methods")))[1]

  list(
    class_name = class_name,
    class_lines = class_lines,
    prop_section_idx = prop_section_idx,
    method_section_idx = method_section_idx
  )
}

all_class_data_raw <- map(seq_along(class_names), extract_class_data)
names(all_class_data_raw) <- class_names

# ------------------------------------------------------------------------------
# STEP 4: EXTRACT PROPERTIES
# ------------------------------------------------------------------------------

cat("STEP 4: Extracting properties from each class...\n")

extract_properties_from_class <- function(class_data) {
  class_name <- class_data$class_name
  class_lines <- class_data$class_lines
  prop_section_idx <- class_data$prop_section_idx
  method_section_idx <- class_data$method_section_idx

  if (is.na(prop_section_idx) || is.na(method_section_idx)) {
    # No properties section
    return(NULL)
  }

  # Property lines are between property section header and method section header
  prop_lines <- class_lines[(prop_section_idx + 1):(method_section_idx - 1)]

  # Find property definitions (name followed by => or <-> )
  # After control character cleanup, all arrows use regular ASCII dash
  prop_def_pattern <- "^([a-zA-Z]\\w*)\\s+(=>|<->)\\s+\\(([^)]+)\\)"
  prop_def_indices <- which(str_detect(prop_lines, prop_def_pattern))

  if (length(prop_def_indices) == 0) {
    return(NULL)
  }

  # Extract each property with its description
  extract_one_property <- function(prop_idx) {
    prop_line <- prop_lines[prop_def_indices[prop_idx]]

    # Parse property definition
    matches <- str_match(prop_line, prop_def_pattern)
    prop_name <- matches[, 2]
    symbol <- matches[, 3]
    prop_type <- matches[, 4]

    # Description is the rest of the property line plus any following lines
    # until the next property definition or section end
    if (prop_idx < length(prop_def_indices)) {
      next_prop_idx <- prop_def_indices[prop_idx + 1]
      desc_lines <- prop_lines[prop_def_indices[prop_idx]:(next_prop_idx - 1)]
    } else {
      desc_lines <- prop_lines[prop_def_indices[prop_idx]:length(prop_lines)]
    }

    # Remove the property definition from the first line to get just description
    desc_lines[1] <- str_remove(desc_lines[1], prop_def_pattern) %>% str_trim()
    description <- paste(desc_lines, collapse = " ") %>% str_trim()

    tibble(
      property = prop_name,
      symbol = symbol,
      property_type = prop_type,
      description = description
    )
  }

  map_dfr(seq_along(prop_def_indices), extract_one_property) %>%
    mutate(
      property_type_desc = collect_types(property_type),
      property_singleton = str_detect(property_type, "\\$"),
      modifiable = ifelse(symbol == "<->",
                          "a variable, so it is modifiable",
                          "a constant, so it is not modifiable")
    )
}

all_properties_data <- map(all_class_data_raw, extract_properties_from_class)
all_properties_data <- all_properties_data[!map_lgl(all_properties_data, is.null)]

cat("  - Extracted properties for", length(all_properties_data), "classes\n")
for (cls in names(all_properties_data)) {
  n_props <- nrow(all_properties_data[[cls]])
  cat("    -", cls, ":", n_props, "properties\n")
}
cat("\n")

# ------------------------------------------------------------------------------
# STEP 5: EXTRACT METHODS
# ------------------------------------------------------------------------------

cat("STEP 5: Extracting methods from each class...\n")

extract_methods_from_class <- function(class_data) {
  class_name <- class_data$class_name
  class_lines <- class_data$class_lines
  method_section_idx <- class_data$method_section_idx

  if (is.na(method_section_idx)) {
    # No methods section
    return(NULL)
  }

  # Method lines start after method section header
  method_lines <- class_lines[(method_section_idx + 1):length(class_lines)]

  # Find method signatures
  # After control character cleanup: en-dash (0x13 0xA0) becomes "- " (dash + space)
  # Pattern matches: [+ or -] + space + (returnType)methodName(
  # "-" = instance method, "+" = class method
  method_def_pattern <- "^[+-] \\(([^)]+)\\)([a-zA-Z_]\\w*)\\("
  method_def_indices <- which(str_detect(method_lines, method_def_pattern))

  # Debug: print first few method lines for first class
  if (class_name == "Chromosome" && FALSE) {  # Set to TRUE to enable debug
    cat("\n=== DEBUG: Chromosome method section ===\n")
    cat("Method section index:", method_section_idx, "\n")
    cat("Number of method lines:", length(method_lines), "\n")
    cat("First 10 method lines:\n")
    for (i in 1:min(10, length(method_lines))) {
      cat(sprintf("Line %d: '%s'\n", i, method_lines[i]))
    }
    cat("Pattern:", method_def_pattern, "\n")
    cat("Pattern matches:", length(method_def_indices), "\n")
    # Test pattern on first line
    test_line <- method_lines[1]
    cat("Testing pattern on line 1:\n")
    cat("  Line length:", nchar(test_line), "\n")
    cat("  First 5 chars (hex):", paste(sprintf("%02X", utf8ToInt(substr(test_line, 1, 5))), collapse=" "), "\n")
    cat("  Starts with space:", substr(test_line, 1, 1) == " ", "\n")
    cat("  Starts with (:", substr(test_line, 2, 2) == "(", "\n")
    # Try simpler patterns
    cat("  Matches '^ ':", str_detect(test_line, "^ "), "\n")
    cat("  Matches '^ \\(':", str_detect(test_line, "^ \\("), "\n")
    cat("  Matches '\\(is\\)':", str_detect(test_line, "\\(is\\)"), "\n")
    cat("  str_detect result:", str_detect(test_line, method_def_pattern), "\n")
    cat("=== END DEBUG ===\n\n")
  }

  if (length(method_def_indices) == 0) {
    return(NULL)
  }

  # Extract each method with its description
  extract_one_method <- function(method_idx) {
    method_line <- method_lines[method_def_indices[method_idx]]

    # Parse method signature - after cleanup, en-dash becomes "- " or plus becomes "+ "
    # Capture the symbol (+ or -) for class vs instance methods
    full_pattern <- "^[+-] \\(([^)]+)\\)([a-zA-Z_]\\w*)\\((.*)\\)\\s*$"
    matches <- str_match(method_line, full_pattern)
    return_type <- matches[, 2]
    method_name <- matches[, 3]
    arguments <- matches[, 4]

    # Description follows until next method or end of section
    if (method_idx < length(method_def_indices)) {
      next_method_idx <- method_def_indices[method_idx + 1]
      desc_lines <- method_lines[method_def_indices[method_idx]:(next_method_idx - 1)]
    } else {
      desc_lines <- method_lines[method_def_indices[method_idx]:length(method_lines)]
    }

    # Remove the method definition from the first line (use full_pattern to remove complete signature)
    desc_lines[1] <- str_remove(desc_lines[1], full_pattern) %>% str_trim()
    description <- paste(desc_lines, collapse = " ") %>% str_trim()

    # Parse arguments (reuse logic from v4)
    gather_args <- function(args_txt) {
      if (args_txt == "" || is.na(args_txt) || args_txt == ")") {
        return(tibble(
          args = character(0),
          arg_num = integer(0),
          arg_type = character(0),
          arg_name = character(0),
          arg_default = character(0),
          arg_type_desc = character(0),
          arg_singleton = logical(0)
        ))
      }

      # Remove trailing parenthesis if present
      args_txt <- str_remove(args_txt, "\\)$")

      # Smart split: split by comma but not if inside quotes
      split_args <- function(text) {
        parts <- character()
        current <- ""
        in_quotes <- FALSE
        quote_char <- ""

        for (i in seq_len(nchar(text))) {
          char <- substr(text, i, i)

          if (char %in% c('"', "'") && !in_quotes) {
            in_quotes <- TRUE
            quote_char <- char
            current <- paste0(current, char)
          } else if (char == quote_char && in_quotes) {
            in_quotes <- FALSE
            quote_char <- ""
            current <- paste0(current, char)
          } else if (char == "," && !in_quotes) {
            parts <- c(parts, str_trim(current))
            current <- ""
          } else {
            current <- paste0(current, char)
          }
        }

        if (nchar(current) > 0) {
          parts <- c(parts, str_trim(current))
        }

        parts
      }

      args_list <- split_args(args_txt)

      arg_df <- tibble(args = args_list) %>%
        mutate(arg_num = 1:n())

      # Try to parse each argument
      patterns <- arg_df$args %>%
        map_dfr(function(arg) {
          # Try optional parameter: [type name = default]
          if (str_detect(arg, "^\\[.*\\]$")) {
            arg <- str_remove_all(arg, "^\\[|\\]$")
            parts <- str_match(arg, "^([^\\s]+)\\s+([^\\s=]+)\\s*=\\s*(.+)$")
            if (!is.na(parts[1, 1])) {
              return(tibble(arg_type = parts[1, 2], arg_name = parts[1, 3], arg_default = parts[1, 4]))
            }
          }
          # Try required parameter: type name
          parts <- str_match(arg, "^([^\\s]+)\\s+([^\\s=]+)$")
          if (!is.na(parts[1, 1])) {
            return(tibble(arg_type = parts[1, 2], arg_name = parts[1, 3], arg_default = NA_character_))
          }
          # Fallback: just name
          tibble(arg_type = NA_character_, arg_name = str_trim(arg), arg_default = NA_character_)
        })

      arg_df <- bind_cols(arg_df, patterns)

      if (any(!is.na(arg_df$arg_type))) {
        types <- collect_types(arg_df$arg_type)
      } else {
        types <- rep(NA_character_, nrow(arg_df))
      }

      arg_df <- arg_df %>%
        mutate(
          arg_type_desc = types,
          arg_singleton = ifelse(!is.na(arg_type), str_detect(arg_type, "\\$"), FALSE)
        )

      arg_df
    }

    arg_data <- list(gather_args(arguments))

    tibble(
      symbol = substr(method_line, 1, 1),  # Capture actual + or - symbol
      function_name = method_name,
      return_type = return_type,
      arguments = arguments,
      description = description,
      arg_data = arg_data,
      signature = paste0("(", return_type, ")", method_name, "(", arguments, ")")
    )
  }

  map_dfr(seq_along(method_def_indices), extract_one_method) %>%
    mutate(
      return_type_desc = collect_types(return_type),
      return_singleton = str_detect(return_type, "\\$")
    )
}

all_methods_data <- map(all_class_data_raw, extract_methods_from_class)
all_methods_data <- all_methods_data[!map_lgl(all_methods_data, is.null)]

cat("  - Extracted methods for", length(all_methods_data), "classes\n")
for (cls in names(all_methods_data)) {
  n_methods <- nrow(all_methods_data[[cls]])
  cat("    -", cls, ":", n_methods, "methods\n")
}
cat("\n")

# ------------------------------------------------------------------------------
# STEP 6: EXTRACT CLASS INTRODUCTIONS
# ------------------------------------------------------------------------------

cat("STEP 6: Extracting class introduction text...\n")

extract_class_intro <- function(class_data) {
  class_name <- class_data$class_name
  class_lines <- class_data$class_lines
  prop_section_idx <- class_data$prop_section_idx

  if (is.na(prop_section_idx)) {
    # Introduction is from class header to end
    intro_lines <- class_lines[2:length(class_lines)]
  } else {
    # Introduction is from class header to property section
    intro_lines <- class_lines[2:(prop_section_idx - 1)]
  }

  intro <- paste(intro_lines, collapse = " ") %>% str_trim()
  intro
}

slim_lang_intros <- map_chr(all_class_data_raw, extract_class_intro)
names(slim_lang_intros) <- class_names

cat("  - Extracted introductions for", length(slim_lang_intros), "classes\n\n")

# ------------------------------------------------------------------------------
# STEP 7: PARSE FUNCTIONS FILE (Initialize and Eidos functions)
# ------------------------------------------------------------------------------

cat("STEP 7: Parsing functions file (SLiMHelpFunctions.rtf)...\n")

# Format functions text similarly to classes
functions_text_formatted <- functions_text %>%
  # Add newline before function signatures: (returnType)functionName(
  str_replace_all("\\(([void|integer|float|logical|string|numeric|object]+[^)]*?)\\)([a-zA-Z_]\\w*)\\(", "\n(\\1)\\2(")

functions_lines <- str_split(functions_text_formatted, "\n")[[1]] %>%
  str_trim() %>%
  .[. != ""]

# Find function signatures
func_sig_pattern <- "^\\(([^)]+)\\)([a-zA-Z_]\\w*)\\((.*)$"
func_sig_indices <- which(str_detect(functions_lines, func_sig_pattern))

cat("  - Found", length(func_sig_indices), "function signatures\n")

# Check if any functions were found
if (length(func_sig_indices) == 0) {
  cat("  - WARNING: No functions found in RTF file. Creating empty data structures.\n")

  # Create empty data frames with correct structure
  initialize_functions <- tibble(
    function_name = character(0),
    return_type = character(0),
    arguments = character(0),
    description = character(0),
    arg_data = list(),
    return_type_desc = character(0),
    return_singleton = logical(0)
  )

  eidos_functions <- initialize_functions

} else {
  # Extract Initialize functions vs Eidos functions
  # Heuristic: initialize* functions are Initialize, others are Eidos/Builtin

  extract_one_function <- function(func_idx) {
  func_line <- functions_lines[func_sig_indices[func_idx]]

  # Parse function signature
  matches <- str_match(func_line, func_sig_pattern)
  return_type <- matches[, 2]
  func_name <- matches[, 3]
  arguments <- matches[, 4]

  # Description follows until next function or end
  if (func_idx < length(func_sig_indices)) {
    next_func_idx <- func_sig_indices[func_idx + 1]
    desc_lines <- functions_lines[func_sig_indices[func_idx]:(next_func_idx - 1)]
  } else {
    desc_lines <- functions_lines[func_sig_indices[func_idx]:length(functions_lines)]
  }

  # Remove the function signature from first line
  desc_lines[1] <- str_remove(desc_lines[1], func_sig_pattern)
  description <- paste(desc_lines, collapse = " ") %>% str_trim()

  # Parse arguments (reuse gather_args logic from methods)
  gather_args <- function(args_txt) {
    if (args_txt == "" || is.na(args_txt) || args_txt == ")") {
      return(tibble(
        args = character(0),
        arg_num = integer(0),
        arg_type = character(0),
        arg_name = character(0),
        arg_default = character(0),
        arg_type_desc = character(0),
        arg_singleton = logical(0)
      ))
    }

    args_txt <- str_remove(args_txt, "\\)$")

    # Smart split: split by comma but not if inside quotes
    # This handles cases like: [string$ sep = ", "]
    split_args <- function(text) {
      # Simple heuristic: find commas not inside quotes
      parts <- character()
      current <- ""
      in_quotes <- FALSE
      quote_char <- ""

      for (i in seq_len(nchar(text))) {
        char <- substr(text, i, i)

        if (char %in% c('"', "'") && !in_quotes) {
          in_quotes <- TRUE
          quote_char <- char
          current <- paste0(current, char)
        } else if (char == quote_char && in_quotes) {
          in_quotes <- FALSE
          quote_char <- ""
          current <- paste0(current, char)
        } else if (char == "," && !in_quotes) {
          parts <- c(parts, str_trim(current))
          current <- ""
        } else {
          current <- paste0(current, char)
        }
      }

      if (nchar(current) > 0) {
        parts <- c(parts, str_trim(current))
      }

      parts
    }

    args_list <- split_args(args_txt)

    arg_df <- tibble(args = args_list) %>%
      mutate(arg_num = 1:n())

    patterns <- arg_df$args %>%
      map_dfr(function(arg) {
        # Optional parameter: [type name = default]
        if (str_detect(arg, "^\\[.*\\]$")) {
          arg <- str_remove_all(arg, "^\\[|\\]$")
          parts <- str_match(arg, "^([^\\s]+)\\s+([^\\s=]+)\\s*=\\s*(.+)$")
          if (!is.na(parts[1, 1])) {
            return(tibble(arg_type = parts[1, 2], arg_name = parts[1, 3], arg_default = parts[1, 4]))
          }
        }
        # Required parameter: type name
        parts <- str_match(arg, "^([^\\s]+)\\s+([^\\s=]+)$")
        if (!is.na(parts[1, 1])) {
          return(tibble(arg_type = parts[1, 2], arg_name = parts[1, 3], arg_default = NA_character_))
        }
        # Fallback: just the name
        tibble(arg_type = NA_character_, arg_name = str_trim(arg), arg_default = NA_character_)
      })

    arg_df <- bind_cols(arg_df, patterns)

    if (any(!is.na(arg_df$arg_type))) {
      types <- collect_types(arg_df$arg_type)
    } else {
      types <- rep(NA_character_, nrow(arg_df))
    }

    arg_df <- arg_df %>%
      mutate(
        arg_type_desc = types,
        arg_singleton = ifelse(!is.na(arg_type), str_detect(arg_type, "\\$"), FALSE)
      )

    arg_df
  }

  arg_data <- list(gather_args(arguments))

  tibble(
    function_name = func_name,
    return_type = return_type,
    arguments = arguments,
    description = description,
    arg_data = arg_data
  )
  }

  all_functions_data <- map_dfr(seq_along(func_sig_indices), extract_one_function) %>%
    mutate(
      return_type_desc = collect_types(return_type),
      return_singleton = str_detect(return_type, "\\$")
    )

  # Categorize functions
  initialize_functions <- all_functions_data %>%
    filter(str_starts(function_name, "initialize"))

  slimbuiltin_functions <- all_functions_data %>%
    filter(!str_starts(function_name, "initialize"))

  cat("  - Initialize functions:", nrow(initialize_functions), "\n")
  cat("  - SLiMBuiltin functions:", nrow(slimbuiltin_functions), "\n\n")
}

# Separate builtin functions from initialize functions
# Functions starting with "initialize" are Initialize class
# All other functions from Functions RTF are SLiMBuiltin class

# ------------------------------------------------------------------------------
# STEP 8: PARSE EIDOS FUNCTIONS FILE (EidosHelpFunctions.rtf)
# ------------------------------------------------------------------------------

cat("STEP 8: Parsing Eidos functions file (EidosHelpFunctions.rtf)...\n")

# Format eidos text similarly to functions
eidos_text_formatted <- eidos_text %>%
  # Add newline before function signatures: (returnType)functionName(
  str_replace_all("\\(([void|integer|float|logical|string|numeric|object]+[^)]*?)\\)([a-zA-Z_]\\w*)\\(", "\n(\\1)\\2(")

eidos_lines <- str_split(eidos_text_formatted, "\n")[[1]] %>%
  str_trim() %>%
  .[. != ""]

# Find function signatures in Eidos file (same pattern as SLiM functions)
eidos_func_pattern <- "^\\(([^)]+)\\)([a-zA-Z_]\\w*)\\("
eidos_func_indices <- which(str_detect(eidos_lines, eidos_func_pattern))

cat("  - Found", length(eidos_func_indices), "Eidos function signatures\n")

if (length(eidos_func_indices) > 0) {
  # Use the same extraction function as for SLiM functions
  eidos_functions_data <- map_dfr(seq_along(eidos_func_indices), function(i) {
    func_idx <- eidos_func_indices[i]
    func_line <- eidos_lines[func_idx]

    # Extract return type, function name, and arguments
    matches <- str_match(func_line, eidos_func_pattern)
    return_type <- matches[1, 2]
    func_name <- matches[1, 3]

    # Extract arguments (everything after function name and opening paren)
    args_match <- str_match(func_line, paste0(func_name, "\\((.*)\\)"))
    arguments <- if(!is.na(args_match[1, 2])) args_match[1, 2] else ""

    # Get description (next non-empty lines until next function or end)
    next_func_idx <- if(i < length(eidos_func_indices)) eidos_func_indices[i + 1] else length(eidos_lines) + 1
    desc_lines <- eidos_lines[(func_idx + 1):(next_func_idx - 1)]
    desc_lines <- desc_lines[desc_lines != ""]
    description <- paste(desc_lines, collapse = " ")

    # Parse arguments
    gather_args <- function(args_txt) {
      if (args_txt == "" || is.na(args_txt)) {
        return(tibble(args = character(), arg_num = integer(), arg_type = character(),
                      arg_name = character(), arg_default = character(),
                      arg_type_desc = character(), arg_singleton = logical()))
      }

      # Split arguments (handle nested parentheses and brackets)
      args_list <- list()
      current <- ""
      depth <- 0
      bracket_depth <- 0

      for (char in strsplit(args_txt, "")[[1]]) {
        if (char == "(" || char == "<") {
          depth <- depth + 1
          current <- paste0(current, char)
        } else if (char == ")" || char == ">") {
          depth <- depth - 1
          current <- paste0(current, char)
        } else if (char == "[") {
          bracket_depth <- bracket_depth + 1
          current <- paste0(current, char)
        } else if (char == "]") {
          bracket_depth <- bracket_depth - 1
          current <- paste0(current, char)
        } else if (char == "," && depth == 0 && bracket_depth == 0) {
          args_list <- c(args_list, str_trim(current))
          current <- ""
        } else {
          current <- paste0(current, char)
        }
      }
      if (current != "") {
        args_list <- c(args_list, str_trim(current))
      }

      arg_df <- tibble(args = unlist(args_list)) %>%
        mutate(arg_num = 1:n())

      # Parse each argument
      patterns <- arg_df$args %>%
        map_dfr(function(arg) {
          # Optional parameter: [type name = default]
          if (str_detect(arg, "^\\[.*\\]$")) {
            arg <- str_remove_all(arg, "^\\[|\\]$")
            parts <- str_match(arg, "^([^\\s]+)\\s+([^\\s=]+)\\s*=\\s*(.+)$")
            if (!is.na(parts[1, 1])) {
              return(tibble(arg_type = parts[1, 2], arg_name = parts[1, 3], arg_default = parts[1, 4]))
            }
          }
          # Required parameter: type name
          parts <- str_match(arg, "^([^\\s]+)\\s+([^\\s=]+)$")
          if (!is.na(parts[1, 1])) {
            return(tibble(arg_type = parts[1, 2], arg_name = parts[1, 3], arg_default = NA_character_))
          }
          # Fallback: just name
          tibble(arg_type = NA_character_, arg_name = str_trim(arg), arg_default = NA_character_)
        })

      arg_df <- bind_cols(arg_df, patterns)

      if (any(!is.na(arg_df$arg_type))) {
        types <- collect_types(arg_df$arg_type)
      } else {
        types <- rep(NA_character_, nrow(arg_df))
      }

      arg_df <- arg_df %>%
        mutate(
          arg_type_desc = types,
          arg_singleton = ifelse(!is.na(arg_type), str_detect(arg_type, "\\$"), FALSE)
        )

      arg_df
    }

    arg_data <- list(gather_args(arguments))

    tibble(
      symbol = "-",
      function_name = func_name,
      return_type = return_type,
      arguments = arguments,
      description = description,
      arg_data = arg_data,
      signature = paste0("(", return_type, ")", func_name, "(", arguments, ")")
    )
  }) %>%
    mutate(
      return_type_desc = collect_types(return_type),
      return_singleton = str_detect(return_type, "\\$")
    )

  cat("  - Extracted", nrow(eidos_functions_data), "Eidos functions\n\n")
} else {
  eidos_functions_data <- tibble()
  cat("  - No Eidos functions found\n\n")
}

# ------------------------------------------------------------------------------
# STEP 9: COMBINE ALL METHODS DATA
# ------------------------------------------------------------------------------

cat("STEP 9: Combining all methods data...\n")

# Add to all_methods_data
all_methods_data <- c(
  list(Initialize = initialize_functions),
  all_methods_data,
  list(SLiMBuiltin = slimbuiltin_functions),
  list(Eidos = eidos_functions_data)
)

# Add Initialize intro if not already present
if (!"Initialize" %in% names(slim_lang_intros)) {
  slim_lang_intros <- c(
    Initialize = "Initialize callback functions for setting up simulations.",
    slim_lang_intros
  )
}

# Add SLiMBuiltin intro if not already present
if (!"SLiMBuiltin" %in% names(slim_lang_intros)) {
  slim_lang_intros <- c(
    slim_lang_intros,
    SLiMBuiltin = "SLiM provides a small number of built-in functions, documented here. Note that these are distinct from the functions built into the Eidos language itself, which are documented in the Eidos manual."
  )
}

# Add Eidos intro if not already present
if (!"Eidos" %in% names(slim_lang_intros)) {
  slim_lang_intros <- c(
    slim_lang_intros,
    Eidos = "Eidos is the scripting language used by SLiM. The functions documented here are part of the Eidos language and are available in all SLiM scripts."
  )
}

cat("  - Combined all methods data\n\n")

# ------------------------------------------------------------------------------
# STEP 10: SAVE EXTRACTED DATA
# ------------------------------------------------------------------------------

cat("STEP 10: Saving extracted data...\n")

build_5_dir <- file.path(project_root, "data-raw/build_5")
saveRDS(all_methods_data, file = file.path(build_5_dir, "all_methods_data.rds"))
saveRDS(all_properties_data, file = file.path(build_5_dir, "all_properties_data.rds"))
saveRDS(slim_lang_intros, file = file.path(build_5_dir, "slim_lang_intros.rds"))

cat("  - Saved all_methods_data.rds\n")
cat("  - Saved all_properties_data.rds\n")
cat("  - Saved slim_lang_intros.rds\n\n")

# ------------------------------------------------------------------------------
# STEP 11: SUMMARY STATISTICS
# ------------------------------------------------------------------------------

cat("=== EXTRACTION SUMMARY ===\n\n")

cat("Classes found:", length(class_names), "\n")
cat("  Names:", paste(class_names, collapse = ", "), "\n\n")

cat("Methods by class:\n")
for (cls in names(all_methods_data)) {
  n_methods <- nrow(all_methods_data[[cls]])
  cat(sprintf("  %-20s: %3d methods\n", cls, n_methods))
}

cat("\nProperties by class:\n")
for (cls in names(all_properties_data)) {
  n_props <- nrow(all_properties_data[[cls]])
  cat(sprintf("  %-20s: %3d properties\n", cls, n_props))
}

cat("\nTotal functions:", sum(map_int(all_methods_data, nrow)), "\n")
cat("Total properties:", sum(map_int(all_properties_data, nrow)), "\n\n")

cat("=== EXTRACTION COMPLETE ===\n")
cat("Data ready for Phase 2 (generating R stubs)\n\n")
