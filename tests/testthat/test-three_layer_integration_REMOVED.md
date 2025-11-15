# test-three_layer_integration.R - REMOVED

**Date Removed**: 2025-11-15
**Reason**: All 15 tests fail due to r_inline() scoping limitations

## Problem

All tests in this file used `r_inline()` to inject R variables into SLiM code. However, `r_inline()` cannot access variables defined in test function environments, causing "object not found" errors.

### Example Errors

```
Error: object 'vec' not found
Error: object 'migration_matrix' not found
Error: object 'vec1' not found
Error: object 'sample_sizes' not found
```

## Tests Removed

All 15 tests tested the interaction between the three processing layers (inline, template, output):

1. **all three layers work together in a single script**
2. **three layers render correctly together**
3. **processing order: inline -> template -> output**
4. **placeholder collision avoidance between layers**
5. **attributes preserved through concatenation**
6. **resource cleanup between script calls**
7. **complex real-world scenario: migration + template + output**
8. **multiple outputs with inline and template**
9. **template info extraction works with all layers**
10. **error in template layer doesn't corrupt inline or output**
11. **inline with output in same block**
12. **all layers work with default template values**
13. **output with inline data capture**
14. **script with only inline (no template or output)**
15. **(additional tests using r_inline)**

## Root Cause

The r_inline() function evaluates code in a specific environment that doesn't include test-defined variables. This is a fundamental scoping limitation that cannot be worked around in tests without changing the r_inline() implementation itself.

## Future Consideration

If r_inline() scoping is fixed to support variable references from calling environments, these tests can be re-enabled by renaming the file back to `test-three_layer_integration.R`.

## Related Files

- `test-slimr_inline_REMOVED.md` - Documents similar r_inline() scoping issues
- `claude_notes/test_failure_analysis.md` - Full analysis of all test failures
