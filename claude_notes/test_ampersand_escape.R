# Test script to find the correct way to escape & for Rd format
library(stringr)

# The problematic text
original_text <- "Eidos follows R in using the geometric distribution with support on the set {0, 1, 2, &}, where the drawn value indicates the number of failures prior to success."

cat("Original text:\n")
cat(original_text, "\n\n")

# Test different escape approaches
cat("=== Testing different escape methods ===\n\n")

# Approach 1: Replace & with "and"
cat("1. Replace & with 'and':\n")
result1 <- str_replace_all(original_text, "&", "and")
cat(result1, "\n\n")

# Approach 2: Replace the whole pattern with ...
cat("2. Replace {0, 1, 2, &} with {0, 1, 2, ...}:\n")
result2 <- str_replace_all(original_text, "\\{0, 1, 2, &\\}", "{0, 1, 2, ...}")
cat(result2, "\n\n")

# Approach 3: HTML entity
cat("3. Replace & with HTML entity &amp;:\n")
result3 <- str_replace_all(original_text, "&", "&amp;")
cat(result3, "\n\n")

# Approach 4: Use fixed() for literal replacement
cat("4. Use fixed() for literal {0, 1, 2, &} replacement:\n")
result4 <- str_replace_all(original_text, fixed("{0, 1, 2, &}"), "{0, 1, 2, ...}")
cat(result4, "\n\n")

# Approach 5: Just remove the &
cat("5. Remove the &:\n")
result5 <- str_replace_all(original_text, " &", "")
cat(result5, "\n\n")

# Now test which one works in an Rd file by writing a minimal Rd file
cat("\n=== Testing in actual Rd format ===\n\n")

# Create a minimal test function for each approach
for (i in 1:5) {
  result <- get(paste0("result", i))

  # Create minimal Rd content
  rd_content <- paste0(
    "\\name{test_func_", i, "}\n",
    "\\alias{test_func_", i, "}\n",
    "\\title{Test Function ", i, "}\n",
    "\\description{\n",
    result, "\n",
    "}\n"
  )

  # Write to file
  rd_file <- paste0("claude_notes/test_approach_", i, ".Rd")
  writeLines(rd_content, rd_file)

  # Try to parse it with tools::parse_Rd
  tryCatch({
    parsed <- tools::parse_Rd(rd_file)
    cat(sprintf("Approach %d: SUCCESS - Rd file parses correctly\n", i))
  }, error = function(e) {
    cat(sprintf("Approach %d: FAILED - %s\n", i, e$message))
  })
}

cat("\n=== Summary ===\n")
cat("Check the output above to see which approach works.\n")
cat("The successful approach should be used in extract_from_rtf.R\n")