# SLiM Recipe Conversion Project Plan

**Created:** 2025-10-21
**Updated:** 2025-10-23
**Purpose:** Convert all SLiM official recipes to slimr format with comprehensive documentation

---

## Quick Start for Agents

**TL;DR** - You're converting SLiM recipes to slimr format. Here's what you need to know:

**📖 Recommended reading order:**

1. **THIS FILE** (`RECIPE_CONVERSION_PLAN.md`) - You're here! Understand the overall process ⭐
2. **`RECIPE_CONVERSION_GUIDE.md`** - Essential conversion patterns and solutions (concise reference) ⭐ START HERE FOR PATTERNS
3. **`CURRENT_STATUS.md`** - Current progress and what to work on next

The guide contains critical patterns (like `..` for open-ended ranges, asFloat() for callbacks, 0-based indexing, etc.) that will save you time and ensure consistency!

**Optional**: `recipe_conversion_notes.md` contains detailed historical session notes if you need more context.

---

**Workflow per recipe:**

1. **Find work**: Check `inst/extdata/slim_recipes/original/` for recipes without corresponding files in `inst/extdata/slim_recipes/converted/`
2. **Convert**: Read recipe → Understand purpose → Convert to slimr → Store original as attribute
3. **Test**: Create test file in `tests/testthat/test-recipe_X_Y.R` and **RUN IT** with `TEST_RECIPES=true`
4. **Document**: Write description in recipe header comments
5. **⭐ CRITICAL - DO NOT SKIP**:
   - Update `data-raw/slim_recipes/recipe_metadata.csv` for EVERY recipe (REQUIRED!)
   - At end of session: Review what you learned, update conversion guide if needed (REQUIRED!)
6. **Key rule**: Understand the recipe's purpose and maintain its spirit - don't change what it demonstrates

**⚠️ REMINDER**: Steps 1-5 are NOT optional. Metadata updates are how we track progress!

**Files per recipe**:
- Input: `inst/extdata/slim_recipes/original/Recipe X.Y - Title.txt`
- Output 1: `inst/extdata/slim_recipes/converted/recipe_X_Y.R` (with `library(slimr)` and original as attribute)
- Output 2: `tests/testthat/test-recipe_X_Y.R`
- **⭐ REQUIRED**: `data-raw/slim_recipes/recipe_metadata.csv` (add row for EACH recipe!)
- **⭐ REQUIRED at session end**: Review session, update `claude_notes/RECIPE_CONVERSION_GUIDE.md` if NEW patterns found

### Quick Start Commands (Copy-Paste Ready)

**IMPORTANT**: Use Glob tool for file listing, NOT bash dir/ls commands on Windows!

**1. Check what's already done:**
```
Use Glob tool with patterns:
- inst/extdata/slim_recipes/original/Recipe*.txt
- inst/extdata/slim_recipes/converted/recipe_*.R
- tests/testthat/test-recipe_*.R
```

**2. Find unconverted recipes** (use R via Bash tool):
```r
Rscript -e "
orig <- list.files('inst/extdata/slim_recipes/original', pattern = '^Recipe.*\\.txt$')
conv <- list.files('inst/extdata/slim_recipes/converted', pattern = '^recipe_.*\\.R$')
cat('Total original recipes:', length(orig), '\n')
cat('Converted recipes:', length(conv), '\n')
cat('Remaining:', length(orig) - length(conv), '\n')
"
```

**3. Set SLIM_PATH** (Windows, adjust for your system):
```r
Sys.setenv(SLIM_PATH = 'C:/Users/USERNAME/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe')
```

**4. Test a converted recipe**:
```bash
Rscript -e "Sys.setenv(TEST_RECIPES='true'); Sys.setenv(SLIM_PATH='C:/Users/dinnage/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe'); devtools::load_all('.'); testthat::test_file('tests/testthat/test-recipe_X_Y.R')"
```

**It's okay to give up** after 15-30 min on a difficult recipe - document it and move on.

### Common Conversion Patterns (Quick Reference)

Before you start, review these patterns discovered during conversion:

1. **Property access**: `.` can stay OR use `$` (stylistic - dots pass through to SLiM, but `$` is more R-like)
2. **Generation ranges**: `1000:1099` → `slim_block(1000, 1099, ...)` (REQUIRED)
3. **Open-ended ranges**: `1000:` → `slim_block(1000, .., ...)` using special `..` symbol (REQUIRED)
4. **Empty blocks**: Must have `NULL` statement, not just comments (REQUIRED)
5. **SLiM 5.x**: Use `haplosomes` not `genomes` (REQUIRED for v5)
6. **Output in tests**: Read `result$output_file`, don't use `capture_output = TRUE` (preferred)
7. **LogFile custom columns**: Expressions are SLiM code strings
8. **Block deregistration**: `community.deregisterScriptBlock(self)` → `community$deregisterScriptBlock(self)`

**See full patterns in**: `claude_notes/RECIPE_CONVERSION_GUIDE.md` (essential reference)
**Historical details in**: `claude_notes/recipe_conversion_notes.md` (optional, detailed session history)

---

## Overview

This plan outlines the strategy for converting SLiM's official example recipes from native SLiM syntax to slimr R syntax. The goal is to create a curated library of paired SLiM↔slimr examples that are:
- **Tested**: Each recipe runs successfully in slimr with unit tests
- **Documented**: Conversion patterns and edge cases are documented
- **Maintainable**: Clear process for updating when new SLiM versions release
- **Multi-agent friendly**: Designed to work across multiple agent sessions with clear state tracking

---

## Rationale

### Why Not Use `as_slimr_script()`?

The existing `as_slimr_script()` function attempts automatic conversion but:
- ❌ Brittle - breaks with SLiM syntax changes
- ❌ Limited - can't handle all SLiM constructs
- ❌ Untested - no guarantee converted code actually works
- ❌ Unmaintained - harder to debug than hand-converted code

### Why AI-Assisted Manual Conversion?

- ✅ **Quality**: Each recipe is tested and verified to work
- ✅ **Documentation**: Conversion patterns are documented for future reference
- ✅ **Maintainability**: Clear, readable slimr code that can be updated
- ✅ **Learning**: Documents slimr best practices and idioms
- ✅ **One-time cost**: Future updates only need to handle new/changed recipes

---

## Project Structure

### Directory Organization

```
inst/extdata/slim_recipes/
├── original/                       # Original SLiM recipes (included in package)
│   ├── Recipe X.Y - Title.txt     # From SLiM repo
│   └── ...
└── converted/                      # Converted slimr recipes (included in package)
    ├── recipe_X_Y.R
    └── ...

data-raw/slim_recipes/
├── download_recipes.R              # Script to refresh recipes from SLiM GitHub
└── recipe_metadata.csv             # Tracking: recipe #, title, status, notes

tests/testthat/
├── test-recipe_X_Y.R               # Individual test file per recipe (for progress tracking)
└── ...

claude_notes/
├── recipe_conversion_notes.md      # Running append-only notes from all agents
└── RECIPE_CONVERSION_PLAN.md       # This file
```

### File Naming Convention

- **Original SLiM**: `Recipe X.Y - Title.txt` (from SLiM GitHub, spaces in filename)
- **Converted slimr**: `recipe_X_Y.R` (underscores for R compatibility)
- **Test file**: `test-recipe_X_Y.R` (matches testthat convention)
- Example: `Recipe 4.1 - A basic neutral simulation.txt` → `recipe_4_1.R` → `test-recipe_4_1.R`

### Progress Tracking Mechanism

**How agents determine what needs to be done:**

1. **Not yet converted**: Original file exists in `inst/extdata/slim_recipes/original/` but no corresponding file in `inst/extdata/slim_recipes/converted/`
2. **Converted but not tested**: File exists in `inst/extdata/slim_recipes/converted/` but no corresponding `test-recipe_X_Y.R` in `tests/testthat/`
3. **Fully completed**: Both converted recipe and test file exist, and test passes

**To find work:**
```r
# List all original recipes
originals <- list.files("inst/extdata/slim_recipes/original", pattern = "^Recipe.*\\.txt$")

# List converted recipes
converted <- list.files("inst/extdata/slim_recipes/converted", pattern = "^recipe_.*\\.R$")

# List tests
tests <- list.files("tests/testthat", pattern = "^test-recipe_.*\\.R$")

# Identify gaps
# (Agent can use this logic to find next recipe to work on)
```

---

## Conversion Process (Per Recipe)

### Step 0: Select Recipe
1. Check progress tracking (see above) to find unconverted recipe
2. Verify original file exists in `inst/extdata/slim_recipes/original/`
3. Parse recipe number from filename (e.g., `Recipe 4.1 - A basic neutral simulation.txt` → `4.1`)

### Step 1: Understand the Recipe
**CRITICAL**: Before converting, understand what the recipe demonstrates:
1. Read original SLiM recipe carefully
2. Identify the biological/genetic concept being illustrated
3. Note key parameters and their purposes
4. Understand expected outputs and behaviors
5. Write a clear description in your own words

**Goal**: Maintain the "spirit" of the original recipe. Don't make changes just to get code running if they change the point of the recipe.

### Step 2: Initial Conversion
1. Start the R script with:
   ```r
   library(slimr)
   ```
2. Convert SLiM syntax to slimr:
   - `initialize()` callback → `slim_block(initialize(), { ... })`
   - `early()/late()` → `slim_block(gen, early()/late(), { ... })`
   - Property access: `.` → `$` or `%.%`
   - Assignment: `=` → `<-` (in R portions)
   - Comments: `//` → `#`
   - **SLiM 5.x**: `genomes` → `haplosomes`, `genome1/genome2` → `haploidGenome1/haploidGenome2`
3. Wrap in `slim_script()` call and assign to `recipe_X_Y_script`
4. Store original SLiM text as attribute:
   ```r
   recipe_X_Y_script <- slim_script(...)
   attr(recipe_X_Y_script, "original_slim") <- readLines(
     system.file("extdata/slim_recipes/original/Recipe X.Y - Title.txt", package = "slimr")
   )
   ```
5. Save to `inst/extdata/slim_recipes/converted/recipe_X_Y.R`

### Step 2.5: Common Conversion Patterns and Challenges

**CRITICAL: Parallel Iteration and Array Indexing**

SLiM's parallel iteration syntax (`for (id in 1:3, type in c("A", "X", "Y"))`) does **not** work in R. You must use indexed loops with **0-based indexing**:

```r
# ❌ WRONG - SLiM parallel iteration doesn't work in R
for (id in 1:3, type in c("A", "X", "Y")) {  # Syntax error in R!
  initializeChromosome(id, 1e6, type = type)
}

# ❌ WRONG - 1-based indexing causes "subscript out of range" error
for (i in 1:3) {
  type <- c("A", "X", "Y")[i]  # Will fail when i=3 in SLiM (0-based)
  initializeChromosome(i, 1e6, type = type)
}

# ✅ CORRECT - Use 0-based loop with indexed access
types <- c("A", "X", "Y")
symbols <- c("A", "X", "Y")
for (i in 0:2) {  # SLiM arrays use 0-based indexing!
  initializeChromosome(i + 1, 1e6, type = types[i], symbol = symbols[i])
  # Chromosome IDs are 1-based (i+1), but array indices are 0-based (i)
}
```

**Why this works**:
- R's `for (i in 0:2)` becomes SLiM's `for (i in 0:2)` (i = 0, 1, 2)
- SLiM arrays use 0-based indexing: types[0], types[1], types[2] ✓
- Chromosome IDs are typically 1-based, so use `i + 1` for IDs
- Vector indices in the loop use `i` directly to access SLiM 0-based arrays

**Common scenarios**:
- Multiple chromosomes with different properties (Recipe 8.3.x)
- Programmatic population creation (Recipe 5.3.x)
- Any loop that needs to access elements from vectors/arrays

**Other common patterns**:
- See `recipe_conversion_notes.md` for comprehensive pattern documentation
- Open-ended ranges: `1000:` → `slim_block(1000, .., ...)`
- Boolean constants: Use `T` and `F` (not `TRUE`/`FALSE`)
- Do-while loops: Convert to `while(T) { ... if (condition) break; }`

### Step 3: Documentation
Add comprehensive header comment to converted R script:
```r
# Recipe X.Y: [Title]
#
# Description:
# [Your clear explanation of what this recipe demonstrates, written after
# understanding the code. Explain the biological/genetic concept, key parameters,
# and expected behavior.]
#
# SLiM Version: 5.x
# Features: [e.g., nucleotides, tree-seq, spatial, selection, etc.]
#
# Conversion notes:
# [Any challenges encountered, workarounds used, or special considerations]
```

### Step 4: Create Unit Test
Create individual test file at `tests/testthat/test-recipe_X_Y.R`:
```r
test_that("Recipe X.Y: [Title] works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_X_Y.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_X_Y_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # IMPORTANT: ALWAYS test output when recipes produce it!
  # Read output from result$output_file (ALWAYS available)
  output <- readLines(result$output_file)

  # Recipe-specific checks (PERSIST - don't skip these!)
  # expect_true(any(grepl("expected pattern", output)))
  # expect_true(length(output) > 0)
  # expect_true(nrow(result$output_data) > 0)  # If using slimr_output()
})
```

**CRITICAL REMINDER**:
- `result$output_file` - ALWAYS contains the output file path (read with `readLines()`)
- `result$output` - ONLY populated if `capture_output = TRUE`
- **PERSIST in testing output** - Don't skip output tests! Use `readLines(result$output_file)` and check patterns

### Step 5: Run and Verify Test
**CRITICAL**: Always run the test before moving on!

```r
# In R or via command line:
Sys.setenv(TEST_RECIPES = "true")
devtools::load_all('.')
testthat::test_file('tests/testthat/test-recipe_X_Y.R')
```

Or via bash:
```bash
Rscript -e "Sys.setenv(TEST_RECIPES='true'); devtools::load_all('.'); testthat::test_file('tests/testthat/test-recipe_X_Y.R')"
```

Verify:
- Test passes (PASS 1, FAIL 0)
- Recipe runs without errors
- Output matches expectations (REQUIRED - don't skip output tests!)

**If stuck on the recipe logic**: After reasonable effort (15-30 min), document the issue and move on
- Add note to `claude_notes/recipe_conversion_notes.md`
- Mark recipe as "needs_attention" in metadata
- It's okay to give up on difficult recipes - maintainer will review later
- **BUT**: Don't give up on testing output - that should always be straightforward with `readLines(result$output_file)`

### Step 6: Documentation and Metadata ⭐ CRITICAL - ALWAYS DO THIS

**CRITICAL**: These steps are MANDATORY for every recipe session, not optional!

1. **Update recipe metadata CSV** (REQUIRED for EVERY recipe):
   - Open `data-raw/slim_recipes/recipe_metadata.csv`
   - Add row for EACH recipe you converted with:
     - recipe_num (e.g., "20.1")
     - recipe_title (from original file)
     - slim_version ("5.x")
     - features (comma-separated: "multispecies, nonWF, spatial" etc.)
     - status ("complete")
     - converted_date (today's date: "2025-10-27")
     - tested_date (today's date if test passed)
     - notes (brief, key conversion challenges or patterns)
   - **DO NOT SKIP** - Metadata is how we track progress!

2. **Review session for lessons learned** (REQUIRED at end of session):
   - Before ending your session, take 5 minutes to review what you learned
   - Ask yourself: "Did I encounter any NEW patterns that future agents will need?"
   - If YES: Update `claude_notes/RECIPE_CONVERSION_GUIDE.md`
   - Add to appropriate section or create new section if needed
   - Keep it brief: pattern name, issue, solution, minimal example
   - Only add patterns that apply to MULTIPLE recipes (not recipe-specific workarounds)

3. **Save all files** (verify before ending session):
   - Converted recipes in `inst/extdata/slim_recipes/converted/`
   - Test files in `tests/testthat/`
   - Updated metadata CSV in `data-raw/slim_recipes/`
   - Updated conversion guide in `claude_notes/` (if new patterns discovered)

**Why this matters**:
- Metadata CSV is the single source of truth for progress tracking
- Conversion guide prevents future agents from re-discovering the same solutions
- Missing metadata = invisible progress = wasted effort

---

## Package Integration

### Recipe Loading Function

Update or create `slim_get_recipe()` function in package:
```r
slim_get_recipe <- function(recipe_num, print_only = FALSE, compare = FALSE) {
  # Find recipe file
  recipe_file <- system.file(
    sprintf("extdata/slim_recipes/converted/recipe_%s.R", gsub("\\.", "_", recipe_num)),
    package = "slimr"
  )

  if (!file.exists(recipe_file)) {
    stop("Recipe ", recipe_num, " not found")
  }

  # Source the recipe
  source(recipe_file, local = TRUE)
  script_obj <- get(sprintf("recipe_%s_script", gsub("\\.", "_", recipe_num)))

  if (print_only) {
    print(script_obj)
    return(invisible(script_obj))
  }

  if (compare) {
    slim_compare_recipe(script_obj)
    return(invisible(script_obj))
  }

  return(script_obj)
}
```

### Side-by-Side Comparison Function

Function to generate HTML comparison of original SLiM vs converted slimr:
```r
slim_compare_recipe <- function(slimr_script, output_file = NULL, open = TRUE) {
  # Get original SLiM code from attribute
  original <- attr(slimr_script, "original_slim")
  if (is.null(original)) {
    stop("No original SLiM code stored in script attribute")
  }

  # Get slimr R code representation (not converted back to SLiM!)
  # Shows the actual R/slimr syntax side-by-side with original SLiM
  converted <- paste(capture.output(print(slimr_script)), collapse = "\n")

  # Generate HTML with side-by-side comparison
  # Left: Original SLiM syntax
  # Right: Converted slimr R syntax
  html <- generate_comparison_html(original, converted)

  # Save and optionally open
  if (is.null(output_file)) {
    output_file <- tempfile(fileext = ".html")
  }
  writeLines(html, output_file)

  if (open && interactive()) {
    browseURL(output_file)
  }

  message("Comparison saved to: ", output_file)
  invisible(output_file)
}
```

**Note**: This compares original SLiM syntax with slimr R syntax, NOT SLiM-to-SLiM. The purpose is to show users how SLiM code maps to slimr R code.

---

## Downloading/Updating Recipes from SLiM GitHub

**Script**: `data-raw/slim_recipes/download_recipes.R`

This script should be run by a single agent when updating recipes:

```r
# Download all recipes from SLiM GitHub repository
# This fetches the latest versions from the master branch

library(glue)

# Base URL for SLiM recipes
base_url <- "https://raw.githubusercontent.com/MesserLab/SLiM/master/QtSLiM/recipes/"

# Recipe ranges to download (update as new recipes are added)
# Format: chapter number, section ranges
recipes <- list(
  "4" = 1:10,   # Chapter 4 recipes
  "5" = 1:10,   # Chapter 5 recipes
  "6" = 1:10,   # Chapter 6 recipes
  # Add more as needed
)

# Output directory - recipes go in inst/extdata to be included in package
out_dir <- "inst/extdata/slim_recipes/original"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# Download function
download_recipe <- function(recipe_num) {
  # Construct URL and filename
  # SLiM recipes are named like "Recipe 13.1 - Title.txt"
  # Need to handle URL encoding and variations

  # Try multiple naming patterns
  patterns <- c(
    "Recipe%20{recipe_num}%20-%20*.txt",
    "Recipe_{recipe_num}_*.txt"
  )

  # Implementation details...
  # Use curl or download.file()
  # Save to out_dir
}

# Download all recipes
for (chapter in names(recipes)) {
  for (section in recipes[[chapter]]) {
    recipe_num <- paste0(chapter, ".", section)
    download_recipe(recipe_num)
  }
}

cat("Downloaded", length(list.files(out_dir)), "recipes\n")
```

**When to run**:
- At start of recipe conversion project (already done)
- When SLiM releases new version
- When maintainer wants to refresh recipes

---

## Conversion Patterns to Document

### Common Patterns

**1. Initialize Block**
```slim
// SLiM
initialize() {
    initializeMutationRate(1e-7);
    ...
}
```

```r
# slimr
slim_block(initialize(), {
  initializeMutationRate(1e-7)
  ...
})
```

**2. Timed Events**
```slim
// SLiM
1 early() {
    ...
}

1000 late() {
    sim.simulationFinished();
}
```

```r
# slimr
slim_block(1, early(), {
  ...
})

slim_block(1000, late(), {
  sim$simulationFinished()
})
```

**3. Property Access**
```slim
// SLiM - direct property access
p1.individuals.haplosomes
```

```r
# slimr - multiple valid options

# Option 1: Keep dots (they work fine, pass through to SLiM)
p1.individuals.haplosomes

# Option 2: Use $ for more R-like style (stylistic preference)
p1$individuals$haplosomes

# Option 3: %.% for autocomplete (always works)
p1%.%Subpopulation$individuals$haplosomes

# Note: All three are valid. Using $ is more idiomatic R but not required.
```

**4. SLiM 5.x Updates**
```slim
// SLiM 4.x
p1.individuals.genomes
```

```r
# slimr with SLiM 5.x
p1$individuals$haplosomes  # Changed in v5!
# or
p1.individuals.haplosomes  # Also works
```

### Edge Cases to Document

1. **Nucleotide-based models** - Special initialization
2. **Tree sequence recording** - treeSeq setup and output
3. **Spatial models** - Coordinate handling
4. **Custom fitness callbacks** - Function definitions
5. **Complex data structures** - Matrix/vector handling
6. **File I/O** - Reading/writing files in slimr context
7. **Conditional logic** - R vs SLiM evaluation
8. **Loop constructs** - for/while loops
9. **String manipulation** - Concatenation, formatting
10. **Output handling** - Capturing vs displaying

---

## Testing Strategy

### Individual Recipe Tests

Each recipe has its own test file in `tests/testthat/test-recipe_X_Y.R`:

```r
test_that("Recipe X.Y: [Title] works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe from package
  source(system.file("extdata/slim_recipes/converted/recipe_X_Y.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_X_Y_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe-specific checks (if applicable)
  # expect_true(nrow(result$output_data) > 0)  # If output expected
  # ... other assertions
})
```

### Test Execution Control

```r
# Run recipe tests (slow, opt-in)
Sys.setenv(TEST_RECIPES = "true")
devtools::test()

# Skip recipe tests (default)
Sys.unsetenv("TEST_RECIPES")
devtools::test()

# Or run a specific recipe test:
Sys.setenv(TEST_RECIPES = "true")
testthat::test_file('tests/testthat/test-recipe_X_Y.R')
```

### Continuous Integration

- **PR checks**: Skip recipe tests (too slow)
- **Nightly builds**: Run all recipe tests
- **Pre-release**: Run all recipe tests

---

## Documentation Files

### RECIPE_CONVERSION_GUIDE.md (Primary Reference)

**Purpose**: Concise, focused reference for essential conversion patterns and solutions.

**Content**:
- Core syntax conversions
- Critical type handling issues
- Common gotchas with examples
- Reusable patterns applicable to multiple recipes
- Brief, focused examples

**When to update**:
- You discover a NEW pattern that will help with future recipes
- Only add patterns that apply to MULTIPLE recipes (not recipe-specific workarounds)
- Keep additions brief - pattern name, issue, solution, minimal example

**How to update**:
Add to "Recipe-Specific Notes" section at bottom using this template:
```markdown
### [Pattern Name] - Recipe X.Y

**Issue**: [What was the problem]
**Solution**: [How to fix it]
**Example**:
```r
# Minimal code example showing the pattern
```
```

### recipe_conversion_notes.md (Historical Archive)

**Purpose**: Detailed session-by-session historical record (optional reference).

**Content**:
- Detailed session notes from all conversion work
- Recipe-by-recipe conversion details
- Thought process and evolution of understanding
- Complete history of conversion project

**When to read**:
- When you need deep context about why certain decisions were made
- Researching edge cases from specific recipes
- Understanding evolution of conversion patterns

**Do NOT update**: This file is now archived. All new documentation goes in RECIPE_CONVERSION_GUIDE.md.

---

## Multi-Agent Workflow

### Entry Protocol (Starting a Session)

When a fresh agent starts working on recipe conversion:

1. **Check current status**:
   ```r
   devtools::load_all('.')

   # List original recipes
   originals <- list.files("inst/extdata/slim_recipes/original",
                          pattern = "^Recipe.*\\.txt$", full.names = TRUE)

   # List converted recipes
   converted <- list.files("inst/extdata/slim_recipes/converted",
                          pattern = "^recipe_.*\\.R$")

   # List completed tests
   tests <- list.files("tests/testthat",
                      pattern = "^test-recipe_.*\\.R$")

   # Find unconverted recipes
   # Parse recipe numbers and compare
   ```

2. **Read essential documentation**:
   - Review `claude_notes/RECIPE_CONVERSION_GUIDE.md` for conversion patterns (essential)
   - Check `data-raw/slim_recipes/recipe_metadata.csv` for status
   - Optionally review `recipe_conversion_notes.md` if you need historical context

3. **Select recipes to convert**:
   - Start with first unconverted recipe (lowest number)
   - Or tackle specific recipes based on complexity/features

### Core Workflow (Per Recipe)

1. **Understand**: Read and comprehend what the recipe demonstrates
2. **Convert**: Transform SLiM to slimr, maintaining the recipe's purpose
3. **Document**: Write clear description and comments
4. **Test**: Create and run unit test
5. **Record**: Update metadata and append notes
6. **Save**: Write all files (recipe, test, metadata)

**CRITICAL REMINDERS**:
- **Understand before converting** - Know what the recipe demonstrates
- **Maintain the spirit** - Don't change the recipe's purpose
- **Store original text** - As attribute on slimr_script object
- **It's okay to give up** - Document issues and move on after 15-30 min
- **Update guide only for NEW patterns** - Brief notes in `RECIPE_CONVERSION_GUIDE.md` for reusable patterns only

### Exit Protocol (Ending a Session) ⭐ CRITICAL CHECKLIST

Before ending a session, ALWAYS complete these steps:

1. **Verify files saved** (MANDATORY):
   - [ ] Converted recipes in `inst/extdata/slim_recipes/converted/`
   - [ ] Test files in `tests/testthat/`
   - [ ] **Metadata CSV updated** in `data-raw/slim_recipes/recipe_metadata.csv` ⭐ REQUIRED
   - [ ] Guide updated in `claude_notes/RECIPE_CONVERSION_GUIDE.md` (if NEW patterns discovered)

2. **Review session for lessons** (MANDATORY):
   - [ ] **Take 5 minutes to review what you learned** ⭐ REQUIRED
   - [ ] Ask: "Did I encounter NEW patterns future agents will need?"
   - [ ] If YES: Add brief notes to RECIPE_CONVERSION_GUIDE.md
   - [ ] Update "Last updated" date at bottom of guide

3. **Update metadata for ALL recipes** (MANDATORY):
   - [ ] **Every recipe you converted MUST have a metadata row** ⭐ REQUIRED
   - [ ] Include: recipe_num, title, version, features, status, dates, notes
   - [ ] This is HOW WE TRACK PROGRESS - do not skip!

4. **Clean exit**:
   - Leave repository in working state
   - No uncommitted partial work
   - Next agent can immediately pick up where you left off

**Why this matters**:
- Without metadata updates, your work is invisible to future agents
- Without lesson updates, future agents will waste time re-discovering solutions
- These steps take 5-10 minutes but save hours for future agents

### Quality Checklist (Per Recipe)

Before marking a recipe as complete:

- [ ] Recipe has been read and understood
- [ ] Description clearly explains what recipe demonstrates
- [ ] Converted code maintains spirit of original
- [ ] Original SLiM text stored as attribute
- [ ] Code runs without errors (or documented as needs_attention)
- [ ] Unit test created and runs (or documented as failing)
- [ ] Header comment is complete
- [ ] **⭐ CRITICAL: Metadata row added to recipe_metadata.csv** (REQUIRED!)
- [ ] **⭐ CRITICAL: Session reviewed for new patterns** (REQUIRED at session end!)
- [ ] NEW reusable patterns added to RECIPE_CONVERSION_GUIDE.md (if discovered)
- [ ] All files saved (recipe, test, metadata, guide if updated)

**The metadata CSV and lesson review are NOT optional!**

---

## Future Maintenance (For New SLiM Versions)

When a new SLiM version is released:

1. **Check for new recipes**: Compare recipe list with previous version
2. **Check for changed recipes**: Diff existing recipes against new versions
3. **For new recipes**: Follow full conversion process
4. **For changed recipes**:
   - Review changes
   - Update converted version
   - Update tests if needed
   - Document version-specific changes
5. **Update RECIPE_CONVERSION_GUIDE.md**: Add any new patterns/changes discovered

---

## Metadata Schema (recipe_metadata.csv)

```csv
recipe_num,recipe_title,slim_version,features,status,converted_date,tested_date,notes
4.1,"A basic neutral simulation",5.0,"basic,neutral,foundation",completed,2025-10-23,2025-10-23,"Straightforward conversion. First recipe demonstrating minimum SLiM simulation components."
4.2.1,"Basic output, Entire population",5.0,"basic,output",needs_attention,2025-10-23,,Test fails - needs investigation
```

**Fields:**
- `recipe_num`: Recipe number from manual (e.g., "4.1" or "4.2.1")
- `recipe_title`: Short title from original recipe
- `slim_version`: Min SLiM version required (5.0 for current conversion)
- `features`: Comma-separated tags (basic, selection, nucleotides, tree-seq, spatial, etc.)
- `status`: not_started | in_progress | completed | needs_attention
  - `not_started`: No converted file exists
  - `in_progress`: Converted file exists but no test
  - `completed`: Both converted file and passing test exist
  - `needs_attention`: Converted but test fails or other issues
- `converted_date`: Date recipe was converted (YYYY-MM-DD)
- `tested_date`: Date test last ran successfully (empty if test hasn't passed)
- `notes`: Any special notes, issues, or context

---

## Benefits of This Approach

### For Users
✅ High-quality, tested examples
✅ Learn slimr best practices
✅ Copy-paste ready code
✅ Clear conversion patterns for their own code

### For Maintainers
✅ Easy to update when SLiM changes
✅ Clear documentation of conversion patterns
✅ Test suite for slimr functionality
✅ Examples exercise diverse SLiM features

### For AI Assistants
✅ Reference library of conversion patterns
✅ Documented edge cases and solutions
✅ Examples of slimr idioms
✅ Clear process for converting user code

---

## Estimated Effort

**Assumptions:**
- ~50-100 recipes in SLiM manual
- Average 15-30 minutes per recipe (read, convert, test, document)
- Some recipes will be quick (5 min), others complex (60+ min)

**Total Time Estimate:**
- **Simple recipes (40%)**: ~10 min each = 4-8 hours
- **Moderate recipes (40%)**: ~20 min each = 8-16 hours
- **Complex recipes (20%)**: ~45 min each = 8-16 hours
- **Total**: 20-40 hours of AI-assisted work

**Breakdown:**
- Initial setup: 1 hour (directories, templates, first recipe)
- Bulk conversion: 15-30 hours (most recipes)
- Complex recipes: 5-10 hours (tree-seq, nucleotides, spatial)
- Documentation polish: 2-5 hours

---

## Initial Setup (One-time)

Before starting recipe conversion, ensure these are in place:

1. **Directory structure**:
   ```bash
   mkdir -p inst/extdata/slim_recipes
   mkdir -p data-raw/slim_recipes/original
   mkdir -p claude_notes
   ```

2. **Initialize metadata file** (`data-raw/slim_recipes/recipe_metadata.csv`):
   ```csv
   recipe_num,recipe_title,slim_version,features,status,converted_date,tested_date,notes
   ```

3. **Initialize notes file** (`claude_notes/recipe_conversion_notes.md`):
   ```markdown
   # Recipe Conversion Notes

   This file contains running notes from agents working on recipe conversion.
   **APPEND ONLY** - Never overwrite existing content.

   ---

   ## Session [Date]

   [Agent notes go here...]
   ```

4. **Update `.Rbuildignore`**:
   ```
   ^data-raw$
   ^claude_notes$
   ```

5. **Verify SLiM 5.x installed**:
   ```r
   devtools::load_all('.')
   slim_is_avail()  # Should be TRUE
   slim_version()   # Should be "5.1" or higher
   ```

---

## Success Metrics

**Primary Goals**:
- [ ] All recipes converted to slimr format with original stored as attribute
- [ ] All recipes have unit tests (passing or documented as needs_attention)
- [ ] All conversion patterns documented in notes
- [ ] recipe_metadata.csv is complete and accurate
- [ ] Package functions updated: `slim_get_recipe()`, `slim_compare_recipe()`

**Quality Goals**:
- [ ] Each recipe includes clear description explaining what it demonstrates
- [ ] Converted code maintains the spirit of original recipes
- [ ] Zero `as_slimr_script()` usage in package code
- [ ] Recipe tests can run in CI with `TEST_RECIPES=true` flag
- [ ] Documentation includes side-by-side comparison capability

**Documentation Goals**:
- [ ] RECIPE_CONVERSION_GUIDE.md captures all essential patterns and solutions
- [ ] Vignette created: "Converting SLiM to slimr"
- [ ] User guide updated with recipe examples

---

## Immediate Next Steps

1. **Initial setup** (if not done):
   - Create directory structure
   - Initialize metadata and notes files
   - Verify SLiM 5.x installation

2. **Start conversion**:
   - Begin with first recipe (lowest number)
   - Follow multi-agent workflow
   - Document patterns as discovered

3. **Iterate**:
   - Convert recipes in numerical order
   - Build up pattern library
   - Update metadata continuously

---

## Design Decisions (Resolved)

1. **Recipe storage location**
   - **Decision**: Converted recipes in `inst/extdata/slim_recipes/` (included in package)
   - **Rationale**: Accessible via `system.file()`, standard R package convention

2. **Original SLiM text storage**
   - **Decision**: Store as attribute on slimr_script object
   - **Rationale**: Keeps original and converted together, enables comparison function

3. **Progress tracking mechanism**
   - **Decision**: Use presence of test files to indicate completion
   - **Rationale**: Clear file-based signal, natural integration with testthat

4. **Recipe access**
   - **Decision**: Update `slim_get_recipe()` to source from extdata
   - **Rationale**: Maintains existing API, adds comparison feature

5. **Side-by-side comparison**
   - **Decision**: Create `slim_compare_recipe()` that generates HTML
   - **Rationale**: Visual comparison helps users learn conversion patterns

6. **Multi-agent coordination**
   - **Decision**: Append-only notes file + CSV metadata
   - **Rationale**: No merge conflicts, clear audit trail, easy status checks

7. **Testing approach**
   - **Decision**: Individual test file per recipe, env flag to enable
   - **Rationale**: Fine-grained progress tracking, optional slow tests

8. **External files**
   - **Decision**: Include sample data in `inst/extdata/slim_recipes/data/` if needed
   - **Rationale**: Self-contained examples, easy to distribute

9. **Conversion strategy**
   - **Decision**: AI-assisted manual conversion, not automated
   - **Rationale**: Higher quality, better documentation, maintainable code

---

## References

- **SLiM Manual**: http://benhaller.com/slim/SLiM_Manual.pdf
- **SLiM Recipes**: Chapter 13+ in manual
- **SLiM GitHub**: https://github.com/MesserLab/SLiM
- **slimr Documentation**: https://rdinnager.github.io/slimr/
