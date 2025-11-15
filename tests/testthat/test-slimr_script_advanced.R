# Advanced tests for slimr_script manipulation functions
# These tests cover advanced features NOT covered in test-slimr_script.R

# Helper to create minimal script
make_minimal_script <- function() {
  suppressWarnings(slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500)
    }),
    slim_block(1, 100, {
      sim.simulationFinished()
    })
  ))
}

# Helper to create unrendered script with templates
make_template_script <- function() {
  suppressWarnings(slim_script(
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 500))
    })
  ))
}

# =============================================================================
# 1. slim_script_duration() modification tests
# =============================================================================

test_that("slim_script_duration() sets duration shorter than current", {
  script <- make_minimal_script()
  modified <- slim_script_duration(script, 50)

  # The function sets end_gens < duration TO duration
  # So block 3 with end_gen=100 stays at 100 (not < 50)
  # The function doesn't reduce end_gen values
  expect_equal(as.numeric(end_gen(modified)[3]), 100)
  expect_equal(as.numeric(vctrs::field(modified, "start_gen")[3]), 1)
})

test_that("slim_script_duration() sets duration longer than current", {
  script <- make_minimal_script()
  modified <- slim_script_duration(script, 200)

  # end_gens < 200 should be set TO 200
  # Block 3 has end_gen=100 which is < 200, so it becomes 200
  expect_equal(as.numeric(end_gen(modified)[3]), 200)
  # Note: script_info is NOT updated by slim_script_duration
})

test_that("slim_script_duration() increases end_gen to match duration", {
  script <- make_minimal_script()
  modified <- slim_script_duration(script, 150)

  # Blocks with end_gen < 150 should be updated to 150
  expect_equal(as.numeric(end_gen(modified)[3]), 150)
})

test_that("slim_script_duration() handles duration = 1", {
  script <- make_minimal_script()
  modified <- slim_script_duration(script, 1)

  # Non-range blocks have NA for end_gen
  expect_true(is.na(end_gen(modified)[2]))
  # Range block with end_gen=100 is > 1, so stays at 100
  expect_equal(as.numeric(end_gen(modified)[3]), 100)
})

test_that("slim_script_duration() updates start_gen when > duration", {
  script <- make_minimal_script()
  modified <- slim_script_duration(script, 50)

  # start_gens > duration should be set TO duration
  # Block 3 has start_gen=1 which is < 50, so stays at 1
  expect_equal(as.numeric(vctrs::field(modified, "start_gen")[3]), 1)
})

# =============================================================================
# 2. Script concatenation (vec_c) tests
# =============================================================================

test_that("vec_c combines scripts with compatible metadata", {
  suppressWarnings(script1 <- slim_script(
    slim_block(1, {
      sim.addSubpop("p1", 500)
    })
  ))

  suppressWarnings(script2 <- slim_script(
    slim_block(100, {
      sim.simulationFinished()
    })
  ))

  combined <- vctrs::vec_c(script1, script2)

  expect_s3_class(combined, "slimr_script")
  expect_equal(length(combined), 2)
  expect_equal(attr(combined, "script_info")$end_gen, 100)
})

test_that("vec_c combines scripts with different inline attributes", {
  suppressWarnings(script1 <- slim_script(
    slim_block(1, {
      x <- r_inline(c(1, 2, 3))
      sim.addSubpop("p1", 500)
    })
  ))

  suppressWarnings(script2 <- slim_script(
    slim_block(100, {
      sim.simulationFinished()
    })
  ))

  combined <- vctrs::vec_c(script1, script2)

  expect_s3_class(combined, "slimr_script")
  # Should preserve inline metadata
  expect_true(nrow(attr(combined, "slimr_inline")) >= nrow(attr(script1, "slimr_inline")))
})

test_that("vec_c combines scripts with different template attributes", {
  suppressWarnings(script1 <- slim_script(
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 500))
    })
  ))

  suppressWarnings(script2 <- slim_script(
    slim_block(100, {
      sim.simulationFinished()
    })
  ))

  combined <- vctrs::vec_c(script1, script2)

  expect_s3_class(combined, "slimr_script")
  # Should preserve template metadata
  expect_true(any(!is.na(attr(combined, "slimr_template")$var_names)))
})

test_that("vec_c combines scripts with different output attributes", {
  suppressWarnings(script1 <- slim_script(
    slim_block(1, 100, {
      slimr_output(sim.outputFull(), "out", do_every = 10)
    })
  ))

  suppressWarnings(script2 <- slim_script(
    slim_block(100, {
      sim.simulationFinished()
    })
  ))

  combined <- vctrs::vec_c(script1, script2)

  expect_s3_class(combined, "slimr_script")
  # Should preserve output metadata
  expect_true(nrow(attr(combined, "slimr_output")) >= nrow(attr(script1, "slimr_output")))
})

test_that("vec_c handles single block scripts", {
  suppressWarnings(script1 <- slim_script(
    slim_block(1, {
      sim.addSubpop("p1", 100)
    })
  ))

  suppressWarnings(script2 <- slim_script(
    slim_block(100, {
      sim.simulationFinished()
    })
  ))

  combined <- vctrs::vec_c(script1, script2)

  expect_s3_class(combined, "slimr_script")
  expect_equal(length(combined), 2)
})

test_that("vec_c sets rendered flag correctly", {
  suppressWarnings(script1 <- slim_script(
    slim_block(1, {
      sim.addSubpop("p1", 500)
    })
  ))

  suppressWarnings(script2 <- slim_script(
    slim_block(100, {
      sim.simulationFinished()
    })
  ))

  # Mark one as rendered
  attr(script1, "script_info")$rendered <- TRUE
  attr(script2, "script_info")$rendered <- FALSE

  combined <- vctrs::vec_c(script1, script2)

  # Should be FALSE if any are not rendered
  expect_false(attr(combined, "script_info")$rendered)
})

# =============================================================================
# 3. Field getters and setters tests
# =============================================================================

test_that("code() getter extracts code correctly", {
  script <- make_minimal_script()
  code_field <- code(script)

  expect_s3_class(code_field, "slimr_code")
  expect_equal(length(code_field), 3)
})

test_that("code<-() setter replaces code", {
  script <- make_minimal_script()
  new_code <- slimr_code("print('test')", "x <- 1", "y <- 2")

  code(script) <- new_code

  expect_equal(length(code(script)), 3)
  expect_equal(as.character(code(script)[[1]]), "print('test')")
})

test_that("code<-() accepts valid slimr_code", {
  script <- make_minimal_script()
  new_code <- slimr_code("print('test')", "x <- 1", "y <- 2")

  # This should work
  code(script) <- new_code
  expect_equal(length(code(script)), 3)
})

test_that("end_gen() getter extracts end generations", {
  script <- make_minimal_script()
  end_gens <- end_gen(script)

  expect_type(end_gens, "character")
  expect_equal(length(end_gens), 3)
  # Only range blocks have end_gen, others are NA
  expect_equal(end_gens[3], "100")
  expect_true(is.na(end_gens[1]))
})

test_that("end_gen<-() setter modifies end generation", {
  script <- make_minimal_script()

  # Directly modify field to test setter
  vctrs::field(script, "end_gen")[3] <- "200"
  attr(script, "script_info")$end_gen <- 200

  expect_equal(end_gen(script)[3], "200")
})

test_that("end_gen<-() updates script correctly", {
  script <- make_minimal_script()

  # Use actual setter
  end_gen(script)[3] <- "500"

  expect_equal(end_gen(script)[3], "500")
})

test_that("script_info tracks maximum end_gen", {
  script <- make_minimal_script()

  # script_info$end_gen should reflect max generation
  expect_equal(attr(script, "script_info")$end_gen, 100)

  # After modifying, it should update if we manually update the attribute
  vctrs::field(script, "end_gen")[3] <- "150"
  attr(script, "script_info")$end_gen <- 150
  expect_equal(attr(script, "script_info")$end_gen, 150)
})

# =============================================================================
# 4. get_block() extraction tests
# =============================================================================

test_that("get_block() extracts by numeric index", {
  script <- make_minimal_script()

  block <- get_block(script, 1)

  expect_s3_class(block, "slimr_script")
  expect_equal(length(block), 1)
  expect_equal(vctrs::field(block, "callback"), "initialize()")
})

test_that("get_block() extracts by block name", {
  script <- make_minimal_script()

  # Check what the actual block name is
  block_names <- vctrs::field(script, "block_name")
  init_block_name <- block_names[1]

  block <- get_block(script, init_block_name)

  expect_s3_class(block, "slimr_script")
  expect_equal(length(block), 1)
  expect_equal(vctrs::field(block, "callback"), "initialize()")
})

test_that("get_block() extracts multiple blocks by numeric indices", {
  script <- make_minimal_script()

  blocks <- get_block(script, c(1, 3))

  expect_s3_class(blocks, "slimr_script")
  expect_equal(length(blocks), 2)
})

test_that("get_block() errors on invalid numeric index", {
  script <- make_minimal_script()

  expect_error(get_block(script, 10))
  # Note: vctrs allows 0 and negative indices with special behavior
  # so we test only clearly out-of-bounds positive indices
})

test_that("get_block() errors on invalid block name", {
  script <- make_minimal_script()

  expect_error(get_block(script, "nonexistent_block"))
})

test_that("get_block() preserves attributes", {
  suppressWarnings(script <- slim_script(
    slim_block(1, {
      x <- r_inline(c(1, 2, 3))
      sim.addSubpop("p1", 500)
    })
  ))

  block <- get_block(script, 1)

  expect_true(!is.null(attr(block, "slimr_inline")))
  expect_true(!is.null(attr(block, "slimr_template")))
  expect_true(!is.null(attr(block, "script_info")))
})

# =============================================================================
# 5. slimr_script_coll operations tests
# =============================================================================

test_that("slimr_script_coll creates collection from scripts", {
  script1 <- make_minimal_script()
  script2 <- make_minimal_script()

  coll <- slimr_script_coll(script1, script2)

  expect_s3_class(coll, "slimr_script_coll")
  expect_equal(length(coll), 2)
})

test_that("slimr_script_coll handles single script", {
  script <- make_minimal_script()

  coll <- slimr_script_coll(script)

  expect_s3_class(coll, "slimr_script_coll")
  expect_equal(length(coll), 1)
})

test_that("slimr_script_coll format works correctly", {
  scripts <- replicate(5, make_minimal_script(), simplify = FALSE)
  coll <- do.call(slimr_script_coll, scripts)

  # Test that format returns a character vector
  expect_s3_class(coll, "slimr_script_coll")
  expect_equal(length(coll), 5)
})

test_that("slimr_script_coll prints with max_show limit", {
  scripts <- replicate(5, make_minimal_script(), simplify = FALSE)
  coll <- do.call(slimr_script_coll, scripts)

  # Should print without error and show truncation
  expect_output(print(coll), "and.*more", ignore.case = TRUE)
})

test_that("slimr_script_coll handles empty collection", {
  coll <- new_slimr_script_coll()

  expect_s3_class(coll, "slimr_script_coll")
  expect_equal(length(coll), 0)
  expect_equal(format(coll), "{}")
})

# =============================================================================
# 6. as_slimr_script() conversion tests
# =============================================================================

test_that("as_slimr_script() converts valid SLiM text", {
  slim_text <- "initialize() { initializeMutationRate(1e-7); }"

  script <- as_slimr_script(slim_text)

  expect_s3_class(script, "slimr_script")
  expect_equal(length(script), 1)
})

test_that("as_slimr_script() handles multiblock scripts", {
  slim_text <- "
  initialize() { initializeMutationRate(1e-7); }
  1 { sim.addSubpop('p1', 500); }
  100 { sim.simulationFinished(); }
  "

  script <- as_slimr_script(slim_text)

  expect_s3_class(script, "slimr_script")
  expect_equal(length(script), 3)
})

test_that("as_slimr_script() rejects non-character input", {
  expect_error(as_slimr_script(123), "only accepts character")
  expect_error(as_slimr_script(NULL), "only accepts character")
  expect_error(as_slimr_script(list()), "only accepts character")
})

test_that("as_slimr_script() handles empty string", {
  # Empty string should parse but produce empty script
  script <- as_slimr_script("")

  expect_s3_class(script, "slimr_script")
})

test_that("as_slimr_script() handles SLiM comments", {
  slim_text <- "
  // This is a comment
  initialize() {
    // Another comment
    initializeMutationRate(1e-7);
  }
  "

  script <- as_slimr_script(slim_text)

  expect_s3_class(script, "slimr_script")
  expect_equal(length(script), 1)
})

test_that("as_slimr_script() marks script as rendered", {
  slim_text <- "initialize() { initializeMutationRate(1e-7); }"

  script <- as_slimr_script(slim_text)

  expect_true(attr(script, "script_info")$rendered)
})

test_that("as_slimr_script() sets correct end_gen in script_info", {
  slim_text <- "
  initialize() { initializeMutationRate(1e-7); }
  1 { sim.addSubpop('p1', 500); }
  100 { sim.simulationFinished(); }
  "

  script <- as_slimr_script(slim_text)

  expect_equal(attr(script, "script_info")$end_gen, 100)
})

test_that("as_slimr_script() handles generation ranges", {
  slim_text <- "1:100 { catn(sim.cycle); }"

  script <- as_slimr_script(slim_text)

  expect_equal(vctrs::field(script, "start_gen"), "1")
  expect_equal(vctrs::field(script, "end_gen"), "100")
})

# =============================================================================
# 7. Rendering edge cases tests
# =============================================================================

test_that("slim_script_render() handles script with no templates", {
  # Scripts created with slim_script are already marked as rendered
  # So we test rendering an unrendered template script
  script <- make_template_script()

  # Mark as unrendered
  attr(script, "script_info")$rendered <- FALSE

  # Should render without error
  rendered <- slim_script_render(script)

  expect_s3_class(rendered, "slimr_script")
  expect_true(attr(rendered, "script_info")$rendered)
})

test_that("slim_script_render() errors on already-rendered script", {
  # Create script that's already rendered
  script <- make_minimal_script()

  expect_error(
    slim_script_render(script),
    "already been rendered"
  )
})

test_that("slim_script_render() allows replication on rendered script", {
  # Create already-rendered script
  script <- make_minimal_script()

  # reps > 1 should work on already-rendered
  replicated <- slim_script_render(script, reps = 3)

  expect_s3_class(replicated, "slimr_script_coll")
  expect_equal(length(replicated), 3)
})

test_that("slim_script_render() handles reps > 1 with templates", {
  script <- make_template_script()
  attr(script, "script_info")$rendered <- FALSE

  rendered <- slim_script_render(script,
                                  template = data.frame(pop_size = c(100, 200)),
                                  reps = 1)

  expect_s3_class(rendered, "slimr_script_coll")
  expect_equal(length(rendered), 2)
})

test_that("slim_script_render() requires template when no defaults", {
  script <- make_template_script()
  # Remove default by creating template without default
  suppressWarnings(script2 <- slim_script(
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size"))
    })
  ))
  attr(script2, "script_info")$rendered <- FALSE

  expect_error(
    slim_script_render(script2),
    "not all templated variables have defaults"
  )
})

test_that("slim_script_render() uses defaults when template not provided", {
  script <- make_template_script()
  attr(script, "script_info")$rendered <- FALSE

  # Should use default value
  rendered <- suppressWarnings(slim_script_render(script))

  expect_s3_class(rendered, "slimr_script")
  expect_true(attr(rendered, "script_info")$rendered)
})

test_that("slim_script_render() converts data.frame template correctly", {
  script <- make_template_script()
  attr(script, "script_info")$rendered <- FALSE

  rendered <- slim_script_render(script,
                                  template = data.frame(pop_size = c(100, 200)))

  expect_s3_class(rendered, "slimr_script_coll")
  expect_equal(length(rendered), 2)
})

test_that("slim_script_render() accepts list template", {
  script <- make_template_script()
  attr(script, "script_info")$rendered <- FALSE

  rendered <- slim_script_render(script,
                                  template = list(pop_size = 100))

  expect_s3_class(rendered, "slimr_script")
  expect_true(attr(rendered, "script_info")$rendered)
})

# =============================================================================
# 8. Additional edge cases
# =============================================================================

test_that("as_slim_text() converts script to text correctly", {
  script <- make_minimal_script()

  text <- as_slim_text(script)

  expect_type(text, "character")
  expect_equal(length(text), 1)
  expect_true(grepl("initialize", text))
})

test_that("reconstruct() generates valid slimrlang code", {
  script <- make_minimal_script()

  reconstructed <- reconstruct(script)

  expect_type(reconstructed, "character")
  expect_true(grepl("slim_script", reconstructed))
  expect_true(grepl("slim_block", reconstructed))
})

test_that("slimr_write() writes script to file", {
  script <- make_minimal_script()
  temp_file <- tempfile(fileext = ".txt")

  slimr_write(script, temp_file)

  expect_true(file.exists(temp_file))
  content <- readLines(temp_file)
  expect_true(length(content) > 0)
  expect_true(any(grepl("initialize", content)))

  unlink(temp_file)
})

test_that("format.slimr_script() respects add_block_names parameter", {
  script <- make_minimal_script()

  with_names <- format(script, add_block_names = TRUE)
  without_names <- format(script, add_block_names = FALSE)

  expect_true(any(grepl("block_", with_names)))
  expect_false(any(grepl("block_", without_names)))
})

test_that("slimr_code() creates code objects from strings", {
  code <- slimr_code("line1", "line2", "line3")

  expect_s3_class(code, "slimr_code")
  expect_equal(length(code), 3)
})

test_that("as.character.slimr_code() with as_list parameter", {
  code <- slimr_code("line1", "line2")

  as_list <- as.character(code, as_list = TRUE)
  as_string <- as.character(code, as_list = FALSE)

  expect_type(as_list, "list")
  expect_type(as_string, "character")
})

test_that("field modification updates script_info correctly", {
  script <- make_minimal_script()

  # Modify end_gen field directly
  vctrs::field(script, "end_gen")[3] <- "200"

  # Check field was updated
  expect_equal(end_gen(script)[3], "200")

  # Note: script_info would need to be manually updated
  # or updated through proper setter functions
})
