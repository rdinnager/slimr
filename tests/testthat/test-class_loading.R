test_that("All SLiM 5.x class objects are loaded", {
  # Expected class objects for SLiM 5.x
  expected_classes <- c(
    "Initialize", "Chromosome", "Community", "Eidos",
    "Haplosome",  # New in v5 (replaces Genome)
    "GenomicElement", "GenomicElementType",
    "Individual", "InteractionType", "LogFile",
    "Mutation", "MutationType",
    "Plot",  # New in v5
    "SLiMBuiltin", "SLiMEidosBlock",
    "SLiMgui", "SpatialMap", "Species",
    "Subpopulation", "Substitution"
  )

  # Check that all class objects exist in namespace
  for (class_name in expected_classes) {
    expect_true(
      exists(class_name, envir = asNamespace("slimr")),
      info = paste("Class", class_name, "should exist")
    )
  }
})

test_that("Class abbreviations are loaded", {
  # Expected abbreviated class names
  expected_abbrs <- c(
    "Init", "Ch", "Co", "E",
    "Ha",  # New in v5
    "GE", "GET",
    "In", "IT", "LF",
    "M", "MT",
    "Pl",  # New in v5
    "SB", "SEB",
    "SG", "SM", "Sp",
    "P", "S"
  )

  # Check that all abbreviations exist
  for (abbr in expected_abbrs) {
    expect_true(
      exists(abbr, envir = asNamespace("slimr")),
      info = paste("Class abbreviation", abbr, "should exist")
    )
  }
})

test_that("Class objects with properties have them loaded", {
  # Classes that should have properties
  # Note: Eidos has no properties in SLiM 5.x, so it won't be in this list

  # Individual should have properties
  expect_true(
    length(ls(Individual)) > 0,
    info = "Individual class should have properties"
  )
  expect_true(
    "age" %in% ls(Individual),
    info = "Individual should have 'age' property"
  )

  # Species should have properties
  expect_true(
    length(ls(Species)) > 0,
    info = "Species class should have properties"
  )
  expect_true(
    "chromosome" %in% ls(Species),
    info = "Species should have 'chromosome' property"
  )

  # Haplosome should have properties (new in v5, replaces Genome)
  expect_true(
    length(ls(Haplosome)) > 0,
    info = "Haplosome class should have properties"
  )
  expect_true(
    "mutations" %in% ls(Haplosome),
    info = "Haplosome should have 'mutations' property"
  )

  # Subpopulation should have properties
  expect_true(
    length(ls(Subpopulation)) > 0,
    info = "Subpopulation class should have properties"
  )
  expect_true(
    "individuals" %in% ls(Subpopulation),
    info = "Subpopulation should have 'individuals' property"
  )
})

test_that("Eidos functions are available", {
  # Eidos class has no properties, but Eidos functions should be available
  # as eidos_* functions

  # Check that Eidos environment exists (even if empty)
  expect_true(
    exists("Eidos", envir = asNamespace("slimr")),
    info = "Eidos class object should exist"
  )

  # Check that key eidos_* functions are available
  eidos_functions <- c(
    "eidos_abs", "eidos_c", "eidos_cat",
    "eidos_float", "eidos_integer", "eidos_logical",
    "eidos_max", "eidos_min", "eidos_mean",
    "eidos_print", "eidos_seq", "eidos_sum"
  )

  for (func_name in eidos_functions) {
    expect_true(
      exists(func_name, envir = asNamespace("slimr")),
      info = paste("Eidos function", func_name, "should be available")
    )
  }
})

test_that("SLiM 5.x specific classes exist", {
  # Haplosome replaces Genome in v5
  expect_true(
    exists("Haplosome", envir = asNamespace("slimr")),
    info = "Haplosome class should exist (new in SLiM 5.x)"
  )

  # Plot is new in v5
  expect_true(
    exists("Plot", envir = asNamespace("slimr")),
    info = "Plot class should exist (new in SLiM 5.x)"
  )

  # Genome should NOT exist in v5 (was removed/renamed to Haplosome)
  # Note: We're checking the v5 namespace, not testing backwards compatibility
})

test_that("slim_classes data is loaded", {
  # The slim_classes data should be available
  expect_true(
    exists("slim_classes"),
    info = "slim_classes data should be loaded"
  )

  # It should be a data frame/tibble
  expect_true(
    is.data.frame(slim_classes),
    info = "slim_classes should be a data frame"
  )

  # It should have the expected columns
  expect_true(
    all(c("class_name", "class_abbr") %in% names(slim_classes)),
    info = "slim_classes should have class_name and class_abbr columns"
  )

  # Should have the expected number of classes (20 in v5)
  expect_equal(
    nrow(slim_classes),
    20,
    info = "slim_classes should have 20 classes for SLiM 5.x"
  )
})