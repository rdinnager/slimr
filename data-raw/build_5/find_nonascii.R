## Find and catalog non-printable characters in generated file
## This includes both control characters (0-31 except tab/newline) and non-ASCII (>127)
library(stringr)

cat("Scanning R/slim_lang_v5.R for non-printable characters...\n\n")

# Determine project root
if (file.exists("../../R/slim_lang_v5.R")) {
  file_path <- "../../R/slim_lang_v5.R"
} else if (file.exists("../R/slim_lang_v5.R")) {
  file_path <- "../R/slim_lang_v5.R"
} else if (file.exists("R/slim_lang_v5.R")) {
  file_path <- "R/slim_lang_v5.R"
} else {
  stop("Cannot find R/slim_lang_v5.R")
}

cat("Reading:", file_path, "\n\n")

# Read file
text <- readLines(file_path, warn = FALSE)

# Collect all non-printable characters
# Printable: 32-126 (space through ~), plus 9 (tab), 10 (LF), 13 (CR)
# Everything else is non-printable
all_chars <- character()
for (line in text) {
  # Extract characters that are NOT:
  # - tab (09)
  # - newline (0A)
  # - carriage return (0D)
  # - printable ASCII (20-7E)
  # This will catch control characters (00-1F except tab/LF/CR) and non-ASCII (7F+)
  matches <- str_extract_all(line, "[^\t\n\r\x20-\x7E]")[[1]]
  if (length(matches) > 0) {
    all_chars <- c(all_chars, matches)
  }
}

# Get unique characters and their counts
unique_chars <- unique(all_chars)

if (length(unique_chars) == 0) {
  cat("✓ No non-printable characters found! File is clean.\n")
  quit(save = "no", status = 0)
}

char_table <- data.frame(
  char = unique_chars,
  code = sapply(unique_chars, function(x) utf8ToInt(x)),
  count = sapply(unique_chars, function(x) sum(all_chars == x)),
  stringsAsFactors = FALSE
)

# Sort by code point
char_table <- char_table[order(char_table$code), ]

# Add hex representation
char_table$hex <- sprintf("U+%04X", char_table$code)

# Add suggested replacements (common cases)
char_table$replacement <- ""
# Control characters (0-31)
char_table$replacement[char_table$code == 19] <- "'"  # EM - used for apostrophe
char_table$replacement[char_table$code == 25] <- "'"  # EM - also apostrophe
char_table$replacement[char_table$code == 28] <- '"'  # FS - left quote
char_table$replacement[char_table$code == 29] <- '"'  # GS - right quote
# Non-ASCII characters (127+)
char_table$replacement[char_table$code == 160] <- " "  # NBSP
char_table$replacement[char_table$code == 169] <- "(c)"  # Copyright
char_table$replacement[char_table$code == 215] <- "x"  # Multiplication
char_table$replacement[char_table$code == 8211] <- "-"  # En dash
char_table$replacement[char_table$code == 8212] <- "-"  # Em dash
char_table$replacement[char_table$code == 8216] <- "'"  # Left single quote
char_table$replacement[char_table$code == 8217] <- "'"  # Right single quote/apostrophe
char_table$replacement[char_table$code == 8220] <- '"'  # Left double quote
char_table$replacement[char_table$code == 8221] <- '"'  # Right double quote
char_table$replacement[char_table$code == 8230] <- "..."  # Ellipsis
char_table$replacement[char_table$code == 8592] <- "<-"  # Left arrow
char_table$replacement[char_table$code == 8594] <- "->"  # Right arrow

# Add descriptions
char_table$description <- ""
# Control characters
char_table$description[char_table$code == 19] <- "DC3/EM (Control Char)"
char_table$description[char_table$code == 25] <- "EM (Control Char)"
char_table$description[char_table$code == 28] <- "FS (File Separator)"
char_table$description[char_table$code == 29] <- "GS (Group Separator)"
# Non-ASCII
char_table$description[char_table$code == 160] <- "Non-Breaking Space"
char_table$description[char_table$code == 169] <- "Copyright Sign"
char_table$description[char_table$code == 215] <- "Multiplication Sign"
char_table$description[char_table$code == 8211] <- "En Dash"
char_table$description[char_table$code == 8212] <- "Em Dash"
char_table$description[char_table$code == 8216] <- "Left Single Quote"
char_table$description[char_table$code == 8217] <- "Right Single Quote"
char_table$description[char_table$code == 8220] <- "Left Double Quote"
char_table$description[char_table$code == 8221] <- "Right Double Quote"
char_table$description[char_table$code == 8230] <- "Ellipsis"
char_table$description[char_table$code == 8592] <- "Left Arrow"
char_table$description[char_table$code == 8594] <- "Right Arrow"

cat("Found", nrow(char_table), "unique non-printable characters:\n\n")

# Print table
cat(sprintf("%-6s %-8s %-6s %-30s %-8s %-15s\n",
            "Char", "Hex", "Dec", "Description", "Count", "Replacement"))
cat(paste(rep("-", 85), collapse=""), "\n")

for (i in 1:nrow(char_table)) {
  cat(sprintf("%-6s %-8s %-6d %-30s %-8d -> '%s'\n",
              char_table$char[i],
              char_table$hex[i],
              char_table$code[i],
              char_table$description[i],
              char_table$count[i],
              char_table$replacement[i]))
}

cat("\n")

# Save the mapping for use in cleanup
saveRDS(char_table, "nonascii_mapping.rds")
cat("Saved character mapping to nonascii_mapping.rds\n")

# Generate R code for replacement
cat("\n=== SUGGESTED R CODE FOR CLEANUP ===\n\n")
cat('# Add to generate_slim_lang_v5.R cleanup section:\n')
cat('r_script <- r_script %>%\n')

for (i in 1:nrow(char_table)) {
  if (char_table$replacement[i] != "") {
    # Escape special regex characters in replacement
    repl <- char_table$replacement[i]
    repl <- gsub("\\\\", "\\\\\\\\", repl)  # Escape backslashes

    cat(sprintf('  str_replace_all("\\\\u%04X", "%s") %%>%%  # %s\n',
                char_table$code[i],
                repl,
                char_table$description[i]))
  }
}

cat('  identity()  # End of pipe\n')
