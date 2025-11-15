# Advanced tests for slim_run execution pipeline edge cases

# Helper function to create a basic minimal script
make_minimal_script <- function(end_gen = 10) {
  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, early(), {
      sim$addSubpop("p1", 100)
    }),
    slim_block(!!end_gen, late(), {
      sim$simulationFinished()
    })
  )
}

# Helper to create script with template variables
make_template_script <- function() {
  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, early(), {
      sim$addSubpop("p1", r_template("pop_size", 100))
    }),
    slim_block(10, late(), {
      sim$simulationFinished()
    })
  )
}

# Helper to create a script that errors
make_error_script <- function() {
  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, early(), {
      sim$addSubpop("p1", 100)
    }),
    slim_block(5, late(), {
      # This will cause an error: invalid function call
      stop("ERROR")
    })
  )
}

# ============================================================================
# 1. Auto-rendering behavior
# ============================================================================

test_that("unrendered script gets auto-rendered with inform message", {
  skip_if_not(slim_is_avail())

  script <- make_template_script()

  # Script should be unrendered
  expect_false(attr(script, "script_info")$rendered)

  # Running should auto-render and inform user
  expect_message(
    result <- slim_run(script),
    "slimr_script is unrendered. Trying to render now..."
  )

  expect_s3_class(result, "slimr_results")
  expect_equal(result$exit_status, 0L)
})

test_that("rendered script doesn't re-render", {
  skip_if_not(slim_is_avail())

  script <- make_template_script()
  rendered_script <- slim_script_render(script, template = data.frame(mut_rate = 1e-6, pop_size = 50))

  # Script should be rendered
  expect_true(attr(rendered_script, "script_info")$rendered)

  # Running should NOT show auto-render message
  expect_no_message(
    result <- slim_run(rendered_script),
    regexp = "unrendered"
  )

  expect_s3_class(result, "slimr_results")
  expect_equal(result$exit_status, 0L)
})

test_that("script without templates is marked as rendered", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()

  # Script without templates should be auto-marked as rendered
  expect_true(attr(script, "script_info")$rendered)

  # Should not show auto-render message
  expect_no_message(
    result <- slim_run(script),
    regexp = "unrendered"
  )
})

# ============================================================================
# 2. Exit status handling
# ============================================================================

test_that("successful run returns exit_status 0", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script)

  expect_equal(result$exit_status, 0L)
  expect_length(result$error, 0L)
})

test_that("exit_status is properly captured", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script)

  # Check that exit_status is an integer
  expect_type(result$exit_status, "integer")
  expect_length(result$exit_status, 1L)
})

test_that("successful run shows 'Success!' message", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()

  expect_message(
    result <- slim_run(script),
    "Success!"
  )
})

# ============================================================================
# 3. Error propagation (throw_error parameter)
# ============================================================================

test_that("throw_error = TRUE stops on error", {
  skip_if_not(slim_is_avail())

  script <- make_error_script()

  expect_error(
    slim_run(script, throw_error = TRUE)
  )
})

test_that("throw_error = FALSE returns result with error field", {
  skip_if_not(slim_is_avail())

  script <- make_error_script()

  # Should warn but not error
  expect_warning(
    result <- slim_run(script, throw_error = FALSE),
    "Failed!"
  )

  expect_s3_class(result, "slimr_results")
  expect_gt(result$exit_status, 0L)
  expect_type(result$error, "character")
})

test_that("throw_error default is FALSE", {
  skip_if_not(slim_is_avail())

  script <- make_error_script()

  # Default should not throw
  expect_warning(
    result <- slim_run(script),
    "Failed!"
  )

  expect_s3_class(result, "slimr_results")
})

test_that("error messages are captured in error field", {
  skip_if_not(slim_is_avail())

  script <- make_error_script()

  suppressWarnings({
    result <- slim_run(script, throw_error = FALSE)
  })

  expect_type(result$error, "character")
  expect_gt(length(result$error), 0L)
})

# ============================================================================
# 4. slimr_script_coll execution
# ============================================================================

test_that("collection with parallel = FALSE runs sequentially", {
  skip_if_not(slim_is_avail())

  script <- make_template_script()
  coll <- slim_script_render(script, template = data.frame(
    mut_rate = c(1e-7, 1e-6, 1e-5),
    pop_size = c(50, 75, 100)
  ))

  expect_s3_class(coll, "slimr_script_coll")
  expect_length(coll, 3L)

  results <- slim_run(coll, parallel = FALSE)

  expect_s3_class(results, "slimr_results_coll")
  expect_length(results, 3L)
  expect_true(all(purrr::map_int(results, "exit_status") == 0L))
})

test_that("collection results have correct structure", {
  skip_if_not(slim_is_avail())

  script <- make_template_script()
  coll <- slim_script_render(script, template = data.frame(
    mut_rate = c(1e-7, 1e-6),
    pop_size = c(50, 100)
  ))

  results <- slim_run(coll, parallel = FALSE)

  # Each result should be a slimr_results object
  expect_true(all(purrr::map_lgl(results, ~inherits(.x, "slimr_results"))))

  # Each should have expected fields
  for (i in seq_along(results)) {
    expect_named(results[[i]], c("output", "exit_status", "output_data", "process", "error", "output_file"))
  }
})

test_that("collection with parallel = TRUE requires future backend", {
  skip_if_not(slim_is_avail())
  skip_on_cran()

  script <- make_template_script()
  coll <- slim_script_render(script, template = data.frame(
    mut_rate = c(1e-7, 1e-6),
    pop_size = c(50, 100)
  ))

  # Set up future backend
  future::plan(future::multisession, workers = 2)
  on.exit(future::plan(future::sequential), add = TRUE)

  results <- slim_run(coll, parallel = TRUE)

  expect_s3_class(results, "slimr_results_coll")
  expect_length(results, 2L)
  expect_true(all(purrr::map_int(results, "exit_status") == 0L))
})

test_that("empty collection returns empty results", {
  skip_if_not(slim_is_avail())

  # Create empty collection
  coll <- structure(list(), class = "slimr_script_coll")

  results <- slim_run(coll, parallel = FALSE)

  expect_s3_class(results, "slimr_results_coll")
  expect_length(results, 0L)
})

# ============================================================================
# 5. Output file handling
# ============================================================================

test_that("simple_run = TRUE uses pipe for output", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script, simple_run = TRUE, capture_output = TRUE)

  expect_equal(result$output_file, "|")
})

test_that("simple_run = FALSE creates temp file", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script, simple_run = FALSE, capture_output = TRUE)

  expect_type(result$output_file, "character")
  expect_true(grepl("\\.txt$", result$output_file))
})

test_that("capture_output = TRUE captures output", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script, simple_run = TRUE, capture_output = TRUE)

  expect_type(result$output, "character")
})

test_that("capture_output = FALSE returns empty output", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script, simple_run = TRUE, capture_output = FALSE)

  expect_length(result$output, 0L)
})

# ============================================================================
# 6. Character input handling
# ============================================================================

test_that("slim_run.character accepts character vector", {
  skip_if_not(slim_is_avail())

  slim_code <- "
    initialize() {
      initializeMutationRate(1e-7);
      initializeMutationType('m1', 0.5, 'f', 0.0);
      initializeGenomicElementType('g1', m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }
    1 early() {
      sim.addSubpop('p1', 100);
    }
    10 late() {
      sim.simulationFinished();
    }
  "

  result <- slim_run(slim_code)

  expect_s3_class(result, "slimr_results")
  expect_equal(result$exit_status, 0L)
})

test_that("slim_run.character concatenates multi-element vectors", {
  skip_if_not(slim_is_avail())

  slim_code <- c(
    "initialize() {",
    "  initializeMutationRate(1e-7);",
    "  initializeMutationType('m1', 0.5, 'f', 0.0);",
    "  initializeGenomicElementType('g1', m1, 1.0);",
    "  initializeGenomicElement(g1, 0, 99999);",
    "  initializeRecombinationRate(1e-8);",
    "}",
    "1 early() { sim.addSubpop('p1', 100); }",
    "10 late() { sim.simulationFinished(); }"
  )

  expect_warning(
    result <- slim_run(slim_code),
    "Concatenating them with newline separators"
  )

  expect_s3_class(result, "slimr_results")
  expect_equal(result$exit_status, 0L)
})

# ============================================================================
# 7. Results object structure
# ============================================================================

test_that("slimr_results has all required fields", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script)

  expect_s3_class(result, "slimr_results")
  expect_named(result, c("output", "exit_status", "output_data", "process", "error", "output_file"))
})

test_that("output_data is a slimr_output_data tibble", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script)

  expect_s3_class(result$output_data, "slimr_output_data")
  expect_s3_class(result$output_data, "tbl_df")
})

test_that("process is a processx object", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()
  result <- slim_run(script)

  expect_s3_class(result$process, "process")
})

# ============================================================================
# 8. Additional edge cases
# ============================================================================

test_that("running very short simulation works", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script(end_gen = 2)
  result <- slim_run(script)

  expect_equal(result$exit_status, 0L)
})

test_that("slim_run invisibly returns result", {
  skip_if_not(slim_is_avail())

  script <- make_minimal_script()

  # Should be invisible
  expect_invisible <- function(x) {
    expect_true(withVisible(x)$visible == FALSE)
  }

  suppressMessages({
    result <- slim_run(script)
  })

  # Result should still be returned
  expect_s3_class(result, "slimr_results")
})

test_that("assert_slim_installed is called for all methods", {
  skip_if(slim_is_avail())

  # If SLiM is not installed, should error
  expect_error(
    slim_run(make_minimal_script()),
    "SLiM"
  )

  expect_error(
    slim_run("initialize() { }"),
    "SLiM"
  )
})
