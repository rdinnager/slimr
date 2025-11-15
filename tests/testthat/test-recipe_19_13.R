test_that("Recipe 19.13: Tree-sequence with nucleotide-based models works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create temporary directory for output
  temp_dir <- tempdir()
  old_wd <- getwd()
  setwd(temp_dir)

  # Clean up any previous test files
  if (file.exists("test_recipe_nuc.trees")) file.remove("test_recipe_nuc.trees")

  # Create shortened test version
  recipe_19_13_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("L", 1e4)  # Smaller for testing

      initializeSLiMOptions(nucleotideBased = T)
      initializeTreeSeq()

      initializeAncestralNucleotides(randomNucleotides(L))

      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(1e-6))
      initializeGenomicElement(g1, 0, L - 1)
      initializeRecombinationRate(1e-6)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 500)  # Smaller for testing
    }),

    # Shorter runtime: 100 instead of 1000
    slim_block(100, late(), {
      sim$treeSeqOutput("test_recipe_nuc.trees")
    })
  )

  # Run the test
  result <- slim_run(recipe_19_13_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Verify tree sequence file was created
  expect_true(file.exists("test_recipe_nuc.trees"))

  # Check file has content
  if (file.exists("test_recipe_nuc.trees")) {
    file_size <- file.info("test_recipe_nuc.trees")$size
    expect_gt(file_size, 0)
  }

  # Clean up
  setwd(old_wd)
  if (file.exists(file.path(temp_dir, "test_recipe_nuc.trees")))
    file.remove(file.path(temp_dir, "test_recipe_nuc.trees"))
})
