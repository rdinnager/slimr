# Tests for SLiM 5.x API
# These tests verify that the v5 API is loaded correctly

test_that("v5 class objects are available in package", {
  # v5 classes should be present in loaded package
  expect_true(exists(".Ha", envir = asNamespace("slimr")))  # Haplosome (new in v5)
  expect_true(exists(".Pl", envir = asNamespace("slimr")))  # Plot (new in v5)
  expect_true(exists(".Init", envir = asNamespace("slimr")))  # Initialize (v4 and v5)
  expect_true(exists(".E", envir = asNamespace("slimr")))  # Eidos (v4 and v5)
})

test_that("slim_classes data contains v5 classes", {
  # Load the class lookup table from package data
  data("slim_classes", package = "slimr", envir = environment())

  slim_classes <- get("slim_classes", envir = environment())

  # Check it's a data frame with correct structure
  expect_s3_class(slim_classes, "data.frame")
  expect_true("class_name" %in% names(slim_classes))
  expect_true("class_abbr" %in% names(slim_classes))
  expect_true("class_internal" %in% names(slim_classes))

  # Check v5-specific classes are present
  expect_true("Haplosome" %in% slim_classes$class_name)
  expect_true("Plot" %in% slim_classes$class_name)

  # Check class abbreviations
  haplosome_row <- slim_classes[slim_classes$class_name == "Haplosome", ]
  expect_equal(haplosome_row$class_abbr, "Ha")
  expect_equal(haplosome_row$class_internal, ".Ha")

  plot_row <- slim_classes[slim_classes$class_name == "Plot", ]
  expect_equal(plot_row$class_abbr, "Pl")
  expect_equal(plot_row$class_internal, ".Pl")

  # v4-only classes should not be present
  expect_false("Genome" %in% slim_classes$class_name)
  expect_false("SLiMSim" %in% slim_classes$class_name)
})

test_that("expected number of v5 classes present", {
  # Load the class lookup table from package data
  data("slim_classes", package = "slimr", envir = environment())

  slim_classes <- get("slim_classes", envir = environment())

  # v5 should have 20 classes (including SLiMBuiltin - a slimr-created class)
  expect_equal(nrow(slim_classes), 20)

  # List of expected v5 classes
  expected_classes <- c(
    "Initialize", "Chromosome", "Community", "Eidos",
    "GenomicElement", "GenomicElementType", "Haplosome",
    "Individual", "InteractionType", "LogFile",
    "Mutation", "MutationType", "Plot", "SLiMBuiltin",
    "SLiMEidosBlock", "SLiMgui", "SpatialMap",
    "Species", "Subpopulation", "Substitution"
  )

  # All expected classes should be present
  for (class_name in expected_classes) {
    expect_true(class_name %in% slim_classes$class_name,
                info = paste(class_name, "should be in slim_classes"))
  }
})
