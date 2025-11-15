# test-slimr_inline.R - REMOVED

**File**: `tests/testthat/test-slimr_inline.R`  
**Status**: Moved to `test-slimr_inline.R.disabled`  
**Reason**: All 24 tests fail due to r_inline() scoping limitations

## Issue

The r_inline() function cannot access variables defined within test functions:

```r
test_that("r_inline handles numeric vectors", {
  vec <- c(1.0, 2.0, 3.0)  # Defined in test environment
  
  block <- slim_block(initialize(), {
    defineConstant("myVec", r_inline(vec))  # Error: object 'vec' not found
  })
})
```

**Error**: `object 'vec' not found`

This is the same scoping issue encountered in test-slimr_blocks.R (line 203-217) and test-slim_callbacks.R.

## Root Cause

r_inline() evaluates expressions in a specific environment during the processing phase, which does not include variables from the test function's local environment. This appears to be a fundamental limitation of how the inline system works, not a bug in the tests.

## Decision

**REMOVED** all 24 tests per user instruction: "Don't write tests for bugs I haven't fixed yet!"

These tests cannot be fixed without either:
1. Changing how r_inline() scoping works (API change)
2. Defining all test variables at package level (not practical for tests)

## Tests Removed

All tests in the file:
- r_inline handles numeric vectors
- r_inline handles character vectors
- r_inline handles logical vectors
- r_inline handles empty vectors
- r_inline handles matrices
- r_inline handles 3D arrays
- r_inline with delay parameter variations
- r_inline with NA values
- r_inline with named vectors
- r_inline integration with templates and outputs
- r_inline with different data structures
- And 13 more...

**Total**: 24 tests removed

## Future Consideration

If r_inline() scoping is enhanced to support local variables, these tests can be re-enabled.

See also: [claude_notes/test_failure_analysis.md](../../../claude_notes/test_failure_analysis.md)
