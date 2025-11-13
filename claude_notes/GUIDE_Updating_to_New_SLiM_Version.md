# Comprehensive Guide: Updating slimr to a New Major Version of SLiM

**Version:** 1.0 **Created:** 2025-10-21 **Purpose:** Step-by-step guide for updating the slimr R package when a new major version of SLiM is released

------------------------------------------------------------------------

## Table of Contents

1.  [Overview](#overview)
2.  [Prerequisites](#prerequisites)
3.  [Phase 1: Preparation](#phase-1-preparation)
4.  [Phase 2: API Extraction](#phase-2-api-extraction)
5.  [Phase 3: Comparison and Analysis](#phase-3-comparison-and-analysis)
6.  [Phase 4: Code Updates](#phase-4-code-updates)
7.  [Phase 5: Testing and Validation](#phase-5-testing-and-validation)
8.  [Phase 6: Documentation and Release](#phase-6-documentation-and-release)
9.  [Troubleshooting](#troubleshooting)
10. [Automation Notes for AI Agents](#automation-notes-for-ai-agents)

------------------------------------------------------------------------

## Overview {#overview}

This guide documents the process for updating the slimr R package to support a new major version of SLiM (e.g., SLiM 5.x, 6.x, etc.). The process was developed during the SLiM 4.x → 5.x upgrade and is designed to be reusable for future upgrades.

### **CRITICAL: Version Compatibility Policy**

**slimr follows a clean break approach for SLiM major version upgrades:**

- **slimr v0.5.0+ supports ONLY SLiM 5.x**
- **slimr v0.4.x supports ONLY SLiM 4.x**
- **NO backward compatibility layers** - do not implement dual version support
- **Clean replacement** - replace R/slim_lang.R entirely with new version
- Users needing older SLiM versions use older slimr versions

**This means:**
- ✅ Replace all API documentation
- ✅ Update all class/property references directly
- ❌ NO version detection systems
- ❌ NO translation layers for old property names
- ❌ NO supporting both versions simultaneously

See CLAUDE.md for the full version compatibility policy.

### What This Guide Covers

-   Extracting complete API documentation from SLiM's RTF help files
-   Comparing old vs new APIs to identify breaking changes
-   Generating R documentation and class objects
-   Updating slimr code to support the new API
-   Testing and validating the upgrade

### Time Estimate

-   **Phase 1-3 (Extraction & Analysis):** 2-4 hours
-   **Phase 4 (Code Updates):** 4-8 hours (varies by breaking changes)
-   **Phase 5 (Testing):** 2-4 hours
-   **Phase 6 (Documentation):** 1-2 hours

**Total:** 1-2 days of focused work

------------------------------------------------------------------------

## Prerequisites {#prerequisites}

### Required Software

1.  **R** (version \>= 4.0)

2.  **RStudio** (recommended for development)

3.  **Required R Packages:**

    ``` r
    install.packages(c("unrtf", "stringr", "dplyr", "purrr", "tidyr",
                       "glue", "usethis", "devtools", "testthat"))
    ```

4.  **SLiM** - New version installed and accessible

    ``` r
    # Test SLiM availability
    slimr::slim_is_avail()
    slimr::slim_version()
    ```

### Required Files from SLiM Repository

You'll need the RTF help files from the SLiM GitHub repository:

1.  **SLiMHelpClasses.rtf** - Contains all SLiM class documentation (properties and methods)
2.  **SLiMHelpFunctions.rtf** - Contains Initialize and SLiMBuiltin functions
3.  **EidosHelpFunctions.rtf** - Contains Eidos language functions

**Locations in SLiM repo:**
- SLiM files: `https://github.com/MesserLab/SLiM/tree/master/SLiMgui/`
- Eidos file: `https://github.com/MesserLab/SLiM/tree/master/EidosScribe/`

**How to obtain:**

``` r
# Download directly using curl (recommended)
dir.create("data-raw/slim_man", showWarnings = FALSE, recursive = TRUE)

# SLiM classes file
system('curl -L "https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/SLiMgui/SLiMHelpClasses.rtf" -o "data-raw/slim_man/SLiMHelpClasses.rtf"')

# SLiM functions file
system('curl -L "https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/SLiMgui/SLiMHelpFunctions.rtf" -o "data-raw/slim_man/SLiMHelpFunctions.rtf"')

# Eidos functions file
system('curl -L "https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/EidosScribe/EidosHelpFunctions.rtf" -o "data-raw/slim_man/EidosHelpFunctions.rtf"')
```

### Knowledge Required

-   Basic understanding of R package development
-   Familiarity with SLiM scripting language
-   Understanding of the slimr architecture (see CLAUDE.md)

------------------------------------------------------------------------

## Phase 1: Preparation {#phase-1-preparation}

### Step 1.1: Create Build Directory

``` bash
mkdir -p data-raw/build_X  # Replace X with new SLiM version (e.g., build_6)
cd data-raw/build_X
```

### Step 1.2: Review SLiM Changelog

**Action:** Review the official SLiM changelog to understand what changed.

**Location:** `https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/VERSIONS`

**What to look for:** - New classes added - Removed/renamed classes - Major API changes - Terminology changes (e.g., "generation" → "tick" in v5) - Property changes - Method changes

**Document your findings** in a preliminary notes file for reference.

### Step 1.3: Create Upgrade Plan

Create a file `SLIM_X_UPGRADE_PLAN.md` in the project root outlining: - Known breaking changes from changelog - Estimated scope of work - Priority order for updates - Testing strategy

------------------------------------------------------------------------

## Phase 2: API Extraction {#phase-2-api-extraction}

This phase extracts complete API documentation from SLiM's RTF help files.

### Step 2.1: Copy Extraction Template

If this is the first major version upgrade using this process, you'll need to create the extraction script. Otherwise, copy from the previous version:

``` bash
cp data-raw/build_5/extract_from_rtf.R data-raw/build_X/extract_from_rtf.R
```

### Step 2.2: Understand the Extraction Script

The extraction script (`extract_from_rtf.R`) performs these steps:

1.  **Convert RTF to plain text** using the `unrtf` package
2.  **Clean control characters** (CRITICAL - must happen BEFORE parsing)
3.  **Parse class structure** (find class headers, property sections, method sections)
4.  **Extract properties** with types, descriptions, read/write status
5.  **Extract methods** with signatures, return types, arguments, descriptions
6.  **Extract class introductions** for documentation
7.  **Parse functions** (Initialize and SLiMBuiltin functions)
8.  **Save to RDS files** for next phase

**Key insights:**

- The `unrtf` package converts special characters like en-dash (–) to control characters (0x13 + 0xA0). These MUST be cleaned to regular ASCII BEFORE parsing, otherwise read-write properties (`<->`) will be missed.

- **Three slimr-created classes:** slimr creates three "pseudo-classes" to organize functions that aren't SLiM class methods:
  - **Initialize**: Functions starting with "initialize" (from SLiMHelpFunctions.rtf)
  - **SLiMBuiltin**: All other built-in SLiM functions (from SLiMHelpFunctions.rtf)
  - **Eidos**: Eidos language functions (from EidosHelpFunctions.rtf)

  The extraction script separates Initialize and SLiMBuiltin by checking if function names start with "initialize". Eidos functions come from a separate file.

### Step 2.3: Run the Extraction

``` r
# From project root
Rscript data-raw/build_X/extract_from_rtf.R
```

**Expected output:**

```         
=== SLiM X.x RTF EXTRACTION PIPELINE ===

STEP 1: Extracting plain text from RTF files...
  - Extracting from RTF files using unrtf package...
  - Classes file: XXXXXX characters
  - Functions file: XXXXX characters

STEP 2: Setting up type system...
  - Type legend created

STEP 3: Parsing classes file...
  - Found XX classes: [class names]

STEP 4: Extracting properties from each class...
  - Extracted properties for XX classes
  [list of classes with property counts]

STEP 5: Extracting methods from each class...
  - Extracted methods for XX classes
  [list of classes with method counts]

STEP 6: Extracting class introduction text...
  - Extracted introductions for XX classes

STEP 7: Parsing functions file...
  - Found XX function signatures
  - Initialize functions: XX
  - SLiMBuiltin functions: XX

STEP 8: Saving extracted data...
  - Saved all_methods_data.rds
  - Saved all_properties_data.rds
  - Saved slim_lang_intros.rds

=== EXTRACTION COMPLETE ===
```

**Files created:** - `data-raw/build_X/all_methods_data.rds` - `data-raw/build_X/all_properties_data.rds` - `data-raw/build_X/slim_lang_intros.rds` - `data-raw/slim_man/SLiMHelpClasses_unrtf.txt` (cached for faster re-runs) - `data-raw/slim_man/SLiMHelpFunctions_unrtf.txt` (cached)

### Step 2.4: Verify Extraction Quality

**Quick verification:**

``` r
# Load extracted data
methods <- readRDS("data-raw/build_X/all_methods_data.rds")
properties <- readRDS("data-raw/build_X/all_properties_data.rds")

# Check counts
cat("Classes with methods:", length(methods), "\n")
cat("Classes with properties:", length(properties), "\n")

# Check total counts
cat("Total methods:", sum(purrr::map_int(methods, nrow)), "\n")
cat("Total properties:", sum(purrr::map_int(properties, nrow)), "\n")

# Check for tag properties (should be present in most classes)
for(cls in names(properties)) {
  tags <- grep('^tag', properties[[cls]]$property, value=TRUE)
  if(length(tags) > 0) {
    cat(cls, ":", paste(tags, collapse=", "), "\n")
  }
}
```

**Expected:** Most classes should have a `tag` property. If tag properties are missing, the control character cleaning step likely failed.

**Troubleshooting:** If properties or methods are missing: 1. Check that control character cleanup happened BEFORE parsing 2. Verify regex patterns match the actual text format 3. Look at the cached `_unrtf.txt` files to see the actual text structure 4. Use the `find_nonascii.R` script to check for unexpected characters

------------------------------------------------------------------------

## Phase 3: Comparison and Analysis {#phase-3-comparison-and-analysis}

This phase compares the new API against the previous version to identify all breaking changes.

### Step 3.1: Copy Comparison Script

``` bash
cp data-raw/build_5/compare_v4_v5.R data-raw/build_X/compare_vY_vX.R
```

Update the script to: - Load from the correct old version directory (e.g., build_5) - Load from the correct new version directory (e.g., build_X) - Update file paths accordingly

### Step 3.2: Run Comparison

``` r
Rscript data-raw/build_X/compare_vY_vX.R
```

**Expected output:**

```         
=== COMPARING SLiM Y.x vs X.x APIs ===

STEP 1: Loading SLiM X.x data...
  - Loaded XX vX method sets
  - Loaded XX vX property sets

STEP 2: Loading SLiM Y.x data...
  - Found XX vY methods files
  - Parsed XX vY classes with methods
  - Parsed XX vY classes with properties

STEP 3: Comparing class lists...

V4 Classes (XX): [list]
V5 Classes (XX): [list]

**NEW CLASSES in vX:**
  + [class names]

**REMOVED CLASSES from vY:**
  - [class names]

STEP 4: Comparing methods for each class...
[Detailed method changes by class]

STEP 5: Comparing properties for each class...
[Detailed property changes by class]

=== SUMMARY REPORT ===

CLASS CHANGES:
  - New classes: X
  - Removed classes: X
  - Common classes: X

METHOD CHANGES:
  - Classes with changes: X
  - Total new methods: X
  - Total removed methods: X
  - Total signature changes: X

PROPERTY CHANGES:
  - Classes with changes: X
  - Total new properties: X
  - Total removed properties: X

STEP 7: Saving comparison results...
  - Saved comparison results to vY_vX_comparison.rds
```

**Files created:** - `data-raw/build_X/vY_vX_comparison.rds`

### Step 3.3: Verify Against Changelog

**CRITICAL STEP:** Compare your extraction results against the official SLiM changelog.

**Common verification points:** - Do new classes match what the changelog says? - Do removed classes match? - Do major terminology changes explain many signature changes? - Are tag properties preserved or removed? - Do property changes align with documented changes?

**If there are discrepancies:** 1. Recheck the extraction (likely missing data) 2. Review the changelog more carefully 3. Check for version mismatches

### Step 3.4: Generate Breaking Changes Report

Create a comprehensive breaking changes document:

``` bash
# Create from template or previous version
cp claude_notes/BREAKING_CHANGES_v4_to_v5.md \
   claude_notes/BREAKING_CHANGES_vY_to_vX.md
```

**Update the report with:** - Executive summary with statistics - Detailed class changes (new, removed, renamed) - Property changes by class - Method changes by class - Impact assessment (CRITICAL, HIGH, MEDIUM, LOW priority) - Recommended upgrade approach (phases) - Testing strategy - Migration guide sections

**Save to:** `claude_notes/BREAKING_CHANGES_vY_to_vX.md`

------------------------------------------------------------------------

## Phase 4: Code Updates {#phase-4-code-updates}

This phase updates the slimr codebase to support the new SLiM API.

### Step 4.1: Generate R Documentation and Class Objects

**Copy generation script:**

``` bash
cp data-raw/build_5/generate_slim_lang_vX.R data-raw/build_X/
```

**Update class abbreviations** in the script if needed: - New classes need new abbreviations (e.g., `.Ha` for Haplosome, `.Pl` for Plot) - Removed classes should be deleted from the list - Follow existing naming conventions (usually first 1-3 letters)

**Run generation:**

``` r
Rscript data-raw/build_X/generate_slim_lang_vX.R
```

**Expected output:**

```         
=== GENERATING SLiM X.x R DOCUMENTATION ===

STEP 1: Loading extracted SLiM X.x data...
STEP 2: Setting up class abbreviations...
STEP 3: Defining roxygen templates...
STEP 4: Defining generator functions...
STEP 5: Generating class creation code...
STEP 6: Generating method assignment code...
STEP 7: Generating property assignment code...
STEP 8: Sourcing code to create class objects...
  - Created class objects
  - Populated methods
  - Populated properties
STEP 9: Generating roxygen documentation...
STEP 10: Generating class documentation...
STEP 11: Assembling R/slim_lang_vX.R...
STEP 12: Saving class objects to R/sysdata.rda...
  - Saved class objects to R/sysdata.rda
  - Saved slim_classes to data/slim_classes.rda

=== GENERATION COMPLETE ===

Classes created: XX
Methods documented: XXX
Properties created: XXX
```

**Files created:** - `R/slim_lang_vX.R` - Roxygen documentation (large file, \~1 MB) - `R/sysdata.rda` - Internal class objects loaded on package startup - `data/slim_classes.rda` - Class lookup table

**Verify class objects:**

``` r
# Load and inspect
load("R/sysdata.rda")
ls()  # Should show all .ClassName objects

# Check new class objects
.Ha  # Example: Haplosome class
length(.Ha)  # Should have methods + properties

# Verify methods
names(.Ha)[1:5]

# Verify properties
tail(names(.Ha), 5)
```

### Step 4.2: Update Core Translation Code

The R↔SLiM translation code in `R/slimr_code.R` needs updating for:

**A. Class Name Changes**

If classes were renamed (e.g., Genome → Haplosome):

1.  Search for old class name references:

    ``` bash
    grep -r "Genome" R/
    ```

2.  Update class references:

    -   Update regex patterns that match class names
    -   Update class name lookup tables
    -   Update class validation code

**B. Property Name Changes**

If properties were renamed (e.g., `genome1` → `haploidGenome1`):

1.  Create property mapping table:

    ``` r
    # In slimr_code.R or similar
    property_aliases_vX <- list(
      Individual = c(
        genome1 = "haploidGenome1",
        genome2 = "haploidGenome2",
        genomes = "haplosomes",
        genomesNonNull = "haplosomesNonNull"
      ),
      Subpopulation = c(
        genomes = "haplosomes",
        genomesNonNull = "haplosomesNonNull"
      )
    )
    ```

2.  Update property translation functions:

    -   Add mapping logic to R→SLiM translation
    -   Add reverse mapping for SLiM→R translation
    -   Consider backward compatibility options

**C. Method Signature Changes**

If method signatures changed (common with terminology shifts):

1.  Review all signature changes from comparison report
2.  For each changed signature:
    -   Note old parameter names
    -   Note new parameter names
    -   Update any special handling code
    -   Update examples in documentation

### Step 4.3: Update Class Environment Code

File: `R/zzz.R` or similar package initialization code

**Update:** - `.onLoad()` function if it references specific classes - Class loading/attachment code - `slim_load_globals()` function to handle new classes

**Example update for v5:**

``` r
# Old (v4)
.onLoad <- function(libname, pkgname) {
  # ... existing code ...
  # .G is for Genome class
}

# New (v5)
.onLoad <- function(libname, pkgname) {
  # ... existing code ...
  # .Ha is for Haplosome class (replaces .G)
}
```

### Step 4.4: Update Autocomplete Support

The `%.%` operator and `$` method support needs updating:

1.  **File:** `R/slimr_script.R` or wherever `%.%` is defined

2.  **Update class list** if new classes added:

    ``` r
    # Add new class abbreviations
    Species = .Sp,
    Haplosome = .Ha,  # New in v5
    Plot = .Pl        # New in v5
    ```

3.  **Remove old classes** from autocomplete:

    ``` r
    # Remove: Genome = .G  (replaced by Haplosome in v5)
    ```

### Step 4.5: Update Helper Functions

Files to check and update:

**`R/slimr_template.R`:** - Update any class-specific template code - Update examples that reference changed classes/properties

**`R/slimr_inline.R`:** - Update inline conversion for new/changed types - Update examples

**`R/slimr_output.R`:** - Update output parsing for new classes - Update output type detection

**`R/slim_extract.R`:** - Update extraction functions for new output formats - Update class/type detection

### Step 4.6: Update Package Data

**slim_callbacks data:**

If callbacks changed, update `R/slim_callbacks.R`: - New callback types - Removed callback types - Changed callback signatures

**Example scripts/recipes:**

**NEW STRATEGY (as of v5 upgrade):** slimr now maintains manually converted recipes instead of relying on brittle `as_slimr_script()` conversion.

**For existing recipes:**
1. Check which recipes changed in new SLiM version
2. For each changed recipe:
   - Re-convert using conversion patterns in `claude_notes/RECIPE_CONVERSION_PLAN.md`
   - Follow the documented conversion process
   - Test the converted recipe
   - Update `data-raw/slim_recipes/conversion_notes.md` if new patterns emerge

**For new recipes:**
1. Identify new recipes in SLiM manual/repo
2. Convert using AI-assisted process (see RECIPE_CONVERSION_PLAN.md)
3. Test and document as per recipe conversion plan
4. Add to test suite

**Key files:**
- `data-raw/slim_recipes/converted/recipe_X_Y.R` - Converted recipes
- `data-raw/slim_recipes/conversion_notes.md` - Conversion patterns
- `data-raw/slim_recipes/recipe_metadata.csv` - Recipe tracking
- `tests/testthat/test-slim_recipes.R` - Recipe tests

See `claude_notes/RECIPE_CONVERSION_PLAN.md` for complete process.

------------------------------------------------------------------------

## Phase 5: Testing and Validation {#phase-5-testing-and-validation}

This phase ensures everything works correctly with the new API.

### Step 5.1: Update Unit Tests

**Files:** `tests/testthat/test-*.R`

For each changed class/property/method, update or create tests:

``` r
# Example: Test new Haplosome class
test_that("Haplosome class works", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      # ... initialization ...
    }),
    slim_block(1, {
      # Test Haplosome access
      p1.individuals[0].haploidGenome1  # New property name
    })
  )

  expect_s3_class(script, "slimr_script")
  # ... more tests ...
})

# Example: Test property renaming
test_that("genome1 translates to haploidGenome1", {
  # Test R→SLiM translation
  # Test that old property names get warnings or errors
  # Test backward compatibility if implemented
})
```

**Critical areas to test:** - \[ \] New class creation and access - \[ \] Property name translation (old → new) - \[ \] Method signature changes - \[ \] Backward compatibility (if any) - \[ \] Output parsing with new formats - \[ \] Template system with new classes - \[ \] Inline system with new types

### Step 5.2: Update Integration Tests

Test complete workflows:

``` r
test_that("Full simulation with new API works", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    # Complete realistic simulation using new API
    slim_block(initialize(), { ... }),
    slim_block(1, { ... }),
    slim_block(1000, { ... })
  )

  result <- slim_run(script)
  expect_equal(result$exit_status, 0)
})
```

### Step 5.3: Update Vignettes

**Priority order:** 1. Main introduction vignette (highest impact) 2. Getting started / tutorial vignettes 3. Advanced feature vignettes 4. Specialized topic vignettes

**For each vignette:** 1. Update class references 2. Update property access 3. Update method calls 4. Add examples of new features 5. Add migration notes if substantial changes 6. Test that code chunks run without errors: `r    devtools::build_vignettes()`

### Step 5.4: Run Full Package Check

``` r
# Full R CMD check
devtools::check()
```

**Fix all:** - Errors (blocking) - Warnings (should fix) - Notes (review, fix if reasonable)

**Common issues:** - Unused imports (remove old class references) - Missing exports (add new classes) - Documentation mismatches (rebuild docs) - Example failures (update examples)

### Step 5.5: Test with Real SLiM

**Run integration tests with actual SLiM:**

``` r
# Ensure SLiM is available
slimr::slim_is_avail()
slimr::slim_version()  # Should show new version

# Run package tests
devtools::test()

# Run examples from vignettes
# Run example scripts from inst/examples if present
```

**Manual testing checklist:** - \[ \] Create simple simulation - \[ \] Run simulation - \[ \] Capture and parse output - \[ \] Use new classes - \[ \] Use renamed properties - \[ \] Use changed methods - \[ \] Test parameter sweeps (templates) - \[ \] Test inline data injection - \[ \] Test autocomplete in RStudio

------------------------------------------------------------------------

## Phase 6: Documentation and Release {#phase-6-documentation-and-release}

### Step 6.1: Update CHANGELOG/NEWS

**File:** `NEWS.md`

Add a new section for the version:

``` markdown
# slimr X.Y.Z

## Major Changes

* Updated to support SLiM X.x (#issue)
* **BREAKING CHANGE:** Genome class replaced with Haplosome class
* **BREAKING CHANGE:** Property `genome1` renamed to `haploidGenome1`
* Added support for new Plot class
* Updated all documentation for SLiM X.x API

## New Features

* Added support for multi-chromosome simulations
* Added methods for [specific new features]

## Bug Fixes

* Fixed [issues related to upgrade]

## Deprecated

* `genome1`, `genome2` properties (use `haploidGenome1`, `haploidGenome2`)
* [Other deprecated features]

## Migration Guide

See `claude_notes/MIGRATION_GUIDE_vY_to_vX.md` for detailed migration instructions.
```

### Step 6.2: Create Migration Guide

**File:** `claude_notes/MIGRATION_GUIDE_vY_to_vX.md`

Create a user-friendly migration guide:

``` markdown
# Migration Guide: SLiM Y.x to X.x

## Quick Start

The most common changes you'll need to make:

1. Replace `Genome` with `Haplosome`
2. Replace `genome1` with `haploidGenome1`
3. Replace `genome2` with `haploidGenome2`
4. Replace `genomes` with `haplosomes`

## Detailed Changes

### Class Changes
[Detailed information]

### Property Changes
[Detailed information]

### Method Changes
[Detailed information]

### Code Examples

Before (SLiM Y.x):
[example code]

After (SLiM X.x):
[example code]
```

### Step 6.3: Update README

**File:** `README.md`

Update: - Installation instructions if needed - Supported SLiM version (update to X.x) - Basic examples (ensure they use new API) - Badges (if version-specific)

### Step 6.4: Update Package Documentation

**File:** `R/slimr-package.R`

Update package-level documentation:

``` r
#' @details
#' This version of slimr supports SLiM X.x.
#' For SLiM Y.x support, use slimr version Y.Y.Y.
```

### Step 6.5: Rebuild Documentation

``` r
# Rebuild all documentation
devtools::document()

# Rebuild pkgdown site if present
pkgdown::build_site()
```

### Step 6.6: Version Bump

**File:** `DESCRIPTION`

Update version following semantic versioning: - **Major version bump** (X.0.0) for breaking API changes - **Minor version bump** (X.Y.0) for backward-compatible additions - **Patch version bump** (X.Y.Z) for backward-compatible bug fixes

For SLiM major version updates with breaking changes:

```         
Version: 2.0.0  # If breaking changes (recommended)
```

### Step 6.7: Final Package Check

``` r
# Final comprehensive check
devtools::check(cran = TRUE)

# Build package
devtools::build()

# Install locally and test
devtools::install()

# Test in clean session
# Restart R
library(slimr)
# Run basic tests
```

------------------------------------------------------------------------

## Troubleshooting {#troubleshooting}

### Common Issues and Solutions

#### Issue: Missing Properties After Extraction

**Symptom:** Property count much lower than expected, tag properties missing

**Cause:** Control characters not cleaned before parsing

**Fix:** 1. Check that `clean_control_chars()` is called BEFORE parsing 2. Verify it converts 0x13 → `-` and 0xA0 → (space) 3. Clear cached `_unrtf.txt` files and re-run 4. Check the pattern matches: `<->` not `<–>` (en-dash)

#### Issue: Methods Not Extracted

**Symptom:** Method count zero or very low

**Cause:** Method signature pattern doesn't match actual format

**Fix:** 1. Look at the `_unrtf.txt` file directly 2. Find a method signature in the text 3. Check the hex values of special characters 4. Update pattern to match actual format 5. After control char cleanup, should match: `^- \(`

#### Issue: Parse Errors in Generated Code

**Symptom:** R/slim_lang_vX.R has syntax errors

**Cause:** Special characters in descriptions not escaped

**Fix:** 1. Add more character replacements to cleanup section 2. Common culprits: curly quotes, special apostrophes, em-dash 3. Use `find_nonascii.R` to identify problem characters 4. Add replacements in generation script

#### Issue: Class Objects Not Working

**Symptom:** Classes undefined, autocomplete doesn't work

**Cause:** sysdata.rda not created or not loaded

**Fix:** 1. Check that `usethis::use_data(..., internal = TRUE)` ran 2. Verify `R/sysdata.rda` exists 3. Check it loads: `load("R/sysdata.rda"); ls()` 4. Rebuild and reinstall package: `devtools::install()` 5. Restart R session

#### Issue: Tests Failing After Update

**Symptom:** Unit tests fail with old class/property names

**Cause:** Tests not updated for new API

**Fix:** 1. Update test expectations for new names 2. Update test scripts to use new classes 3. Add skip conditions if testing version-specific features 4. Consider adding backward compatibility tests

#### Issue: Vignettes Won't Build

**Symptom:** Vignette build fails with errors

**Cause:** Example code uses old API

**Fix:** 1. Update vignette code chunks systematically 2. Test each code chunk individually 3. Update output expectations 4. Consider adding version notes in vignettes

------------------------------------------------------------------------

## Automation Notes for AI Agents {#automation-notes-for-ai-agents}

This section provides guidance for AI agents (like Claude) attempting to automate parts of this process.

### Fully Automatable Steps

These steps can be fully automated:

1.  **Downloading RTF files** - Use curl/wget commands
2.  **Running extraction script** - Execute R script, parse output
3.  **Running comparison script** - Execute R script, parse output
4.  **Running generation script** - Execute R script, verify files created
5.  **Creating directory structure** - Standard filesystem operations
6.  **Moving/organizing files** - Standard filesystem operations
7.  **Running package checks** - Execute devtools functions, parse output

### Partially Automatable Steps

These require human judgment but can be assisted:

1.  **Reviewing changelog** - Can fetch and parse, but human should interpret
2.  **Creating breaking changes report** - Can template and populate, but needs review
3.  **Updating translation code** - Can identify locations, suggest changes, but needs validation
4.  **Writing tests** - Can generate test templates, but coverage decisions need human input
5.  **Updating vignettes** - Can update syntax, but pedagogical flow needs human review

### Human-Required Steps

These critically require human judgment:

1.  **Determining class abbreviations** - Requires understanding of naming conventions and conflicts
2.  **Deciding backward compatibility strategy** - Business/API design decision
3.  **Assessing breaking change impact** - Requires understanding user base
4.  **Writing migration guide** - Requires understanding user workflows
5.  **Final quality review** - Overall assessment of readiness

### Automation Strategy for AI Agents

**Phase 1-2 (Extraction): High Automation Potential** - Can run extraction pipeline autonomously - Should verify output quality automatically - Should flag unusual results for human review

**Phase 3 (Comparison): Medium Automation Potential** - Can run comparison autonomously - Can generate structured report - Should present summary to human for validation - Should fetch and include changelog for human review

**Phase 4 (Code Updates): Medium Automation Potential** - Can identify files needing updates - Can suggest specific changes - Should ask human to confirm class abbreviations - Should ask human to confirm backward compatibility approach - Should make changes with human approval

**Phase 5 (Testing): Medium Automation Potential** - Can run automated tests - Can identify failing tests - Can suggest test updates - Should have human review test coverage

**Phase 6 (Documentation): Low Automation Potential** - Can update version numbers and dates - Can generate template migration guide - Human should review all user-facing documentation - Human should write release notes

### Error Handling for Automation

**If extraction yields unexpected results:** 1. Check property count - should be similar to previous version 2. Check method count - should be similar to previous version 3. Check for tag properties - should be present in most classes 4. If counts way off, STOP and alert human

**If comparison shows massive changes:** 1. Verify you're comparing correct versions 2. Check changelog mentions these changes 3. If mismatch, STOP and alert human

**If generated code has syntax errors:** 1. Try re-running with cleaned text 2. Check for unhandled special characters 3. If persists after retry, STOP and alert human

**If tests fail after updates:** 1. Categorize failures (syntax vs. logic vs. API) 2. Fix obvious syntax issues 3. For logic/API failures, present to human

### Autonomous Execution Workflow

For a well-structured autonomous run:

```         
1. [AUTO] Create build directory
2. [AUTO] Download RTF files
3. [AUTO] Run extraction
4. [AUTO] Verify extraction quality
   - IF quality check fails → STOP, alert human
5. [AUTO] Run comparison
6. [AUTO] Fetch changelog
7. [HUMAN] Review comparison + changelog, approve continuation
8. [AUTO] Generate R documentation
9. [AUTO] Verify generation success
10. [HUMAN] Confirm class abbreviations
11. [HUMAN] Confirm backward compatibility strategy
12. [AUTO WITH APPROVAL] Update translation code
13. [AUTO WITH APPROVAL] Update class environment code
14. [AUTO] Run package check
15. [HUMAN] Review check results, approve fixes
16. [AUTO WITH APPROVAL] Update tests
17. [AUTO WITH APPROVAL] Update vignettes
18. [AUTO] Run final package check
19. [HUMAN] Review documentation
20. [HUMAN] Approve release
```

### Communication Protocol for AI Agents

When working with a human on this process:

**At each phase transition:** 1. Summarize what was accomplished 2. Present key statistics (counts, changes, etc.) 3. Highlight any unexpected results 4. Present options for next phase 5. Get explicit approval to continue

**When encountering issues:** 1. Describe the issue clearly 2. Explain what was attempted 3. Present diagnostic information 4. Suggest potential solutions 5. Ask for guidance rather than making assumptions

**When making changes:** 1. Explain what will be changed and why 2. Show examples of changes 3. Estimate scope (how many files affected) 4. Get approval before executing 5. Confirm changes worked as expected

------------------------------------------------------------------------

## Appendix A: File Locations Reference

### Source Files (inputs)

```         
data-raw/slim_man/SLiMHelpClasses.rtf        # From SLiM repo
data-raw/slim_man/SLiMHelpFunctions.rtf      # From SLiM repo
data-raw/build_Y/                            # Previous version data
```

### Build Files (per version)

```         
data-raw/build_X/extract_from_rtf.R          # Extraction script
data-raw/build_X/generate_slim_lang_vX.R     # Generation script
data-raw/build_X/compare_vY_vX.R             # Comparison script
data-raw/build_X/all_methods_data.rds        # Extracted methods
data-raw/build_X/all_properties_data.rds     # Extracted properties
data-raw/build_X/slim_lang_intros.rds        # Class introductions
data-raw/build_X/vY_vX_comparison.rds        # Comparison results
```

### Output Files (package)

```         
R/slim_lang_vX.R                              # Roxygen documentation
R/sysdata.rda                                 # Class objects (internal)
data/slim_classes.rda                         # Class lookup (external)
```

### Core Code Files to Update

```         
R/slimr_code.R                                # Translation functions
R/slimr_script.R                              # Scripting functions
R/zzz.R                                       # Package initialization
R/slim_callbacks.R                            # Callback definitions
```

### Documentation Files

```         
NEWS.md                                       # Changelog
README.md                                     # Package readme
DESCRIPTION                                   # Package metadata
claude_notes/BREAKING_CHANGES_vY_to_vX.md    # Breaking changes
claude_notes/MIGRATION_GUIDE_vY_to_vX.md     # User migration guide
```

------------------------------------------------------------------------

## Appendix B: Quality Checklist

Use this checklist to ensure a complete upgrade:

### Phase 1: Preparation

-   [ ] RTF files downloaded from SLiM repo
-   [ ] Build directory created
-   [ ] Changelog reviewed and noted
-   [ ] Upgrade plan created

### Phase 2: Extraction

-   [ ] Extraction script runs without errors
-   [ ] Property count reasonable (\~150-250)
-   [ ] Method count reasonable (\~200-300)
-   [ ] Tag properties present in output
-   [ ] Class introductions extracted
-   [ ] All RDS files created

### Phase 3: Comparison & Analysis

-   [ ] Comparison script runs without errors
-   [ ] Results match changelog
-   [ ] Breaking changes documented
-   [ ] New classes identified
-   [ ] Removed classes identified
-   [ ] Property changes catalogued
-   [ ] Method changes catalogued
-   [ ] Impact assessment completed

### Phase 4: Code Updates

-   [ ] R documentation generated (R/slim_lang_vX.R)
-   [ ] Class objects created (R/sysdata.rda)
-   [ ] Class lookup created (data/slim_classes.rda)
-   [ ] Translation code updated
-   [ ] Class environment updated
-   [ ] Autocomplete updated
-   [ ] Helper functions updated

### Phase 5: Testing

-   [ ] Unit tests updated
-   [ ] Unit tests pass
-   [ ] Integration tests updated
-   [ ] Integration tests pass
-   [ ] Vignettes updated
-   [ ] Vignettes build successfully
-   [ ] Examples tested with real SLiM
-   [ ] Package check passes (devtools::check())

### Phase 6: Documentation

-   [ ] NEWS.md updated
-   [ ] Migration guide created
-   [ ] README updated
-   [ ] Package documentation updated
-   [ ] Version number bumped
-   [ ] pkgdown site rebuilt (if applicable)
-   [ ] Final package check passes

### Release Readiness

-   [ ] All tests pass
-   [ ] Documentation complete
-   [ ] Examples working
-   [ ] No outstanding TODO items
-   [ ] Git repository clean
-   [ ] Ready for CRAN (if applicable)

------------------------------------------------------------------------

## Appendix C: Version History of This Guide

-   **v1.0 (2025-10-21):** Initial version created during SLiM 4.x → 5.x upgrade
    -   Documents complete process from RTF extraction through release
    -   Includes automation guidance for AI agents
    -   Includes troubleshooting section

------------------------------------------------------------------------

**End of Guide**

For questions or issues with this process, consult: - `CLAUDE.md` - Project instructions for AI assistants - `claude_notes/` - Additional documentation and analysis - SLiM manual - https://messerlab.org/slim/ - SLiM GitHub - https://github.com/MesserLab/SLiM