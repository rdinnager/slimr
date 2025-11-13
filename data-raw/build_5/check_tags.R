## Check for tag properties in v5 data
props <- readRDS('data-raw/build_5/all_properties_data.rds')

cat("Classes with 'tag' properties in v5:\n")
for(cls in names(props)) {
  df <- props[[cls]]
  tags <- grep('^tag', df$property, value=TRUE)
  if(length(tags) > 0) {
    cat(sprintf("  %s: %s\n", cls, paste(tags, collapse=", ")))
  }
}

# Count total tag properties
all_props <- do.call(rbind, props)
n_tag_props <- sum(grepl('^tag', all_props$property))
cat(sprintf("\nTotal tag properties in v5: %d\n", n_tag_props))

# Show all Individual properties
cat("\nAll Individual properties:\n")
print(props$Individual$property)
