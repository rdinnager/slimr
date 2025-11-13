#' Get a SLiM recipe
#'
#' @param recipe_num Character or numeric. Can be a recipe name (e.g., "4.1") or numeric index (e.g., 1, 2, 3).
#'
#' @return Character vector containing the SLiM recipe code
#' @export
#'
#' @examples
#' \dontrun{
#' # Get recipe by name
#' recipe <- slim_get_recipe("4.1")
#'
#' # Get recipe by index
#' recipe <- slim_get_recipe(1)
#'
#' # Convert to slimr_script
#' script <- as_slimr_script(slim_get_recipe(1))
#' }
slim_get_recipe <- function(recipe_num) {
  # If numeric and looks like an index (integer without decimal), treat as index
  if (is.numeric(recipe_num) && recipe_num == floor(recipe_num)) {
    # Get by index
    if (recipe_num < 1 || recipe_num > length(.slim_assets$slim_recipes)) {
      stop("Recipe index ", recipe_num, " out of range. ",
           "Available recipes: 1 to ", length(.slim_assets$slim_recipes))
    }
    return(.slim_assets$slim_recipes[[recipe_num]])
  }

  # Otherwise treat as recipe name
  recipe_name <- as.character(recipe_num)
  if (recipe_name %in% names(.slim_assets$slim_recipes)) {
    return(.slim_assets$slim_recipes[[recipe_name]])
  }

  # Not found
  stop("Recipe '", recipe_num, "' not found. ",
       "Check available recipes with names(.slim_assets$slim_recipes)")
}

#' Compare original SLiM recipe with slimr conversion
#'
#' @param recipe_num Character or numeric specifying the recipe number (e.g., "4.1" or 4.1).
#' @param output_file Optional path for HTML output file. If NULL, creates a temp file.
#' @param open Logical. If TRUE and in interactive session, opens comparison in browser. Default TRUE.
#'
#' @return Path to HTML file (invisibly)
#' @export
#' @importFrom utils browseURL capture.output
#'
#' @examples
#' \dontrun{
#' # Compare recipe 4.1
#' slim_compare_recipe("4.1")
#'
#' # Save to specific file
#' slim_compare_recipe("5.2.1", output_file = "recipe_comparison.html")
#' }
slim_compare_recipe <- function(recipe_num, output_file = NULL, open = TRUE) {
  # Load the recipe
  recipe_id <- gsub("\\.", "_", as.character(recipe_num))

  # Find recipe file
  recipe_file <- system.file(
    sprintf("extdata/slim_recipes/converted/recipe_%s.R", recipe_id),
    package = "slimr"
  )

  if (!file.exists(recipe_file) || recipe_file == "") {
    stop("Recipe ", recipe_num, " not found. Check available recipes with list.files(system.file('extdata/slim_recipes/converted', package = 'slimr'))")
  }

  # Source the recipe in a new environment
  recipe_env <- new.env(parent = globalenv())
  source(recipe_file, local = recipe_env)

  # Get the script object (should be named recipe_X_Y_script)
  script_name <- sprintf("recipe_%s_script", recipe_id)
  if (!exists(script_name, envir = recipe_env)) {
    stop("Recipe file exists but script object '", script_name, "' not found")
  }

  slimr_script <- get(script_name, envir = recipe_env)


  # Get original SLiM code from attribute
  original <- attr(slimr_script, "original_slim")
  if (is.null(original)) {
    stop("No original SLiM code stored in script attribute. ",
         "Recipe may have been created without original text.")
  }

  # Get the slimr R code representation
  # Use capture.output to get the printed representation
  converted <- paste(capture.output(print(slimr_script)), collapse = "\n")

  # Prepare text for HTML
  original_html <- paste(original, collapse = "\n")
  converted_html <- converted

  # Escape HTML characters
  original_html <- gsub("<", "&lt;", original_html)
  original_html <- gsub(">", "&gt;", original_html)
  converted_html <- gsub("<", "&lt;", converted_html)
  converted_html <- gsub(">", "&gt;", converted_html)

  # Generate HTML with side-by-side comparison
  html_content <- sprintf('
<!DOCTYPE html>
<html>
<head>
    <title>SLiM Recipe Comparison</title>
    <style>
        body {
            font-family: "Courier New", monospace;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            display: flex;
            gap: 20px;
            max-width: 1400px;
            margin: 0 auto;
        }
        .column {
            flex: 1;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h2 {
            margin-top: 0;
            color: #333;
            font-family: Arial, sans-serif;
        }
        pre {
            margin: 0;
            white-space: pre-wrap;
            word-wrap: break-word;
            font-size: 13px;
            line-height: 1.4;
        }
        .original { border-left: 3px solid #e74c3c; }
        .converted { border-left: 3px solid #3498db; }
    </style>
</head>
<body>
    <div class="container">
        <div class="column original">
            <h2>Original SLiM Code</h2>
            <pre>%s</pre>
        </div>
        <div class="column converted">
            <h2>Converted slimr Code</h2>
            <pre>%s</pre>
        </div>
    </div>
</body>
</html>
  ', original_html, converted_html)

  # Save HTML
  if (is.null(output_file)) {
    output_file <- tempfile(fileext = ".html")
  }
  writeLines(html_content, output_file)

  # Open in browser if requested
  if (open && interactive()) {
    browseURL(output_file)
  }

  message("Comparison saved to: ", output_file)
  invisible(output_file)
}

#' Get multiple SLiM recipes
#'
#' @param recipes Character vector of recipe names (e.g., c("4.1", "9.2")),
#'   numeric vector of indices (e.g., c(1, 45, 53)), or "all" to retrieve all recipes.
#'
#' @return Named list of SLiM recipes, each element a character vector
#' @export
#'
#' @examples
#' \dontrun{
#' # Get all recipes
#' all_recipes <- slim_get_recipes("all")
#'
#' # Get specific recipes by index
#' some_recipes <- slim_get_recipes(c(1, 45, 53, 132))
#'
#' # Get specific recipes by name
#' some_recipes <- slim_get_recipes(c("4.1", "9.2", "15.20"))
#' }
slim_get_recipes <- function(recipes = "all") {
  if (is.numeric(recipes)) {
    # Get by numeric indices
    if (any(recipes < 1 | recipes > length(.slim_assets$slim_recipes))) {
      stop("Recipe index out of range. ",
           "Available recipes: 1 to ", length(.slim_assets$slim_recipes))
    }
    return(.slim_assets$slim_recipes[recipes])
  } else if (is.character(recipes)) {
    if (length(recipes) == 1 && recipes == "all") {
      # Get all recipes
      return(.slim_assets$slim_recipes)
    } else {
      # Get by recipe names
      missing_recipes <- recipes[!recipes %in% names(.slim_assets$slim_recipes)]
      if (length(missing_recipes) > 0) {
        stop("Recipe(s) not found: ", paste(missing_recipes, collapse = ", "))
      }
      return(.slim_assets$slim_recipes[recipes])
    }
  } else {
    stop("recipes must be numeric indices, character names, or 'all'")
  }
}


