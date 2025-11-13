# Test if the issue is with BRACES, not ampersands
library(stringr)

original_text <- "support on the set {0, 1, 2, &}, where the drawn"

cat("Testing different brace escape approaches:\n\n")

# Approach 1: Escape braces with backslash
cat("1. Escape braces: \\{...\\}\n")
result1 <- str_replace_all(original_text, "\\{", "\\\\{")
result1 <- str_replace_all(result1, "\\}", "\\\\}")
cat(result1, "\n")

# Create Rd file
rd1 <- paste0("\\name{test1}\n\\description{\n", result1, "\n}\n")
writeLines(rd1, "claude_notes/test_braces_1.Rd")

tryCatch({
  tools::parse_Rd("claude_notes/test_braces_1.Rd")
  tools::checkRd("claude_notes/test_braces_1.Rd")
  cat("SUCCESS - No errors\n\n")
}, warning = function(w) {
  cat("WARNING:", w$message, "\n\n")
}, error = function(e) {
  cat("ERROR:", e$message, "\n\n")
})

# Approach 2: Use \\emph{} markup
cat("2. No escaping (original):\n")
result2 <- original_text
cat(result2, "\n")

rd2 <- paste0("\\name{test2}\n\\description{\n", result2, "\n}\n")
writeLines(rd2, "claude_notes/test_braces_2.Rd")

tryCatch({
  tools::parse_Rd("claude_notes/test_braces_2.Rd")
  tools::checkRd("claude_notes/test_braces_2.Rd")
  cat("SUCCESS - No errors\n\n")
}, warning = function(w) {
  cat("WARNING:", w$message, "\n\n")
}, error = function(e) {
  cat("ERROR:", e$message, "\n\n")
})

# Approach 3: Replace with parentheses
cat("3. Replace {} with ():\n")
result3 <- str_replace_all(original_text, "\\{", "(")
result3 <- str_replace_all(result3, "\\}", ")")
cat(result3, "\n")

rd3 <- paste0("\\name{test3}\n\\description{\n", result3, "\n}\n")
writeLines(rd3, "claude_notes/test_braces_3.Rd")

tryCatch({
  tools::parse_Rd("claude_notes/test_braces_3.Rd")
  tools::checkRd("claude_notes/test_braces_3.Rd")
  cat("SUCCESS - No errors\n\n")
}, warning = function(w) {
  cat("WARNING:", w$message, "\n\n")
}, error = function(e) {
  cat("ERROR:", e$message, "\n\n")
})

cat("\nNow testing with tools::checkRd which does stricter validation:\n\n")