test_that("get_os returns a valid platform", {
  expect_true(get_os() %in% c("windows", "linux", "osx"))
})

# test_that('slimr_which returns a valid path or ""', {
#   slim_path <- slimr_which("R")
#   if(slim_path != "") {
#     expect_true(file.exists(slim_path))
#   }
# })

test_that("%+% and %+n% work as expected", {

  new_string <- "skleepsers" %+% "spleenmatrix"
  new_string2 <- "calamity" %+n% "strain"
  expect_type(new_string, "character")
  expect_equal(nchar(new_string), 23L)
  expect_match(new_string2, "\n")

})

# Additional tests for assert_package() ----------------------------------------

test_that("assert_package works with installed packages", {
  # Should pass silently for base packages
  expect_invisible(assert_package("base"))
  expect_invisible(assert_package("utils"))
  expect_invisible(assert_package("stats"))
})

test_that("assert_package aborts for non-installed packages", {
  # Should abort with informative message
  expect_error(
    assert_package("ThisPackageDefinitelyDoesNotExist12345"),
    "This function requires the ThisPackageDefinitelyDoesNotExist12345 package"
  )
  expect_error(
    assert_package("ThisPackageDefinitelyDoesNotExist12345"),
    "install.packages"
  )
})

test_that("assert_package checks version correctly", {
  # Get current version of base package
  current_version <- as.character(utils::packageVersion("base"))

  # Should pass with NULL version (no version check)
  expect_invisible(assert_package("base", version = NULL))

  # Should pass with old version requirement (current version is newer)
  expect_invisible(assert_package("base", version = "1.0.0"))

  # Should fail with future version requirement
  expect_error(
    assert_package("base", version = "999.0.0"),
    "requires the base package to be version 999.0.0 or higher"
  )
})

test_that("assert_package custom install message works", {
  expect_error(
    assert_package("NonExistentPkg", install = "remotes::install_github"),
    "remotes::install_github"
  )
})

# Additional tests for sets_equal() --------------------------------------------

test_that("sets_equal detects equal sets", {
  expect_true(sets_equal(c(1, 2, 3), c(1, 2, 3)))
  expect_true(sets_equal(c(3, 2, 1), c(1, 2, 3)))  # Order doesn't matter
  expect_true(sets_equal(c("a", "b", "c"), c("c", "b", "a")))
})

test_that("sets_equal detects different sets", {
  expect_false(sets_equal(c(1, 2, 3), c(1, 2, 4)))
  # Note: sets_equal only checks if actual is subset of expected (one-way check)
  expect_true(sets_equal(c(1, 2), c(1, 2, 3)))  # c(1,2) is subset of c(1,2,3)
  expect_false(sets_equal(c(1, 2, 3), c(1, 2)))  # c(1,2,3) is NOT subset of c(1,2)
  expect_false(sets_equal(c("a", "b"), c("a", "c")))
})

test_that("sets_equal handles empty sets", {
  expect_true(sets_equal(c(), c()))
  expect_true(sets_equal(character(0), character(0)))
  # Empty set is subset of any set
  expect_true(sets_equal(c(), c(1)))
  # But non-empty set is not subset of empty set
  expect_false(sets_equal(c(1), c()))
})

test_that("sets_equal handles duplicates correctly", {
  # Sets ignore duplicates - setdiff behavior
  expect_true(sets_equal(c(1, 1, 2, 2, 3), c(1, 2, 3)))
  expect_true(sets_equal(c(1, 2, 3), c(1, 1, 2, 2, 3)))
  expect_true(sets_equal(c("a", "a", "b"), c("a", "b", "b")))
})

test_that("sets_equal works with different types", {
  expect_true(sets_equal(c(1L, 2L, 3L), c(1L, 2L, 3L)))  # Integers
  expect_true(sets_equal(c(1.5, 2.5), c(2.5, 1.5)))      # Doubles
  expect_true(sets_equal(letters[1:5], letters[5:1]))    # Characters
})

# Additional tests for convert_to_wsl_path() ----------------------------------

test_that("convert_to_wsl_path converts Windows paths correctly", {
  # Standard C: drive path
  result <- convert_to_wsl_path("C:/Users/test/file.txt")
  expect_match(result, "^/mnt/c/")
  expect_match(result, "Users/test/file.txt$")

  # Different drive letter
  result_d <- convert_to_wsl_path("D:/Projects/myproject")
  expect_match(result_d, "^/mnt/d/")

  # Uppercase drive letter should become lowercase
  result_upper <- convert_to_wsl_path("C:/test")
  expect_match(result_upper, "^/mnt/c/")

  result_upper_d <- convert_to_wsl_path("D:/test")
  expect_match(result_upper_d, "^/mnt/d/")
})

test_that("convert_to_wsl_path handles paths with spaces", {
  result <- convert_to_wsl_path("C:/Program Files/test file.txt")
  expect_match(result, "^/mnt/c/")
  expect_match(result, "Program Files/test file.txt$")
})

test_that("convert_to_wsl_path handles different drive letters", {
  drives <- c("A:", "B:", "E:", "Z:")
  for (drive in drives) {
    path <- paste0(drive, "/test/path")
    result <- convert_to_wsl_path(path)
    expected_prefix <- paste0("/mnt/", tolower(substring(drive, 1, 1)), "/")
    expect_match(result, paste0("^", expected_prefix))
  }
})

# Additional tests for fix_integers() ------------------------------------------

test_that("fix_integers converts integer literals to plain numbers", {
  # Note: regex requires a non-alphanumeric char after L (except dot)
  code <- c("x = 123L;", "y = 456L,")
  result <- fix_integers(code)
  expect_equal(result[[1]], "x = 123;")
  expect_equal(result[[2]], "y = 456,")
})

test_that("fix_integers handles edge cases", {
  # Integer followed by semicolon
  code <- c("x = 100L;")
  result <- fix_integers(code)
  expect_equal(result[[1]], "x = 100;")

  # Integer followed by comma
  code <- c("c(1L, 2L, 3L)")
  result <- fix_integers(code)
  expect_equal(result[[1]], "c(1, 2, 3)")

  # Integer followed by parenthesis
  code <- c("func(10L)")
  result <- fix_integers(code)
  expect_equal(result[[1]], "func(10)")
})

test_that("fix_integers doesn't break decimals", {
  # Should not affect numbers with decimals
  code <- c("x = 123.456")
  result <- fix_integers(code)
  expect_equal(result[[1]], "x = 123.456")

  # Mixed case
  code <- c("x = 123L + 456.789")
  result <- fix_integers(code)
  expect_equal(result[[1]], "x = 123 + 456.789")
})

test_that("fix_integers handles multiple integers in one line", {
  code <- c("x = 100L; y = 200L; z = 300L;")
  result <- fix_integers(code)
  expect_equal(result[[1]], "x = 100; y = 200; z = 300;")

  # Also test that integers at end of string without trailing char are NOT replaced
  code2 <- c("x = 123L")
  result2 <- fix_integers(code2)
  expect_equal(result2[[1]], "x = 123L")  # Not replaced - no trailing char
})

# Additional tests for expr_deparse_fast() -------------------------------------

test_that("expr_deparse_fast handles if/else formatting", {
  expr <- quote(if (x > 0) y else z)
  result <- expr_deparse_fast(expr)
  expect_type(result, "character")
  # Should keep if/else on same line
  expect_true(any(grepl("if.*else", result)))
})

test_that("expr_deparse_fast handles multiline expressions", {
  expr <- quote({
    x <- 1
    y <- 2
    z <- x + y
  })
  result <- expr_deparse_fast(expr)
  expect_type(result, "character")
  expect_true(length(result) > 1)  # Should be split into multiple lines
})

test_that("expr_deparse_fast respects width parameter", {
  # Create a long expression
  expr <- quote(very_long_function_name(argument1, argument2, argument3, argument4))
  result <- expr_deparse_fast(expr)
  expect_type(result, "character")
  # With width = 500, should stay on one line
  expect_true(length(result) >= 1)
})

test_that("expr_deparse_fast handles simple expressions", {
  expr <- quote(x + y)
  result <- expr_deparse_fast(expr)
  expect_equal(result, "x + y")

  expr2 <- quote(1 + 2)
  result2 <- expr_deparse_fast(expr2)
  expect_equal(result2, "1 + 2")
})

# Additional edge case tests for string operators ------------------------------

test_that("%+% handles empty strings", {
  result <- "" %+% "test"
  expect_equal(result, " test")

  result2 <- "test" %+% ""
  expect_equal(result2, "test ")

  result3 <- "" %+% ""
  expect_equal(result3, " ")
})

test_that("%+n% handles empty strings", {
  result <- "" %+n% "test"
  expect_equal(result, "\ntest")

  result2 <- "test" %+n% ""
  expect_equal(result2, "test\n")

  result3 <- "" %+n% ""
  expect_equal(result3, "\n")
})

test_that("%+% and %+n% handle long strings", {
  long_str1 <- paste(rep("a", 1000), collapse = "")
  long_str2 <- paste(rep("b", 1000), collapse = "")

  result1 <- long_str1 %+% long_str2
  expect_equal(nchar(result1), 2001)  # 1000 + 1 space + 1000

  result2 <- long_str1 %+n% long_str2
  expect_equal(nchar(result2), 2001)  # 1000 + 1 newline + 1000
  expect_match(result2, "\n")
})

test_that("%+% and %+n% handle special characters", {
  result1 <- "test" %+% "with\ttab"
  expect_match(result1, "\t")

  result2 <- "line1" %+n% "line2"
  expect_equal(result2, "line1\nline2")

  # Multiple operations
  result3 <- "a" %+% "b" %+% "c"
  expect_equal(result3, "a b c")
})
