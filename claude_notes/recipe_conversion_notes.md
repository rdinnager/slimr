# Recipe Conversion Notes

This file contains running notes from agents working on recipe conversion.
**APPEND ONLY** - Never overwrite existing content.

---

## Session 2025-10-23 (Initial Setup)

Setup completed:
- Created `inst/extdata/slim_recipes/` directory for converted recipes
- Reset `data-raw/slim_recipes/recipe_metadata.csv` to header only (starting fresh)
- Created this notes file
- Updated RECIPE_CONVERSION_PLAN.md with multi-agent workflow

Ready to begin recipe conversion following the updated plan.

---

## Session 2025-10-23 (First Recipe Conversion - Recipe 4.1)

### Recipe 4.1: A basic neutral simulation

**Status**: Completed successfully

**Conversion process**:
1. Read and understood the recipe - it's the foundational example showing minimum SLiM simulation components
2. Converted to slimr syntax:
   - `initialize()` → `slim_block(initialize(), { ... })`
   - Property access: `sim.addSubpop()` → `sim$addSubpop()`
   - Comments: `//` → `#`
3. Stored original SLiM code as attribute using `system.file()`
4. Created unit test in `tests/testthat/test-recipe_4_1.R`
5. Ran test successfully - PASS

**Patterns documented**:
- Standard three-block structure: initialize() + early() for population creation + early() for simulation end
- Basic property access conversion using `$` operator
- No output produced by this basic recipe, so test only verifies exit_status == 0

**Directory structure note**:
- User moved original recipes from `data-raw/slim_recipes/original/` to `inst/extdata/slim_recipes/original/`
- Created `inst/extdata/slim_recipes/converted/` for converted recipes
- This allows original SLiM text to be included in package and accessed via `system.file()`
- Updated RECIPE_CONVERSION_PLAN.md to reflect correct directory structure

**Notes for future conversions**:
- Always test using `Sys.setenv(TEST_RECIPES="true")` and `testthat::test_file()`
- Basic recipes may not produce output - adjust test expectations accordingly
- File naming: `Recipe X.Y - Title.txt` → `recipe_X_Y.R` → `test-recipe_X_Y.R`

---

## Session 2025-10-23 (Bulk Recipe Conversion - Recipes 4.2.1 through 5.1.2_I)

### Summary

Converted 8 additional recipes (total: 9 including previously completed 4.1):
- 4.2.1 - Basic output - Entire population
- 4.2.2 - Basic output - Sampling
- 4.2.3 - Migration and weighted sampling
- 4.2.4 - Output fixed mutations
- 4.2.5 - Log files with FST
- 4.2.6 - MS-format output
- 5.1.1 - Population size changes - Bottleneck
- 5.1.2_I - Exponential growth

All tests pass successfully.

### Key Patterns Discovered

#### 1. Output Handling
**Issue**: The `result$output` field is only populated when `capture_output = TRUE` is passed to `slim_run()`.
**Solution**: Read from `result$output_file` instead - keeps tests cleaner without non-default arguments.
**Example**: Recipe 4.2.1, 4.2.2
```r
# Preferred approach: read from output_file
expect_true(file.exists(result$output_file))
output_content <- readLines(result$output_file)

# Alternative (not recommended):
# result <- slim_run(script, capture_output = TRUE)
# Then check result$output
```

#### 2. Empty Blocks
**Issue**: Empty blocks with only comments cause parsing errors.
**Solution**: Use `NULL` statement instead of just comment.
**Example**: Recipe 4.2.5
```r
slim_block(20000, late(), {
  NULL  # Simulation finishes - need NULL not just comment
})
```

#### 3. Generation Ranges
**Issue**: SLiM `1000:1099` syntax doesn't work directly in slimr.
**Solution**: Use separate start and end parameters.
**Example**: Recipe 5.1.2_I
```r
# SLiM: 1000:1099 early() { ... }
# slimr:
slim_block(1000, 1099, early(), { ... })
```

#### 4. Property Access Chains
**Pattern**: Dot notation can stay as-is OR be converted to dollar signs (stylistic choice).
**Note**: Dots work fine because they form valid R names and pass through to SLiM unchanged. Converting to `$` is optional but makes code look more R-like.
```r
# SLiM original:
sim.subpopulations.individuals

# Both work in slimr:
sim.subpopulations.individuals  # Valid - dots pass through to SLiM
sim$subpopulations$individuals  # Also valid - more R-like style

# We use $ for consistency and R idioms, but . is not wrong
```

#### 5. SLiM 5.x Terminology
**Important**: SLiM 5.x uses `haplosomes` instead of `genomes`.
```r
# SLiM 4.x: p1.individuals.genomes
# SLiM 5.x: p1.individuals.haplosomes
# slimr:    p1$individuals$haplosomes
```
Recipes 4.2.3 and 4.2.6 demonstrate this.

#### 6. LogFile Creation
**Pattern**: Log files for time-series data.
**Example**: Recipe 4.2.5
```r
log <- community$createLogFile("sim_log.txt", logInterval = 10)
log$addCycle()  # Adds generation/cycle column
log$addCustomColumn("FST", "calcFST(p1.haplosomes, p2.haplosomes);")
```
**Note**: Custom column expressions are strings containing SLiM code.

#### 7. Complex String Manipulation
**Pattern**: MS-format output with loops and formatting.
**Example**: Recipe 4.2.6
```r
# For loops work in SLiM blocks
for (haplosome in h) {
  hasMuts <- (match(m, haplosome$mutations) >= 0)
  cat(paste(asInteger(hasMuts), sep = "") + "\n")
}
```
**Note**: String concatenation with `+` stays as is in SLiM expressions.

### Recipes by Complexity

**Simple** (straightforward conversion):
- 4.2.1, 4.2.2, 4.2.4, 5.1.1
- Pattern: Basic output, population size changes
- Time: ~5-10 min each

**Moderate** (some challenges):
- 4.2.5, 5.1.2_I
- Pattern: Log files, generation ranges
- Time: ~15 min each
- Issues: Empty block syntax, generation range syntax

**Advanced** (complex features):
- 4.2.3, 4.2.6
- Pattern: Multiple mutation types, weighted sampling, custom output, loops
- Time: ~20 min each
- Features: haplosomes, match(), string formatting, for loops

### Testing Strategy

All tests follow this pattern:
```r
test_that("Recipe X.Y: Title works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_X_Y.R", package = "slimr"))
  result <- slim_run(recipe_X_Y_script)

  expect_equal(result$exit_status, 0)
  # Recipe-specific assertions
})
```

### Common Gotchas

1. **Case sensitivity in log headers**: LogFile outputs "cycle" not "Cycle"
2. **Output location**: Check `output_file` not `output` field
3. **Empty blocks**: Must contain at least `NULL` statement
4. **Generation ranges**: Separate parameters `slim_block(start, end, ...)` not `start:end`
5. **haplosomes vs genomes**: Use SLiM 5.x terminology

### Files Created This Session

**Converted recipes** (8 files):
- inst/extdata/slim_recipes/converted/recipe_4_2_1.R
- inst/extdata/slim_recipes/converted/recipe_4_2_2.R
- inst/extdata/slim_recipes/converted/recipe_4_2_3.R
- inst/extdata/slim_recipes/converted/recipe_4_2_4.R
- inst/extdata/slim_recipes/converted/recipe_4_2_5.R
- inst/extdata/slim_recipes/converted/recipe_4_2_6.R
- inst/extdata/slim_recipes/converted/recipe_5_1_1.R
- inst/extdata/slim_recipes/converted/recipe_5_1_2_I.R

**Test files** (8 files):
- tests/testthat/test-recipe_4_2_1.R through test-recipe_5_1_2_I.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (8 new rows)

### Next Steps for Future Agents

1. Continue with remaining Recipe 5.1.2 variants (II, III, IV, V)
2. Move to Recipe 5.2.x series (population structure)
3. Recipe 5.3.x series (migration patterns)
4. Recipe 6.x series (genomic structure)

**Estimated remaining**: ~90+ recipes
**Pattern library established**: Yes - common patterns now documented
**Conversion getting faster**: Yes - later recipes should be quicker with established patterns

---

## Session 2025-10-23 (Recipe 5.1.2 variants - II through V)

### Summary

Converted 4 additional Recipe 5.1.2 variants demonstrating different approaches to exponential growth:
- 5.1.2_II - Basic exponential growth at 3% per generation
- 5.1.2_III - Exponential growth with population cap using conditional check
- 5.1.2_IV - Exponential growth with cap using calculate-then-constrain approach
- 5.1.2_V - Exponential growth with self-deregistering block for efficiency

All tests pass successfully.

### CRITICAL PATTERN DISCOVERED: Open-Ended Generation Ranges

**Issue**: SLiM uses `1000:` syntax for open-ended generation ranges (run from gen 1000 until end of simulation).

**Solution**: Use the special `..` symbol in slimr as the end_gen parameter.

**Documentation reference**: From `slim_block()` documentation:
> "The special value of `..` can be used for end_gen instead, which is shorthand for the last generation (in other words, run the event every generation between start_gen and the last generation used elsewhere in the script)."

**Examples**:
```r
# SLiM original: 1000: early() { ... }
# slimr conversion:
slim_block(1000, .., early(), {
  # code runs from gen 1000 until the last generation defined elsewhere
})

# This automatically determines the end from other blocks
# For example, if you have slim_block(10000, late(), ...) elsewhere,
# then 1000, .. will run from 1000 to 10000
```

**Why this matters**:
- Preserves the intent of the original SLiM code
- Avoids hardcoding generation numbers
- More maintainable - changing the final generation automatically adjusts all open-ended ranges

**IMPORTANT**: Always use `..` (not a hardcoded number) when converting open-ended SLiM ranges like `1000:`

### New Pattern: Script Block Self-Deregistration

**Pattern**: Removing a script block from execution once it's no longer needed.

**SLiM syntax**: `community.deregisterScriptBlock(self)`

**slimr syntax**: `community$deregisterScriptBlock(self)`

**Use case**: Efficient implementation of conditional behavior that should stop once a condition is met.

**Example from Recipe 5.1.2_V**:
```r
slim_block(1000, .., early(), {
  newSize <- asInteger(round(1.03^(sim$cycle - 999) * 100))
  if (newSize >= 2000)
  {
    newSize <- 2000
    community$deregisterScriptBlock(self)  # Stop running this block
  }
  p1$setSubpopulationSize(newSize)
})
```

**Benefits**:
- More efficient than checking condition every generation
- Block stops executing once deregistered
- Cleaner than complex conditional logic

### Comparison of Population Cap Approaches

Recipes 5.1.2_III, IV, and V demonstrate three different approaches to capping population growth:

**Approach 1 (Recipe III)**: Check before calculation
```r
if (p1$individualCount < 2000) {
  newSize <- asInteger(round(1.03^(sim$cycle - 999) * 100))
  p1$setSubpopulationSize(newSize)
}
```
- Pro: Skips calculation once cap reached
- Con: Still runs block every generation

**Approach 2 (Recipe IV)**: Calculate then constrain
```r
newSize <- round(1.03^(sim$cycle - 999) * 100)
if (newSize > 2000)
  newSize <- 2000
p1$setSubpopulationSize(asInteger(newSize))
```
- Pro: Simple, clear logic
- Con: Continues calculating even after cap reached

**Approach 3 (Recipe V)**: Self-deregister when done
```r
newSize <- asInteger(round(1.03^(sim$cycle - 999) * 100))
if (newSize >= 2000) {
  newSize <- 2000
  community$deregisterScriptBlock(self)
}
p1$setSubpopulationSize(newSize)
```
- Pro: Most efficient - block stops running once cap reached
- Con: Slightly more complex

### Files Created This Session

**Converted recipes** (4 files):
- inst/extdata/slim_recipes/converted/recipe_5_1_2_II.R
- inst/extdata/slim_recipes/converted/recipe_5_1_2_III.R
- inst/extdata/slim_recipes/converted/recipe_5_1_2_IV.R
- inst/extdata/slim_recipes/converted/recipe_5_1_2_V.R

**Test files** (4 files):
- tests/testthat/test-recipe_5_1_2_II.R
- tests/testthat/test-recipe_5_1_2_III.R
- tests/testthat/test-recipe_5_1_2_IV.R
- tests/testthat/test-recipe_5_1_2_V.R

**Total recipes completed**: 13 (9 from previous session + 4 this session)

### Lessons Learned

1. **Always preserve open-ended syntax**: Use `..` not hardcoded generation numbers
2. **Read slim_block documentation**: It has critical information about syntax features
3. **Multiple valid approaches**: SLiM recipes often show different ways to achieve the same goal
4. **Block deregistration**: Powerful technique for conditional block execution

### Next Steps for Future Agents

Continue with Recipe 5.1.4 and onwards (skipping 5.1.3 which doesn't exist based on available files).

**Remaining estimated**: ~85+ recipes

---


## Additional Patterns and Tips for Future Agents

### Pattern: Blocks That Run Every Generation

**Issue**: SLiM allows blocks with no generation number to run every generation.

**SLiM syntax**: 
```slim
early() {
  // runs every generation
}
```

**slimr syntax**:
```r
slim_block(early(), {
  # runs every generation
})
```

**Example**: Recipe 5.1.4 (oscillating population) and 5.1.5 (fitness-dependent size)

**Note**: Omitting generation numbers means the block executes in ALL generations, which can be useful for continuous processes.

---

### Pattern: defineConstant()

**Purpose**: Define constants in the initialize block that are accessible throughout the simulation.

**SLiM syntax**: `defineConstant("NAME", value);`

**slimr syntax**: `defineConstant("NAME", value)`

**Example from Recipe 5.3.1**:
```r
slim_block(initialize(), {
  defineConstant("COUNT", 10)
  # ... rest of initialization
})

# Later use in other blocks:
slim_block(1, early(), {
  for (i in 0:(COUNT - 1))
    sim$addSubpop(i, 500)
})
```

**Use cases**: 
- Simulation parameters used in multiple blocks
- Makes code more maintainable
- Easier to modify parameters in one place

---

### Pattern: Programmatic Population Creation

**Pattern**: Using loops to create multiple populations with similar properties.

**Example from Recipe 5.3.1**:
```r
slim_block(1, early(), {
  for (i in 0:(COUNT - 1))
    sim$addSubpop(i, 500)
  
  # Then configure them
  subpops <- sim$subpopulations
  for (i in 1:(COUNT - 1)) subpops[i]$setMigrationRates(i - 1, 0.2)
})
```

**Benefits**:
- Reduces repetitive code
- Easy to scale (change COUNT constant)
- Clean and maintainable

---

### Quick Conversion Reference by Recipe Type

**Simple recipes** (~5-10 min):
- Basic population dynamics (4.2.1, 4.2.2, 5.1.1)
- Simple output (4.2.4)
- Basic migration (5.2.1)

**Moderate recipes** (~15-20 min):
- Generation ranges (5.1.2 variants)
- Log files (4.2.5)
- Oscillating dynamics (5.1.4)

**Advanced recipes** (~20-30 min):
- Custom output formats (4.2.6)
- Complex migration patterns (5.3.1)
- Fitness-dependent dynamics (5.1.5)

---

### Tips for Efficient Conversion

1. **Always read the recipe first** - Understand what it demonstrates before converting
2. **Look for similar recipes** - Check if a pattern exists in already-converted recipes
3. **Test frequently** - Run tests as soon as conversion is complete
4. **Use descriptive commit messages** - If committing, explain what recipe does
5. **Don't batch test runs** - Test each recipe individually to catch errors early
6. **Reference the plan** - Check RECIPE_CONVERSION_PLAN.md for quick patterns
7. **Copy-paste is OK** - Test file structure is very consistent

---

### Progress Tracking Helper

To quickly see progress:

```r
# Run this in R to see current status
orig <- list.files('inst/extdata/slim_recipes/original', pattern = '^Recipe.*\.txt$')
conv <- list.files('inst/extdata/slim_recipes/converted', pattern = '^recipe_.*\.R$')
tests <- list.files('tests/testthat', pattern = '^test-recipe_.*\.R$')

cat('Original recipes:', length(orig), '\n')
cat('Converted recipes:', length(conv), '\n')
cat('Tested recipes:', length(tests), '\n')
cat('Completion rate:', round(length(conv) / length(orig) * 100, 1), '%\n')
```

**Current status as of 2025-10-23**:
- Original recipes: ~95+ files
- Converted recipes: 17
- Completion rate: ~18%
- Estimated remaining: ~78 recipes

---

### Common Mistakes to Avoid

1. **Using hardcoded generations instead of `..`** for open-ended ranges
2. **Forgetting to test** - Always run the test after creating it
3. **Empty blocks without NULL** - Must have at least `NULL` statement
4. **Using wrong property names** - Remember SLiM 5.x uses `haplosomes` not `genomes`
5. **Not reading output correctly** - Use `result$output_file` not `result$output`
6. **Forgetting to store original** - Always add the `attr(script, "original_slim")` line
7. **Overwriting notes** - Always APPEND to recipe_conversion_notes.md

---

### Templates for Quick Copy-Paste

**Standard test file template**:
```r
test_that("Recipe X.Y: [Title] works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_X_Y.R", package = "slimr"))
  result <- slim_run(recipe_X_Y_script)
  
  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))
  
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("Mutations", output_content)))
})
```

**Standard recipe header template**:
```r
# Recipe X.Y: [Title]
#
# Description:
# [What this recipe demonstrates - write this AFTER understanding the code]
#
# SLiM Version: 5.x
# Features: [comma-separated tags]
#
# Conversion notes:
# - [Any special patterns or challenges]

library(slimr)

recipe_X_Y_script <- slim_script(
  # ... blocks here
)

attr(recipe_X_Y_script, "original_slim") <- readLines(
  system.file("extdata/slim_recipes/original/Recipe_X.Y_Title.txt", package = "slimr")
)
```

---

### Examples of Well-Documented Recipes

Use these as templates when uncertain:

- **Simple example**: Recipe 4.1 (basic neutral simulation)
- **With generation ranges**: Recipe 5.1.2_I (exponential growth)
- **With open-ended range**: Recipe 5.1.2_IV (uses `..`)
- **With loops**: Recipe 5.3.1 (stepping-stone model)
- **With complex logic**: Recipe 5.1.2_V (block deregistration)
- **With custom output**: Recipe 4.2.6 (MS format)

---

### When to Give Up on a Recipe

It's OK to mark a recipe as "needs_attention" and move on if:

1. **After 30 minutes** of effort without success
2. **Error messages are unclear** and you've tried basic debugging
3. **Recipe uses advanced features** you're not familiar with
4. **Dependencies are missing** (external files, etc.)

When giving up:
1. Document what you tried in recipe_conversion_notes.md
2. Mark status as "needs_attention" in metadata CSV
3. Add notes explaining the issue
4. Move on to next recipe - don't get stuck!

The maintainer can review difficult recipes later.

---

### Recommended Next Recipes (in order)

Based on current progress, continue with:

1. ✅ Recipe 5.1.2_II through V (completed)
2. ✅ Recipe 5.1.4, 5.1.5 (completed)
3. ✅ Recipe 5.2.1 (completed)
4. ✅ Recipe 5.3.1 (completed)
5. **Next**: Recipe 5.3.2, 5.3.3, 5.3.4, 5.3.5 (migration patterns)
6. Then: Recipe 5.4_I, 5.4_II, 5.5_I, 5.5_II
7. Then: Recipe 6.x series (genomic structure)
8. Then: Recipe 10+ series (selection, mating, etc.)

---

## End of Session 2025-10-23 (Second batch)

**Session completed**: 8 additional recipes converted and tested
**Total recipes completed**: 17
**All tests passing**: Yes
**Key documentation added**: Open-ended generation range pattern (`..`)
**Files updated**: Recipes, tests, metadata CSV, plan, notes

Ready for next agent to continue from Recipe 5.3.2 onwards.

---

## Session 2025-10-23 (Recipe 5.3.2 - Non-spatial metapopulation)

### Summary

Converted Recipe 5.3.2: A non-spatial metapopulation

**Status**: Completed successfully
**Test result**: PASS (all 3 expectations pass)

### Recipe 5.3.2: A non-spatial metapopulation

**Purpose**: Demonstrates a complete migration graph where all subpopulations exchange migrants with all other subpopulations at equal rates, creating a well-mixed metapopulation structure.

**Key features**:
1. Creates 5 subpopulations of equal size (500 individuals each)
2. Uses nested loops to establish migration between ALL pairs of populations
3. Each population migrates to every other population at rate 0.05
4. Conditional check (i != j) prevents self-migration
5. Creates a "non-spatial" metapopulation - migration doesn't depend on distance

**Conversion patterns**:
- Standard property access conversion: `sim.addSubpop()` → `sim$addSubpop()`
- Nested loops stay as is in SLiM block
- Array indexing `[i-1]` stays as is in SLiM expression
- Variable assignment in SLiM block: `subpopCount <- 5`

**Code structure**:
```r
slim_block(1, early(), {
  subpopCount <- 5
  for (i in 1:subpopCount)
    sim$addSubpop(i, 500)
  for (i in 1:subpopCount)
    for (j in 1:subpopCount)
      if (i != j)
        sim$subpopulations[i-1]$setMigrationRates(j, 0.05)
})
```

**Migration pattern explanation**:
- Outer loop: iterate through source populations (i)
- Inner loop: iterate through destination populations (j)
- Conditional: only set migration if i ≠ j (no self-migration)
- Result: Complete graph with 5×4=20 directed migration edges (5 pops × 4 destinations each)

**Comparison with Recipe 5.3.1**:
- **5.3.1** (stepping-stone): Linear arrangement, each pop migrates only to neighbors
- **5.3.2** (non-spatial): Complete graph, each pop migrates to all others
- Both use loops for programmatic setup, but different connectivity patterns

### Pattern: Complete Migration Graph

**Purpose**: Model a metapopulation where all subpopulations are equally connected

**Implementation**:
```r
# Create nested loops for all pairs
for (i in 1:n)
  for (j in 1:n)
    if (i != j)
      sim$subpopulations[i-1]$setMigrationRates(j, rate)
```

**Use cases**:
- Well-mixed metapopulations
- Island models in population genetics
- Scenarios where spatial structure doesn't matter
- Baseline for comparing with structured models

**Notes**:
- Creates n×(n-1) migration edges for n populations
- All edges have equal weight (same migration rate)
- Symmetrical migration (bidirectional with equal rates)

### Testing notes

Test checks:
1. Exit status is 0 (simulation completes successfully)
2. Output file exists
3. Output contains "Mutations" (standard fixed mutations output)

Runs quickly (~2 seconds) with default parameters.

### Files created this session

**Converted recipe**:
- inst/extdata/slim_recipes/converted/recipe_5_3_2.R

**Test file**:
- tests/testthat/test-recipe_5_3_2.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (added row for 5.3.2)
- claude_notes/recipe_conversion_notes.md (this entry)

### Total progress

**Recipes completed**: 18 (previously 17 + Recipe 5.3.2)
**Completion rate**: ~19%

### Next steps

Continue with:
1. Recipe 5.3.3 - Two-dimensional subpopulation matrix
2. Recipe 5.3.4 - Random sparse spatial metapopulation
3. Recipe 5.3.5 - Reading migration matrix from file

---

## Session 2025-10-23 (Recipe 5.3.3 - 2D Grid Migration)

### Summary

Converted Recipe 5.3.3: A two-dimensional subpopulation matrix

**Status**: Completed successfully
**Test result**: PASS (all 3 expectations pass)

### Recipe 5.3.3: A two-dimensional subpopulation matrix

**Purpose**: Demonstrates a 2D spatial stepping-stone model where subpopulations are arranged in a grid, and migration occurs only between adjacent neighbors in the four cardinal directions.

**Key features**:
1. Creates a 3×3 grid of subpopulations (9 total)
2. Uses nested loops over x,y coordinates
3. Maps 2D coordinates to linear subpopulation IDs: `destID = (x-1) + (y-1) * metapopSide + 1`
4. Sets migration to 4 cardinal neighbors (up, down, left, right) only
5. Uses conditionals to prevent off-grid migration at boundaries
6. Migration rate: 0.05 to each neighbor

### Pattern: 2D Grid Coordinate Mapping

**Purpose**: Convert 2D spatial coordinates to linear subpopulation IDs

**Mapping formula**:
```r
# Convert (x, y) coordinates to linear ID (1-indexed)
destID <- (x - 1) + (y - 1) * gridSize + 1
```

**Neighbor calculation**:
```r
# For population at (x,y) with ID = destID:
left_ID   = destID - 1           # if x > 1
right_ID  = destID + 1           # if x < gridSize
top_ID    = destID - gridSize    # if y > 1
bottom_ID = destID + gridSize    # if y < gridSize
```

### Total progress

**Recipes completed**: 19 (previously 18 + Recipe 5.3.3)
**Completion rate**: ~20%

### Next steps

Continue with Recipe 5.3.4 - Random sparse spatial metapopulation

---

## Session 2025-10-23 (Recipe 5.3.4 - Sparse Metapopulation with Selection)

### Summary

Converted Recipe 5.3.4: A random, sparse spatial metapopulation

**Status**: Completed successfully
**Test result**: PASS (all 3 expectations pass)
**Runtime**: ~40 seconds (larger simulation: 100 populations × 10000 generations)

### Recipe 5.3.4: A random, sparse spatial metapopulation

**Purpose**: Demonstrates a complex, realistic spatial metapopulation with multiple advanced features: random migration rates, habitat fragmentation, and selection.

**Key features**:
1. Large 10×10 grid (100 populations initially)
2. **Random migration rates**: Each neighbor connection drawn from U(0, 0.05) independently
3. **Habitat fragmentation**: Removes 25% of populations to create sparse landscape
4. **Selection**: Introduces beneficial mutation (m2, s=0.3) into 10 random haplosomes
5. SLiMgui visualization configuration (optional in slimr)

**Differences from Recipe 5.3.3**:
- Much larger grid (10×10 vs 3×3)
- Heterogeneous migration (random rates vs fixed 0.05)
- Sparse landscape (75 pops remain vs all 9)
- Selection present (beneficial mutation vs neutral only)
- More realistic/complex scenario

**Conversion patterns**:
- `runif(1, 0.0, 0.05)` generates random migration rate for each edge
- `setSubpopulationSize(0)` removes populations (habitat loss)
- `sample(sim$subpopulations, 1)` selects random population
- `sample(target_subpop$haplosomes, 10)` selects random haplosomes
- `addNewDrawnMutation(m2, 20000)` adds beneficial mutation at position 20000

### Pattern: Random Migration Rates

**Purpose**: Create heterogeneous migration landscape

**Implementation**:
```r
# Each migration edge gets independent random rate
if (x > 1)
  ds$setMigrationRates(destID - 1, runif(1, 0.0, 0.05))
```

**Effect**:
- Some connections have high migration (up to 0.05)
- Some have very low migration (near 0)
- Creates realistic heterogeneity in connectivity
- Each edge is independent draw

### Pattern: Population Removal (Habitat Fragmentation)

**Purpose**: Create sparse metapopulation by removing populations

**Implementation**:
```r
# Remove 25% of populations
subpops[sample(0:99, 25)]$setSubpopulationSize(0)
```

**Effect**:
- 75 populations remain, 25 are removed
- Creates patches of habitat separated by "unsuitable" areas
- Migration paths may be broken
- More realistic than complete grid

**Use cases**:
- Habitat loss simulations
- Fragmentation effects on genetic diversity
- Conservation genetics

### Pattern: Beneficial Mutation Introduction

**Purpose**: Introduce selection into the system

**Implementation**:
```r
# Select random population
target_subpop <- sample(sim$subpopulations, 1)

# Add beneficial mutation to 10 random haplosomes
sample(target_subpop$haplosomes, 10)$addNewDrawnMutation(m2, 20000)
```

**Notes**:
- Mutation type m2 defined with s=0.3 (beneficial)
- Added at position 20000 (middle of genome)
- Starts in 10 haplosomes (low initial frequency)
- Can spread through selection and migration

**Use cases**:
- Studying beneficial mutation spread
- Selection in spatial context
- Gene flow vs selection balance

### Testing notes

**Test expectations**:
1. Simulation completes (exit_status = 0)
2. Output file created
3. Output contains mutations

**Runtime**: ~40 seconds due to:
- 100 populations (vs 9 in 5.3.3)
- 10000 generations
- Selection computations

**Randomness**: Each run will have:
- Different migration rates
- Different removed populations
- Different target population for beneficial mutation
- But all should complete successfully

### Files created this session

**Converted recipe**:
- inst/extdata/slim_recipes/converted/recipe_5_3_4.R

**Test file**:
- tests/testthat/test-recipe_5_3_4.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (added row for 5.3.4)
- claude_notes/recipe_conversion_notes.md (this entry)

### Total progress

**Recipes completed**: 20 (previously 19 + Recipe 5.3.4)
**Completion rate**: ~21%

### Next steps

Continue with Recipe 5.3.5 - Reading migration matrix from file

---

## Session 2025-10-23 (Recipe 5.3.5 - Reading Migration Matrix from File)

### Summary

Converted Recipe 5.3.5: Reading a migration matrix from a file

**Status**: Completed successfully
**Test result**: PASS (all 3 expectations pass)
**Runtime**: ~2 seconds

### Recipe 5.3.5: Reading a migration matrix from a file

**Purpose**: Demonstrates how to configure migration between subpopulations by reading migration rates from an external CSV file. This is useful for complex migration scenarios or when migration parameters need to be managed separately from the simulation script.

**Key features**:
1. Creates 3 subpopulations of 1000 individuals each
2. Reads migration rates from CSV file with format: source_id,dest_id,migration_rate
3. Filters out comment lines (starting with "//")
4. Parses CSV data using string operations
5. Sets migration rates for all population pairs (excluding self-migration)

**Migration file format** (migration.csv):
```csv
// Comment lines start with "//"
1,1,0.78
1,2,0.10
1,3,0.12
2,1,0.01
2,2,0.96
2,3,0.03
3,1,0.33
3,2,0.17
3,3,0.50
```

**Interpretation**: Each row defines migration rate from source population to destination population. For example, row 2 means: "Population 2 receives migrants from population 1 at rate 0.10".

### NEW PATTERN: File I/O with r_inline()

**Issue**: SLiM's `readFile()` expects a file path, but we need to use R's `system.file()` to locate package resources.

**Solution**: Use `r_inline()` to evaluate the R expression and inject the resulting path as a string.

**Example**:
```r
# In slimr:
lines <- readFile(r_inline(system.file("extdata/recipe_resources/migration.csv", package = "slimr")))

# This evaluates system.file() in R and injects the path string into SLiM
# The SLiM code sees: lines = readFile("/full/path/to/migration.csv");
```

**Why this works**:
- `r_inline()` evaluates R expressions at render time
- Returns the result as a SLiM-compatible value
- File path is computed in R, used in SLiM

**Use cases**:
- Reading configuration files
- Loading spatial data
- Importing parameter files
- Any file-based input to simulations

### Pattern: String Parsing in SLiM

**Operations demonstrated**:
```r
# Filter lines
lines <- lines[substr(lines, 0, 1) != "//"]  # Remove comment lines

# Split by delimiter
fields <- strsplit(line, ",")  # Returns array of strings

# Type conversion
i <- asInteger(fields[0])  # Convert to integer
m <- asFloat(fields[2])    # Convert to float
```

**Note**: SLiM uses 0-based indexing for arrays, so `fields[0]` is the first element.

### Pattern: Population Lookup by ID

**Purpose**: Find a specific subpopulation by its ID

**Implementation**:
```r
subpops <- sim$subpopulations
p_i <- subpops[subpops.id == i]  # Get population with ID i
```

**How it works**:
- `subpops.id` returns array of all population IDs
- `subpops.id == i` creates boolean mask
- Subsetting returns matching population(s)

**Alternative approaches**:
```r
# If you know populations are numbered sequentially starting from 1:
p_i <- sim$subpopulations[i-1]  # Direct indexing (0-based)

# For sparse or non-sequential IDs:
p_i <- subpops[subpops.id == i]  # Safer approach
```

### Conversion patterns

**String operations**: All work as-is in SLiM blocks
- `substr(string, start, end)` - Extract substring
- `strsplit(string, delimiter)` - Split string
- `asInteger()`, `asFloat()` - Type conversion

**File operations**: Require special handling
- Use `r_inline()` for R-based path construction
- `readFile()` returns array of strings (one per line)

**Control flow**: Standard in SLiM
- `for (line in lines)` - Iterate over array
- `if (condition)` - Conditional execution

### Testing notes

**Test expectations**:
1. Simulation completes (exit_status = 0)
2. Output file created
3. Output contains mutations

**File dependency**: Test requires migration.csv in inst/extdata/recipe_resources/

**Edge cases handled**:
- Comment lines filtered out
- Self-migration entries (i==j) skipped
- Population lookup by ID works correctly

### Files created this session

**Converted recipe**:
- inst/extdata/slim_recipes/converted/recipe_5_3_5.R

**Test file**:
- tests/testthat/test-recipe_5_3_5.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (added row for 5.3.5)
- claude_notes/recipe_conversion_notes.md (this entry)

**Supporting file** (already existed):
- inst/extdata/recipe_resources/migration.csv

### Total progress

**Recipes completed**: 21 (previously 20 + Recipe 5.3.5)
**Completion rate**: ~22%

### Next steps

Continue with Recipe 5.4 series and beyond. Recipe 5.3.x series (migration patterns) is now complete!

**Remaining recipes**: ~74

---

## Session 2025-10-23 (Recipes 5.4 and 5.5 - Advanced Demographics and Rescaling)

### Summary

Converted 4 additional recipes focusing on advanced demographic modeling and performance optimization:
- Recipe 5.4_I - Gravel et al. (2011) human evolution model
- Recipe 5.4_II - Same model with Jump Menu annotations
- Recipe 5.5_I - Rescaling baseline (original parameters)
- Recipe 5.5_II - Rescaling demonstration (rescaled parameters)

**All tests passing**: Yes ✅
**Total recipes completed**: 25 (previously 21 + 4 new)

### Recipe 5.4 Series: The Gravel et al. (2011) Human Evolution Model

**Purpose**: Implement a published demographic model of human population history based on genomic data from the 1000 Genomes Project.

**Key features**:
1. **Ancestral African population** (p1) established at generation 1 with size ~7310
2. **Burn-in period** of 73,104 generations (10×N) for demographic equilibrium
3. **African expansion** at generation 73,105 to size ~14,474
4. **Out-of-Africa migration** at generation 76,968 splitting Eurasians (p2) from Africans (p1)
5. **European-Asian split** at generation 78,084 creating Europeans (p2) and East Asians (p3)
6. **Complex migration matrix** between all three populations with asymmetric rates
7. **Exponential growth** in European and Asian populations from 78,084 to 79,024
8. **Sample output** matching real human population samples (YRI, CEU, CHB from 1000 Genomes)

**Timeline** (25-year generation time):
- Generation 1: Ancestral African population established
- Generation 73,105 (147,978 years ago): African expansion begins
- Generation 76,968 (51,410 years ago): Out-of-Africa migration
- Generation 78,084 (23,495 years ago): European-Asian split
- Generation 79,024 (present day): Sample output

**Parameter precision**: Recipe uses highly precise parameter values from the paper with comments showing the rounded values used in the publication. For example:
```r
sim$addSubpop("p1", asInteger(round(7310.370867595234)))  # paper rounds to 7310
```

### Pattern: addSubpopSplit() for Population Splits

**Purpose**: Create new subpopulation from existing one (representing population split/founder event)

**Syntax**:
```r
sim$addSubpopSplit("new_pop_id", size, source_population)
```

**Example from Recipe 5.4**:
```r
# Split Eurasians (p2) from Africans (p1)
sim$addSubpopSplit("p2", asInteger(round(1861.288190027689)), p1)

# Later, split Europeans (p2) and East Asians (p3)
# Note: p3 split from p2, and p2 is resized
sim$addSubpopSplit("p3", asInteger(round(553.8181989)), p2)
p2$setSubpopulationSize(asInteger(round(1032.1046957333444)))
```

**Important notes**:
- New population inherits genetic variation from source population
- Source population continues to exist (unlike migration where individuals move)
- Common pattern: split population, then resize both populations, then set up migration
- Represents founding events in demographic history

### Pattern: Complex Migration Matrices

**Purpose**: Set up asymmetric migration between multiple populations

**Syntax**:
```r
population$setMigrationRates(c(source1, source2, ...), c(rate1, rate2, ...))
```

**Example from Recipe 5.4** (3-population system):
```r
# Migration into each population from the other two
p1$setMigrationRates(c(p2, p3), c(2.54332678e-5, 0.7770583877e-5))
p2$setMigrationRates(c(p1, p3), c(2.54332678e-5, 3.115817913e-5))
p3$setMigrationRates(c(p1, p2), c(0.7770583877e-5, 3.115817913e-5))
```

**Interpretation**:
- Each row defines migration INTO one population
- First line: p1 receives migrants from p2 at rate 2.54e-5 and from p3 at rate 0.78e-5
- Creates asymmetric migration graph (different rates in different directions)
- Rates typically very small (1e-5 range) representing rare long-distance migration

**Use cases**:
- Realistic demographic models with gene flow
- Island biogeography models
- Stepping-stone models with edge effects

### Pattern: Long Simulations with Burn-in

**Purpose**: Allow population to reach mutation-selection-drift equilibrium before demographic events

**Implementation**:
```r
# Rule of thumb: burn-in for 10×N generations
# For N=7310, burn-in = 73,104 generations

slim_block(1, early(), {
  sim$addSubpop("p1", 7310)
})

# Events start after burn-in
slim_block(73105, early(), {
  # First demographic event
})
```

**Why burn-in matters**:
- Starting from scratch (generation 1), population has no mutations
- Needs time to accumulate mutation-selection-drift balance
- 10×N is standard rule for neutral models
- Selection/structure may need longer burn-in

**Alternatives**:
- Start from previously saved population state
- Use tree sequence recording and restart from checkpoint
- For very large N, may need to rescale (see Recipe 5.5)

### Recipe 5.4 Part II: Jump Menu Annotations

**Difference from Part I**: Same model, different commenting style

**Purpose**: Demonstrate structured comments for SLiMgui navigation

**SLiM comment styles**:
```slim
/// Triple-slash comments are documentation
/* Block labels */ for navigation
/**/ Section dividers
```

**slimr conversion**:
```r
# Triple-slash becomes regular R comment
slim_block(gen, early(), {  # block label as inline comment
})

# ---
# Section divider
```

**Use case**: When organizing complex models, structured comments help navigation in both SLiMgui and when reading R code.

### Recipe 5.5 Series: Rescaling for Performance Optimization

**Purpose**: Demonstrate rescaling technique to speed up simulations while maintaining equivalent evolutionary dynamics

**The rescaling principle**:
Population genetics depends on composite parameters:
- **θ = 4Nμ** (neutral diversity)
- **4Ns** (selection strength relative to drift)
- **4Nr** (recombination relative to drift)
- **Time in units of N generations** (coalescent time scale)

If these stay constant, evolutionary dynamics are equivalent.

### Pattern: Parameter Rescaling (10× speedup)

**Original (Recipe 5.5_I)**:
```r
# Population: 5000 → 1000 → 5000
# Mutation rate: 1e-8
# Selection: s = -0.01
# Recombination: 1e-8
# Generations: 60,000
```

**Rescaled (Recipe 5.5_II)** - apply scaling factor k=10:
```r
# Population: N/k = 500 → 100 → 500
# Mutation rate: μ×k = 1e-7
# Selection: s×k = -0.1
# Recombination: r×k = 1e-7
# Generations: gen/k = 6,000
```

**Verification** (composite parameters stay constant):
- θ = 4Nμ: 4×5000×1e-8 = 4×500×1e-7 = 0.0002 ✓
- 4Ns: 4×5000×0.01 = 4×500×0.1 = 200 ✓
- 4Nr: 4×5000×1e-8 = 4×500×1e-7 = 0.0002 ✓
- Time scale: 60000/5000 = 6000/500 = 12 (in units of N) ✓

**Result**: ~10× speedup with similar evolutionary outcomes

**When to use rescaling**:
- Large population sizes make simulation slow
- Focus is on evolutionary dynamics, not absolute values
- Demographic ratios matter more than absolute sizes
- Testing/development before full-scale runs

**Limitations**:
- Discrete generation effects at very small N
- Stochastic effects differ (smaller N = more drift)
- Fixation probabilities similar but not identical
- Best for comparing qualitative patterns, not precise predictions

### Conversion Patterns Summary

**addSubpopSplit()**:
```r
sim$addSubpopSplit("new_id", size, source_pop)
```

**Multi-population migration**:
```r
pop$setMigrationRates(c(source1, source2), c(rate1, rate2))
```

**Burn-in before events**:
```r
slim_block(1, early(), {
  # Initialize
})
slim_block(10*N + 1, early(), {
  # First demographic event after burn-in
})
```

**Parameter rescaling** (for k× speedup):
- N → N/k
- μ → μ×k
- s → s×k
- r → r×k
- generations → generations/k

### Testing Notes

**Recipe 5.4** (79,024 generations):
- Runtime: ~30-40 seconds
- Very long simulation modeling ~2 million years
- Output includes samples from 3 populations
- Tests verify all 3 populations present in output

**Recipe 5.5_I** (60,000 generations):
- Runtime: ~20-30 seconds
- Baseline for rescaling comparison

**Recipe 5.5_II** (6,000 generations):
- Runtime: ~2-3 seconds
- Demonstrates ~10× speedup
- Nearly identical to 5.5_I in structure

### Files Created This Session

**Converted recipes** (4 files):
- inst/extdata/slim_recipes/converted/recipe_5_4_I.R
- inst/extdata/slim_recipes/converted/recipe_5_4_II.R
- inst/extdata/slim_recipes/converted/recipe_5_5_I.R
- inst/extdata/slim_recipes/converted/recipe_5_5_II.R

**Test files** (4 files):
- tests/testthat/test-recipe_5_4_I.R
- tests/testthat/test-recipe_5_4_II.R
- tests/testthat/test-recipe_5_5_I.R
- tests/testthat/test-recipe_5_5_II.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (4 new rows)
- claude_notes/recipe_conversion_notes.md (this entry)

### Total Progress

**Recipes completed**: 25 (previously 21 + 4 new)
**Completion rate**: ~26%
**Remaining recipes**: ~70

### Next Steps

Continue with Recipe 6.x series (genomic structure) or other Chapter 5 recipes.

**Important concepts added**:
- Population splits with addSubpopSplit()
- Complex migration matrices
- Burn-in periods for equilibrium
- Long-running demographic simulations
- Parameter rescaling for performance
- Composite parameter theory (4Nμ, 4Ns, 4Nr)

### Key Insights for Future Conversions

1. **Preserve parameter precision**: When recipes include precise values from papers, keep them and add comments with rounded values
2. **Document complex models**: Use detailed descriptions for multi-stage demographic models
3. **Explain rescaling math**: Show calculations proving composite parameters stay constant
4. **Long simulations**: Note runtime in test comments for 50K+ generation simulations
5. **Structured comments**: Convert SLiM documentation comments (///) to R-style appropriately

---

## Session 2025-10-23 (Recipe 6.x series - Genomic Structure)

### Summary

Converted all 4 Recipe 6.x recipes demonstrating genomic structure concepts:
- Recipe 6.1 - Mutation types and fitness effects
- Recipe 6.2 - Genomic element types
- Recipe 6.3 - Chromosome organization
- Recipe 6.4 - Custom display colors in SLiMgui

**All tests passing**: Yes
**Total recipes completed**: 29 (previously 25 + 4 new)

### Recipe 6.1: Mutation types and fitness effects

**Purpose**: Foundation recipe showing how to define mutation types with different fitness distributions.

**Key features**:
- Defines 4 mutation types: m1 (non-coding), m2 (synonymous), m3 (deleterious), m4 (beneficial)
- Each has different dominance coefficient (h) and fitness effect distribution
- Only m1 used in genomic elements (others defined for future use)
- Shows basic mutation type syntax: `initializeMutationType(id, h, dfe_type, ...params)`

**Fitness distributions**:
- "f" (fixed): constant selection coefficient
- "g" (gamma): mean and shape parameters
- "e" (exponential): mean parameter

**Conversion**: Straightforward, no special patterns.

---

### Recipe 6.2: Genomic element types

**Purpose**: Shows how to create genomic element types with multiple mutation types in different proportions.

**Key features**:
- Defines 3 genomic element types: g1 (exon), g2 (intron), g3 (non-coding)
- Each uses different mutation types with relative proportions
- g1: m2, m3, m4 at 2:8:0.1 (mostly deleterious, some synonymous, few beneficial)
- g2: m1, m3 at 9:1 (mostly neutral, some deleterious)
- g3: m1 at 1.0 (completely neutral)

**Syntax**:
```r
initializeGenomicElementType("g1", c(m2,m3,m4), c(2,8,0.1))
```

**Interpretation**: Proportions are relative weights, not percentages. Total doesn't need to sum to 1.

**Conversion**: Straightforward, c() works same in R and SLiM.

---

### Recipe 6.3: Chromosome organization

**Purpose**: Demonstrates realistic chromosome structure with randomly generated genes.

**Key features**:
- Uses while loop to generate multiple genes until chromosome length ~100kb
- Each gene has structure: non-coding → exon → (intron-exon pairs)* → non-coding
- Random lengths from statistical distributions (rdunif, rlnorm)
- Variable number of exons per gene (80% chance to continue adding pairs)

### NEW PATTERN: do-while loop conversion

**Issue**: SLiM's `do { ... } while (condition)` syntax doesn't parse in R.

**Solution**: Convert to `while (T) { ... if (!condition) break }` which is semantically equivalent.

**Original SLiM**:
```slim
do {
  // code
} while (runif(1) < 0.8);
```

**Converted slimr**:
```r
while (T) {
  # code
  if (runif(1) >= 0.8) break
}
```

**Why this works**:
- R can parse while(T) syntax
- Executes at least once (same as do-while)
- Break on inverse condition gives identical behavior
- T works in both R and SLiM (TRUE only works in R)

### CRITICAL: SLiM boolean constants

**Issue**: SLiM uses `T` and `F` for boolean constants, NOT `TRUE` and `FALSE`.

**Error if you use TRUE/FALSE**:
```
ERROR (EidosSymbolTable::_GetValue): undefined identifier TRUE.
```

**Solution**: Always use `T` and `F` in SLiM blocks.

**Examples**:
```r
# WRONG - doesn't work in SLiM
while (TRUE) { ... }

# CORRECT - works in both R and SLiM
while (T) { ... }

# Also correct
if (T) { ... }
some_property <- F
```

---

### Recipe 6.4: Custom display colors in SLiMgui

**Purpose**: Demonstrates visual customization for SLiMgui (cosmetic, doesn't affect simulation).

**Key features**:
- Sets `color` and `colorSubstitution` properties on mutation types
- Sets `color` properties on genomic element types
- Color syntax: named colors ("red", "cornflowerblue") or hex ("#550000")
- Setting to empty string ("") disables coloring

**Pattern: Property assignment**:
```r
# In initialize block or other blocks:
m1.color <- "gray40"
m1.colorSubstitution <- "gray20"
g1.color <- "cornflowerblue"
sim.chromosomes.colorSubstitution <- ""
```

**Use cases**:
- Visualizing different mutation types in SLiMgui
- Highlighting genomic regions
- Making plots more interpretable
- Completely optional - simulation runs same without colors

---

### Conversion Patterns Summary (Recipe 6.x)

**Mutation types**:
```r
initializeMutationType("m1", h, "f", s)           # fixed
initializeMutationType("m2", h, "g", mean, shape) # gamma
initializeMutationType("m3", h, "e", mean)        # exponential
```

**Genomic element types**:
```r
initializeGenomicElementType("g1", c(m1,m2), c(weight1,weight2))
```

**Placing genomic elements**:
```r
initializeGenomicElement(g1, start_pos, end_pos)
```

**do-while conversion**:
```r
# SLiM: do { code } while (condition);
# slimr:
while (T) {
  # code
  if (!condition) break
}
```

**Boolean constants**: Use `T` and `F`, NOT `TRUE` and `FALSE`

**Color properties**:
```r
mutationType.color <- "color_name"
mutationType.colorSubstitution <- "#hexcolor"
genomicElementType.color <- "color_name"
```

---

### Testing Notes

All Recipe 6.x tests simple:
- Verify exit_status == 0
- Verify output_file exists
- No specific output checks needed (basic neutral simulations)

Recipes 6.3 and 6.4 generate random chromosome structure, so exact genomic element positions vary between runs, but all should complete successfully.

---

### Files Created This Session

**Converted recipes** (4 files):
- inst/extdata/slim_recipes/converted/recipe_6_1.R
- inst/extdata/slim_recipes/converted/recipe_6_2.R
- inst/extdata/slim_recipes/converted/recipe_6_3.R
- inst/extdata/slim_recipes/converted/recipe_6_4.R

**Test files** (4 files):
- tests/testthat/test-recipe_6_1.R
- tests/testthat/test-recipe_6_2.R
- tests/testthat/test-recipe_6_3.R
- tests/testthat/test-recipe_6_4.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (4 new rows)
- claude_notes/recipe_conversion_notes.md (this entry)

---

### Total Progress

**Recipes completed**: 29 (previously 25 + 4 Recipe 6.x)
**Completion rate**: ~31%
**Remaining recipes**: ~66

---

### Next Steps for Future Agents

Recipe 6.x series is complete! Next options:

1. **Continue with remaining recipes** in numerical order
2. **Look for Chapter 7+** recipes if available
3. **Check for other recipe series** (selection, mating, etc.)

**Pattern library now includes**:
- do-while loop conversion (while(T) + break)
- Boolean constants (T/F not TRUE/FALSE)
- Color properties for visualization
- Mutation type fitness distributions
- Genomic element types with mutation proportions
- Random chromosome structure generation

---

### Common Mistakes to Avoid (Updated)

1. Using hardcoded generations instead of `..` for open-ended ranges
2. Forgetting to test - Always run the test after creating it
3. Empty blocks without NULL - Must have at least `NULL` statement
4. Using wrong property names - Remember SLiM 5.x uses `haplosomes` not `genomes`
5. Not reading output correctly - Use `result$output_file` not `result$output`
6. Forgetting to store original - Always add the `attr(script, "original_slim")` line
7. Overwriting notes - Always APPEND to recipe_conversion_notes.md
8. **NEW: Using TRUE/FALSE instead of T/F** - SLiM only recognizes T and F
9. **NEW: Not converting do-while loops** - Must use while(T) + break pattern

---

### Key Insights

1. **do-while loops**: Cannot use SLiM's `do...while` syntax directly in slimr. Must convert to `while(T) { ... if (!condition) break }`.

2. **Boolean constants**: Critical difference between R and SLiM. Use `T` and `F` (work in both) instead of `TRUE` and `FALSE` (R only).

3. **Genomic structure recipes are foundational**: These 4 recipes build on each other:
   - 6.1: Define mutation types
   - 6.2: Combine into genomic element types
   - 6.3: Place elements to create realistic chromosome
   - 6.4: Add visual customization

4. **Random chromosome generation**: Recipe 6.3's approach is a good template for any simulation needing realistic gene structure.

5. **Statistical distributions**: SLiM has rich set of random number generators (rdunif, rlnorm, runif, etc.) that work same as R equivalents.

---

## End of Session 2025-10-23 (Recipe 6.x series)

**Session completed**: 4 recipes converted and tested (Recipe 6.1-6.4)
**All tests passing**: Yes
**Key patterns documented**: do-while conversion, T/F boolean constants
**Files updated**: Recipes, tests, metadata CSV, notes
**Total progress**: 29/95 recipes (31%)

Ready for next agent to continue with remaining recipes!

---

## Session 2025-10-23 (Recipe 5.2.x completion - 5.2.2, 5.2.3, 5.2.4)

### Summary

Completed the 5.2.x series by converting 3 additional recipes (5.2.1 was done earlier):
- Recipe 5.2.2 - Removing subpopulations
- Recipe 5.2.3 - Splitting subpopulations
- Recipe 5.2.4 - Joining subpopulations

**All tests passing**: Yes ✅
**Total recipes completed**: 32 (previously 29 + 3 new)

### Recipe 5.2.2: Removing subpopulations

**Purpose**: Demonstrates population extinction by setting size to 0, with gradual migration establishment.

**Key features**:
1. Multiple populations added at different times (p1 at gen 1, p2 at gen 100, p3 at gen 1000)
2. Gradual migration establishment using progress variables (0 to 1 over time range)
3. Population growth (p3 grows from 10 to 1000 over 100 generations)
4. **Population removal** at gen 2000 via `setSubpopulationSize(0)`

**Pattern**: Gradual migration establishment
```r
# Calculate progress from 0 to 1 over time range
migrationProgress <- (sim$cycle - start_gen) / duration
p1$setMigrationRates(p2, target_rate * migrationProgress)
```

**Use cases**:
- Modeling population extinction events
- Gradual establishment of gene flow (vs instantaneous)
- Dynamic population structure

---

### Recipe 5.2.3: Splitting subpopulations

**Purpose**: Demonstrates population splits (founder events) using `addSubpopSplit()`.

**Key difference from Recipe 5.2.2**:
- **5.2.2** uses `addSubpop()`: Creates independent population with no genetic relationship
- **5.2.3** uses `addSubpopSplit()`: Creates population by sampling from source (founder event)

**Pattern**: Population split/founder event
```r
# New population inherits genetic variation from source
sim$addSubpopSplit("new_id", size, source_population)
```

**Why this matters**:
- `addSubpop()`: Random draw from mutation types (no shared ancestry)
- `addSubpopSplit()`: Samples individuals from source (shared ancestry, genealogical relationship)
- Use `addSubpopSplit()` for modeling:
  - Range expansion
  - Colonization events
  - Population divergence
  - Founder effects

**Also seen in**: Recipe 5.4 (Gravel model uses addSubpopSplit for Out-of-Africa and European-Asian splits)

---

### Recipe 5.2.4: Joining subpopulations

**Purpose**: Demonstrates population merger/admixture technique.

**The challenge**: SLiM has no direct "merge" function.

**The solution**: Use migration to create admixed population
1. Create new population (p3)
2. Set migration rates that sum to 1.0 (100% from migrants)
3. In same generation (late callback), remove migration and remove sources
4. Result: New population with specified admixture proportions

**Pattern**: Population merger via migration
```r
# Generation N early(): Create population with 100% migration
slim_block(N, early(), {
  sim$addSubpop("p3", 300)
  p3$setMigrationRates(c(p1, p2), c(0.75, 0.25))  # 75% p1, 25% p2
})

# Generation N late(): Remove migration and sources
slim_block(N, late(), {
  p3$setMigrationRates(c(p1, p2), c(0.0, 0.0))
  p1$setSubpopulationSize(0)
  p2$setSubpopulationSize(0)
})
```

**Key insight**: Migration rates c(0.75, 0.25) determine admixture proportions in new population.

**Use cases**:
- Modeling population mergers
- Admixture events (e.g., Neanderthal-modern human admixture)
- Secondary contact after divergence
- Combining populations with different histories

**Important**: Uses both `early()` and `late()` callbacks in same generation to ensure proper sequencing.

---

### Conversion Patterns Summary (Recipe 5.2.x series)

**Gradual migration establishment**:
```r
progress <- (sim$cycle - start) / duration
pop$setMigrationRates(source, target_rate * progress)
```

**Population removal/extinction**:
```r
pop$setSubpopulationSize(0)
```

**Population split/founder event**:
```r
sim$addSubpopSplit("new_id", size, source_pop)
```

**Population merger/admixture**:
```r
# Early callback: set up 100% migration
sim$addSubpop("merged", size)
merged$setMigrationRates(c(pop1, pop2), c(prop1, prop2))

# Late callback: complete merger
merged$setMigrationRates(c(pop1, pop2), c(0.0, 0.0))
pop1$setSubpopulationSize(0)
pop2$setSubpopulationSize(0)
```

---

### Comparison: 5.2.x Population Structure Operations

**5.2.1** - Basic migration: Set migration rates between existing populations
**5.2.2** - Removing: Remove populations via setSubpopulationSize(0)
**5.2.3** - Splitting: Create new population from existing via addSubpopSplit()
**5.2.4** - Joining: Merge populations via migration technique

Together, these 4 recipes demonstrate all major population structure operations in SLiM.

---

### Testing Notes

All three recipes:
- Run successfully (exit_status = 0)
- ~2-3 seconds runtime
- Output fixed mutations at generation 10000
- Standard neutral simulations with dynamic population structure

---

### Files Created This Session

**Converted recipes** (3 files):
- inst/extdata/slim_recipes/converted/recipe_5_2_2.R
- inst/extdata/slim_recipes/converted/recipe_5_2_3.R
- inst/extdata/slim_recipes/converted/recipe_5_2_4.R

**Test files** (3 files):
- tests/testthat/test-recipe_5_2_2.R
- tests/testthat/test-recipe_5_2_3.R
- tests/testthat/test-recipe_5_2_4.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (3 new rows)
- claude_notes/recipe_conversion_notes.md (this entry)

---

### Total Progress

**Recipes completed**: 32 (previously 29 + 3 new: 5.2.2, 5.2.3, 5.2.4)
**Completion rate**: ~34%
**Remaining recipes**: ~63

**Complete series**:
- ✅ Recipe 4.1, 4.2.x (7 recipes)
- ✅ Recipe 5.1.x (5 recipes)
- ✅ Recipe 5.2.x (4 recipes) ← **Just completed!**
- ✅ Recipe 5.3.x (5 recipes)
- ✅ Recipe 5.4.x (2 recipes)
- ✅ Recipe 5.5.x (2 recipes)
- ✅ Recipe 6.x (4 recipes)

---

### Next Steps for Future Agents

The 5.2.x series is now complete! Next options:

1. **Recipe 4.1.10** - Unclear numbering (might be 4.10.1?)
2. **Recipe 10.x series** - Selection topics
3. **Recipe 11.x series** - Mating systems
4. **Recipe 12.x series** - Advanced topics
5. **Recipe 13.x series** - Quantitative traits
6. **Recipe 14.x series** - Advanced modeling techniques
7. **Recipe 15.x series** - Non-Wright-Fisher models

Recommend starting with Recipe 10.x (selection) or checking Recipe 4.1.10.

---

### Key Insights

1. **Population operations are complementary**: The 5.2.x series shows a complete set of population structure manipulations that work together.

2. **Gradual vs instantaneous**: Using progress variables (0 to 1) creates smooth transitions rather than abrupt changes - more realistic for many scenarios.

3. **Migration as a tool**: Recipe 5.2.4 shows migration can be used creatively beyond just gene flow - here it's a technique for population merging.

4. **Early vs late callbacks**: Recipe 5.2.4 demonstrates using both callbacks in same generation for proper sequencing of operations.

5. **addSubpop vs addSubpopSplit**: Critical to choose the right function based on whether populations have shared ancestry or not.

---

## End of Session 2025-10-23 (Recipe 5.2.x completion)

**Session completed**: 3 recipes converted and tested (5.2.2, 5.2.3, 5.2.4)
**All tests passing**: Yes ✅
**Key patterns documented**: Gradual migration, population removal, population split, population merger
**Files updated**: Recipes, tests, metadata CSV, notes
**Total progress**: 32/95 recipes (34%)

Ready for next agent to continue with Recipe 10.x or other series!

---

## Session 2025-10-23 (Recipe 4.1.10 - Parameter Management)

### Summary

Converted Recipe 4.1.10: Using defineConstant() for parameterization

**Status**: Completed successfully
**Test result**: PASS (2 expectations pass)
**Runtime**: ~35 seconds (10,000 generations with N=500)

### Recipe 4.1.10: Using defineConstant() for parameterization

**Purpose**: Demonstrates best practice of using `defineConstant()` to define global constants for simulation parameters. This makes scripts more maintainable by centralizing parameter definitions.

**Key features**:
1. Defines four constants: MU (mutation rate), L (genome length), R (recombination rate), N (population size)
2. Uses constants throughout initialization
3. **Demonstrates arithmetic with constants** in generation numbers (20*N)
4. Shows centralized parameter management

**Why this matters**:
- **Maintainability**: Change parameter in one place, affects entire simulation
- **Readability**: Named constants (MU) more clear than magic numbers (1e-7)
- **Flexibility**: Constants can be used in calculations (20*N for runtime)
- **Documentation**: Constant names self-document their purpose
- **Parameter sweeps**: Easy to modify for testing different parameter values

### Pattern: Arithmetic in Generation Numbers

**Issue**: SLiM allows expressions in generation numbers, but how does this work in slimr?

**Solution**: R expressions work directly in generation positions!

**Example**:
```r
# SLiM: 20*N early() { ... }
# slimr:
slim_block(20*500, early(), {
  sim$simulationFinished()
})
```

**How it works**:
- slimr evaluates R expressions in generation parameters
- `20*500` evaluates to `10000` before creating the block
- Can use any R arithmetic: `N*10`, `floor(N/2)`, etc.

**Use cases**:
- Runtime proportional to population size (e.g., `10*N` generations)
- Events at specific population multiples
- Calculated generation numbers based on parameters

**Note**: The constant N=500 is hardcoded in the example (slim_block(20*500, ...)) because it needs to be evaluated at script creation time. In the SLiM code, 20*N works because N is defined via defineConstant(). For dynamic parameter values, consider using slimr templates.

### Pattern: defineConstant() for Parameter Organization

**Best practice pattern** for organizing simulation parameters:

```r
slim_block(initialize(), {
  # Define all simulation parameters as constants
  defineConstant("MU", 1e-7)      # Mutation rate
  defineConstant("L", 1e5)        # Genome length
  defineConstant("R", 1e-8)       # Recombination rate
  defineConstant("N", 500)        # Population size

  # Use constants throughout initialization
  initializeMutationRate(MU)
  initializeGenomicElement(g1, 0, L - 1)
  initializeRecombinationRate(R)
})

slim_block(1, early(), {
  sim$addSubpop("p1", N)  # Use constant
})
```

**Benefits**:
1. **Single source of truth**: Parameters defined once
2. **Easy to modify**: Change constant value, entire simulation updates
3. **Self-documenting**: Named constants explain their purpose
4. **Supports calculations**: Use in expressions like `L-1` or `20*N`
5. **Better than comments**: Constants enforce correct usage

**When to use**:
- Any script with repeated parameter values
- Scripts with related parameters (e.g., 20*N runtime)
- Scripts intended for sharing or reuse
- Scripts that might need parameter adjustments

### Conversion notes

**Straightforward conversion**:
- defineConstant() syntax identical in SLiM and slimr
- Constants used as-is in expressions
- Arithmetic in generation numbers works directly

**Test adjustments**:
- Initial test checked for "Mutations" in output but recipe doesn't output mutations explicitly
- Fixed by removing overly specific output check
- Recipe runs successfully and completes at generation 10,000 (20*500)

### Files created this session

**Converted recipe**:
- inst/extdata/slim_recipes/converted/recipe_4_1_10.R

**Test file**:
- tests/testthat/test-recipe_4_1_10.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (added row for 4.1.10)
- claude_notes/recipe_conversion_notes.md (this entry)

### Total progress

**Recipes completed**: 33 (previously 32 + Recipe 4.1.10)
**Completion rate**: ~35%

### Next steps

Recipe 4.1.10 complete! Continue with Recipe 10.1 (temporally varying selection) to start the selection series.

**Remaining recipes**: ~62

---

## Pattern Library Update

**New pattern added**: Arithmetic in generation numbers
- R expressions evaluate directly in generation positions
- Example: `slim_block(20*500, ...)` instead of hardcoding 10000
- Useful for runtime proportional to parameters

**Reinforced pattern**: defineConstant() for parameter management
- Best practice for organizing simulation parameters
- Creates self-documenting, maintainable code
- Enables calculations with parameters

---

### Key Insights

1. **defineConstant() is a best practice**: Not just for complex models - even simple simulations benefit from centralized parameter definitions.

2. **Arithmetic works in generation numbers**: slimr evaluates R expressions in generation positions, enabling flexible runtime specifications.

3. **Test specificity matters**: Not all recipes produce the same output format. Adjust test expectations based on what the recipe actually does, not generic assumptions.

4. **Recipe 4.1.10 bridges basic and advanced**: Shows transition from hardcoded values (Recipe 4.1) to parameterized scripts (foundation for parameter sweeps and templates).

---

## End of Session 2025-10-23 (Recipe 4.1.10)

**Session completed**: 1 recipe converted and tested (Recipe 4.1.10)
**All tests passing**: Yes ✅
**Key patterns documented**: defineConstant() for parameters, arithmetic in generation numbers
**Files updated**: Recipe, test, metadata CSV, notes
**Total progress**: 33/95 recipes (35%)

Ready for next agent to continue with Recipe 10.1 (selection series)!

---

## Session 2025-10-23 (Recipe 8.1.x - Reproduction basics)

### Summary

Converted 6 recipes from Recipe 8.1.x series (Reproduction fundamentals):
- Recipe 8.1.1 - Enabling separate sexes
- Recipe 8.1.2 I - Sex ratios at population creation
- Recipe 8.1.2 II - Dynamic sex ratio changes
- Recipe 8.1.3 - Selfing in hermaphroditic populations
- Recipe 8.1.4 I - Basic clonal reproduction
- Recipe 8.1.4 II - Sex-specific cloning rates

**All tests passing**: Yes ✅
**Total recipes completed**: 39 (previously 33 + 6 new)
**Completion rate**: ~41%

### Recipe 8.1 Series Overview

This series covers fundamental reproductive modes in SLiM:
1. **Sexual reproduction** (8.1.1) - Separate sexes with initializeSex()
2. **Sex ratio control** (8.1.2 I, II) - Fixed and dynamic sex ratios
3. **Selfing** (8.1.3) - Self-fertilization in hermaphrodites
4. **Cloning** (8.1.4 I, II) - Asexual reproduction with optional sex-specificity

### Pattern: initializeSex() for sexual reproduction

**Purpose**: Switch from hermaphroditic (default) to sexual model with separate males and females.

**Syntax**:
```r
slim_block(initialize(), {
  initializeSex()  # Must be called before other initialization
  # ... rest of initialization
})
```

**Effects**:
- Population splits into males and females
- Reproduction requires both sexes
- Automatic ~1:1 sex ratio unless modified
- Enables sex-specific parameters (cloning rates, migration, etc.)

**When to use**:
- Modeling organisms with separate sexes
- Sex-specific selection or traits
- Sex-biased demography or dispersal
- XY or ZW sex chromosome systems

### Pattern: Sex ratio control

**Two approaches for controlling sex ratios:**

**1. At population creation** (Recipe 8.1.2 I):
```r
sim$addSubpop("p1", 500, 0.6)  # Third parameter = proportion males
```
- Sets initial sex ratio once
- Ratio then evolves naturally with genetic drift and selection

**2. Dynamic changes** (Recipe 8.1.2 II):
```r
slim_block(1, .., early(), {
  p1$setSexRatio(runif(1, 0.3, 0.7))  # Random ratio each generation
})
```
- Changes sex ratio of newborns every generation
- Models environmental sex determination
- Can use constants or expressions

**Use cases**:
- Temperature-dependent sex determination
- Sex-biased mortality or dispersal
- Environmental sex determination
- Male/female harems or leks

### Pattern: Selfing in hermaphrodites

**Purpose**: Enable self-fertilization in hermaphroditic populations.

**Syntax**:
```r
slim_block(1, early(), {
  sim$addSubpop("p1", 500)
  p1$setSelfingRate(0.8)  # 80% selfing, 20% outcrossing
})
```

**Important**: Do NOT call initializeSex() - hermaphroditic model is default

**Effects**:
- Proportion of offspring from selfing vs outcrossing
- Increases homozygosity rapidly
- Can purge deleterious alleles (homozygous exposure)
- Can fix beneficial alleles faster

**Use cases**:
- Plants (many are facultative selfers)
- Some invertebrates (C. elegans, flatworms)
- Inbreeding studies
- Mating system evolution

### Pattern: Clonal reproduction

**Two variants:**

**1. Simple cloning** (Recipe 8.1.4 I):
```r
p1$setCloningRate(0.1)  # 10% clonal, 90% sexual
```
- Single value applies to all individuals (or all females if sexual)
- No recombination or segregation for clones

**2. Sex-specific cloning** (Recipe 8.1.4 II):
```r
initializeSex()  # Required for sex-specific rates
p1$setCloningRate(c(0.5, 0.0))  # [female_rate, male_rate]
```
- Vector with two values: [female_rate, male_rate]
- Models facultative parthenogenesis
- Common in aphids, Daphnia, some reptiles

**Cloning effects**:
- Preserves exact multilocus genotypes
- No recombination = maintains beneficial gene combinations
- No segregation = offspring are genetic copies
- Can be mixed with sexual reproduction

**Use cases**:
- Aphids (cyclical parthenogenesis)
- Plants (vegetative reproduction)
- Rotifers (cyclical parthe

nogenesis)
- Daphnia (environmental sex determination)
- Whiptail lizards (obligate parthenogenesis)

### Conversion Patterns Summary

**Sexual reproduction**:
```r
initializeSex()  # In initialize block
```

**Sex ratios**:
```r
# At creation:
sim$addSubpop("p1", N, proportion_male)

# Dynamic:
p1$setSexRatio(value)  # 0-1, proportion male
```

**Selfing (hermaphroditic)**:
```r
p1$setSelfingRate(rate)  # 0-1, proportion selfing
# Note: NO initializeSex()
```

**Cloning**:
```r
# Simple:
p1$setCloningRate(rate)

# Sex-specific:
initializeSex()  # Required
p1$setCloningRate(c(female_rate, male_rate))
```

### Testing Notes

All 6 recipes:
- Runtime: ~30 seconds each
- Simple neutral models
- No specific output checks needed
- All pass with exit_status == 0

### Files Created This Session

**Converted recipes** (6 files):
- inst/extdata/slim_recipes/converted/recipe_8_1_1.R
- inst/extdata/slim_recipes/converted/recipe_8_1_2_I.R
- inst/extdata/slim_recipes/converted/recipe_8_1_2_II.R
- inst/extdata/slim_recipes/converted/recipe_8_1_3.R
- inst/extdata/slim_recipes/converted/recipe_8_1_4_I.R
- inst/extdata/slim_recipes/converted/recipe_8_1_4_II.R

**Test files** (6 files):
- tests/testthat/test-recipe_8_1_1.R through test-recipe_8_1_4_II.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (6 new rows)
- claude_notes/recipe_conversion_notes.md (this entry)

### Total Progress

**Recipes completed**: 39 (previously 33 + 6 new)
**Completion rate**: ~41% (of ~95 estimated)
**Note**: Actual total may be 150-200 recipes based on Recipe 7-20 series discovery

### Next Steps

Recipe 8.1.x series complete! Continue with:
1. **Recipe 8.2.x** - Recombination (random maps, file-based maps, unlinked loci, gene conversion)
2. **Recipe 8.3.x** - Multiple chromosomes (autosomes, haploids, sex chromosomes)
3. Or jump to **Recipe 9.x** - Selective sweeps and adaptation

**Remaining in Recipe 8.x**: ~10 more recipes (8.2.x and 8.3.x)

---

### Key Insights

1. **Reproductive modes are modular**: SLiM allows mixing sexual/asexual reproduction, selfing, and cloning in flexible combinations.

2. **Sex-specific parameters**: Many SLiM functions accept vectors for sex-specific values when initializeSex() is active.

3. **Hermaphroditic is default**: No initializeSex() call means hermaphroditic model where all individuals can mate.

4. **Sex ratio control has two levels**: Initial (at addSubpop) and ongoing (via setSexRatio).

5. **Cloning preserves genotypes**: Unlike sexual reproduction, cloning maintains exact multilocus combinations, useful for studying the evolution of sex.

---

## End of Session 2025-10-23 (Recipe 8.1.x series)

**Session completed**: 6 recipes converted and tested (Recipe 8.1.1 through 8.1.4 II)
**All tests passing**: Yes ✅
**Key patterns documented**: initializeSex, sex ratios, selfing, cloning (simple and sex-specific)
**Files updated**: 6 recipes, 6 tests, metadata CSV, notes
**Total progress**: 39/~95 recipes (~41%)

Ready for next agent to continue with Recipe 8.2.x (recombination) or Recipe 9.x (selective sweeps)!

---

## Session 2025-10-24 (Recipe 8.2.x series - Recombination)

### Summary

Converted 4 recipes from Recipe 8.2.x series (Recombination mechanisms):
- Recipe 8.2.1 - Making a random recombination map
- Recipe 8.2.2 - Reading a recombination map from a file
- Recipe 8.2.3 - Unlinked loci
- Recipe 8.2.4 - Gene conversion

**All tests passing**: Yes ✅
**Total recipes completed**: 43 (previously 39 + 4 new)
**Completion rate**: ~45% (of ~95 estimated) or ~29% (of ~150 estimated)

### Recipe 8.2 Series Overview

This series covers different approaches to modeling recombination in SLiM:
1. **Random heterogeneous maps** (8.2.1) - Spatially varying recombination rates
2. **Empirical maps from files** (8.2.2) - Using real recombination data
3. **Unlinked loci** (8.2.3) - Maximum recombination (r=0.5)
4. **Gene conversion** (8.2.4) - Non-reciprocal genetic exchange

### Recipe 8.2.1: Making a random recombination map

**Purpose**: Demonstrates creating heterogeneous recombination landscapes with random rates across the genome.

**Key features**:
- Divides genome into 1000 random regions
- Each region gets random recombination rate from U(1e-9, 1e-7)
- Uses `sort(sample(0:99998, 999))` to create sorted random breakpoints
- Uses `runif(1000, 1e-9, 1e-7)` for random rates
- Passes vectors to `initializeRecombinationRate(rates, ends)`

**Why this matters**:
- Models realistic recombination hotspots and coldspots
- Each simulation run has different recombination landscape
- More realistic than uniform recombination rate

**Conversion**: Straightforward - all functions work same in R and SLiM

---

### Recipe 8.2.2: Reading a recombination map from a file

**Purpose**: Shows how to use empirical recombination maps from real genomic data.

**Key features**:
- Uses Drosophila melanogaster chromosome 2L map from Comeron et al. (2012)
- Genome length L = 23,011,544 bp (actual chromosome size)
- Function: `initializeRecombinationRateFromFile(file_path, end_position)`
- File format: Tab-separated values with positions and rates

**Pattern: File I/O with r_inline() (reinforced)**:
```r
# Use r_inline() to compute file path in R
initializeRecombinationRateFromFile(
  r_inline(system.file("extdata/recipe_resources/Comeron_100kb_chr2L.txt", package = "slimr")),
  L - 1
)
```

**Why this pattern**:
- SLiM's `readFile()` and `initializeRecombinationRateFromFile()` need file paths
- R's `system.file()` finds package resources at runtime
- `r_inline()` evaluates R expression and injects result into SLiM code

**Also seen in**: Recipe 5.3.5 (reading migration matrix from file)

---

### Recipe 8.2.3: Unlinked loci

**Purpose**: Demonstrates free recombination (unlinked loci) using maximum recombination rate.

**Key features**:
- Recombination rate = 0.5 (maximum possible)
- At r=0.5, any two loci recombine 50% of the time
- Equivalent to loci on different chromosomes or infinitely far apart
- Short genome (100 bp) with high mutation rate (1e-5)

**Why r=0.5 means unlinked**:
- Recombination rate of 0.5 means 50% probability of recombination per generation
- This is the same as independent assortment (Mendel's second law)
- Higher values (>0.5) would give negative linkage (impossible)
- Linkage disequilibrium (LD) decays very rapidly

**Use cases**:
- Modeling multiple independent loci
- Studying selection without Hill-Robertson interference
- Testing neutral theory predictions
- Baseline for comparing with linked loci

**Conversion**: Straightforward, just set recombination rate to 0.5

---

### Recipe 8.2.4: Gene conversion

**Purpose**: Enables gene conversion - non-reciprocal transfer of genetic material between homologs.

**Key features**:
- Function: `initializeGeneConversion(fraction, mean_length, simple_fraction)`
- Parameters in this recipe:
  - 0.2 = 20% of recombination events also involve gene conversion
  - 500 = mean length of gene conversion tract (bp)
  - 1.0 = 100% simple conversion (vs complex/heteroduplex conversion)

**Gene conversion vs crossover recombination**:
- **Crossover**: Reciprocal exchange of segments between homologs
- **Gene conversion**: Non-reciprocal copy of tract from one homolog to another
- Gene conversion can occur with or without associated crossover

**Biological importance**:
- Homogenizes sequences between duplicated genes (concerted evolution)
- GC-biased gene conversion (gBGC) can mimic selection
- Maintains multi-gene families (e.g., rRNA genes, immunoglobulins)
- Spreads variation between tandem duplicates

**Simple vs complex conversion**:
- **Simple** (fraction = 1.0): Direct copy of tract from donor to recipient
- **Complex** (fraction < 1.0): Heteroduplex formation with possible mismatches

**Use cases**:
- Modeling gene families
- GC-biased gene conversion
- Evolution of duplicated genes
- Recombination hotspot dynamics

**Conversion**: Straightforward - `initializeGeneConversion()` works same in slimr

---

### Conversion Patterns Summary (Recipe 8.2.x)

**Random recombination map**:
```r
ends <- c(sort(sample(0:99998, 999)), 99999)
rates <- runif(1000, min_rate, max_rate)
initializeRecombinationRate(rates, ends)
```

**Recombination map from file**:
```r
initializeRecombinationRateFromFile(
  r_inline(system.file("path/to/file.txt", package = "slimr")),
  genome_end_position
)
```

**Unlinked loci**:
```r
initializeRecombinationRate(0.5)  # Maximum recombination
```

**Gene conversion**:
```r
initializeGeneConversion(
  fraction,        # Proportion of recomb events with gene conversion
  mean_length,     # Mean tract length in bp
  simple_fraction  # Proportion using simple conversion
)
```

---

### Testing Notes

All 4 recipes:
- Runtime: ~30 seconds each (10,000 generations)
- Simple neutral models
- No specific output checks needed
- All pass with exit_status == 0

**Recipe 8.2.2 notes**:
- Requires data file: `inst/extdata/recipe_resources/Comeron_100kb_chr2L.txt`
- File already present in package
- Uses real Drosophila recombination data

---

### Files Created This Session

**Converted recipes** (4 files):
- inst/extdata/slim_recipes/converted/recipe_8_2_1.R
- inst/extdata/slim_recipes/converted/recipe_8_2_2.R
- inst/extdata/slim_recipes/converted/recipe_8_2_3.R
- inst/extdata/slim_recipes/converted/recipe_8_2_4.R

**Test files** (4 files):
- tests/testthat/test-recipe_8_2_1.R
- tests/testthat/test-recipe_8_2_2.R
- tests/testthat/test-recipe_8_2_3.R
- tests/testthat/test-recipe_8_2_4.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (4 new rows)
- claude_notes/recipe_conversion_notes.md (this entry)

---

### Total Progress

**Recipes completed**: 43 (previously 39 + 4 new: 8.2.1 through 8.2.4)
**Completion rate**: ~45% (of ~95) or ~29% (of ~150)
**Remaining recipes**: ~52-107 depending on total count

**Complete series**:
- ✅ Recipe 4.1, 4.2.x (7 recipes)
- ✅ Recipe 5.1.x (5 recipes)
- ✅ Recipe 5.2.x (4 recipes)
- ✅ Recipe 5.3.x (5 recipes)
- ✅ Recipe 5.4.x (2 recipes)
- ✅ Recipe 5.5.x (2 recipes)
- ✅ Recipe 6.x (4 recipes)
- ✅ Recipe 8.1.x (6 recipes)
- ✅ Recipe 8.2.x (4 recipes) ← **Just completed!**

---

### Next Steps for Future Agents

Recipe 8.2.x series is complete! Continue with:

1. **Recipe 8.3.x** - Multiple chromosomes (check if available)
2. **Recipe 9.x series** - Selective sweeps and adaptive evolution (12+ recipes available)
3. **Recipe 10.x series** - Selection topics (temporally varying, spatially varying, epistasis, frequency-dependent)

Recommend starting with Recipe 9.1 (Introducing adaptive mutations) to begin the selective sweeps series.

---

### Key Insights

1. **Recombination heterogeneity is important**: Real genomes have hotspots and coldspots. Recipe 8.2.1 shows random maps, 8.2.2 shows using real data.

2. **r=0.5 is the maximum**: Recombination rate of 0.5 means free recombination (unlinked loci). Higher values would be impossible.

3. **Gene conversion is distinct from crossover**: Non-reciprocal transfer (gene conversion) vs reciprocal exchange (crossover). Both important for evolution.

4. **File I/O pattern is consistent**: Use `r_inline(system.file(...))` for all file-based inputs (migration matrices, recombination maps, etc.).

5. **Recombination affects selection efficacy**: Linked loci experience Hill-Robertson interference. Unlinked loci evolve independently. Recombination maps determine which loci are functionally linked.

---

## End of Session 2025-10-24 (Recipe 8.2.x series)

**Session completed**: 4 recipes converted and tested (Recipe 8.2.1 through 8.2.4)
**All tests passing**: Yes ✅
**Key patterns documented**: Random recombination maps, file-based maps, unlinked loci, gene conversion
**Files updated**: 4 recipes, 4 tests, metadata CSV, notes
**Total progress**: 43/~95-150 recipes (~29-45%)

Ready for next agent to continue with Recipe 9.x (selective sweeps) or check for Recipe 8.3.x!

---

## Session 2025-10-24 continued (Recipe 8.3.x series - Multiple Chromosomes)

### Summary

Completed Recipe 8.3.x series (7 recipes on multiple chromosomes):
- Recipe 8.3.1 - Multiple diploid autosomes
- Recipe 8.3.2 - Clonal haploids and chromosome types
- Recipe 8.3.3 - Haploids with recombination
- Recipe 8.3.4 - Sex-chromosome evolution and null haplosomes
- Recipe 8.3.5 - Modeling the full human genome
- Recipe 8.3.6 - A model of bryophytes with UV sex determination
- Recipe 8.3.7 - Output from multiple-chromosome models

**All tests passing**: Yes ✅
**Total recipes this session**: 11 (4 from 8.2.x + 7 from 8.3.x)
**Total recipes completed**: 54 (previously 43 + 11 new)
**Completion rate**: ~57% (of ~95) or ~36% (of ~150)

**ENTIRE RECIPE 8.x SERIES COMPLETE!** All reproduction, recombination, and chromosome topics covered.

### Critical Pattern Discovery: SLiM 0-Based Array Indexing

**IMPORTANT**: When using loops with array indexing in SLiM, must use 0-based indexing!

**Problem**: SLiM's parallel iteration (`for (id in 1:3, type in c("A", "X", "Y"))`) doesn't work in R syntax.

**Solution**: Use indexed loops with 0-based indexing:
```r
# Define vectors
types <- c("A", "X", "Y")
symbols <- c("A", "X", "Y")

# Loop with 0-based index (SLiM arrays are 0-indexed!)
for (i in 0:2) {
  initializeChromosome(i + 1, length, type = types[i], symbol = symbols[i])
  # ...
}
```

**Why this works**:
- R loop `for (i in 0:2)` becomes SLiM `for (i in 0:2)` (i = 0, 1, 2)
- SLiM arrays use 0-based indexing: types[0], types[1], types[2]
- Chromosome IDs use 1-based: `i + 1` gives 1, 2, 3

**What doesn't work**:
```r
# ❌ WRONG: 1-based loop with direct indexing
for (i in 1:3) {
  initializeChromosome(i, length, type = types[i], ...)
  # This tries to access types[1], types[2], types[3]
  # But SLiM array only has indices 0, 1, 2!
  # Results in "subscript 3 out of range" error
}
```

This pattern applies to ALL array indexing in loops that get converted to SLiM code!

---

### Recipe 8.3 Series Overview

This series demonstrates SLiM's powerful multi-chromosome modeling capabilities:
1. **Multiple autosomes** (8.3.1) - Independent diploid chromosomes
2. **Haploid chromosomes** (8.3.2, 8.3.3) - Type "H" for bacteria, fungi, etc.
3. **Sex chromosomes XY** (8.3.4) - Mammalian-style with realistic sizes
4. **Full human genome** (8.3.5) - All 24 chromosomes from GRCh38.p14
5. **UV sex chromosomes** (8.3.6) - Haploid sex system in bryophytes
6. **Output methods** (8.3.7) - VCF and other formats for multi-chromosome data

### Recipe-by-Recipe Details

#### Recipe 8.3.1: Multiple diploid autosomes

**Purpose**: Shows how to model multiple independent chromosomes with different properties.

**Key features**:
- Two autosomes with different lengths (100kb vs 200kb)
- Each chromosome has independent mutation and recombination rates
- Chromosome 2 has three-part structure (g1-g2-g1)
- Chromosomes recombine freely with each other (unlinked)

**Pattern**:
```r
# Chromosome 1
initializeChromosome(1, 1e5)
initializeGenomicElement(g1, 0, 1e5 - 1)
initializeMutationRate(1e-7)
initializeRecombinationRate(1e-8)

# Chromosome 2 (different parameters)
initializeChromosome(2, 2e5)
initializeGenomicElement(g1, 0, 1e5 - 1)
initializeGenomicElement(g2, 1e5, 1.5e5 - 1)
initializeGenomicElement(g1, 1.5e5, 2e5 - 1)
initializeMutationRate(2e-7)
initializeRecombinationRate(1e-7)
```

**Use cases**:
- Modeling organisms with multiple chromosomes
- Studying chromosome-specific selection
- Comparing linked vs unlinked loci

---

#### Recipe 8.3.2: Clonal haploids and chromosome types

**Purpose**: Models haploid organisms with asexual (clonal) reproduction.

**Key features**:
- `type="H"` specifies haploid chromosome
- Dominance h=1.0 (mutations fully exposed to selection)
- Recombination rate = 0.0 (no recombination in clones)
- Cloning rate = 1.0 (100% asexual reproduction)

**Pattern**:
```r
initializeChromosome(1, type = "H")
# ... genome structure ...
initializeRecombinationRate(0.0)  # No recombination

# In simulation:
p1$setCloningRate(1.0)  # 100% clonal
```

**Biological examples**: Bacteria, some fungi, clonal algae, parthenogenetic organisms

---

#### Recipe 8.3.3: Haploids with recombination

**Purpose**: Haploid organisms with sexual reproduction.

**Key difference from 8.3.2**:
- Has recombination (r = 1e-8)
- No cloning (default sexual reproduction)

**Pattern**:
```r
initializeChromosome(1, 1e5, type = "H")
initializeGenomicElement(g1)  # Covers full chromosome
initializeRecombinationRate(1e-8)  # Recombination allowed
```

**Biological examples**: Yeast during sexual phase, gametophytes in plants with alternation of generations

**Key insight**: `initializeGenomicElement(g1)` without position arguments covers the entire chromosome automatically.

---

#### Recipe 8.3.4: Sex-chromosome evolution and null haplosomes

**Purpose**: Models XY sex determination with realistic human chromosome sizes.

**Key features**:
- X chromosome: 156,040,895 bp (realistic human X)
- Y chromosome: 57,227,415 bp (realistic human Y)
- initializeSex() enables sex chromosomes
- Y has no recombination (no initializeRecombinationRate call)
- Males are XY (one X, one Y)
- Females are XX (two X, no Y - "null haplosome")

**Pattern**:
```r
initializeSex()

# X chromosome
initializeChromosome(1, X_LEN, type = "X", symbol = "X")
initializeGenomicElement(g1)
initializeMutationRate(1e-7)
initializeRecombinationRate(1e-8)  # X recombines

# Y chromosome
initializeChromosome(2, Y_LEN, type = "Y", symbol = "Y")
initializeGenomicElement(g1)
initializeMutationRate(1e-7)
# No recombination rate for Y!
```

**Biological implications**:
- Y degeneration (Muller's ratchet from lack of recombination)
- Sex-linked inheritance patterns
- X dosage compensation needs
- Genetic drift stronger on sex chromosomes (especially Y)

**Computational note**: Took ~7 minutes to run 10,000 generations with N=500 due to large chromosome sizes.

---

#### Recipe 8.3.5: Modeling the full human genome

**Purpose**: Models ALL 24 human chromosomes with actual sizes from GRCh38.p14.

**Key features**:
- 22 autosomes + X + Y
- Total genome: ~3.1 billion base pairs
- Actual chromosome lengths from NCBI Human Genome Assembly GRCh38.p14 (2022-02-03)
- Uses indexed loop pattern with 0-based indexing
- Small population (N=100) and short run (1000 gen) due to computational scale

**Data source**: https://www.ncbi.nlm.nih.gov/grc/human/data

**Pattern** (using indexed loops):
```r
ids <- 1:24
symbols <- c(1:22, "X", "Y")
lengths <- c(248956422, 242193529, ...)  # All 24 chromosome lengths
types <- c(rep("A", 22), "X", "Y")

# 0-based loop for SLiM array indexing
for (i in 0:23) {
  initializeChromosome(ids[i], lengths[i], types[i], symbols[i])
  initializeMutationRate(1e-7)
  initializeRecombinationRate(1e-8)
  initializeGenomicElement(g1)
}
```

**Computational considerations**:
- VERY large genome (3.1 Gb)
- Even with N=100 and 1000 generations, takes several minutes
- For larger populations or longer runs:
  - Use rescaling (Recipe 5.5.x)
  - Use tree-sequence recording (Recipe 18.x)
  - Focus on specific chromosomes only

**Use cases**:
- Foundation for realistic human population genetics
- Studying chromosome-specific evolution
- Modeling complex demographic histories
- Research-grade human evolution simulations

**Test runtime**: ~2-3 minutes for 1000 generations with N=100

---

#### Recipe 8.3.6: A model of bryophytes with UV sex determination

**Purpose**: Models the unique UV haploid sex chromosome system in bryophytes (mosses, liverworts).

**UV system explained**:
- Unlike diploid XY (mammals) or ZW (birds) systems
- Sex chromosomes are HAPLOID
- Three chromosomes:
  1. A (autosome, type="H" for haploid)
  2. U (sex chromosome, type="W")
  3. V (sex chromosome, type="Y")
- Individuals are either AU or AV (haploid genotypes)
- All three chromosomes undergo recombination

**Pattern**:
```r
initializeSex()  # Required even for haploid sex chromosomes

ids <- 1:3
types <- c("H", "W", "Y")
symbols <- c("A", "U", "V")

for (i in 0:2) {
  initializeChromosome(ids[i], 1e7, type = types[i], symbol = symbols[i])
  initializeMutationRate(1e-7)
  initializeGenomicElement(g1)
  initializeRecombinationRate(1e-8)  # All chromosomes recombine
}
```

**Biological context**:
- Bryophytes alternate between haploid gametophyte (dominant) and diploid sporophyte
- UV chromosomes determine production of antheridia (male) vs archegonia (female)
- System evolved independently from animal sex chromosomes
- U and V are highly differentiated in some species

**Sex determination comparison**:
- **XY (mammals)**: Diploid, males XY, females XX
- **ZW (birds)**: Diploid, males ZZ, females ZW
- **UV (bryophytes)**: Haploid, one sex AU, other sex AV ← Unique!

---

#### Recipe 8.3.7: Output from multiple-chromosome models

**Purpose**: Demonstrates different output methods for multi-chromosome simulations.

**Three output methods**:
1. `outputFull()` - Complete population in SLiM format
2. `outputIndividuals()` - Subset of individuals in SLiM format
3. `outputIndividualsToVCF()` - Subset in VCF format (genomics standard)

**Pattern**:
```r
# Sample subset of individuals
inds <- p1$sampleIndividuals(5)

# Three output methods
sim$outputFull()                  # All individuals, all loci
inds$outputIndividuals()          # 5 individuals, SLiM format
inds$outputIndividualsToVCF()     # 5 individuals, VCF format
```

**Use cases**:
- Preparing data for downstream genomic analysis tools
- Sampling large populations for efficiency
- Converting to standard formats (VCF) for interoperability
- Comparing different output formats

**Note**: Uses indexed loop with 0-based indexing to create 3 chromosomes (A, X, Y).

---

### Conversion Patterns Summary (Recipe 8.3.x)

**Multiple chromosomes**:
```r
# Sequential initialization
initializeChromosome(1, length1)
# ... configure chromosome 1 ...

initializeChromosome(2, length2)
# ... configure chromosome 2 ...
```

**Indexed loop with 0-based indexing** (preferred for many chromosomes):
```r
types <- c("A", "X", "Y")
lengths <- c(1e6, 1e6, 1e6)

for (i in 0:2) {  # 0-based!
  initializeChromosome(i + 1, lengths[i], type = types[i])
  # ...
}
```

**Chromosome types**:
- `"A"` = Autosome (diploid, default)
- `"H"` = Haploid autosome
- `"X"` = X sex chromosome (diploid)
- `"Y"` = Y sex chromosome (diploid)
- `"W"` and `"Z"` = ZW sex system chromosomes

**Haploid models**:
```r
initializeChromosome(1, length, type = "H")
initializeMutationType("m1", 1.0, ...)  # h=1.0 for haploids
```

**Sex chromosomes**:
```r
initializeSex()  # Required first!

initializeChromosome(1, X_len, type = "X", symbol = "X")
# ... X configuration ...

initializeChromosome(2, Y_len, type = "Y", symbol = "Y")
# ... Y configuration (often no recombination) ...
```

---

### Testing Notes

**Runtime summary**:
- 8.3.1 (2 autosomes): ~30 seconds
- 8.3.2 (haploid clonal): ~1 minute
- 8.3.3 (haploid sexual): ~1 minute
- 8.3.4 (X/Y realistic sizes): ~7 minutes ⚠️ (large chromosomes)
- 8.3.5 (full human genome): ~2-3 minutes ⚠️ (3.1 Gb total)
- 8.3.6 (UV haploid sex): ~2 minutes
- 8.3.7 (output demo): ~5 seconds (only 100 generations)

All tests passed on first try after fixing the 0-based indexing issue in 8.3.7!

---

### Files Created This Session (8.3.x)

**Converted recipes** (7 files):
- inst/extdata/slim_recipes/converted/recipe_8_3_1.R
- inst/extdata/slim_recipes/converted/recipe_8_3_2.R
- inst/extdata/slim_recipes/converted/recipe_8_3_3.R
- inst/extdata/slim_recipes/converted/recipe_8_3_4.R
- inst/extdata/slim_recipes/converted/recipe_8_3_5.R
- inst/extdata/slim_recipes/converted/recipe_8_3_6.R
- inst/extdata/slim_recipes/converted/recipe_8_3_7.R

**Test files** (7 files):
- tests/testthat/test-recipe_8_3_1.R through test-recipe_8_3_7.R

**Updated**:
- data-raw/slim_recipes/recipe_metadata.csv (11 new rows total: 4 from 8.2.x + 7 from 8.3.x)
- claude_notes/recipe_conversion_notes.md (this comprehensive entry)

---

### Total Progress

**Recipes completed**: 54 (previously 43 + 11 new this session)
**Session breakdown**:
  - Recipe 8.2.x: 4 recipes (recombination)
  - Recipe 8.3.x: 7 recipes (multiple chromosomes)

**Completion rate**: ~57% (of ~95) or ~36% (of ~150)

**Complete series** (all tested and passing):
- ✅ Recipe 4.1, 4.2.x (7 recipes)
- ✅ Recipe 5.1.x (5 recipes)
- ✅ Recipe 5.2.x (4 recipes)
- ✅ Recipe 5.3.x (5 recipes)
- ✅ Recipe 5.4.x (2 recipes)
- ✅ Recipe 5.5.x (2 recipes)
- ✅ Recipe 6.x (4 recipes)
- ✅ Recipe 8.1.x (6 recipes)
- ✅ Recipe 8.2.x (4 recipes)
- ✅ Recipe 8.3.x (7 recipes) ← **Just completed!**

**ENTIRE RECIPE 8.x SERIES COMPLETE!** (17 recipes total)

---

### Next Steps for Future Agents

Recipe 8.x series is fully complete! Continue with:

1. **Recipe 9.x series** - Selective sweeps and adaptive evolution (15+ recipes available)
2. **Recipe 10.x series** - Selection topics (varying selection, epistasis, frequency-dependence)
3. **Recipe 11.x series** - Mating systems

Recommend starting with Recipe 9.1 (Introducing adaptive mutations) to begin the selective sweeps series.

---

### Key Insights

1. **0-based array indexing is critical**: SLiM uses 0-based indexing for arrays. When looping over indices to access arrays, use `for (i in 0:2)` not `for (i in 1:3)`.

2. **Indexed loops > parallel iteration**: Since SLiM's parallel iteration syntax (`for (a in x, b in y)`) doesn't work in R, use indexed loops with 0-based indexing.

3. **Haploid vs diploid chromosome types**: Type "H" for haploids changes genome structure and mutation expression (h=1.0 appropriate).

4. **Sex chromosomes need initializeSex()**: Must call before defining X/Y or U/V chromosomes, even for haploid sex systems.

5. **Y chromosomes typically lack recombination**: This leads to degeneration over time (Muller's ratchet).

6. **Computational scaling with genome size**: Full human genome (3.1 Gb) is manageable but slow. Consider rescaling or tree-sequences for large-scale studies.

7. **Chromosome-level modularity**: Each chromosome can have completely independent mutation rates, recombination rates, and genomic structure.

8. **VCF output available**: SLiM can output in VCF format for interoperability with genomics tools.

---

## End of Session 2025-10-24 (Recipe 8.2.x and 8.3.x series)

**Session completed**: 11 recipes converted and tested (8.2.1-8.2.4 and 8.3.1-8.3.7)
**All tests passing**: Yes ✅
**Key patterns documented**:
  - 0-based array indexing in loops (CRITICAL!)
  - Multiple chromosome initialization
  - Haploid chromosome types
  - Sex chromosome systems (XY, UV)
  - Indexed loops for clean multi-chromosome code
**Files updated**: 11 recipes, 11 tests, metadata CSV, notes
**Total progress**: 54/~95-150 recipes (~36-57%)
**Major milestone**: ENTIRE RECIPE 8.x SERIES COMPLETE (17 recipes)!

Ready for next agent to continue with Recipe 9.x (selective sweeps and adaptive evolution)!

---

## Session 2025-10-24 (Recipe 9.1 - Starting Recipe 9.x series)

### Recipe 9.1: Introducing adaptive mutations

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Foundation for selective sweep studies
2. Converted to slimr syntax following established patterns
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early/late block structure
- Property access using `$` operator (e.g., `sim$addSubpop()`, `p1$haplosomes`)
- Generation range 1000:100000 → `slim_block(1000, 100000, late(), { ... })`
- SLiM 5.x terminology: `haplosomes` (not `genomes`)

**New patterns discovered**:
None - this recipe used all previously documented patterns

**Recipe purpose**:
This is the foundation recipe for studying selective sweeps. It demonstrates:
1. How to introduce a beneficial mutation at a specific time and location
2. Using `addNewDrawnMutation()` to inject mutations programmatically
3. Tracking mutation fate with `countOfMutationsOfType()` and `substitutions`
4. The stochastic nature of selection - even beneficial mutations can be lost

**Biological insights**:
- Beneficial mutation with s=0.5 (large effect) and h=1.0 (dominant)
- Introduced in generation 1000 in a single haplosome at position 10000
- Simulation continues until mutation is either fixed or lost
- Output shows either "FIXED" or "LOST"
- Demonstrates that drift can overcome selection when mutations are rare

**Technical notes**:
- Uses `sample(p1$haplosomes, 1)` to randomly select a haplosome for mutation introduction
- Checks `sim$countOfMutationsOfType(m2) == 0` to detect when mutation is gone from segregating sites
- Checks `sum(sim$substitutions$mutationType == m2) == 1` to see if it fixed
- Range block runs from 1000 to 100000, checking every generation
- `simulationFinished()` terminates simulation early once outcome is determined

**Test results**: ✅ All tests passing (exit_status = 0, output contains FIXED or LOST)

**Recipe series context**:
This is the first recipe in the Recipe 9.x series on selective sweeps and adaptive evolution. It provides the foundation techniques that later recipes will build upon for:
- Conditional sweeps (9.2, 9.3)
- Partial sweeps (9.4)
- Soft sweeps (9.5.x)
- Standing variation (9.6.x)
- Adaptive introgression (9.7)
- Hill-Robertson interference (9.8)

Ready to continue with Recipe 9.2!

---

### Recipe 9.2: Making sweeps conditional on fixation

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Advanced sweep technique with save/restore
2. Converted to slimr syntax following established patterns
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early/late block structure
- Property access using `$` operator
- Generation range 1000:100000 → `slim_block(1000, 100000, late(), { ... })`
- SLiM 5.x terminology: `haplosomes`

**New patterns discovered**:
✅ **Save/restore simulation state pattern**:
- `getSeed()` - Get current random seed as unique identifier
- `defineConstant("simID", getSeed())` - Store seed for use in filenames
- `sim$outputFull(tempdir() + "slim_" + simID + ".txt")` - Save full simulation state
- `sim$readFromPopulationFile(...)` - Restore simulation from saved state
- `setSeed(rdunif(1, 0, asInteger(2^62) - 1))` - Generate new random seed
- Pattern guarantees fixation by restarting with different random seed if mutation lost

**Recipe purpose**:
This recipe extends 9.1 by ensuring the beneficial mutation ALWAYS reaches fixation.
The save/restore mechanism allows studying:
1. Genetic diversity patterns during sweeps
2. Hitchhiking effects on linked neutral variation
3. Sweep dynamics without worrying about loss probability
4. Expected patterns conditional on fixation

**Biological insights**:
- Even beneficial mutations (s=0.5, h=1.0) are frequently lost by drift
- Conditional analysis (given fixation) reveals different patterns than unconditional
- Save/restore lets us sample from the distribution of trajectories that reach fixation
- Important for theoretical predictions that assume fixation has occurred

**Technical notes**:
- Saves state at generation 1000 BEFORE introducing mutation
- If mutation fixes: simulation ends normally with "FIXED" message
- If mutation lost: prints "LOST - RESTARTING", reloads state, new seed, re-introduces mutation
- Restart loop continues until fixation achieved
- `tempdir()` provides temporary directory for state file
- String concatenation with `+` works in SLiM: `"slim_" + simID + ".txt"`
- `rdunif(1, 0, asInteger(2^62) - 1)` generates large random integer for seed

**Test results**: ✅ All tests passing (exit_status = 0, output always contains "FIXED")

**Comparison with Recipe 9.1**:
- 9.1: Natural outcome (FIXED or LOST)
- 9.2: Guaranteed outcome (always FIXED, may show restarts)
- Use 9.1 for fixation probability studies
- Use 9.2 for sweep dynamics studies

Ready to continue with Recipe 9.3!

---

### Recipe 9.3: Making sweeps conditional on establishment

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Conditional on establishment (not fixation)
2. Converted to slimr syntax following established patterns
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early/late block structure
- Property access using `$` operator
- ✅ **Open-ended range**: `1000:` → `slim_block(1000, .., late(), { ... })` - IMPORTANT!
- Block deregistration with `community$deregisterScriptBlock(self)`
- SLiM 5.x terminology: `haplosomes`

**New patterns discovered**:
✅ **Establishment threshold monitoring**:
- `sim$mutationsOfType(m2)` - Get mutation object(s) of specific type
- `sim$mutationFrequencies(NULL, mut)` - Calculate frequency (NULL = all populations)
- Check frequency > 0.1 for 10% establishment threshold
- `community$deregisterScriptBlock(self)` - Stop monitoring once established
- Separate end block at generation 10000 to finish simulation

**Recipe purpose**:
This recipe guarantees the beneficial mutation reaches ESTABLISHMENT (10% frequency)
rather than fixation. This is useful for:
1. Studying the period between establishment and fixation
2. Understanding sweep dynamics after the critical early phase
3. Expected time to fixation conditional on establishment
4. Genetic diversity patterns during the rise to fixation

**Biological insights**:
- Establishment (~10%) is a key milestone - mutation unlikely to be lost after this
- Early phase (0-10%) is most susceptible to drift
- Conditional on establishment ≠ conditional on fixation
- Allows studying later sweep phases without waiting for complete fixation
- More efficient than conditioning on fixation if interested in intermediate dynamics

**Technical notes**:
- Uses open-ended range `1000:` (continues until deregistered or end block)
- Checks if `size(mut) == 1` to ensure exactly one mutation of type m2 exists
- If mutation lost (`size(mut) != 1`): restart like Recipe 9.2
- If mutation frequency > 10%: print "ESTABLISHED", deregister checking block
- Block deregistration stops the checking loop once established
- Simulation continues to generation 10000 after establishment
- `mutationFrequencies(NULL, mut)` calculates frequency across all populations

**Test results**: ✅ All tests passing (exit_status = 0, output always contains "ESTABLISHED")

**Comparison with Recipes 9.1 and 9.2**:
- 9.1: Natural outcome (may fix, may be lost) - fixation probability ~2s for beneficial
- 9.2: Guaranteed fixation (100% frequency) - studies complete sweep
- 9.3: Guaranteed establishment (10% frequency) - studies partial sweep dynamics

**Use cases**:
- 9.1: Estimating fixation probability, studying loss vs fixation
- 9.2: Studying genetic diversity patterns during complete sweeps
- 9.3: Studying dynamics in establishment-to-fixation phase (faster than 9.2)

Ready to continue with Recipe 9.4!

---

### Recipe 9.4: Partial sweeps

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Partial sweep with dynamic selection change
2. Converted to slimr syntax following established patterns
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early/late block structure
- Property access using `$` operator
- Generation range 1000:10000 → `slim_block(1000, 10000, late(), { ... })`
- SLiM 5.x terminology: `haplosomes`

**New patterns discovered**:
✅ **Dynamic selection coefficient changes**:
- `mut$selectionCoeff` - Access mutation's current selection coefficient
- `mut$setSelectionCoeff(0.0)` - Change selection coefficient during simulation
- Check `mut$selectionCoeff != 0.0` to avoid redundant updates
- Pattern enables modeling changing selective pressures

**Recipe purpose**:
This recipe demonstrates a PARTIAL selective sweep where a beneficial mutation
rises to 50% frequency and then becomes neutral (s changes from 0.5 to 0.0).
This models:
1. Environmental changes that alter selection pressures
2. Epistatic interactions that modify fitness effects mid-sweep
3. Balancing selection that maintains polymorphism
4. Realistic scenarios where sweeps don't go to fixation

**Biological insights**:
- Partial sweeps are common in nature (incomplete selective sweeps)
- Leave distinctive signatures: reduced diversity near selected site but not complete loss
- Different from complete sweeps in patterns of linkage disequilibrium
- Can result from: selection relaxation, epistasis, frequency-dependent selection
- At 50%, mutation is in quasi-equilibrium - drift will determine final fate as neutral

**Technical notes**:
- Mutation introduced at generation 1000 with s=0.5
- Monitors frequency from generation 1000-10000
- When frequency >= 50%, changes s from 0.5 to 0.0
- After becoming neutral, mutation drifts (may fix, may be lost, may persist)
- Simulation ends early if mutation is lost (size(mut) == 0)
- Checks `mut$selectionCoeff != 0.0` to ensure only changes once
- No save/restore needed - accepts natural stochastic outcomes

**Test results**: ✅ All tests passing (exit_status = 0)

**Comparison with previous recipes**:
- 9.1: Natural sweep (may fix or be lost)
- 9.2: Guaranteed fixation (complete sweep)
- 9.3: Guaranteed establishment (10% threshold)
- 9.4: Partial sweep (50% then neutral) - NEW pattern!

**Use cases for partial sweeps**:
- Studying incomplete sweeps in genomic data
- Modeling temporally varying selection
- Understanding balancing selection mechanisms
- Simulating realistic sweep patterns (not all beneficial mutations fix)

**Key method**: `setSelectionCoeff()` - Can change any mutation's fitness effect during simulation

Ready to continue with Recipe 9.5.1!

---

### Recipe 9.5.1: A soft sweep from recurrent de novo mutations in a large population

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Soft sweep from recurrent mutations
2. Converted to slimr syntax following established patterns
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early block structure
- Property access using `$` operator
- Generation range 1:10000 → `slim_block(1, 10000, early(), { ... })`
- SLiM 5.x terminology: `haplosomes`

**New patterns discovered**:
✅ **Soft sweep mechanisms**:
- `m1$convertToSubstitution <- F` - Prevents mutations from being removed when reaching fixation
- `m1$mutationStackPolicy <- "f"` - First mutation at position wins (no stacking)
- `p1$haplosomes$countOfMutationsOfType(m1)` - Count mutations on each haplosome
- `p1$haplosomes$containsMutations(mut)` - Check if haplosome has specific mutation
- `sortBy(sim$mutations, "originTick")` - Sort mutations by origin generation
- `mut$originTick` - Access generation when mutation arose
- Large population (N=100,000) + high mutation rate (μ=1e-5) = recurrent mutations

**Recipe purpose**:
This recipe demonstrates a SOFT SWEEP where multiple independent beneficial
mutations at the same locus arise and all contribute to fixation. Contrasts with
hard sweeps (single origin). Key insights:
1. Multiple mutations sweep together when 2Nμ >> 1 (high mutation supply)
2. Soft sweeps preserve more genetic diversity than hard sweeps
3. Different mutations have different origin times and frequencies
4. All mutations functionally equivalent (same locus, same s value)

**Biological insights**:
- Soft sweeps common in large populations with high mutation rates
- Preserve more ancestral diversity than hard sweeps
- Leave different signatures in genome: multiple haplotypes at high frequency
- Important for detecting selection in genomic data (hard vs soft sweep signals)
- Can occur from: recurrent mutation (this recipe), standing variation, or gene flow

**Technical notes**:
- Genome is single base pair (position 0) - all mutations at same locus
- No recombination (r=0) - simplifies tracking
- Mutation rate 1e-5 (high) ensures recurrent mutations
- Population size 100,000 (large) - mutation supply 2Nμ = 2×10^5×10^-5 = 2 per generation
- Beneficial mutation: s=0.5, h=0.45 (slightly recessive)
- mutationStackPolicy="f" means first mutation wins, subsequent mutations at same position ignored
- convertToSubstitution=F keeps all mutations even after reaching 100% frequency
- Tracks when all haplosomes have at least one m1 mutation (freq==1.0)
- Reports all mutations with origin generation and current frequency
- Output shows multiple mutations from different generations contributing to sweep

**Test results**: ✅ All tests passing (exit_status = 0, shows multiple mutation origins)

**Soft sweep vs Hard sweep**:
- Hard sweep (Recipe 9.1): Single mutation, complete loss of diversity at locus
- Soft sweep (Recipe 9.5.1): Multiple mutations, preserves diversity from multiple origins
- Detection: Soft sweeps show multiple high-frequency haplotypes, hard sweeps show one

**Population genetics theory**:
- Soft sweeps likely when: 2Nμ × (selection phase duration) >> 1
- Selection phase ≈ 2/s generations for beneficial mutation
- Here: 2Nμ = 2, selection phase ≈ 4 generations, product ≈ 8 >> 1 ✓
- Multiple mutations expected to arise during selective phase

**Key properties**:
- `convertToSubstitution` - Controls whether fixed mutations are converted to substitutions
- `mutationStackPolicy` - Controls how mutations at same position interact ("f"=first, "s"=stack, "l"=last)

Ready to continue with Recipe 9.5.2!

---

### Recipe 9.5.2: A soft sweep with a fixed de novo mutation schedule

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Controlled soft sweep with fixed schedule
2. Converted to slimr syntax following established patterns
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early/late block structure
- Property access using `$` operator
- Generation ranges: 1000:1100 and 1:10000
- SLiM 5.x terminology: `haplosomes`

**New patterns discovered**:
✅ **Programmatic soft sweep mechanisms**:
- `sim$cycle %% 10 == 0` - Execute every 10th generation (R uses %% not %)
- `p1$tag` - Use population tag property to track state (number of lineages)
- `all(p1$haplosomes$countOfMutationsOfType(m2) > 0)` - Check all haplosomes have mutation
- `any(sim$substitutions$mutationType == m2)` - Check if any mutation is fixed
- Logical AND uses `&` (not `&&`) in SLiM
- `print()` function for outputting mutation frequencies

**Recipe purpose**:
This recipe demonstrates a soft sweep using a FIXED SCHEDULE for introducing mutations,
rather than relying on natural recurrent mutation. Useful for:
1. Small/medium populations where 2Nμ << 1 (recurrent mutation unlikely)
2. Controlled experiments with known number of mutation events
3. Studying hard vs soft sweep dynamics under identical conditions
4. Understanding how sweep type depends on mutation supply

**Biological insights**:
- Soft sweep vs hard sweep depends on number of successful mutation lineages
- Fixed schedule allows controlled soft sweep in small populations
- Up to 11 mutations introduced (generations 1000, 1010, 1020, ..., 1100)
- Each mutation introduced to random haplosome without existing m2 mutation
- Simulation classifies outcome: hard sweep (1 lineage), soft sweep (multiple), or failed
- Tracks lineage count throughout sweep progression

**Technical notes**:
- Population size 500 (smaller than 9.5.1)
- Standard mutation rate 1e-7 (much lower than 9.5.1)
- Mutations introduced every 10 generations from 1000-1100 (11 opportunities)
- Only adds mutation if target haplosome doesn't already have one
- p1.tag tracks number of distinct mutation lineages (updates when count changes)
- Hard sweep: One lineage reaches fixation (becomes substitution)
- Soft sweep: All haplosomes have mutation but multiple lineages persist
- Failed sweep: All mutations lost after generation 1100
- `sim$cycle %% 10 == 0` ensures mutations introduced at regular intervals
- Checks `target$countOfMutationsOfType(m2) == 0` before adding to avoid duplicates

**Test results**: ✅ All tests passing (exit_status = 0, shows sweep classification)

**Comparison with Recipe 9.5.1**:
- 9.5.1: Natural recurrent mutation (2Nμ = 2 per generation, large N=100k)
- 9.5.2: Programmatic introduction (every 10 gen, small N=500)
- 9.5.1: Relies on high mutation supply
- 9.5.2: Controlled schedule, works even when 2Nμ << 1

**Sweep classification logic**:
- Track lineage count in `p1.tag`
- Hard sweep: `any(sim$substitutions$mutationType == m2)` - one lineage fixed
- Soft sweep: `all(p1$haplosomes$countOfMutationsOfType(m2) > 0)` - all have mutation
- Failed: `p1.tag == 0 & sim.cycle > 1100` - no mutations left after introduction period

**Key insights**:
- Programmatic introduction enables soft sweep studies in any population size
- Fixed schedule provides reproducible control over mutation supply
- Can study transition from hard to soft sweeps by varying introduction frequency
- Tag property useful for tracking simulation state across generations

Ready to continue with Recipe 9.5.3!

---

### Recipe 9.5.3: A soft sweep with a random de novo mutation schedule

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Random Poisson-distributed mutation schedule
2. Converted to slimr format using slimr-ish approach (R + r_inline)
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early/late block structure
- Property access using `$` operator
- Generation range 1:10000
- SLiM 5.x terminology: `haplosomes`

**New patterns discovered - THE SLIMR-ISH WAY!**:
✅ **R + SLiM hybrid approach for data generation**:
- Generate schedule in R: `gens <- cumsum(rpois(10, 10))`
- Inject into SLiM with `r_inline()`: `defineConstant("ADD_GENS", r_inline(ADD_GENS))`
- Leverages R's capabilities for data generation/manipulation
- Uses SLiM for simulation execution
- Best of both worlds!

✅ **Additional patterns**:
- `mut$size()` - Property (not function) to check number of mutations
- `target$addMutations(mut)` - Add existing mutation to haplosome (creates identical lineages)
- `catn()` - cat() with automatic newline
- `any(ADD_GENS == sim$cycle)` - Check if current generation in schedule
- Poisson process for realistic stochastic timing

**Recipe purpose**:
This recipe demonstrates a soft sweep using a RANDOM SCHEDULE for mutation introduction
following a Poisson process. More biologically realistic than fixed intervals (9.5.2).
Key features:
1. Variable intervals between mutation events (stochastic)
2. Can add existing mutation OR create new one
3. Models realistic mutation supply under random timing
4. Demonstrates slimr's R+SLiM integration

**Biological insights**:
- Poisson process more realistic than fixed intervals for mutation events
- Can create soft sweeps with IDENTICAL mutations (via addMutations)
  - Different from 9.5.1 where each mutation is independent
- addMutations() creates lineages from same mutation (soft sweep from one mutation)
- addNewDrawnMutation() creates independent mutations (soft sweep from multiple mutations)
- This recipe can show both patterns depending on timing

**Technical notes**:
- Schedule generated in R: `cumsum(rpois(10, 10))` + alignment to start at 1000
- `cumsum()` converts intervals to absolute generations
- `rpois(10, 10)` generates 10 random intervals, mean 10 generations each
- ADD_GENS and Z defined in R, injected into SLiM with r_inline()
- Each generation, checks `any(ADD_GENS == sim$cycle)` to trigger mutation addition
- If mutation(s) already exist: adds one of them to random haplosome (addMutations)
- If no mutations exist yet: creates new one (addNewDrawnMutation)
- Multiple haplosomes can have same mutation object → soft sweep from one origin
- Sweep succeeds if any mutation becomes substitution
- Sweep fails if all mutations lost after last scheduled introduction (cycle > Z)

**Test results**: ✅ All tests passing (exit_status = 0, shows sweep outcome)

**Comparison with Recipes 9.5.1 and 9.5.2**:
- 9.5.1: Natural recurrent mutation (2Nμ >> 1, large N, high μ)
- 9.5.2: Fixed schedule (every 10 gen, small N, deterministic timing)
- 9.5.3: Random Poisson schedule (stochastic timing, small N, realistic)

**The slimr-ish approach (IMPORTANT PATTERN!)**:
1. Use R for data generation/manipulation (rpois, cumsum, min, max)
2. Use r_inline() to inject R-generated data into SLiM
3. Use SLiM for simulation execution
4. This combines R's statistical/data capabilities with SLiM's simulation engine
5. More flexible than doing everything in SLiM
6. More efficient than trying to replicate SLiM in pure R

**Key difference from original SLiM code**:
- Original: Generates schedule inside SLiM using SLiM's rpois()
- slimr version: Generates schedule in R, injects with r_inline()
- Advantage: Can manipulate schedule with R's tools before simulation
- Tradeoff: Schedule fixed when script sourced (not regenerated each run)
- Can regenerate by re-sourcing the .R file

**addMutations() vs addNewDrawnMutation()**:
- `addMutations(mut)` - Adds existing mutation object to haplosome
  - Creates soft sweep from single mutation
  - Multiple lineages of SAME mutation
- `addNewDrawnMutation(m2, pos)` - Creates new independent mutation
  - Creates soft sweep from multiple independent mutations
  - Multiple mutations at same position

Ready to continue!

---

## Session 2025-10-24 continued (Recipe 9.6.1)

### Recipe 9.6.1: A sweep from standing variation at a random locus

**Status**: Completed successfully ✅

**Conversion process**:
1. Read and understood the recipe - Standing variation selective sweep
2. Converted to slimr syntax following established patterns
3. Created test file and verified it passes
4. Updated metadata CSV
5. Appended notes to this file

**Key patterns used**:
- Standard initialize/early/late block structure
- Property access using `$` operator
- ✅ **Open-ended range**: `1000:10000` → `slim_block(1000, .., late(), { ... })`
- SLiM 5.x terminology: Not relevant (no haplosome references in this recipe)

**New patterns discovered**:
✅ **Standing variation sweep pattern**:
- Neutral burn-in period (1000 generations) to accumulate variation
- `sim$mutations` - Get all segregating mutations
- `sim$mutationFrequencies(p1, muts)` - Calculate frequencies for specific population
- Filter mutations by frequency: `muts[sim$mutationFrequencies(p1, muts) > 0.1]`
- `sample(muts, 1)` - Randomly select one qualifying mutation
- `mut$setSelectionCoeff(0.5)` - Convert neutral to beneficial in-place

**Recipe purpose**:
This recipe demonstrates a selective sweep originating from "standing variation" -
neutral genetic variation that already exists in the population. Rather than introducing
a new beneficial mutation de novo (Recipes 9.1-9.5), this model:
1. Allows neutral evolution for 1000 generations to build up standing variation
2. At generation 1000, selects a random neutral mutation with freq > 10%
3. Converts it to beneficial (s = 0.5) via setSelectionCoeff()
4. Tracks whether this mutation fixes or is lost

**Biological insights**:
- **Standing variation** = neutral alleles already present before selection acts
- Important for rapid adaptation when environment changes suddenly
- Faster to fixation than new mutations (head start from existing frequency)
- Common in: antibiotic resistance, pesticide resistance, climate change adaptation
- Examples: lactose tolerance in humans, DDT resistance in Drosophila
- Differs from:
  - Hard sweeps (new mutation, Recipe 9.1-9.4)
  - Soft sweeps (recurrent mutations, Recipe 9.5.x)
  - Standing variation sweeps have intermediate diversity patterns

**Technical notes**:
- Neutral burn-in (1000 gen) with m1 (h=1.0, s=0.0) accumulates variation
- At gen 1000 late(), filters mutations: frequency > 0.1 in p1
- If qualifying mutation exists: converts one to beneficial (s=0.5)
- If no qualifying mutation: prints "No contender" message
- Open-ended tracking block `1000:10000` checks for fixation or loss
- Checks `sum(sim$mutations$selectionCoeff) == 0.0` to detect when all beneficial mutations gone
- Then checks `sum(sim$substitutions$selectionCoeff) == 0.0`:
  - If true: mutation was lost
  - If false: mutation reached fixation (became substitution)
- Two blocks at generation 1000 late() work sequentially:
  1. First block: Sets up sweep by modifying mutation
  2. Second block: Starts tracking (runs every generation from 1000 onwards)

**Outcome possibilities**:
1. "No contender of sufficient frequency found" - No mutation > 10% at gen 1000
2. "Sweep mutation lost in cycle X" - Mutation was lost after being made beneficial
3. "Sweep mutation reached fixation" - Mutation fixed in population

**Test approach**:
- Used `result$output_file` to read SLiM output (preferred pattern per notes)
- Simple success check (exit_status = 0) as outcome is stochastic
- All three outcomes are valid depending on random chance

**Comparison with other sweep recipes**:
- Recipe 9.1: Hard sweep from new mutation (de novo at specific position)
- Recipe 9.5.x: Soft sweeps from recurrent mutations (multiple origins)
- Recipe 9.6.1: Sweep from standing variation (existing neutral allele)
- Recipe 9.6.2: Standing variation at predetermined locus (next up)

**Use cases**:
- Modeling rapid adaptation from pre-existing variation
- Studying environmental change scenarios
- Understanding genetic rescue from standing variation
- Comparing sweep signatures (standing var vs de novo)

**Key functions**:
- `sim$mutationFrequencies(pop, muts)` - Calculate frequencies in specific population
- `mut$setSelectionCoeff(s)` - Change selection coefficient in-place
- `sample(vector, n)` - Random sampling from vector
- `size(vector)` - Get length/size of vector

Ready to continue with Recipe 9.6.2!

---

## Session 2025-10-24 continued (Recipes 9.6.2 through 9.12 - COMPLETE Recipe 9.x series!)

### Recipe 9.6.2: A sweep from standing variation at a predetermined locus

**Status**: Completed successfully ✅

**Key features**:
- Combines concepts from multiple previous recipes
- Standing variation (like 9.6.1) + save/restore (like 9.2) + establishment threshold (like 9.3)
- Predetermined locus (position 10000) rather than random

**Pattern: Hybrid approach combining techniques**:
```r
# Generation 1000: Save state and introduce neutral mutation
slim_block(1000, late(), {
  sim$outputFull(tempdir() + "slim_" + simID + ".txt")
  target <- sample(p1$haplosomes, 1)
  target$addNewDrawnMutation(m2, 10000)  # Predetermined position
})

# Open-ended: Check for establishment
slim_block(1000, .., late(), {
  mut <- sim$mutationsOfType(m2)
  if (size(mut) == 1) {
    if (sim$mutationFrequencies(NULL, mut) > 0.1) {
      # Established! Convert to beneficial
      mut$setSelectionCoeff(0.5)
      community$deregisterScriptBlock(self)
    }
  } else {
    # Lost before establishment - restart
    sim$readFromPopulationFile(...)
    setSeed(rdunif(1, 0, asInteger(2^62) - 1))
    # Re-introduce mutation
  }
})
```

**Biological context**:
- Models scenario where specific locus drifts to appreciable frequency as neutral
- Environmental change makes that specific variant beneficial
- Guarantees establishment before selection begins (via restart mechanism)
- More controlled than random locus approach (9.6.1)

**Conversion notes**:
- Two open-ended ranges in same script (establishment check + fixation tracking)
- Three blocks at generation 1000: save, introduce, start checking
- Different from 9.6.1: separate mutation type (m2) rather than modifying m1

---

### Recipe 9.7: Adaptive introgression

**Status**: Completed successfully ✅

**Key concept**: Beneficial mutation spreads between populations via gene flow (migration)

**Pattern: Stepping-stone model with asymmetric migration**:
```r
slim_block(1, early(), {
  subpopCount <- 10

  # Create populations
  for (i in 1:subpopCount) {
    sim$addSubpop(i, 500)
  }

  # Asymmetric migration
  for (i in 2:subpopCount) {
    sim$subpopulations[i-1]$setMigrationRates(i-1, 0.01)  # Weak backward
  }
  for (i in 1:(subpopCount-1)) {
    sim$subpopulations[i-1]$setMigrationRates(i+1, 0.2)   # Strong forward
  }
})
```

**Important indexing note**:
- Loop uses 1-based counting for population IDs (correct for SLiM)
- `sim$subpopulations[i-1]` accesses population with ID i (0-based array indexing)
- This is different from previous patterns - population IDs are 1-based but array indices are 0-based

**Biological examples**:
- Pesticide resistance spreading through mosquito populations
- High-altitude adaptation (Denisovan alleles in modern humans)
- Disease resistance spreading in crops
- Wind-aided dispersal creating directional gene flow

**Conversion notes**:
- Asymmetric migration creates directional flow (models range expansion)
- Strong forward (0.2) vs weak backward (0.01) creates net directional movement
- Beneficial mutation introduced only in p1, spreads via migration

---

### Recipe 9.8: Fixation probabilities under Hill-Robertson interference

**Status**: Completed successfully ✅

**Key concept**: Linked beneficial mutations compete, reducing overall fixation rate

**Pattern: Comparing theory to simulation**:
```r
slim_block(6000, late(), {
  # Theoretical fixation probability
  s <- 0.05
  N <- 1000
  p_fix <- (1 - exp(-2 * s)) / (1 - exp(-4 * N * s))

  # Expected fixations
  expected <- mu * locus_size * n_gens * 2 * N * p_fix

  # Actual fixations (after burn-in)
  subs <- sim$substitutions
  actual <- sum(subs$fixationTick >= 5000)

  # Ratio shows interference strength
  cat("Ratio, actual/expected: " + (actual/expected) + "\n")
})
```

**Key insights**:
- Low recombination (1e-8) + high mutation rate (1e-6) = interference
- Actual fixations < expected (ratio < 1.0)
- Demonstrates why recombination evolves (reduces interference)
- Important for understanding limits to adaptation

**Properties used**:
- `fixationTick` - Generation when mutation fixed
- Can filter substitutions by when they occurred

**Conversion notes**:
- Straightforward single analysis block at end
- Mathematical calculations work identically in R and SLiM
- Uses sum() for counting with logical comparison

---

### Recipe 9.9: Keeping a reference to a sweep mutation

**Status**: Completed successfully ✅

**Key pattern**: Storing mutation object reference for efficient tracking

**IMPORTANT PATTERN - Mutation object references**:
```r
slim_block(1000, late(), {
  target <- sample(p1$haplosomes, 1)
  mut <- target$addNewDrawnMutation(m2, 10000)
  defineConstant("SWEEP", mut)  # Store reference!
})

slim_block(1000, 100000, late(), {
  if (!SWEEP.isSegregating) {  # Efficient checking
    cat(ifelse(SWEEP.isFixed, "FIXED\n", "LOST\n"))
    sim$simulationFinished()
  }
})
```

**Key properties**:
- `mutation.isSegregating` - TRUE if mutation is segregating (not fixed/lost)
- `mutation.isFixed` - TRUE if mutation has reached fixation
- These are **properties**, not functions (no parentheses)
- Use dot notation: `SWEEP.isSegregating` not `SWEEP$isSegregating`

**Advantages**:
1. **Performance**: No need to search each generation
2. **Clarity**: Direct reference makes intent clear
3. **Reliability**: Tracks exact mutation even if others arise at same position
4. **Access to properties**: Can check state, frequency, selectionCoeff, etc.

**Conversion notes**:
- `addNewDrawnMutation()` returns the mutation object - capture it!
- `defineConstant()` makes reference available throughout simulation
- Negation: `!SWEEP.isSegregating` means mutation no longer segregating

---

### Recipe 9.10: Tracking the fate of background mutations

**Status**: Completed successfully ✅

**Key concept**: Genetic hitchhiking - background mutations affected by selective sweep

**Pattern: Storing mutations before sweep**:
```r
slim_block(1000, late(), {
  target <- sample(p1.haplosomes, 1)
  defineConstant("BACKGROUND", target.mutations)  # Store all mutations on haplosome
  mut <- target.addNewDrawnMutation(m2, asInteger(L/2))
  defineConstant("SWEEP", mut)
})

slim_block(1500, late(), {
  # Analyze which background mutations fixed vs lost
  nonSeg <- BACKGROUND[!BACKGROUND.isSegregating]
  fixed <- nonSeg[nonSeg.isFixed]
  lost <- nonSeg[!nonSeg.isFixed]
  writeFile("fixed.txt", paste(fixed.position, sep=", "))
  writeFile("lost.txt", paste(lost.position, sep=", "))
})
```

**Logical indexing pattern**:
- `BACKGROUND[!BACKGROUND.isSegregating]` - Get non-segregating mutations
- `nonSeg[nonSeg.isFixed]` - Get fixed ones
- `nonSeg[!nonSeg.isFixed]` - Get lost ones
- Uses `!` for NOT and `&` for AND (not `&&`)

**Biological insights**:
- Selective sweeps reduce diversity at linked sites (hitchhiking)
- Neutral mutations near selected site can fix by chance (riding along)
- Creates patterns: reduced diversity, distorted frequency spectrum
- Important for detecting selection in genomic data

**Conversion notes**:
- `target.mutations` returns vector of mutation objects
- Large genome (3 Mb) to accumulate more background variation
- `writeFile()` outputs results to files
- `stop("LOST")` terminates with message if sweep lost

---

### CRITICAL DISCOVERY: slim_function() Correct Syntax

**Date**: 2025-10-24
**Impact**: Recipes 9.11 and 9.12 (and all future recipes with custom functions)

**Problem**: Curly braces `{}` syntax does NOT work with `slim_function()`

**❌ WRONG - This fails**:
```r
slim_function("(float)myFunction", c(param = "i$"), {
  result <- param * 2
  return(result)
})
# Error: Tries to evaluate as R code at script creation time
```

**✅ CORRECT - Use R function for body**:
```r
slim_function("i$ param",
             name = "myFunction",
             return_type = "f",
             body = function(param) {
               result = param * 2;
               return(result);
             })
```

**Key differences**:
1. **Parameters**: Type annotations as separate arguments: `"i$ param"`
2. **Name**: Use `name = "functionName"` parameter
3. **Return type**: Use `return_type = "f"` (or "i", "void", etc.)
4. **Body**: Pass R `function()` to `body` argument
5. **Inside function**: Use dot notation (`.`) not dollar sign (`$`)
6. **Semicolons**: Use semicolons inside function body (SLiM style)

**Multiple parameters**:
```r
slim_function("o<Subpopulation>$ subpop1", "o<Subpopulation>$ subpop2",
             name = "calculateFST",
             return_type = "f$",
             body = function(subpop1, subpop2) {
               p1_p = sim.mutationFrequencies(subpop1);
               p2_p = sim.mutationFrequencies(subpop2);
               # ... calculations ...
               return(mean(fst));
             })
```

**Optional parameters**:
```r
slim_function("o<Subpopulation>$ subpop", "[No<Chromosome>$ chromosome = NULL]",
             name = "estimateNe",
             return_type = "f",
             body = function(subpop, chromosome) {
               if (isNULL(chromosome)) {
                 # Handle default
               }
               # ... rest of function ...
             })
```

**No parameters (void function)**:
```r
slim_function("void",
             name = "updatePlot",
             return_type = "void",
             body = function(void) {
               # Function code here
             })
```

**Working example from Recipe 4.2.5** (FST calculation):
```r
slim_function("o<Subpopulation>$ subpop1", "o<Subpopulation>$ subpop2",
             name = "calculateFST",
             return_type = "f$",
             body = function(subpop1, subpop2) {
               p1_p = sim.mutationFrequencies(subpop1);
               p2_p = sim.mutationFrequencies(subpop2);
               mean_p = (p1_p + p2_p) / 2.0;
               H_t = 2.0 * mean_p * (1.0 - mean_p);
               H_s = p1_p * (1.0 - p1_p) + p2_p * (1.0 - p2_p);
               fst = 1.0 - H_s/H_t;
               fst = fst[isFinite(fst)];
               return(mean(fst));
             })
```

**CRITICAL**: This discovery documented in `claude_notes/slimr_development_notes.md` for maintainer review.

---

### Recipe 9.11: Effective population size versus census population size

**Status**: Completed successfully ✅ (after fixing slim_function() syntax)

**Key concept**: Estimating Ne from simulation data, comparing to census size N

**Custom functions (using correct slim_function() syntax)**:

**1. Calculate mutation type frequency**:
```r
slim_function("o<MutationType>$ mutType",
             name = "mutTypeFrequency",
             return_type = "f",
             body = function(mutType) {
               muts = sim.mutationsOfType(mutType);
               if (muts.size() > 0)
                 return(sim.mutationFrequencies(NULL, muts));
               return(NULL);
             })
```

**2. Estimate Ne from heterozygosity**:
```r
slim_function("o<Subpopulation>$ subpop", "[No<Chromosome>$ chromosome = NULL]",
             name = "estimateNe_Heterozygosity",
             return_type = "f",
             body = function(subpop, chromosome) {
               if (isNULL(chromosome)) {
                 if (size(sim.chromosomes) == 1) {
                   chromosome = sim.chromosomes;
                 } else {
                   stop("ERROR: in a multi-chrom model, a chromosome must be supplied.");
                 }
               }
               haplosomes = subpop.haplosomesForChromosomes(chromosome, includeNulls=F);
               pi = calcHeterozygosity(haplosomes);
               return(pi / (4 * MU));
             })
```

**3. Estimate Ne from inbreeding/offspring variance**:
```r
slim_function("o<Subpopulation>$ subpop",
             name = "estimateNe_Inbreeding",
             return_type = "f",
             body = function(subpop) {
               previous_N = subpop.getValue("previous_N");
               k = tabulateFecundity(subpop, previous_N);
               return((previous_N * mean(k) - 2) / (mean(k) - 1 + var(k) / mean(k)));
             })
```

**Key requirements**:
- `initializeSLiMOptions(keepPedigrees=T)` - Required for pedigree tracking
- `defineGlobal()` - Makes parameters accessible in custom functions
- LogFile with custom columns using Eidos expressions as strings

**Biological insights**:
- Ne usually < N in real populations
- During sweeps: Ne temporarily reduced (increased drift at linked sites)
- Two estimation methods give different Ne values
- Important for conservation and parameter estimation

**Conversion notes**:
- Must use R function body for custom functions (not curly braces)
- Need curly braces around if/else blocks inside function body
- Use dot notation inside functions: `sim.mutations` not `sim$mutations`
- Large genome (10 Mb) and long runtime (20k generations)

---

### Recipe 9.12: Observing the site frequency spectrum (SFS) during selective sweeps

**Status**: Completed successfully ✅ (after fixing slim_function() syntax)

**Key concept**: SFS shows distribution of allele frequencies, distorted by selective sweeps

**Custom function (using correct syntax)**:
```r
slim_function("void",
             name = "updatePlot",
             return_type = "void",
             body = function(void) {
               if (exists("slimgui")) {
                 sfs_all = calcSFS(BINCOUNT);
                 sfs_m2 = calcSFS(BINCOUNT, muts=sim.mutationsOfType(m2));
                 x = seq(from=0.0, to=1.0, length=BINCOUNT+1) + 0.5/BINCOUNT;
                 x = x[0:(length(x)-2)];

                 # SLiMgui plotting code...
                 plot = slimgui.createPlot(...);
                 plot.lines(...);
                 # etc.
               }
             })
```

**For void functions (no parameters)**:
- Still need to specify one parameter: `"void"`
- Function signature: `function(void) { ... }`
- This generates: `function (void)updatePlot() { ... }` in SLiM

**IMPORTANT NOTE - SLiMgui plotting**:
- `exists("slimgui")` checks if running in GUI
- Plotting code only works in SLiMgui (interactive mode)
- Simulation runs fine in non-GUI mode (slim_run), just no plots generated
- Wrap all GUI-specific code in `if (exists("slimgui")) { ... }`

**SFS patterns**:
- Neutral SFS: proportional to 1/i (many rare, few common)
- During sweeps: excess rare variants, deficit mid-frequency
- Sweep-specific (m2): shows mutations under selection

**Conversion notes**:
- Two initialize() blocks (both run during initialization)
- Uses `calcSFS()` built-in function
- Arithmetic in generation numbers: 20*N, 25*N, 35*N work fine
- setMutationFractions() changes mutation type proportions dynamically

---

## Summary: Recipe 9.x Series COMPLETE!

**Total recipes**: 15 (all passing ✅)
- 9.1-9.4: Hard sweeps (basic, conditional, partial)
- 9.5.1-9.5.3: Soft sweeps (recurrent, fixed schedule, random schedule)
- 9.6.1-9.6.2: Standing variation sweeps
- 9.7: Adaptive introgression
- 9.8: Hill-Robertson interference
- 9.9: Mutation references
- 9.10: Genetic hitchhiking
- 9.11: Effective population size
- 9.12: Site frequency spectrum

**Key patterns added to library**:
1. ✅ **slim_function() correct syntax** - Use R function body (CRITICAL!)
2. ✅ Standing variation sweeps - setSelectionCoeff() on existing mutations
3. ✅ Adaptive introgression - Asymmetric migration models
4. ✅ Mutation object references - defineConstant() + isSegregating/isFixed
5. ✅ Logical indexing - `vector[!vector.isSegregating]`
6. ✅ Custom Eidos functions - Proper parameter/return type syntax
7. ✅ SLiMgui detection - `exists("slimgui")` check
8. ✅ Pedigree tracking - keepPedigrees=T option
9. ✅ Theoretical predictions - Comparing simulation to theory

**Complete series so far**:
- ✅ Recipe 4.x (7 recipes)
- ✅ Recipe 5.x (17 recipes)
- ✅ Recipe 6.x (4 recipes)
- ✅ Recipe 8.x (17 recipes)
- ✅ Recipe 9.x (15 recipes) ← **Just completed!**

**Total**: 60 recipes completed and tested!

---

## Session 2025-10-25 (Recipe 10.x series - Selection topics)

### Summary

Completed ENTIRE Recipe 10.x series (12 recipes total):
- 10.1 - Temporally varying selection
- 10.2 - Spatially varying selection
- 10.3.1 I & II - Epistasis (gene interactions)
- 10.4.1 I, II, III - Frequency-dependent selection (balancing, positive, with dominance)
- 10.4.2 - Cultural effects on fitness (gene-culture coevolution)
- 10.4.3 - Kin selection and green-beard effect
- 10.5 - Changing selection coefficients with setSelectionCoeff()
- 10.6 I & II - Varying dominance coefficients

All 12 tests passing!

### Key Patterns Discovered

#### 1. **Float vs Integer in Return Statements** ⭐ CRITICAL!
**Issue**: In mutationEffect() callbacks, returning numeric values without explicit type causes errors.
**Solution**: Always use `asFloat()` to ensure float returns.
```r
# ❌ WRONG - causes "incorrect type" error
slim_block(mutationEffect(m2), {
  return(1.0)  # R may convert to integer in SLiM!
})

# ✅ CORRECT
slim_block(mutationEffect(m2), {
  return(asFloat(1.0))  # Explicitly float
})
```
**Examples**: Recipe 10.1, 10.2, 10.4.2

#### 2. **Numeric Literals Lose Decimal Points** ⭐ CRITICAL!
**Issue**: Numeric literals like `100.0` and `10.0` get converted to `100` and `10`, causing type mismatches.
**Solution**: Use `asFloat()` to explicitly maintain float type.
```r
# ❌ WRONG - generates min(floor(...), 10) - type mismatch!
d <- asInteger(min(floor(abs(s) * 100.0), 10.0))

# ✅ CORRECT
d <- asInteger(min(floor(abs(s) * asFloat(100)), asFloat(10)))
```
**Example**: Recipe 10.6 II

#### 3. **mutationEffect() Callbacks**
**Pattern**: Callbacks for modifying fitness effects of specific mutations.
**Syntax**: `slim_block([gen_range,] mutationEffect(mut_type[, subpop]), { ... })`
**Available variables**: `mut`, `effect`, `homozygous`, `individual`

#### 4. **Epistasis (Gene Interactions)**
**Pattern**: Fitness effect of one mutation depends on presence of others.
**Key function**: `countOfMutationsOfType(type)` checks for presence.
**Important**: Set `convertToSubstitution = F` to maintain detection after fixation.

#### 5. **Frequency-Dependent Selection**
**Pattern**: Fitness depends on allele frequency in population.
**Key function**: `sim$mutationFrequencies(pop, mut)` returns frequency.
**Types**: Negative (balancing) and positive (runaway) frequency dependence.

#### 6. **Gene-Culture Coevolution**
**Pattern**: Cultural traits (stored in tags) affect fitness of genetic mutations.
**Example**: Recipe 10.4.2 (lactase persistence)

#### 7. **Green-Beard Effect (Kin Selection)**
**Pattern**: Alleles that recognize and help copies of themselves.
**Components**: Recognition + preferential treatment.

#### 8. **setSelectionCoeff() vs mutationEffect()**
**Alternative approach**: Modify selection coefficients directly.
**When to use**: When coefficient should persist across evaluations.

#### 9. **Parallel Iteration Conversion** ⭐ IMPORTANT!
**Pattern**: SLiM's `for (x in A, y in B)` doesn't work in R.
**Solution**: Convert to indexed loop with `seqAlong()`.

#### 10. **mutation() Callbacks**
**Pattern**: Called when mutations arise.
**Uses**: Initialize per-mutation values, reassign types.
**Must return**: `T` to accept mutation.

#### 11. **Varying Dominance Coefficients**
**Two approaches**: setValue/getValue OR multiple mutation types with reassignment.

#### 12. **Tag Properties for Fitness Tracking**
**Pattern**: Use `tag` (numeric) or `tagL0` (logical) for individual-specific values.

### Files Created This Session

**Converted recipes** (12 files):
- inst/extdata/slim_recipes/converted/recipe_10_1.R through recipe_10_6_II.R

**Test files** (12 files):
- tests/testthat/test-recipe_10_1.R through test-recipe_10_6_II.R

**Total recipes completed**: 72 (60 from previous sessions + 12 this session)

### Next Steps for Future Agents

Continue with Recipe 11.x series (mating systems)

---

## Summary: Recipe 10.x Series COMPLETE!

**Total recipes**: 12 (all passing ✅)

**Key patterns added**:
1. ✅ asFloat() for return values (CRITICAL)
2. ✅ Numeric literal preservation
3. ✅ mutationEffect() callbacks
4. ✅ Epistasis patterns
5. ✅ Frequency-dependent selection
6. ✅ Gene-culture coevolution
7. ✅ Green-beard effect
8. ✅ setSelectionCoeff() alternative
9. ✅ Parallel iteration conversion
10. ✅ mutation() callbacks
11. ✅ Dominance variation
12. ✅ Tag-based fitness

**Complete series**: 4.x, 5.x, 6.x, 8.x, 9.x, 10.x ← **Just completed!**

**Total**: 72 recipes completed and tested!

---

---

## Session 2025-10-25 (Recipe 11.x series - Mating systems)

Converted ENTIRE Recipe 11.x series (4 recipes): 11.1, 11.2 I, 11.2 II, 11.3.
All tests passing!

CRITICAL NEW PATTERN: ifelse() Type Consistency with asFloat()
- Issue: SLiM ifelse() requires same types. Slimr drops decimal points (2.0 -> 2).
- Solution: ifelse(cond, asFloat(0.5), asFloat(1)) - wrap each value individually
- Example from Recipe 11.1: weights calculation for assortative mating

New Callback Patterns:
1. mateChoice() - returns modified weights OR selected mate OR float(0) for failure
2. modifyChild() - returns T (accept) or F (reject), accesses child/parent genomes

Mating System Patterns:
1. Assortative mating - tag individuals, precalculate weights, apply in mateChoice
2. Sequential mate search - loop through mates, accept based on quality/attempt
3. GSI (plant incompatibility) - modifyChild checks pollen-style S-allele match

SLiM 5.x: haploidGenome1/haploidGenome2 (not genome1/genome2)
Tag caching: Store computed values in tagF to avoid recalculation

Files: 4 recipes, 4 tests. Total completed: 76 recipes.

---


---

## Session 2025-10-25 (12.x series - Starting Recipe 12.1)

**Recipes completed this session**: 1 (Recipe 12.1)
**Total recipes completed**: 77
**Test status**: PASS ✅

### Recipe 12.1: Social learning of cultural traits

**Topic**: Gene-culture coevolution with non-genetic inheritance

**Key features**:
- Social transmission of cultural traits (milk drinking behavior)
- Cultural trait stored in tagL0 (logical tag)
- Probabilistic cultural transmission via modifyChild() callback
- Genetic mutation (lactase-promoting) with conditional fitness based on culture
- Demonstrates how culture can drive genetic evolution

**Biological concept**:
Models lactase persistence evolution in human populations with dairy farming traditions. Cultural practice (drinking milk) creates selection pressure for genetic adaptation (lactase enzyme production in adults).

**Implementation details**:
1. **Cultural trait initialization**: Population starts with 50% milk-drinkers (tagL0 = T/F)
2. **Social learning mechanism**: 
   - Children learn from both parents via modifyChild() callback
   - Probabilistic transmission: `runif(1) < 0.1 + 0.8 * mean(parent_cultures)`
   - Baseline 10% chance + 80% weighted by parental cultures
   - Cultural trait is NOT genetically inherited

3. **Mutation types**:
   - m1: neutral (s=0.0)
   - m2: lactase-promoting with convertToSubstitution=F

4. **Conditional fitness**:
   - mutationEffect(m2) callback checks individual.tagL0
   - If milk-drinker: returns effect (s=0.1, beneficial)
   - If non-milk-drinker: returns 1.0 (neutral)
   - Same genetic mutation has different fitness in different cultural contexts

**Callbacks used**:
- `modifyChild()`: Implements social learning of cultural trait
- `mutationEffect(m2)`: Makes genetic mutation conditionally beneficial

**Conversion patterns confirmed**:
1. ✅ tagL0 for logical tag storage (cultural trait)
2. ✅ modifyChild() callback with parent1, parent2, child variables
3. ✅ mutationEffect(mutation_type) callback with individual, effect variables
4. ✅ asFloat() wrapper for numeric return values (asFloat(1.0))
5. ✅ convertToSubstitution property to prevent beneficial mutations from converting

**Key insights**:
- Cultural transmission is environmental, not genetic
- Culture can create selection pressure for genetic change
- Same allele can be beneficial or neutral depending on cultural context
- Social learning rate (0.1 + 0.8×parents) creates high cultural heritability
- Gene-culture coevolution requires both modifyChild() (culture) and mutationEffect() (fitness) callbacks

**Testing**: Test passes successfully. Recipe runs for 10000 generations with social learning and conditional selection.

**Files created**:
- `inst/extdata/slim_recipes/converted/recipe_12_1.R`
- `tests/testthat/test-recipe_12_1.R`
- Updated `data-raw/slim_recipes/recipe_metadata.csv`


---

## Session 2025-10-25 (12.x series - Recipes 12.1, 12.2 I/II, 12.3)

**Recipes completed this session**: 4 (Recipes 12.1, 12.2 I, 12.2 II, 12.3)
**Total recipes completed**: 81
**Test status**: ALL PASS ✅

### Summary of Recipes

#### Recipe 12.1: Social learning of cultural traits
**Topic**: Gene-culture coevolution with non-genetic inheritance
**Key pattern**: Cultural trait (milk drinking) transmitted socially via modifyChild(), genetic mutation (m2) conditionally beneficial based on culture
**Callbacks**: modifyChild() for social learning, mutationEffect(m2) for conditional fitness

#### Recipe 12.2 I: Lethal epistasis I  
**Topic**: Lethal interaction between two beneficial mutations
**Key pattern**: any() checks presence of mutations, modifyChild() returns F if both present
**Models**: Dobzhansky-Muller incompatibilities

#### Recipe 12.2 II: Lethal epistasis II
**Topic**: Dosage-dependent lethal epistasis
**Key pattern**: sum() counts mutation copies (0-2), only double homozygotes lethal
**Difference from 12.2 I**: Double heterozygotes can survive

#### Recipe 12.3: Simulating gene drive
**Topic**: CRISPR gene drive with homing mechanism
**Key patterns**: 
- Homing via modifyChild() converting heterozygotes to homozygotes
- Spatially varying fitness via mutationEffect()
- containsMutations() and addMutations() for gene drive mechanics

### Critical New Patterns Discovered

#### 71. **Method chaining requires $ not . in R context** ⭐ CRITICAL!

**Problem**: When chaining SLiM method calls after R functions, using `.` causes R parse errors.

```r
# ❌ WRONG - R parser error
sample(p1.haplosomes, 20).addNewDrawnMutation(m2, 10000)
# Error: unexpected symbol at .addNewDrawnMutation

# ✅ CORRECT - Use $ for chaining
sample(p1$haplosomes, 20)$addNewDrawnMutation(m2, 10000)
```

**Why**: In R, when you have a chained expression like `sample().addNewDrawnMutation()`, the R parser gets confused because `sample()` is an R function returning a result, and `.addNewDrawnMutation` looks like a separate incomplete statement. Using `$` tells R this is object property/method access.

**Rule**: 
- Within slim_block(), `.` can be used for SLiM property access when it's standalone
- But for **method chaining** (calling methods on return values), use `$`
- Safe default: **always use `$`** for property and method access in slimr

#### 72. **Dosage counting with sum() vs presence checking with any()**

Two approaches for checking mutations in modifyChild():

```r
# Presence/absence (any copy):
hasMut <- any(child$haplosomes$countOfMutationsOfType(m2) > 0)

# Dosage counting (how many copies):
mutCount <- sum(child$haplosomes$countOfMutationsOfType(m2))  # 0, 1, or 2
```

**Use cases**:
- `any()`: Check if mutation present at all (Recipe 12.2 I)
- `sum()`: Count copies for dosage-dependent effects (Recipe 12.2 II)

#### 73. **Gene drive homing mechanism pattern**

Implementing CRISPR/MCR gene drive:

```r
slim_block(modifyChild(), {
  mut <- sim$mutationsOfType(m2)
  
  if (size(mut) == 1) {
    # Check which chromosomes carry the drive
    hasMutOnChromosome1 <- child$haploidGenome1$containsMutations(mut)
    hasMutOnChromosome2 <- child$haploidGenome2$containsMutations(mut)
    
    # Homing: convert heterozygotes to homozygotes
    if (hasMutOnChromosome1 & !hasMutOnChromosome2) {
      child$haploidGenome2$addMutations(mut)  # copy to chr2
    } else if (hasMutOnChromosome2 & !hasMutOnChromosome1) {
      child$haploidGenome1$addMutations(mut)  # copy to chr1
    }
  }
  
  return(T)
})
```

**Key functions**:
- `containsMutations(mut)`: Check if haplosome contains specific mutation object
- `addMutations(mut)`: Copy mutation to another haplosome
- Implements super-Mendelian inheritance (>50% transmission)

#### 74. **Spatially varying fitness with subpop.id**

```r
slim_block(mutationEffect(m2), {
  # Fitness varies by population ID
  return(asFloat(1.5 - subpop.id * 0.15))
  # p0: 1.5, p1: 1.35, p2: 1.2, ..., p5: 0.75
})
```

Creates fitness gradients across metapopulations.

#### 75. **Source/sink dynamics with asymmetric migration**

```r
# Weak backward migration (upstream, against gradient)
for (i in 1:5) {
  sim$subpopulations[i]$setMigrationRates(i - 1, 0.001)
}

# Strong forward migration (downstream, with gradient)  
for (i in 0:4) {
  sim$subpopulations[i]$setMigrationRates(i + 1, 0.1)
}
```

Models directionality in gene flow (e.g., wind dispersal, river flow).

#### 76. **Reading output from result$output_file** ⭐

For recipes that output to stdout (like cat() or print()), the output goes to result$output_file:

```r
# Check output_file first, fallback to output
if (!is.null(result$output_file) && file.exists(result$output_file)) {
  output_text <- paste(readLines(result$output_file), collapse = "\n")
} else {
  output_text <- result$output
}
expect_true(grepl("FIXED|LOST", output_text))
```

**Pattern**: Always check `result$output_file` for cat() / print() output from SLiM scripts.

### Conversion Patterns Confirmed

1. ✅ modifyChild() for offspring modification (social learning, lethality, homing)
2. ✅ mutationEffect(mutation_type) for conditional/spatial fitness
3. ✅ countOfMutationsOfType() + any() for presence
4. ✅ countOfMutationsOfType() + sum() for dosage
5. ✅ haploidGenome1/haploidGenome2 (SLiM 5.x, not genome1/genome2)
6. ✅ containsMutations() and addMutations() for gene drive
7. ✅ $ for method chaining in R context (CRITICAL!)
8. ✅ asFloat() for numeric return values from callbacks
9. ✅ Fallback pattern in tests for development vs installed package
10. ✅ Read output from result$output_file for cat() statements

### Key Insights

**Gene-culture coevolution**: Culture can drive genetic evolution by changing fitness landscapes. Cultural transmission is faster than genetic but less stable.

**Epistasis types**: 
- **Any-any epistasis** (12.2 I): Presence of both mutations lethal
- **Homozygous epistasis** (12.2 II): Only double homozygotes lethal
- Allows modeling different genetic architectures

**Gene drive dynamics**: Can spread even if deleterious because:
- Homing gives super-Mendelian inheritance
- Can be locally beneficial
- Migration carries into sink populations
- Spatial variation in fitness affects spread

**Method chaining**: R parsing vs SLiM execution - need to use R syntax ($) for chaining even though it converts to SLiM (.) in output.

### Files Created

- `inst/extdata/slim_recipes/converted/recipe_12_1.R`
- `inst/extdata/slim_recipes/converted/recipe_12_2_I.R`
- `inst/extdata/slim_recipes/converted/recipe_12_2_II.R`
- `inst/extdata/slim_recipes/converted/recipe_12_3.R`
- Corresponding test files in `tests/testthat/`
- Updated `data-raw/slim_recipes/recipe_metadata.csv`

### Remaining Recipe 12.x Series

- Recipe 12.4 - Suppressing hermaphroditic selfing
- Recipe 12.5 - Tracking separate sexes in script

**Next session**: Continue with Recipe 12.4 and 12.5, then move to Recipe 13.x series (quantitative traits).


---

## Session 2025-10-25 (12.x series COMPLETION - Recipes 12.4, 12.5)

**Recipes completed this session**: 2 (Recipes 12.4, 12.5)
**Total recipes in this full session**: 6 (12.1, 12.2 I/II, 12.3, 12.4, 12.5)
**Total recipes completed overall**: 83
**Test status**: ALL PASS ✅
**MILESTONE**: ENTIRE RECIPE 12.x SERIES COMPLETE! (6/6)

### Summary of Final 12.x Recipes

#### Recipe 12.4: Suppressing hermaphroditic selfing
**Topic**: Preventing self-fertilization in hermaphroditic models
**Key pattern**: modifyChild() with parent identity check (parent1 == parent2)
**IMPORTANT**: This recipe is **OBSOLETE** - included for educational purposes only

**Modern approach (recommended)**:
```r
slim_block(initialize(), {
  initializeSLiMOptions(preventIncidentalSelfing=T)
  # Much faster than callback approach!
})
```

**Old approach (this recipe, for education)**:
```r
slim_block(modifyChild(), {
  if (parent1 == parent2) return(F)  # reject selfing
  return(T)
})
```

#### Recipe 12.5: Tracking separate sexes in script
**Topic**: Manual sex tracking using tags instead of built-in sex model
**Key patterns**:
- tagL0 for sex: F = female, T = male
- repEach(c(F,T), 250) to create 250 of each sex
- Same-sex mating prohibition: parent1$tagL0 == parent2$tagL0
- Random sex assignment: child$tagL0 <- (runif(1) <= 0.5)
- Sex ratio tracking: mean(tagL0) = proportion males

**Use cases**: Custom sex determination, Wolbachia modeling, environmental sex determination

### Critical New Patterns Discovered

#### 77. **Obsolete recipes and modern alternatives** ⭐

Some recipes demonstrate historical approaches now superseded by better methods:

**Recipe 12.4 pattern**:
```r
# ❌ OLD (slow, but works): modifyChild() callback
slim_block(modifyChild(), {
  if (parent1 == parent2) return(F)
  return(T)
})

# ✅ NEW (fast, recommended): configuration flag
slim_block(initialize(), {
  initializeSLiMOptions(preventIncidentalSelfing=T)
})
```

**When to use old approach**: Educational purposes, understanding mechanisms, implementing complex rules beyond simple selfing prevention.

**Documentation strategy**: Show both approaches, clearly mark old as obsolete, explain why new is better.

#### 78. **Manual sex tracking with tags**

Alternative to `initializeSex()` for custom sex determination:

```r
# Initialize sexes manually
p1$individuals$tagL0 <- repEach(c(F, T), 250)  # 250 F, 250 T

# Enforce separate sexes
slim_block(modifyChild(), {
  # Prohibit same-sex mating
  if (parent1$tagL0 == parent2$tagL0) return(F)
  
  # Assign child sex randomly
  child$tagL0 <- (runif(1) <= 0.5)  # 50% male
  
  return(T)
})

# Track sex ratio
mean(p1$individuals$tagL0)  # proportion male (T=1, F=0)
```

**Comparison**:
- **Built-in sex** (`initializeSex()`): Faster, integrates with sex chromosomes, standard
- **Tag-based sex** (this recipe): Flexible, allows custom rules, models non-standard systems

#### 79. **repEach() for creating repeated patterns**

```r
# repEach(values, counts)
repEach(c(F, T), 250)
# Creates: F,F,F,...,F (250 times), T,T,T,...,T (250 times)

# Compare with rep():
rep(c(F, T), 250)  # Creates: F,T,F,T,F,T,... (alternating 250 times)
rep(c(F, T), each=250)  # Same as repEach(c(F,T), 250)
```

**Use**: Creating groups with specific compositions (sexes, genotypes, spatial positions).

#### 80. **Parent identity checking in modifyChild()**

```r
# Check if parents are same individual
if (parent1 == parent2) {
  return(F)  # reject selfed offspring
}

# Check if parents are same sex
if (parent1$tagL0 == parent2$tagL0) {
  return(F)  # reject same-sex mating
}
```

Available in modifyChild():
- `parent1`: First parent individual
- `parent2`: Second parent individual  
- `child`: Offspring individual
- Can compare identity, properties, or tags

### Recipe 12.x Series Complete Summary

**Total recipes in series**: 6
**Topics covered**:
1. Gene-culture coevolution (social learning)
2. Epistasis (lethal interactions, any-any and dosage-dependent)
3. Gene drive (CRISPR homing mechanism)
4. Selfing suppression (obsolete callback approach)
5. Manual sex tracking (tag-based alternative to built-in sex)

**Key callbacks used**:
- `modifyChild()`: Offspring acceptance/rejection, trait assignment, homing
- `mutationEffect()`: Conditional and spatially varying fitness
- `mateChoice()`: (not in 12.x but related to mating control)

**Major themes**:
- Non-genetic inheritance and culture
- Genetic incompatibilities and speciation
- Super-Mendelian inheritance systems
- Flexible alternatives to built-in models
- Custom mating rules and sex determination

### Conversion Patterns Confirmed

1. ✅ parent1 and parent2 available in modifyChild()
2. ✅ Identity comparison: parent1 == parent2
3. ✅ Property comparison: parent1$tagL0 == parent2$tagL0
4. ✅ repEach() for creating repeated groups
5. ✅ tagL0 for boolean/sex tracking (F=0, T=1)
6. ✅ mean(tagL0) for proportion calculation
7. ✅ initializeSLiMOptions() for configuration flags
8. ✅ Documentation of obsolete patterns with modern alternatives

### Key Insights

**Selfing suppression**: Modern SLiM provides efficient built-in method. Old callback approach still works but much slower. Include both for educational value but clearly mark which is current best practice.

**Manual vs built-in sex**: Tag-based sex tracking offers maximum flexibility for non-standard sex determination systems (e.g., temperature-dependent, haplodiploidy, Wolbachia distortion). Built-in sex model faster for standard XY/ZW systems.

**Parent access in callbacks**: modifyChild() provides powerful control over offspring via parent1, parent2, and child objects. Can implement arbitrary mating rules, trait inheritance, or offspring modifications.

**Method chaining caveat** (from earlier in session): Remember to use `$` not `.` after R function calls like sample().

### Files Created

- `inst/extdata/slim_recipes/converted/recipe_12_4.R`
- `inst/extdata/slim_recipes/converted/recipe_12_5.R`
- `tests/testthat/test-recipe_12_4.R`
- `tests/testthat/test-recipe_12_5.R`
- Updated `data-raw/slim_recipes/recipe_metadata.csv`

### Recipe 12.x Series Status

**COMPLETE!** All 6 recipes in Recipe 12.x series have been converted, tested, and documented:
- 12.1 ✅ Social learning
- 12.2 I ✅ Lethal epistasis I
- 12.2 II ✅ Lethal epistasis II
- 12.3 ✅ Gene drive
- 12.4 ✅ Selfing suppression (obsolete)
- 12.5 ✅ Manual sex tracking

**Next series**: Recipe 13.x (Quantitative traits - polygenic selection, QTL models, heritability)

