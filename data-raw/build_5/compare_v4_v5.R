## Compare SLiM 4.x vs 5.x API
## Identify breaking changes for slimr upgrade

library(stringr)
library(dplyr)
library(purrr)
library(tidyr)

cat("=== COMPARING SLiM 4.x vs 5.x APIs ===\n\n")

# ------------------------------------------------------------------------------
# STEP 1: LOAD V5 DATA
# ------------------------------------------------------------------------------

cat("STEP 1: Loading SLiM 5.x data...\n")

# Determine project root
if (file.exists("build_5/all_methods_data.rds")) {
  project_root <- ".."
} else if (file.exists("data-raw/build_5/all_methods_data.rds")) {
  project_root <- "."
} else {
  stop("Cannot find extracted data files.")
}

build_5_dir <- file.path(project_root, "data-raw/build_5")
build_4_dir <- file.path(project_root, "data-raw/build_4/slim_reference")

v5_methods <- readRDS(file.path(build_5_dir, "all_methods_data.rds"))
v5_properties <- readRDS(file.path(build_5_dir, "all_properties_data.rds"))

cat("  - Loaded", length(v5_methods), "v5 method sets\n")
cat("  - Loaded", length(v5_properties), "v5 property sets\n\n")

# ------------------------------------------------------------------------------
# STEP 2: LOAD AND PARSE V4 DATA
# ------------------------------------------------------------------------------

cat("STEP 2: Loading SLiM 4.x data...\n")

# Find all v4 methods files
v4_methods_files <- list.files(build_4_dir, pattern = "_methods\\.txt$", full.names = TRUE)
v4_properties_files <- list.files(build_4_dir, pattern = "_properties\\.txt$", full.names = TRUE)

cat("  - Found", length(v4_methods_files), "v4 methods files\n")
cat("  - Found", length(v4_properties_files), "v4 properties files\n")

# Function to extract class name from filename
extract_class_name <- function(filepath) {
  basename(filepath) %>%
    str_remove("_methods\\.txt$") %>%
    str_remove("_properties\\.txt$")
}

# Parse v4 methods
parse_v4_methods <- function(filepath) {
  text <- readLines(filepath, warn = FALSE) %>% paste(collapse = "\n")
  class_name <- extract_class_name(filepath)

  # Split on method signatures (lines starting with "– (")
  methods <- str_split(text, "\n– \\(")[[1]]

  if (length(methods) == 0) return(NULL)

  # First element won't have a method
  if (length(methods) > 1) {
    methods <- methods[-1]
  } else {
    return(NULL)
  }

  # Extract method names from each
  method_info <- map_dfr(methods, function(method_text) {
    # Restore the opening "("
    method_text <- paste0("(", method_text)

    # Extract signature (first line)
    lines <- str_split(method_text, "\n")[[1]]
    sig_line <- lines[1]

    # Pattern: (return_type)methodName(
    match <- str_match(sig_line, "^\\(([^)]+)\\)([a-zA-Z_]\\w*)\\(")

    if (!is.na(match[1])) {
      tibble(
        class_name = class_name,
        function_name = match[3],
        return_type = match[2],
        signature = sig_line
      )
    } else {
      NULL
    }
  })

  method_info
}

# Parse v4 properties
parse_v4_properties <- function(filepath) {
  text <- readLines(filepath, warn = FALSE)
  class_name <- extract_class_name(filepath)

  # Properties follow pattern: propertyName <symbol> (type)
  # where symbol is => (read-only) or <–> (read-write)
  prop_lines <- text[str_detect(text, "^[a-zA-Z]\\w*\\s+(=>|<)")]

  if (length(prop_lines) == 0) return(NULL)

  map_dfr(prop_lines, function(line) {
    # Extract property name and type
    match <- str_match(line, "^([a-zA-Z]\\w*)\\s+(=>|<[^>]+>)\\s+\\(([^)]+)\\)")

    if (!is.na(match[1])) {
      tibble(
        class_name = class_name,
        property = match[2],
        symbol = match[3],
        type = match[4]
      )
    } else {
      NULL
    }
  })
}

# Parse all v4 files
v4_methods_list <- map(v4_methods_files, parse_v4_methods) %>%
  setNames(map_chr(v4_methods_files, extract_class_name))

v4_properties_list <- map(v4_properties_files, parse_v4_properties) %>%
  setNames(map_chr(v4_properties_files, extract_class_name))

# Remove NULLs
v4_methods_list <- v4_methods_list[!map_lgl(v4_methods_list, is.null)]
v4_properties_list <- v4_properties_list[!map_lgl(v4_properties_list, is.null)]

cat("  - Parsed", length(v4_methods_list), "v4 classes with methods\n")
cat("  - Parsed", length(v4_properties_list), "v4 classes with properties\n\n")

# ------------------------------------------------------------------------------
# STEP 3: COMPARE CLASS LISTS
# ------------------------------------------------------------------------------

cat("STEP 3: Comparing class lists...\n")

v4_classes <- unique(c(names(v4_methods_list), names(v4_properties_list))) %>% sort()
v5_classes <- unique(c(names(v5_methods), names(v5_properties))) %>% sort()

cat("\nV4 Classes (", length(v4_classes), "):\n", sep = "")
cat(paste("  -", v4_classes), sep = "\n")

cat("\nV5 Classes (", length(v5_classes), "):\n", sep = "")
cat(paste("  -", v5_classes), sep = "\n")

new_classes <- setdiff(v5_classes, v4_classes)
removed_classes <- setdiff(v4_classes, v5_classes)

cat("\n**NEW CLASSES in v5 (", length(new_classes), "):**\n", sep = "")
if (length(new_classes) > 0) {
  cat(paste("  +", new_classes), sep = "\n")
} else {
  cat("  (none)\n")
}

cat("\n**REMOVED CLASSES from v4 (", length(removed_classes), "):**\n", sep = "")
if (length(removed_classes) > 0) {
  cat(paste("  -", removed_classes), sep = "\n")
} else {
  cat("  (none)\n")
}

cat("\n")

# ------------------------------------------------------------------------------
# STEP 4: COMPARE METHODS FOR EACH CLASS
# ------------------------------------------------------------------------------

cat("STEP 4: Comparing methods for each class...\n\n")

method_changes <- list()

common_classes <- intersect(v4_classes, v5_classes)

for (class_name in common_classes) {
  v4_m <- v4_methods_list[[class_name]]
  v5_m <- v5_methods[[class_name]]

  if (is.null(v4_m)) v4_m <- tibble(function_name = character())
  if (is.null(v5_m)) v5_m <- tibble(function_name = character())

  v4_method_names <- unique(v4_m$function_name)
  v5_method_names <- unique(v5_m$function_name)

  new_methods <- setdiff(v5_method_names, v4_method_names)
  removed_methods <- setdiff(v4_method_names, v5_method_names)
  common_methods <- intersect(v4_method_names, v5_method_names)

  # Check for signature changes in common methods
  sig_changes <- character()
  for (method in common_methods) {
    v4_sig <- v4_m$signature[v4_m$function_name == method][1]
    v5_sig <- v5_m$signature[v5_m$function_name == method][1]

    # Normalize signatures for comparison (remove whitespace differences)
    v4_sig_norm <- str_replace_all(v4_sig, "\\s+", " ")
    v5_sig_norm <- str_replace_all(v5_sig, "\\s+", " ")

    if (!identical(v4_sig_norm, v5_sig_norm)) {
      sig_changes <- c(sig_changes, method)
    }
  }

  if (length(new_methods) > 0 || length(removed_methods) > 0 || length(sig_changes) > 0) {
    method_changes[[class_name]] <- list(
      new = new_methods,
      removed = removed_methods,
      sig_changed = sig_changes
    )

    cat("**", class_name, "**\n", sep = "")
    if (length(new_methods) > 0) {
      cat("  + New methods (", length(new_methods), "): ", paste(new_methods, collapse = ", "), "\n", sep = "")
    }
    if (length(removed_methods) > 0) {
      cat("  - Removed methods (", length(removed_methods), "): ", paste(removed_methods, collapse = ", "), "\n", sep = "")
    }
    if (length(sig_changes) > 0) {
      cat("  ~ Signature changes (", length(sig_changes), "): ", paste(sig_changes, collapse = ", "), "\n", sep = "")
    }
    cat("\n")
  }
}

# ------------------------------------------------------------------------------
# STEP 5: COMPARE PROPERTIES FOR EACH CLASS
# ------------------------------------------------------------------------------

cat("STEP 5: Comparing properties for each class...\n\n")

property_changes <- list()

for (class_name in common_classes) {
  v4_p <- v4_properties_list[[class_name]]
  v5_p <- v5_properties[[class_name]]

  if (is.null(v4_p)) v4_p <- tibble(property = character())
  if (is.null(v5_p)) v5_p <- tibble(property = character())

  v4_prop_names <- unique(v4_p$property)
  v5_prop_names <- unique(v5_p$property)

  new_props <- setdiff(v5_prop_names, v4_prop_names)
  removed_props <- setdiff(v4_prop_names, v5_prop_names)

  if (length(new_props) > 0 || length(removed_props) > 0) {
    property_changes[[class_name]] <- list(
      new = new_props,
      removed = removed_props
    )

    cat("**", class_name, "**\n", sep = "")
    if (length(new_props) > 0) {
      cat("  + New properties (", length(new_props), "): ", paste(new_props, collapse = ", "), "\n", sep = "")
    }
    if (length(removed_props) > 0) {
      cat("  - Removed properties (", length(removed_props), "): ", paste(removed_props, collapse = ", "), "\n", sep = "")
    }
    cat("\n")
  }
}

# ------------------------------------------------------------------------------
# STEP 6: GENERATE SUMMARY REPORT
# ------------------------------------------------------------------------------

cat("=== SUMMARY REPORT ===\n\n")

cat("CLASS CHANGES:\n")
cat("  - New classes:", length(new_classes), "\n")
cat("  - Removed classes:", length(removed_classes), "\n")
cat("  - Common classes:", length(common_classes), "\n\n")

total_new_methods <- sum(map_int(method_changes, ~length(.x$new)))
total_removed_methods <- sum(map_int(method_changes, ~length(.x$removed)))
total_sig_changes <- sum(map_int(method_changes, ~length(.x$sig_changed)))

cat("METHOD CHANGES:\n")
cat("  - Classes with changes:", length(method_changes), "\n")
cat("  - Total new methods:", total_new_methods, "\n")
cat("  - Total removed methods:", total_removed_methods, "\n")
cat("  - Total signature changes:", total_sig_changes, "\n\n")

total_new_props <- sum(map_int(property_changes, ~length(.x$new)))
total_removed_props <- sum(map_int(property_changes, ~length(.x$removed)))

cat("PROPERTY CHANGES:\n")
cat("  - Classes with changes:", length(property_changes), "\n")
cat("  - Total new properties:", total_new_props, "\n")
cat("  - Total removed properties:", total_removed_props, "\n\n")

# ------------------------------------------------------------------------------
# STEP 7: SAVE RESULTS
# ------------------------------------------------------------------------------

cat("STEP 7: Saving comparison results...\n")

comparison_results <- list(
  summary = list(
    new_classes = new_classes,
    removed_classes = removed_classes,
    common_classes = common_classes
  ),
  method_changes = method_changes,
  property_changes = property_changes,
  v4_data = list(
    methods = v4_methods_list,
    properties = v4_properties_list
  ),
  v5_data = list(
    methods = v5_methods,
    properties = v5_properties
  )
)

saveRDS(comparison_results, file.path(build_5_dir, "v4_v5_comparison.rds"))

cat("  - Saved comparison results to v4_v5_comparison.rds\n\n")

cat("=== COMPARISON COMPLETE ===\n")
