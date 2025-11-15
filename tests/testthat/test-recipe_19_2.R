test_that("Recipe 19.2: Reading ancestral sequence from FASTA works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create a simple FASTA file for testing
  fasta_content <- c(
    ">test_sequence",
    "ATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCG",
    "ATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCG",
    "ATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCG",
    "ATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCG",
    "ATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCG"
  )
  writeLines(fasta_content, "FASTA.txt")

  # Verify FASTA file was created
  expect_true(file.exists("FASTA.txt"))

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_19_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_19_2_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from output_file
  output <- paste(readLines(result$output_file), collapse = "\n")

  # Verify nucleotide-based mutations are in output
  expect_true(grepl("Mutations", output) || grepl("#OUT", output))

  # Clean up FASTA file
  if (file.exists("FASTA.txt")) {
    unlink("FASTA.txt")
  }
})
