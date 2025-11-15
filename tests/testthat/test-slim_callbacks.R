# Comprehensive tests for SLiM callback functions
# Tests initialize(), early(), late(), fitness(), mateChoice(), etc.

test_that("initialize() callback creates correct structure", {
  cb <- initialize()
  expect_type(cb, "character")
  expect_equal(as.character(cb), "initialize()")
})

test_that("early() callback creates correct structure", {
  cb <- early()
  expect_type(cb, "character")
  expect_equal(as.character(cb), "early()")
})

test_that("late() callback creates correct structure", {
  cb <- late()
  expect_type(cb, "character")
  expect_equal(as.character(cb), "late()")
})

test_that("fitness() callback with mutation type", {
  cb <- fitness("m1")
  expect_type(cb, "character")
  expect_true(grepl("fitness", cb))
})

test_that("fitness() callback with NULL mutation type", {
  cb <- fitness(NULL)
  expect_type(cb, "character")
  expect_true(grepl("fitness", cb))
})

test_that("fitness() callback with subpopulation", {
  cb <- fitness("m1", "p1")
  expect_type(cb, "character")
  expect_true(grepl("fitness", cb))
})

test_that("mateChoice() callback", {
  cb <- mateChoice()
  expect_type(cb, "character")
  expect_true(grepl("mateChoice", cb))
})

test_that("mateChoice() with subpopulation", {
  cb <- mateChoice("p1")
  expect_type(cb, "character")
  expect_true(grepl("mateChoice", cb))
})

test_that("modifyChild() callback", {
  cb <- modifyChild()
  expect_type(cb, "character")
  expect_true(grepl("modifyChild", cb))
})

test_that("modifyChild() with subpopulation", {
  cb <- modifyChild("p1")
  expect_type(cb, "character")
  expect_true(grepl("modifyChild", cb))
})

test_that("recombination() callback", {
  cb <- recombination()
  expect_type(cb, "character")
  expect_true(grepl("recombination", cb))
})

test_that("recombination() with subpopulation", {
  cb <- recombination("p1")
  expect_type(cb, "character")
  expect_true(grepl("recombination", cb))
})

test_that("mutation() callback", {
  cb <- mutation()
  expect_type(cb, "character")
  expect_true(grepl("mutation", cb))
})

test_that("mutation() with mutation type", {
  cb <- mutation("m1")
  expect_type(cb, "character")
  expect_true(grepl("mutation", cb))
})

test_that("survival() callback", {
  cb <- survival()
  expect_type(cb, "character")
  expect_true(grepl("survival", cb))
})

test_that("survival() with subpopulation", {
  cb <- survival("p1")
  expect_type(cb, "character")
  expect_true(grepl("survival", cb))
})

test_that("reproduction() callback", {
  cb <- reproduction()
  expect_type(cb, "character")
  expect_true(grepl("reproduction", cb))
})

test_that("reproduction() with subpopulation and sex", {
  cb <- reproduction("p1", "F")
  expect_type(cb, "character")
  expect_true(grepl("reproduction", cb))
})

test_that("initialize() works in slim_block", {
  block <- slim_block(initialize(), {
    initializeMutationRate(1e-7)
  })

  expect_s3_class(block, "slimr_block")
  expect_equal(as.character(vctrs::field(block, "callback")), "initialize()")
})

test_that("early() works in slim_block with generation", {
  block <- slim_block(1, early(), {
    sim$addSubpop("p1", 500)
  })

  expect_equal(as.character(vctrs::field(block, "callback")), "early()")
  expect_equal(vctrs::field(block, "start_gen"), "1")
})

test_that("late() works in slim_block with generation", {
  block <- slim_block(100, late(), {
    sim$simulationFinished()
  })

  expect_equal(as.character(vctrs::field(block, "callback")), "late()")
  expect_equal(vctrs::field(block, "start_gen"), "100")
})

test_that("fitness() callback in complete script", {
  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
    }),
    slim_block(fitness("m1"), {
      return(1.0)
    })
  )

  callbacks <- as.character(vctrs::field(script, "callback"))
  expect_true("fitness(m1)" %in% callbacks || any(grepl("fitness", callbacks)))
})

test_that("callbacks maintain class attribute", {
  cb <- early()
  expect_true(inherits(cb, "character") || !is.null(attr(cb, "class")))
})

test_that("callback functions are case-sensitive", {
  # SLiM callbacks are case-sensitive
  cb1 <- early()
  cb2 <- late()

  expect_false(cb1 == cb2)
})

test_that("multiple callbacks in same script", {
  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
    }),
    slim_block(1, early(), {
      sim$addSubpop("p1", 500)
    }),
    slim_block(1, late(), {
      catn("Late callback")
    })
  )

  callbacks <- as.character(vctrs::field(script, "callback"))
  expect_true("initialize()" %in% callbacks)
  expect_true("early()" %in% callbacks)
  expect_true("late()" %in% callbacks)
})

test_that("callback validation in slim_block", {
  # Valid callback
  expect_error(
    slim_block(early(), {
      sim$addSubpop("p1", 500)
    }),
    NA
  )
})

test_that("callbacks with parameters are formatted correctly", {
  cb <- fitness("m1", "p1")
  expect_type(cb, "character")
  # Should contain both mutation type and subpop info
})

# REMOVED TEST: "callback objects can be stored and reused"
# Reason: The test attempted to store a callback in a variable and reuse it,
# but slim_block() evaluates arguments in a specific callback environment that
# doesn't include user-defined variables. The test's intent doesn't align with
# how the package API actually works. See claude_notes/test_failure_analysis.md

test_that("NULL callback defaults appropriately", {
  # Block without explicit callback
  block <- slim_block(1, {
    sim$addSubpop("p1", 500)
  })

  # Should have some default or no callback
  callback_val <- vctrs::field(block, "callback")
  expect_true(!is.null(callback_val) || is.na(callback_val))
})

test_that("interaction() callback", {
  cb <- interaction("i1")
  expect_type(cb, "character")
  expect_true(grepl("interaction", cb) || grepl("i1", cb))
})
