# Tests for r_inline() and the inline layer of the three-layer processing system

test_that("r_inline creates correct placeholders for scalars", {
  # Numeric scalar
  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_inline(1e-7))
    })
  ) -> script_num

  expect_s3_class(script_num, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_num), "1e-07")))

  # Integer scalar
  slim_script(
    slim_block(1, {
      sim$addSubpop("p1", r_inline(500L))
    })
  ) -> script_int

  expect_s3_class(script_int, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_int), "500")))

  # Character scalar
  slim_script(
    slim_block(1, {
      catn(r_inline("Hello"))
    })
  ) -> script_char

  expect_s3_class(script_char, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_char), "Hello")))

  # Logical scalar
  slim_script(
    slim_block(initialize(), {
      defineConstant("DEBUG", r_inline(TRUE))
    })
  ) -> script_lgl

  expect_s3_class(script_lgl, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_lgl), "T")))
})

test_that("r_inline handles numeric vectors", {
  popsizes <- c(100, 200, 300)

  slim_script(
    slim_block(1, {
      popsizes <- r_inline(popsizes)
      sim$addSubpop("p1", popsizes[0])
    })
  ) -> script_vec

  expect_s3_class(script_vec, "slimr_script")
  # Check that vector is properly formatted
  script_text <- as.character(script_vec)
  expect_true(any(stringr::str_detect(script_text, "100")))
  expect_true(any(stringr::str_detect(script_text, "200")))
  expect_true(any(stringr::str_detect(script_text, "300")))
})

test_that("r_inline handles character vectors", {
  subpop_names <- c("p1", "p2", "p3")

  slim_script(
    slim_block(1, {
      names <- r_inline(subpop_names)
      catn(names)
    })
  ) -> script_char_vec

  expect_s3_class(script_char_vec, "slimr_script")
  script_text <- as.character(script_char_vec)
  expect_true(any(stringr::str_detect(script_text, "p1")))
})

test_that("r_inline handles logical vectors", {
  flags <- c(TRUE, FALSE, TRUE)

  slim_script(
    slim_block(1, {
      flags <- r_inline(flags)
      catn(flags)
    })
  ) -> script_lgl_vec

  expect_s3_class(script_lgl_vec, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_lgl_vec), "T|F")))
})

test_that("r_inline handles empty vectors", {
  empty_vec <- numeric(0)

  slim_script(
    slim_block(1, {
      x <- r_inline(empty_vec)
      catn(x)
    })
  ) -> script_empty

  expect_s3_class(script_empty, "slimr_script")
})

test_that("r_inline handles matrices", {
  # 2x2 migration matrix
  migration_matrix <- matrix(c(0, 0.1, 0.1, 0), nrow = 2)

  slim_script(
    slim_block(1, {
      m <- r_inline(migration_matrix)
      catn(m)
    })
  ) -> script_matrix

  expect_s3_class(script_matrix, "slimr_script")
  script_text <- as.character(script_matrix)
  expect_true(any(stringr::str_detect(script_text, "matrix")))
  expect_true(any(stringr::str_detect(script_text, "nrow")))
  expect_true(any(stringr::str_detect(script_text, "ncol")))
})

test_that("r_inline handles 3D arrays", {
  # 3D array
  arr_3d <- array(1:8, dim = c(2, 2, 2))

  slim_script(
    slim_block(1, {
      a <- r_inline(arr_3d)
      catn(a)
    })
  ) -> script_array

  expect_s3_class(script_array, "slimr_script")
  script_text <- as.character(script_array)
  expect_true(any(stringr::str_detect(script_text, "array")))
  expect_true(any(stringr::str_detect(script_text, "dim")))
})

test_that("r_inline with delay = FALSE evaluates immediately", {
  x <- 42

  slim_script(
    slim_block(1, {
      y <- r_inline(x, delay = FALSE)
      catn(y)
    })
  ) -> script_immediate

  expect_s3_class(script_immediate, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_immediate), "42")))
})

test_that("r_inline with delay = TRUE defers evaluation", {
  # Create script with delayed inline before object exists
  script_delayed <- slim_script(
    slim_block(1, {
      y <- r_inline(future_value, delay = TRUE)
      catn(y)
    })
  )

  expect_s3_class(script_delayed, "slimr_script")

  # Now define the value and render
  future_value <- 99

  script_rendered <- slim_script_render(script_delayed)
  expect_s3_class(script_rendered, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_rendered), "99")))
})

test_that("r_inline handles NULL objects", {
  expect_error(
    slim_script(
      slim_block(1, {
        x <- r_inline(NULL)
      })
    ),
    NA  # Should not error, but behavior may vary
  )
})

test_that("r_inline handles NA values in vectors", {
  vec_with_na <- c(1, NA, 3)

  slim_script(
    slim_block(1, {
      x <- r_inline(vec_with_na)
      catn(x)
    })
  ) -> script_na

  expect_s3_class(script_na, "slimr_script")
})

test_that("r_inline handles named vectors", {
  named_vec <- c(a = 1, b = 2, c = 3)

  slim_script(
    slim_block(1, {
      x <- r_inline(named_vec)
      catn(x)
    })
  ) -> script_named

  expect_s3_class(script_named, "slimr_script")
  # Names should be removed during inline
  script_text <- as.character(script_named)
  expect_true(any(stringr::str_detect(script_text, "1")))
})

test_that("multiple r_inline calls in same block work", {
  val1 <- 100
  val2 <- 200

  slim_script(
    slim_block(1, {
      sim$addSubpop("p1", r_inline(val1))
      sim$addSubpop("p2", r_inline(val2))
    })
  ) -> script_multi

  expect_s3_class(script_multi, "slimr_script")
  script_text <- as.character(script_multi)
  expect_true(any(stringr::str_detect(script_text, "100")))
  expect_true(any(stringr::str_detect(script_text, "200")))
})

test_that("r_inline works across multiple blocks", {
  popsize <- 500

  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_inline(1e-7))
    }),
    slim_block(1, {
      sim$addSubpop("p1", r_inline(popsize))
    })
  ) -> script_multi_block

  expect_s3_class(script_multi_block, "slimr_script")
  expect_length(script_multi_block, 2L)
  script_text <- as.character(script_multi_block)
  expect_true(any(stringr::str_detect(script_text, "1e-07")))
  expect_true(any(stringr::str_detect(script_text, "500")))
})

test_that("r_inline + r_template in same script", {
  popsize <- 500

  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7))
    }),
    slim_block(1, {
      sim$addSubpop("p1", r_inline(popsize))
    })
  ) -> script_combo

  expect_s3_class(script_combo, "slimr_script")

  # Check template attribute exists
  template_attr <- attr(script_combo, "slimr_template")
  expect_false(all(is.na(template_attr$var_names)))

  # Check inline attribute exists
  inline_attr <- attr(script_combo, "slimr_inline")
  expect_false(all(is.na(inline_attr$code_for_slim)))

  # Render with template value
  script_rendered <- slim_script_render(script_combo, template = list(mut_rate = 1e-6))
  expect_s3_class(script_rendered, "slimr_script")
})

test_that("r_inline + slimr_output in same script", {
  popsize <- 500

  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      sim$addSubpop("p1", r_inline(popsize))
    }),
    slim_block(1, 100, {
      slimr_output(sim$outputFull(), "full", do_every = 50)
    }),
    slim_block(100, {
      sim$simulationFinished()
    })
  ) -> script_with_output

  expect_s3_class(script_with_output, "slimr_script")

  # Check inline attribute
  inline_attr <- attr(script_with_output, "slimr_inline")
  expect_false(all(is.na(inline_attr$code_for_slim)))

  # Check output attribute
  output_attr <- attr(script_with_output, "slimr_output")
  expect_false(all(is.na(output_attr$code_for_slim)))
})

test_that("r_inline handles very large vectors", {
  large_vec <- runif(1000)

  slim_script(
    slim_block(1, {
      x <- r_inline(large_vec)
      catn(size(x))
    })
  ) -> script_large

  expect_s3_class(script_large, "slimr_script")
})

test_that("r_inline alias slimr_inline works", {
  slim_script(
    slim_block(1, {
      x <- slimr_inline(42)
      catn(x)
    })
  ) -> script_alias

  expect_s3_class(script_alias, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_alias), "42")))
})

test_that("r_inline with integer sequences", {
  seq_vec <- 1:10

  slim_script(
    slim_block(1, {
      x <- r_inline(seq_vec)
      catn(x)
    })
  ) -> script_seq

  expect_s3_class(script_seq, "slimr_script")
  script_text <- as.character(script_seq)
  expect_true(any(stringr::str_detect(script_text, "1")))
  expect_true(any(stringr::str_detect(script_text, "10")))
})

test_that("r_inline metadata stored correctly in attributes", {
  popsize <- 500

  slim_script(
    slim_block(1, {
      sim$addSubpop("p1", r_inline(popsize))
    })
  ) -> script_meta

  inline_attr <- attr(script_meta, "slimr_inline")

  # Check structure of inline attribute
  expect_true("block_name" %in% names(inline_attr))
  expect_true("code_for_slim" %in% names(inline_attr))
  expect_true("code_for_display" %in% names(inline_attr))

  # Check that inline was recorded
  expect_false(all(is.na(inline_attr$code_for_slim)))
  expect_false(all(is.na(inline_attr$code_for_display)))
})

test_that("r_inline generates unique placeholders", {
  slim_script(
    slim_block(1, {
      x <- r_inline(1)
      y <- r_inline(2)
      z <- r_inline(3)
    })
  ) -> script_unique

  inline_attr <- attr(script_unique, "slimr_inline")

  # Should have 3 inline entries
  expect_equal(sum(!is.na(inline_attr$code_for_slim)), 3L)

  # Placeholders should be unique
  placeholders <- inline_attr$code_for_slim[!is.na(inline_attr$code_for_slim)]
  expect_equal(length(placeholders), length(unique(placeholders)))
})

test_that("r_inline handles matrices with different dimensions", {
  # 3x4 matrix
  mat_3x4 <- matrix(1:12, nrow = 3, ncol = 4)

  slim_script(
    slim_block(1, {
      m <- r_inline(mat_3x4)
      catn(m)
    })
  ) -> script_rect

  expect_s3_class(script_rect, "slimr_script")
  script_text <- as.character(script_rect)
  expect_true(any(stringr::str_detect(script_text, "nrow = 3")))
  expect_true(any(stringr::str_detect(script_text, "ncol = 4")))
})

test_that("r_inline works in rendered scripts", {
  popsize <- 500

  slim_script(
    slim_block_init_minimal(),
    slim_block(1, {
      sim$addSubpop("p1", r_inline(popsize))
    }),
    slim_block(100, {
      sim$simulationFinished()
    })
  ) -> script_render

  # Render the script (even without templates)
  script_rendered <- slim_script_render(script_render)

  expect_s3_class(script_rendered, "slimr_script")
  expect_true(any(stringr::str_detect(as.character(script_rendered), "500")))
})

test_that("r_inline can be used with slim_run", {
  skip_if_not(slim_is_avail())

  popsize <- 100

  slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      sim$addSubpop("p1", r_inline(popsize))
    }),
    slim_block(100, {
      sim$simulationFinished()
    })
  ) -> script_run

  result <- slim_run(script_run, throw_error = TRUE)

  expect_s3_class(result, "slimr_results")
  expect_identical(result$exit_status, 0L)
})

test_that("r_inline handles mixed type matrices", {
  # Numeric matrix
  num_mat <- matrix(c(0.1, 0.2, 0.3, 0.4), nrow = 2)

  slim_script(
    slim_block(1, {
      x <- r_inline(num_mat)
      catn(x)
    })
  ) -> script_num_mat

  expect_s3_class(script_num_mat, "slimr_script")
  script_text <- as.character(script_num_mat)
  expect_true(any(stringr::str_detect(script_text, "0\\.")))
})

test_that("r_inline with delay interacts correctly with templates", {
  script_delayed_template <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7))
    }),
    slim_block(1, {
      sim$addSubpop("p1", r_inline(delayed_pop, delay = TRUE))
    })
  )

  expect_s3_class(script_delayed_template, "slimr_script")

  # Now define delayed value
  delayed_pop <- 250

  # Render with both template and delayed inline
  script_rendered <- slim_script_render(
    script_delayed_template,
    template = list(mut_rate = 1e-6)
  )

  expect_s3_class(script_rendered, "slimr_script")
  script_text <- as.character(script_rendered)
  expect_true(any(stringr::str_detect(script_text, "1e-06")))
  expect_true(any(stringr::str_detect(script_text, "250")))
})

test_that("r_inline preserves numeric precision", {
  precise_val <- 1.23456789012345

  slim_script(
    slim_block(1, {
      x <- r_inline(precise_val)
      catn(x)
    })
  ) -> script_precise

  expect_s3_class(script_precise, "slimr_script")
  # Check that precision is maintained in output
  script_text <- as.character(script_precise)
  expect_true(any(stringr::str_detect(script_text, "1\\.234")))
})

test_that("r_inline handles single-element matrices", {
  single_mat <- matrix(42)

  slim_script(
    slim_block(1, {
      x <- r_inline(single_mat)
      catn(x)
    })
  ) -> script_single

  expect_s3_class(script_single, "slimr_script")
  script_text <- as.character(script_single)
  expect_true(any(stringr::str_detect(script_text, "42")))
})
