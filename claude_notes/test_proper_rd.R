# Proper test with complete Rd structure
library(stringr)

test_approaches <- function() {
  # The problematic text
  original <- "Eidos follows R in using the geometric distribution with support on the set {0, 1, 2, &}, where the drawn value indicates the number of failures prior to success."

  approaches <- list(
    list(name = "Original (unescaped)",
         text = original),

    list(name = "Escaped braces \\{...\\}",
         text = str_replace_all(str_replace_all(original, "\\{", "\\\\{"), "\\}", "\\\\}")),

    list(name = "Replace & with 'and'",
         text = str_replace_all(original, "&", "and")),

    list(name = "Replace {} with ()",
         text = str_replace_all(str_replace_all(original, "\\{", "("), "\\}", ")")),

    list(name = "Replace {0, 1, 2, &} with {0, 1, 2, ...}",
         text = str_replace_all(original, fixed("{0, 1, 2, &}"), "{0, 1, 2, ...}"))
  )

  for (i in seq_along(approaches)) {
    approach <- approaches[[i]]
    cat(sprintf("\n=== Approach %d: %s ===\n", i, approach$name))
    cat("Text:", approach$text, "\n")

    # Create proper Rd file
    rd_content <- sprintf(
      "\\name{testfunc%d}
\\alias{testfunc%d}
\\title{Test Function %d}
\\description{
Test function description.
}
\\details{
%s
}
\\examples{
# Example code
x <- 1
}",
      i, i, i, approach$text
    )

    rd_file <- sprintf("claude_notes/test_rd_%d.Rd", i)
    writeLines(rd_content, rd_file)

    # Test with checkRd
    result <- tryCatch({
      capture.output(tools::checkRd(rd_file), type = "message")
    }, error = function(e) {
      return(paste("ERROR:", e$message))
    })

    if (length(result) == 0 || all(result == "")) {
      cat("✓ PASS - No warnings or errors\n")
    } else {
      cat("✗ FAIL - Issues found:\n")
      cat(paste(result, collapse = "\n"), "\n")
    }
  }
}

test_approaches()