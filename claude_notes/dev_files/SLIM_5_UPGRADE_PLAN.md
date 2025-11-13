# SLiM 5.x Upgrade Plan for slimr Package

**Date**: 2025-10-20
**SLiM Version**: 5.1
**Current slimr Compatibility**: 4.x

## Executive Summary

This document outlines the plan for upgrading the slimr R package to support SLiM version 5.x. The upgrade involves:

1. **Automated extraction** of API information from RTF files in SLiM's GitHub repository
2. **Regeneration** of R stub functions for all SLiM classes, methods, and properties with complete documentation
3. **Code updates** to handle any breaking changes in SLiM 5.x
4. **Testing** to ensure compatibility

### Key Decision: RTF Files as Primary Source

After investigation, **RTF files from SLiM's GitHub repository** are the ideal source:
- ✅ Contains complete descriptions (not just signatures)
- ✅ Source of truth (where manual text comes from)
- ✅ Fully automated extraction (no manual copy/paste)
- ✅ Same quality as current excellent v4 documentation
- ✅ Faster implementation (4-7 hours saved vs PDF approach)

See [FINAL_RTF_RECOMMENDATION.md](data-raw/FINAL_RTF_RECOMMENDATION.md) for detailed analysis.

---

## Quick Start Guide

### Prerequisites (Already Completed)

1. **SLiM 5.1 installed**:
   ```r
   # Already done via conda
   # Location: C:/Users/dinnage/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe
   # Verify with: system2(Sys.getenv('SLIM_PATH'), '-version')
   ```

2. **RTF files downloaded**:
   - `data-raw/slim_man/SLiMHelpClasses.rtf` (627 KB)
   - `data-raw/slim_man/SLiMHelpFunctions.rtf` (151 KB)
   - Source: https://github.com/MesserLab/SLiM/tree/master/SLiMgui

3. **R packages needed**:
   ```r
   # Already installed
   install.packages(c("striprtf", "stringr", "dplyr", "purrr", "tidyr", "glue", "readr"))
   ```

### What You Need to Know

**Current v4 Documentation Format** (target to replicate):
- Located in: `R/slim_lang.R` (~23,800 lines)
- Structure: Roxygen2 documentation + stub functions
- Example function: `initializeAncestralNucleotides()` (lines 1-54)
- Example class method: `ancestralNucleotides()` (documented but not exported)
- Properties: Assigned in `R/sysdata.rda` internal data

**Current v4 Build Process** (to adapt for v5):
- Script: `data-raw/build_slimrlang.R`
- Input: Manual text files in `data-raw/build_4/slim_reference/`
- Process: Parse text → generate roxygen → write `R/slim_lang.R`
- Key functions to reuse:
  - `make_slim_function()` - generates roxygen documentation
  - `make_class_funcs()` - generates all methods for a class
  - `create_properties()` - generates property assignments
  - `make_class_roxy()` - generates class documentation pages

**RTF File Structure** (what you'll be parsing):
```
5.2  Class Chromosome

5.2.1  Chromosome properties

colorSubstitution <–> (string$)
[full description paragraph]

geneConversionEnabled => (logical$)
[full description paragraph]

5.2.2  Chromosome methods

– (is)ancestralNucleotides([Ni$ start = NULL], [Ni$ end = NULL], [string$ format = "string"])
[full detailed description with parameters explained]
```

**Key Patterns to Extract**:
- Class headers: `^\d+\.\d+\s+Class\s+(\w+)`
- Property (R/W): `^([a-zA-Z]\w*)\s+<–>\s+\(([^)]+)\)`
- Property (R/O): `^([a-zA-Z]\w*)\s+=>\s+\(([^)]+)\)`
- Method: `^–\s+\(([^)]+)\)([a-zA-Z_]\w*)\((.*)$`

### First Steps (Phase 1)

1. **Create working directory**:
   ```r
   dir.create("data-raw/build_5", showWarnings = FALSE)
   ```

2. **Extract RTF to plain text**:
   ```r
   library(striprtf)
   classes_text <- read_rtf("data-raw/slim_man/SLiMHelpClasses.rtf")
   functions_text <- read_rtf("data-raw/slim_man/SLiMHelpFunctions.rtf")
   # Note: All text will be on one line - need to split intelligently
   ```

3. **Reference existing v4 code**:
   - Study: `data-raw/build_slimrlang.R` (current build process)
   - Study: `R/slim_lang.R` lines 1-200 (target format)
   - Reuse: Templates and generator functions

4. **Build Phase 1 script**:
   - File: `data-raw/build_5/extract_from_rtf.R`
   - Goal: Generate structured data matching v4 format
   - Output: `all_methods_data`, `all_properties_data`, `slim_lang_intros`

### Expected Data Structure (Phase 1 Output)

Your extraction should produce data matching the v4 format. Example from `build_slimrlang.R`:

```r
# all_methods_data is a named list of tibbles (one per class)
all_methods_data <- list(
  Initialize = tibble(
    function_name = c("initializeAncestralNucleotides", "initializeGeneConversion", ...),
    return_type = c("is", "void", ...),
    return_type_desc = c("integer or string", "void", ...),
    return_singleton = c(TRUE, FALSE, ...),
    arguments = list(...),  # list column with parameter data
    arg_data = list(...),   # list column with parsed parameter tibbles
    description = c("This function, which may be called...", ...)
  ),
  Chromosome = tibble(
    function_name = c("ancestralNucleotides", "drawBreakpoints", ...),
    # ... same structure as above
  ),
  # ... more classes
)

# all_properties_data is a named list of tibbles (one per class)
all_properties_data <- list(
  Chromosome = tibble(
    property = c("colorSubstitution", "geneConversionEnabled", ...),
    symbol = c("<–>", "=>", ...),  # <–> = read-write, => = read-only
    property_type = c("s$", "l$", ...),
    property_type_desc = c("string", "logical", ...),
    property_singleton = c(TRUE, TRUE, ...),
    modifiable = c("a variable, so it is modifiable", "a constant...", ...),
    description = c("The color used to display...", ...)
  ),
  # ... more classes
)

# slim_lang_intros is a named character vector
slim_lang_intros <- c(
  Chromosome = "This class represents a chromosome...",
  Community = "This class represents the simulation community...",
  # ... more classes
)
```

### Testing Your Extraction

After building your extraction script, verify:

```r
# Load and run your extraction
source("data-raw/build_5/extract_from_rtf.R")

# Check structure matches v4
names(all_methods_data)  # Should have ~15-20 classes
names(all_properties_data)  # Same classes

# Spot check
all_methods_data$Chromosome  # Should have ~10-20 methods
all_properties_data$Chromosome  # Should have ~30-40 properties

# Compare with v4 counts
load("data/slim_classes.rda")
slim_classes  # See what classes exist in v4
```

---

## Current State

### ✅ Completed Preparation Steps

1. **Branch Status**: ✅ Develop branch is up-to-date with master (except version number)
   - Latest commits on develop include CI/CD improvements and R CMD CHECK fixes
   - Ready for new development work

2. **SLiM 5.1 Installation**: ✅ Successfully installed via slimr
   - Location: `C:/Users/dinnage/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe`
   - Version confirmed: `SLiM version 5.1, built Sep 12 2025`
   - Warning acknowledged: slimr currently only fully compatible with 4.x

3. **SLiM 5.x Manual**: ✅ Downloaded (960 pages, 38.6MB)
   - Location: `data-raw/slim_man/SLiM_Manual_5.x.pdf`
   - Format: PDF (for reference, not primary source)

4. **Current Implementation Analysis**: ✅ Analyzed `build_slimrlang.R`
   - Uses manual copy/paste to text files in `data-raw/build_4/slim_reference/`
   - Processes with pdftools, unglue, dplyr, stringr
   - Brittle: hardcoded page numbers, manual extraction
   - Generates ~23,800 lines in `R/slim_lang.R`

5. **Extraction Method Research**: ✅ Comprehensive investigation completed
   - **Recommended**: Extract from RTF files in SLiM GitHub repository
   - RTF files contain complete documentation text (not just signatures)
   - Test results: Successfully parsed 445KB of class documentation
   - `striprtf` package works perfectly for extraction
   - Full analysis:
     - `data-raw/RTF_EXTRACTION_RECOMMENDATION.md` (detailed research)
     - `data-raw/FINAL_RTF_RECOMMENDATION.md` (implementation guide)
     - `data-raw/test_rtf_detailed.R` (working test code)

---

## New Extraction Approach

### Why RTF Files from SLiM GitHub?

The SLiM source repository includes RTF documentation files that contain ALL the text used in the manual, in a machine-readable format:

**The Files**:
- **SLiMHelpClasses.rtf** (627 KB) - All classes with properties and methods
- **SLiMHelpFunctions.rtf** (151 KB) - All initialization and Eidos functions
- **Source**: https://github.com/MesserLab/SLiM/tree/master/SLiMgui

**Advantages**:
- ✅ **Complete detailed descriptions**: Full text for @details sections
- ✅ **Authoritative source**: Maintained in SLiM's source repository
- ✅ **Version controlled**: Can track API changes between versions
- ✅ **Fully automated**: No manual copy/paste needed
- ✅ **Same quality as current v4**: These files are the source of the manual text
- ✅ **Easy to parse**: `striprtf` package converts to plain text

**Format Example (after RTF extraction)**:
```
5.2  Class Chromosome

5.2.1  Chromosome properties

colorSubstitution <–> (string$)
The color used to display substitutions in SLiMgui when both mutations
and substitutions are being displayed in the chromosome view...
[full description paragraph]

geneConversionEnabled => (logical$)
When gene conversion has been enabled by calling initializeGeneConversion(),
switching to the DSB recombination model, this property is T...
[full description paragraph]

5.2.2  Chromosome methods

– (is)ancestralNucleotides([Ni$ start = NULL], [Ni$ end = NULL], [string$ format = "string"])
Returns the ancestral nucleotide sequence originally supplied to
initializeAncestralNucleotides(), including any sequence changes...
[full detailed description with parameters explained]
```

**Extraction Patterns**:
- Class headers: `^\d+\.\d+\s+Class\s+(\w+)`
- Section headers: `"Chromosome properties"`, `"Chromosome methods"`
- Property (R/W): `^([a-zA-Z]\w*)\s+<–>\s+\(([^)]+)\)`
- Property (R/O): `^([a-zA-Z]\w*)\s+=>\s+\(([^)]+)\)`
- Method: `^–\s+\(([^)]+)\)([a-zA-Z_]\w*)\((.*)$`
- Descriptions: Text following each definition until next definition/section

---

## Implementation Plan

### Phase 1: Build RTF Extraction Pipeline ⭐ (IMMEDIATE)

**Goal**: Extract complete API documentation from RTF files in SLiM GitHub repository

**Steps**:

1. **Download RTF Files from SLiM GitHub**
   - Download `SLiMHelpClasses.rtf` (627 KB)
   - Download `SLiMHelpFunctions.rtf` (151 KB)
   - Source: https://github.com/MesserLab/SLiM/tree/master/SLiMgui
   - Already downloaded to `data-raw/slim_man/`
   - **Deliverable**: RTF files ready for parsing

2. **Extract Plain Text from RTF**
   - Use `striprtf::read_rtf()` to convert RTF to plain text
   - Handle the fact that all text is on one line (no line breaks)
   - Split text intelligently using structural markers
   - **Deliverable**: Plain text extracted from RTF

3. **Parse Classes Structure**
   - Find class boundaries: `"5.2  Class Chromosome"`
   - Split into sections: properties, methods
   - Extract property definitions: `propertyName <–> (type)` or `propertyName => (type)`
   - Extract property descriptions (text after property until next property/section)
   - Extract method signatures: `– (returnType)methodName(params)`
   - Extract method descriptions (text after method until next method/section)
   - **Deliverable**: Structured tibbles by class

4. **Parse Functions Structure**
   - Find function signatures: `(returnType)functionName(params)`
   - Extract function descriptions
   - Parse parameter information from inline descriptions
   - **Deliverable**: Structured tibbles for initialize/Eidos functions

5. **Build Data Matching Current Format**
   - Create `all_methods_data` (same structure as v4 `build_slimrlang.R`)
   - Create `all_properties_data` (same structure as v4)
   - Create `slim_lang_intros` (class introduction text)
   - Decode type system: `i$` → integer singleton, etc.
   - Parse argument strings into structured format
   - **Deliverable**: Data ready for existing roxygen generators

6. **Identify New/Changed Classes**
   - Compare SLiM 5.x classes with SLiM 4.x (from existing `slim_classes` data)
   - Flag: NEW classes, REMOVED classes, UNCHANGED classes
   - **Deliverable**: Comparison report showing changes

**Expected Effort**: 4-6 hours
**Expected Output**: Complete extraction pipeline in `data-raw/build_5/extract_from_rtf.R`

---

### Phase 2: Generate R Stubs for SLiM 5.x

**Goal**: Create new `R/slim_lang_v5.R` with complete documentation matching v4 quality

**Steps**:

1. **Reuse Existing Roxygen Generators** (minimal changes needed)
   - Templates from `build_slimrlang.R` already work with tibble format:
     - `func_template` - For Initialize/Eidos function documentation
     - `method_code` - For class method stubs (internal)
     - `class_roxy` - For class documentation pages
     - `property_roxy` - For property documentation
   - Update copyright year (2016-2025)
   - Remove manual PDF page references (RTF doesn't have page numbers)
   - **Deliverable**: Reusable template generators

2. **Generate Initialize/Eidos Functions** (exported)
   - For each function from `SLiMHelpFunctions.rtf`:
     - Complete roxygen documentation with @details from RTF descriptions
     - @param tags for each parameter
     - @return type information
     - @examples section
     - Exported stub function
   - **Deliverable**: Exported functions (e.g., `initializeAncestralNucleotides()`)

3. **Generate Class Method Documentation** (internal)
   - For each method from `SLiMHelpClasses.rtf`:
     - Complete roxygen documentation with @details from RTF descriptions
     - @param tags for each parameter
     - @return type information
     - @aliases for `ClassName$method` and `.ClassAbbr$method`
   - Methods assigned internally via `R/sysdata.rda`, not exported
   - **Deliverable**: Method documentation blocks

4. **Generate Property Definitions**
   - For each property:
     - Create assignment: `ClassName$property <- ClassAbbr$property <- 'property'`
     - Include in class documentation page
   - **Deliverable**: Property assignment code for internal data

5. **Generate Class Documentation Pages**
   - For each class:
     - Class introduction text (from RTF)
     - List of all methods with links
     - List of all properties with descriptions (from RTF)
     - Superclass information
   - **Deliverable**: Complete class documentation pages

6. **Assemble and Write Output**
   - Combine all generated roxygen documentation
   - Add exported Initialize/Eidos stub functions
   - Apply text cleanup (smart quotes, escapes, wrapping)
   - Verify R syntax with `parse()`
   - Write to `R/slim_lang_v5.R`
   - **Deliverable**: New `R/slim_lang_v5.R` (~25,000+ lines)

7. **Create Internal Class Objects**
   - Generate class lists: `ClassName <- ClassAbbr <- .ClassInternal <- list()`
   - Assign methods: `.ClassInternal$method <- function() {...}`
   - Assign properties: `.ClassInternal$property <- 'property'`
   - Save to `R/sysdata.rda`
   - Update `data/slim_classes.rda` with v5 class info
   - **Deliverable**: Updated internal class data

**Expected Effort**: 2-3 hours (reusing existing generators)
**Expected Output**: `R/slim_lang_v5.R` with complete, high-quality documentation

---

### Phase 3: Identify Breaking Changes

**Goal**: Document what changed between SLiM 4.x and 5.x that affects slimr code

**Steps**:

1. **Compare Class Lists**
   - SLiM 4.x classes (from current `slim_classes`):
     - Chromosome, Community, Genome, GenomicElement, GenomicElementType
     - Individual, InteractionType, LogFile, Mutation, MutationType
     - SLiMEidosBlock, SpatialMap, Species, Subpopulation, Substitution
   - SLiM 5.x classes (from extraction):
     - Identify NEW classes (not in 4.x)
     - Identify REMOVED classes (in 4.x, not in 5.x)
   - **Deliverable**: Class comparison report

2. **Compare Method Signatures**
   - For each class present in both versions:
     - Methods added in 5.x
     - Methods removed from 4.x
     - Methods with changed signatures (params, return types)
   - **Deliverable**: Method changes report

3. **Compare Property Definitions**
   - Properties added/removed
   - Type changes
   - Modifiability changes (read-only ↔ read-write)
   - **Deliverable**: Property changes report

4. **Check SLiM Release Notes**
   - Review official SLiM 5.x changelog
   - Identify breaking changes mentioned
   - Cross-reference with extracted differences
   - **Deliverable**: Release notes summary

5. **Test Current slimr Examples**
   - Run existing vignettes/examples against SLiM 5.1
   - Document errors/warnings
   - Identify what breaks
   - **Deliverable**: Compatibility test report

**Expected Effort**: 3-5 hours
**Expected Output**: Comprehensive breaking changes document

---

### Phase 4: Update slimr Code for SLiM 5.x

**Goal**: Fix code to handle SLiM 5.x changes

**Steps**:

1. **Update Package Metadata**
   - Bump version: `0.4.1.9000` → `0.5.0` (major version for SLiM 5 support)
   - Update DESCRIPTION: note SLiM 5.x compatibility
   - Update NEWS.md: document SLiM 5 support and breaking changes
   - **Deliverable**: Updated package metadata

2. **Replace `R/slim_lang.R`**
   - Backup old version: `R/slim_lang_v4.R` (for reference)
   - Replace with: `R/slim_lang_v5.R`
   - **Deliverable**: Updated API definitions

3. **Update Version Detection**
   - Modify `slim_version()` to handle 5.x
   - Update compatibility warnings in `slim_setup()`
   - Remove "only compatible with 4.x" warnings
   - Add "5.x supported" messaging
   - **Deliverable**: Updated version handling

4. **Fix Breaking Changes**
   - Based on Phase 3 findings, update:
     - Code that uses removed methods
     - Code that uses changed signatures
     - Code that references removed classes
   - Locations to check:
     - `R/slimr_script.R` - Script building
     - `R/slim_run.R` - Execution
     - `R/slim_extract.R` - Output parsing
     - Vignettes - Examples
   - **Deliverable**: Fixed code

5. **Update Documentation**
   - Regenerate with `devtools::document()`
   - Update vignettes if SLiM 5 introduces new features
   - Update README with SLiM 5 compatibility note
   - **Deliverable**: Updated documentation

**Expected Effort**: 4-8 hours (depends on breaking changes)
**Expected Output**: SLiM 5.x compatible slimr package

---

### Phase 5: Testing & Validation

**Goal**: Ensure everything works with SLiM 5.1

**Steps**:

1. **Run Package Checks**
   ```r
   devtools::check()
   ```
   - Fix any new errors, warnings, or notes
   - Ensure R CMD CHECK passes cleanly
   - **Deliverable**: Clean check results

2. **Run Test Suite**
   ```r
   devtools::test()
   ```
   - All existing tests should pass (or be updated)
   - Add new tests for SLiM 5-specific features
   - **Deliverable**: Passing test suite

3. **Test Vignettes**
   ```r
   devtools::build_vignettes()
   ```
   - Ensure all examples run without errors
   - Update examples if SLiM 5 syntax changed
   - **Deliverable**: Working vignettes

4. **Test SLiM Recipes**
   ```r
   slimr::slim_get_recipe(1)
   # Test all recipes
   ```
   - Verify example scripts still work
   - Update for SLiM 5 if needed
   - **Deliverable**: Working recipes

5. **Manual Testing**
   - Create simple test script:
     ```r
     library(slimr)
     Sys.setenv(SLIM_PATH = 'C:/Users/dinnage/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe')

     script <- slim_script(
       slim_block(initialize(), {
         initializeMutationRate(1e-7)
         initializeMutationType("m1", 0.5, "f", 0.0)
         initializeGenomicElementType("g1", m1, 1.0)
         initializeGenomicElement(g1, 0, 99999)
         initializeRecombinationRate(1e-8)
       }),
       slim_block(1, {
         sim.addSubpop("p1", 500)
       }),
       slim_block(1000, {
         sim.simulationFinished()
       })
     )

     result <- slim_run(script)
     result$exit_status  # Should be 0
     ```
   - Test parameter sweeps
   - Test output capture
   - Test inlining
   - **Deliverable**: Manual test results

6. **CI/CD Updates**
   - Update GitHub Actions to test with SLiM 5.1
   - Modify `.github/workflows/R-CMD-check.yaml`:
     - Add `SLIM_VERSION=5.1` environment variable
     - Update conda installation to use SLiM 5.1
   - **Deliverable**: Updated CI/CD config

**Expected Effort**: 3-5 hours
**Expected Output**: Fully tested, validated package

---

### Phase 6: Documentation & Release

**Goal**: Document changes and prepare for release

**Steps**:

1. **Update NEWS.md**
   - Add section for version 0.5.0
   - Document SLiM 5.x support
   - List breaking changes
   - Note deprecated features
   - **Deliverable**: Updated NEWS.md

2. **Update README.md**
   - Update compatibility note: "Compatible with SLiM 4.x and 5.x"
   - Update installation instructions if needed
   - Add note about SLiM 5 features (if any)
   - **Deliverable**: Updated README.md

3. **Update Vignettes**
   - Review all vignettes for accuracy with SLiM 5
   - Add notes about version-specific features if needed
   - **Deliverable**: Updated vignettes

4. **Create Migration Guide**
   - Document for users upgrading from SLiM 4.x
   - List breaking changes
   - Provide code examples for common migrations
   - **Deliverable**: `vignettes/articles/migrating_to_slim5.Rmd`

5. **Update CLAUDE.md**
   - Update compatibility notes
   - Update SLiM version references
   - Note SLiM 5.x support in all relevant sections
   - **Deliverable**: Updated CLAUDE.md

6. **Prepare Release**
   - Finalize version number (0.5.0)
   - Create Git tag
   - Prepare release notes for GitHub
   - **Deliverable**: Release-ready package

**Expected Effort**: 2-4 hours
**Expected Output**: Documented, release-ready package

---

## Timeline Estimate

| Phase | Description | Effort | Dependencies |
|-------|-------------|--------|--------------|
| **1** | RTF extraction pipeline | 4-6 hrs | - |
| **2** | Generate R stubs | 2-3 hrs | Phase 1 |
| **3** | Identify breaking changes | 3-5 hrs | Phase 2 |
| **4** | Update slimr code | 4-8 hrs | Phase 3 |
| **5** | Testing & validation | 3-5 hrs | Phase 4 |
| **6** | Documentation & release | 2-4 hrs | Phase 5 |
| **TOTAL** | **End-to-end upgrade** | **18-31 hrs** | - |

**Realistic Timeline**: 2-4 days of focused work

**Note**: RTF approach is faster than originally planned (saved 4-7 hours) because:
- No PDF parsing complexity (columns, page breaks)
- Reusing existing roxygen generators (minimal adaptation)
- Complete descriptions already in RTF (no separate extraction needed)

---

## Risk Assessment

### Low Risk
- ✅ RTF extraction method proven (tested with `striprtf`, works perfectly)
- ✅ SLiM 5.1 installed and functional
- ✅ Template generation approach well-established (from v4 build, reusable)
- ✅ RTF files are authoritative source (maintained by SLiM developers)
- ✅ Existing test suite provides safety net

### Medium Risk
- ⚠️ **SLiM 5.x breaking changes unknown** - Could require significant code updates
  - *Mitigation*: Phase 3 will identify early; can adjust timeline
- ⚠️ **Type system changes** - SLiM 5 may use different type encoding
  - *Mitigation*: RTF uses same type abbreviation system as v4 manual
- ⚠️ **RTF text splitting** - All text on one line, need to split intelligently
  - *Mitigation*: Use consistent structural markers ("Class", "properties", "methods")
- ⚠️ **Description extraction** - Need to capture text between definitions
  - *Mitigation*: Sequential parsing with regex, tested approach

### Considerations
- Current test suite uses `skip_if_slim_not_installed()` - will need SLiM 5.1 in CI
- **Version Strategy**: Each slimr release will target one SLiM major version
  - slimr 0.4.x → SLiM 4.x
  - slimr 0.5.x → SLiM 5.x
  - Users needing older SLiM versions can install corresponding slimr version
  - No need to maintain dual compatibility (too complex)
  - Cleaner codebase, easier maintenance

---

## Success Criteria

✅ **Phase 1 Success**:
- Extraction pipeline runs without errors
- Extracts 100% of classes (currently ~67%, needs refinement)
- All methods and properties captured
- Type system fully decoded

✅ **Phase 2 Success**:
- `R/slim_lang_v5.R` generated successfully
- No R syntax errors
- Roxygen documentation complete
- All classes/methods/properties present

✅ **Phase 3 Success**:
- Complete list of breaking changes documented
- All new/removed/changed items identified
- Test results show what breaks with SLiM 5

✅ **Phase 4 Success**:
- All breaking changes addressed
- Package version updated to 0.5.0
- Code runs with SLiM 5.1

✅ **Phase 5 Success**:
- `devtools::check()` passes with 0 errors, 0 warnings
- All tests pass
- Vignettes build successfully
- Manual testing confirms functionality

✅ **Phase 6 Success**:
- Documentation updated and accurate
- Migration guide available
- Release notes complete
- Package ready for CRAN submission (if desired)

---

## Next Steps

**IMMEDIATE**: Begin Phase 1 - Build RTF extraction pipeline
1. Create `data-raw/build_5/` directory
2. Create `extract_from_rtf.R` script
3. Use `striprtf::read_rtf()` to extract plain text from RTF files
4. Parse structure to extract classes, methods, properties, and descriptions
5. Build structured data matching v4 format
6. Generate comparison with SLiM 4.x

**Once Phase 1 complete**: Decision point
- Review breaking changes
- Assess complexity of code updates needed
- Decide on timeline for Phases 2-6

---

## Resources

**Documentation**:
- SLiM 5.x RTF Files (PRIMARY SOURCE):
  - `data-raw/slim_man/SLiMHelpClasses.rtf` (627 KB)
  - `data-raw/slim_man/SLiMHelpFunctions.rtf` (151 KB)
  - Source: https://github.com/MesserLab/SLiM/tree/master/SLiMgui
- SLiM 5.x Manual PDF (reference): `data-raw/slim_man/SLiM_Manual_5.x.pdf`
- RTF extraction research:
  - `data-raw/RTF_EXTRACTION_RECOMMENDATION.md` (detailed analysis)
  - `data-raw/FINAL_RTF_RECOMMENDATION.md` (implementation guide)
  - `data-raw/test_rtf_detailed.R` (working test code)
- Current build script: `data-raw/build_slimrlang.R` (SLiM 4.x approach)

**SLiM Installation**:
- Executable: `C:/Users/dinnage/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe`
- Version: 5.1 (Sep 12 2025 build)

**Key Files to Update**:
- `R/slim_lang.R` → Replace with v5 version
- `R/slim_setup.R` → Remove 4.x-only warnings
- `DESCRIPTION` → Version bump, compatibility note
- `NEWS.md` → Release notes
- `.github/workflows/R-CMD-check.yaml` → SLiM 5.1 in CI

---

## Key Decisions Made

1. **✅ Backward compatibility**: RESOLVED
   - **Decision**: No dual compatibility (too complex)
   - **Strategy**: One slimr version per SLiM major version
   - slimr 0.4.x → SLiM 4.x (current)
   - slimr 0.5.x → SLiM 5.x (this upgrade)
   - Users can install older slimr versions if needed

2. **✅ Documentation source**: RESOLVED
   - **Decision**: Use RTF files from SLiM GitHub repository
   - **Rationale**:
     - Complete descriptions (not just signatures)
     - Authoritative source (maintained by SLiM developers)
     - Same quality as current excellent v4 documentation
     - Fully automated extraction

3. **❓ CRAN release**: TBD
   - Question: Is this a CRAN update or GitHub-only?
   - Considerations: CRAN has stricter checks, broader reach
   - Recommendation: Target CRAN release for broader user base

4. **❓ Version bump strategy**: TBD
   - Question: 0.5.0 (recommended) or 1.0.0?
   - Recommendation: 0.5.0 (major version for SLiM 5 support)
   - Semantic versioning: Major SLiM upgrade = minor slimr version bump

---

## Conclusion

The upgrade to SLiM 5.x is achievable with a clear path forward:

1. ✅ **Preparation complete** - SLiM 5.1 installed, RTF files downloaded, research done
2. ⭐ **RTF approach validated** - Complete documentation extraction tested and working
3. 📋 **Plan established** - 6 phases, ~18-31 hours total effort
4. 🎯 **Success criteria defined** - Clear metrics for each phase
5. 🚀 **Ready to begin** - Phase 1 can start immediately
6. 📖 **Documentation quality assured** - Will match current excellent v4 documentation

The RTF extraction method represents a significant improvement over the manual approach:
- Fully automated (no manual copy/paste)
- Source of truth (maintained by SLiM developers)
- Complete descriptions (same as current v4)
- Faster implementation (4-7 hours saved)
- Easier to update for future SLiM versions

**Version Strategy**: Each slimr release targets one SLiM major version. Users needing SLiM 4.x can continue using slimr 0.4.x. This keeps the codebase clean and maintainable.

**Recommended**: Proceed with Phase 1 immediately to build the RTF extraction pipeline, then continue through Phase 2 to generate the complete v5 documentation.

---

## Troubleshooting Guide

### Common Issues and Solutions

**Issue: RTF extraction gives all text on one line**
- **Expected**: This is normal behavior of `striprtf::read_rtf()`
- **Solution**: Split text using structural markers (class headers, section headers, definitions)

**Issue: Can't find class boundaries**
- **Solution**: Look for pattern `\d+\.\d+\s+Class\s+\w+` (e.g., "5.2  Class Chromosome")
- **Tip**: Section numbers change between versions, but format stays consistent

**Issue: Property/method descriptions span multiple properties/methods**
- **Solution**: Description ends when you hit next definition (next property/method signature)
- **Pattern**: Capture everything until next line matching a signature pattern

**Issue: Multi-line method signatures**
- **Example**: Long parameter lists wrap across lines in RTF
- **Solution**: Join lines that don't start with a signature marker
- **Check**: Parameters in `[...]` or continuing from previous line

**Issue: Type abbreviations unclear**
- **Reference**: `build_slimrlang.R` lines 90-92 has `type_legend`
- **Common**: `i$` = integer singleton, `f` = float, `s$` = string singleton, `o<Class>` = object
- **Function**: Reuse `collect_types()` from v4 script (lines 138-167)

**Issue: Generated roxygen doesn't validate**
- **Check**: Quote escaping (smart quotes → straight quotes)
- **Check**: Backslash escaping (`\t` → `\\t`, `\n` → `\\n`)
- **Reference**: `build_slimrlang.R` lines 728-756 for text cleanup

**Issue: Class abbreviations missing**
- **Reference**: `build_slimrlang.R` lines 436-456 has `class_abbrs` tibble
- **Known**: Chromosome=Ch, Community=Co, Genome=G, Individual=In, etc.
- **Action**: Verify SLiM 5 hasn't changed these

### Debugging Tips

1. **Test on one class first**: Start with Chromosome (well-documented, good test case)

2. **Print intermediate results**:
   ```r
   # After parsing
   cat("Found", length(class_headers), "classes\n")
   cat("Classes:", paste(class_names, collapse = ", "), "\n")
   ```

3. **Compare with v4**:
   ```r
   # Load v4 data
   source("data-raw/build_slimrlang.R", local = v4 <- new.env())

   # Compare structure
   str(v4$all_methods_data$Chromosome)
   str(your_all_methods_data$Chromosome)
   ```

4. **Validate incrementally**: Test each parsing step separately before combining

---

## Reference Materials

### Key Files to Study

**Current Build Process**:
- `data-raw/build_slimrlang.R` - Complete v4 build script
  - Lines 90-92: Type legend
  - Lines 138-167: `collect_types()` function
  - Lines 202-275: `extract_methods()` function
  - Lines 317-346: `func_template` for roxygen
  - Lines 391-422: `make_slim_function()` generator
  - Lines 728-760: Text cleanup

**Target Output Format**:
- `R/slim_lang.R` - Generated documentation
  - Lines 1-54: Initialize function example
  - Lines 56-142: Another function example
  - Browse entire file to understand structure

**Internal Data**:
- `R/sysdata.rda` - Class objects with method/property assignments
- `data/slim_classes.rda` - Public class lookup table

**Supporting Documentation**:
- `data-raw/FINAL_RTF_RECOMMENDATION.md` - Complete RTF analysis and implementation guide
- `data-raw/RTF_EXTRACTION_RECOMMENDATION.md` - Detailed research findings
- `data-raw/test_rtf_detailed.R` - Working RTF extraction test code

### SLiM v4 Classes (For Comparison)

From `data/slim_classes.rda`:
- Chromosome, Community, Genome, GenomicElement, GenomicElementType
- Individual, InteractionType, LogFile, Mutation, MutationType
- SLiMEidosBlock, SpatialMap, Species, Subpopulation, Substitution

Expect SLiM 5 may have added/removed classes - this is one goal of Phase 1.

### External Resources

- SLiM Manual: http://benhaller.com/slim/SLiM_Manual.pdf
- SLiM GitHub: https://github.com/MesserLab/SLiM
- RTF Source Files: https://github.com/MesserLab/SLiM/tree/master/SLiMgui
- slimr Documentation: https://rdinnager.github.io/slimr/

---

## Final Checklist Before Starting

- [ ] Read this entire plan document
- [ ] Review `data-raw/build_slimrlang.R` to understand v4 process
- [ ] Review `R/slim_lang.R` lines 1-200 to see target output format
- [ ] Examine RTF files to understand structure
- [ ] Read `data-raw/FINAL_RTF_RECOMMENDATION.md` for detailed implementation guide
- [ ] Create `data-raw/build_5/` directory
- [ ] Have `striprtf`, `stringr`, `dplyr`, `purrr` packages installed
- [ ] Understand the data structure you need to produce (see Quick Start Guide above)

**You're ready when you can answer**:
- What data structure does Phase 1 need to produce? (Answer: `all_methods_data`, `all_properties_data`, `slim_lang_intros`)
- Where are the roxygen generator functions? (Answer: `build_slimrlang.R`)
- What's the difference between Initialize functions and class methods? (Answer: Initialize exported, class methods internal)
- How do I verify my extraction worked? (Answer: Compare structure and counts with v4)

Good luck with the implementation!
