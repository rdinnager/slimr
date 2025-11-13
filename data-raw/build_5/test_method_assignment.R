# Test if method assignments work

# Create test class objects
Species <- Sp <- .Sp <- list()

# Test method assignment code (like what's generated)
Species$addSubpop <- Sp$addSubpop <- .Sp$addSubpop <- function(subpopID, size) {
  message("Method called!")
}

# Check what we have
cat("Species object:\n")
cat("  Total items:", length(Species), "\n")
cat("  Functions:", sum(sapply(Species, is.function)), "\n")
cat("  Names:", paste(names(Species), collapse=", "), "\n\n")

cat(".Sp object:\n")
cat("  Total items:", length(.Sp), "\n")
cat("  Functions:", sum(sapply(.Sp, is.function)), "\n")
cat("  Names:", paste(names(.Sp), collapse=", "), "\n\n")

# Try calling the method
cat("Calling Species$addSubpop:\n")
Species$addSubpop(1, 100)

cat("\nCalling .Sp$addSubpop:\n")
.Sp$addSubpop(1, 100)
