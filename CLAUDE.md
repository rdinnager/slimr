# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

**slimr** is an R package that enables population genetics forward simulation using the SLiM software from within R. It provides a comprehensive bridge between R and SLiM, allowing users to write SLiM scripts using R syntax, dynamically inject R data into simulations, capture and parse simulation output, and apply templating for parameter sweeps.

## Version Compatibility Policy

**CRITICAL DECISION - DO NOT FORGET:**

- **slimr v0.5.0+ supports ONLY SLiM 5.x**
- **slimr v0.4.x supports ONLY SLiM 4.x**
- **NO backward compatibility** - each major slimr version supports only the corresponding SLiM major version
- Users needing SLiM 4.x should use slimr v0.4.x releases
- This is a **clean break** approach - do not implement dual version support

**Why this matters:**
- SLiM 5.x has breaking API changes (Genome → Haplosome, property renames, etc.)
- Maintaining dual support is complex and error-prone
- Clean versioning makes maintenance easier
- Users can pin slimr version to match their SLiM version

**When upgrading to new SLiM major versions:**
- Create new slimr major version (e.g., v0.6.0 for SLiM 6.x)
- Replace API documentation entirely (R/slim_lang.R)
- Update all class and property references
- Do NOT implement compatibility layers
- Document breaking changes clearly in NEWS.md

## Documentation for AI Assistants

**IMPORTANT:** All documentation, notes, reports, and analysis created by Claude or other AI assistants should be stored in the `claude_notes/` directory. This keeps the main package directories clean and organized.

**Directory:** `claude_notes/`

**What belongs here:**
- Analysis reports (e.g., breaking changes analysis)
- Process documentation (e.g., upgrade guides)
- Investigation results (e.g., extraction reports)
- Phase completion summaries
- Recipe conversion notes (recipe_conversion_notes.md)
- **Development notes and bug reports** → `claude_notes/slimr_development_notes.md`
- Any other AI-generated documentation

**What does NOT belong here:**
- Package documentation (belongs in vignettes/, inst/doc/, etc.)
- User-facing guides (consider vignettes/ or package website)
- Code (belongs in R/, tests/, etc.)
- Data files (belongs in data-raw/, data/, etc.)

**Note:** The `claude_notes/` directory is added to `.Rbuildignore` so its contents won't be included in the built package.

### Development Notes

**File**: `claude_notes/slimr_development_notes.md`

When discovering bugs, potential enhancements, or technical issues during development:
- Add notes to `slimr_development_notes.md` (NOT a new file)
- Include: date, context, problem description, workarounds, and recommended actions
- This helps track issues for future investigation by maintainers

## Development Commands

### **CRITICAL: Always Load Development Version**

When working on slimr development, **ALWAYS** load the development version using `devtools::load_all()` at the start of your R scripts:

```r
# ALWAYS do this first when testing during development
devtools::load_all('.')
```

This ensures that:
- Your code changes are immediately available
- You're testing the current development code, not the installed package
- New functions and bug fixes are used in testing

### Testing
```r
# Load development version first!
devtools::load_all('.')

# Run all tests
devtools::test()

# Run a specific test file
devtools::test_active_file()
testthat::test_file("tests/testthat/test-slim_run.R")

# Check package (full R CMD check)
devtools::check()
```

### Building and Installation
```r
# Install package from source
devtools::install()

# Build documentation
devtools::document()

# Build vignettes
devtools::build_vignettes()

# Check package as CRAN would
devtools::check(args = c("--no-manual", "--as-cran"))
```

### Writing Examples and Documentation

**CRITICAL: CRAN Compliance for Examples**

- **NEVER use `\dontrun{}` in examples** - This is guaranteed to cause CRAN rejection
- If an example cannot be fixed to run properly, ask the maintainer for guidance
- Use `if(slim_is_avail())` to conditionally run examples that require SLiM
- Examples must be executable and pass R CMD check

**Using `@examplesIf` for Conditional Examples (CRAN-approved)**

For examples that require specific conditions (like interactive sessions, external tools, or specific platforms), use the `@examplesIf` roxygen2 tag instead of wrapping code in `if()` statements:

```r
#' @examplesIf interactive()
#' slim_open(minimal_slimr_script())
```

**Note**: Do not use both `@examplesIf` and `@examples` tags together - `@examplesIf` replaces the `@examples` tag entirely.

This approach:
- **Satisfies CRAN requirements** (unlike `\dontrun{}`)
- Prevents examples from running when conditions aren't met
- Keeps example code clean and readable
- Works with R CMD check

Common conditions:
- `@examplesIf interactive()` - Only run in interactive R sessions (e.g., GUI functions)
- `@examplesIf slim_is_avail()` - Only run when SLiM is installed
- `@examplesIf Sys.info()[["sysname"]] == "Linux"` - Platform-specific examples

**Important**: Functions that require external tools (like `slim_open()` requiring SLiMGUI) should:
1. Check if the tool is available/accessible
2. Fail gracefully with an informative error message if not
3. Use `@examplesIf` to prevent running when the tool isn't available

**SLiM 5.x API Changes in Examples**

When writing or updating examples for SLiM 5.x, remember:
- **Haplosome class**: Use `outputHaplosomes()` instead of `output()`
- **Property renames**: `genomes` → `haplosomes`, `genome` → `haplosome`
- **Output methods**:
  - For subpopulations: `p1.outputHaplosomes()` outputs haplosome data
  - For individuals: `individual.outputHaplosomes()` outputs individual haplosome data
  - For full simulation: `sim.outputFull()` outputs complete simulation state

Common example patterns:
```r
# Output haplosome data from a subpopulation (SLiM 5.x)
r_output(p1.outputHaplosomes(), "haplosomes")

# Output full simulation state
r_output(sim.outputFull(), "full_state")

# Access haplosomes property (not genomes)
p1.individuals.haplosomes
```

### SLiM Setup and Version Management

**CRITICAL: slimr v0.5.0+ requires SLiM 5.x**

#### Installing SLiM 5.x

**ALWAYS use `slim_setup()` to install SLiM** - do not install manually unless absolutely necessary.

```r
# Install SLiM 5.1 using conda (RECOMMENDED)
# This is the standard installation method
devtools::load_all('.')  # Load development version first!
slim_setup(method = 'conda', slim_version = '5.1', force = TRUE)

# Install using binary method (Windows only - installs fixed version)
slim_setup(method = 'binary', force = TRUE)

# Check if SLiM is available
slim_is_avail()

# Get SLiM version (should be 5.x for slimr v0.5.0+)
slim_version()  # Should return "5.1" or higher
```

#### Setting SLIM_PATH

After installing SLiM 5.x, you may need to set the `SLIM_PATH` environment variable:

**Option 1: Set in .Renviron file (RECOMMENDED for persistent setting)**
```bash
# Add this line to your project's .Renviron file:
SLIM_PATH=C:/Users/USERNAME/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe
```

**Option 2: Set in R session (temporary)**
```r
# Windows conda installation path (typical)
Sys.setenv(SLIM_PATH = 'C:/Users/USERNAME/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe')

# macOS conda installation path (typical)
Sys.setenv(SLIM_PATH = '/Users/USERNAME/miniconda3/envs/slimr-conda/bin/slim')

# Linux conda installation path (typical)
Sys.setenv(SLIM_PATH = '/home/USERNAME/miniconda3/envs/slimr-conda/bin/slim')

# Verify it's set correctly
Sys.getenv('SLIM_PATH')
slim_version()  # Should show 5.x
```

**Option 3: Set in .Rprofile (for all R sessions)**
```r
# Add to ~/.Rprofile
Sys.setenv(SLIM_PATH = 'path/to/slim.exe')
```

#### Verifying SLiM Installation

```r
# Check installation
devtools::load_all('.')
slim_is_avail()  # Should return TRUE
slim_version()   # Should return "5.1" or higher

# Test with a simple script
test_script <- slim_script(
  slim_block(initialize(), {
    initializeMutationRate(1e-7)
    initializeMutationType("m1", 0.5, "f", 0.0)
    initializeGenomicElementType("g1", m1, 1.0)
    initializeGenomicElement(g1, 0, 99999)
    initializeRecombinationRate(1e-8)
  }),
  slim_block(1, early(), {
    sim$addSubpop("p1", 500)
  }),
  slim_block(100, late(), {
    sim$simulationFinished()
  })
)

result <- slim_run(test_script)
result$exit_status  # Should be 0
```

#### Common SLiM Setup Issues

**Issue: "SLiM is not installed or can't be found"**
- Solution: Set SLIM_PATH environment variable (see above)
- Or reinstall: `slim_setup(method = 'conda', slim_version = '5.1', force = TRUE)`

**Issue: Running SLiM 4.x instead of 5.x**
- Check version: `slim_version()`
- Reinstall 5.x: `slim_setup(method = 'conda', slim_version = '5.1', force = TRUE)`
- Verify: `slim_version()` should show "5.1"

**Issue: Recipe tests failing with property errors (e.g., "property haplosomes is not defined")**
- This means SLiM 4.x is being used instead of 5.x
- SLiM 5.x renamed `genomes` → `haplosomes`
- Solution: Install SLiM 5.1 and set SLIM_PATH correctly

### Running Tests with SLiM
Tests use `skip_if_slim_not_installed()` to conditionally run when SLiM is available. To run tests locally, ensure SLiM is installed first using `slim_setup()`.

### Git Workflow
- Main branch: `master` (stable releases)
- Development branch: `develop` (active development)
- CI runs on both branches for pushes and PRs

### Package Documentation
```r
# View package documentation
?slimr

# Load global SLiM objects for autocomplete
slimr::slim_load_globals()

# Access SLiM recipes (example scripts)
slimr::slim_get_recipe(1)
```

## Important Compatibility Notes

### SLiM Version Compatibility
- **Current compatibility**: SLiM 4.2.2
- SLiM is compiled from source in CI for Windows and Linux
- macOS uses precompiled binaries or conda installation
- Newer SLiM versions (4.2.3+) may have compilation issues with recent Xcode/clang versions

### CI/CD Configuration
The package uses GitHub Actions with a comprehensive test matrix:
- **Windows**: Tests with compiled SLiM and without SLiM (uses `windows-latest`)
- **macOS**: Tests on both macOS-14 (Apple Silicon) and macOS-latest with conda
- **Ubuntu**: Tests with compiled SLiM and conda installation (uses `ubuntu-latest`)
- **R versions**: Tests on both release and devel (macOS only)

Environment variables used in CI:
- `SLIM_PATH`: Path to SLiM executable (Windows: `C:/Program Files (x86)/SLiM/bin/slim.exe`)
- `SLIM_INSTALL`: Set to `1` to trigger conda installation in tests

### Platform-Specific Considerations

#### Windows
- Uses MSYS2 for building SLiM from source
- Requires CMake and mingw64 toolchain
- Binary installation available via `slim_setup(method = 'binary')`

#### macOS
- SLiM 4.2.2 source builds on older Xcode (macOS-13 runners)
- Newer Xcode 16.4/clang 17 has compilation issues
- Prefer conda installation for macOS-latest
- Requires GDAL system dependency (`brew install gdal`)

#### Linux
- Builds SLiM from source using cmake
- Conda-based installation also available

## R-SLiM Syntax Conversion

slimr allows writing SLiM code using R syntax with automatic conversion. Key conversions:

### Supported R Syntax Patterns
- **Assignment**: `<-` is converted to `=` in SLiM
- **Object access**: `$` is converted to `.` (e.g., `sim$addSubpop()` → `sim.addSubpop()`)
- **Special operator**: `%.%` for accessing class methods with autocomplete (e.g., `sim%.%Species$addSubpop()`)

### Autocomplete Support
Two methods for SLiM autocomplete in RStudio:

1. **Using `slim_load_globals()`** (recommended):
   ```r
   slim_load_globals()  # Load SLiM class stubs
   sim$addSubpop()      # Use $ for autocomplete, auto-converts to .
   ```

2. **Using `%.%` operator**:
   ```r
   sim%.%Species$addSubpop()  # Or use abbreviated: sim%.%Sp$addSubpop()
   ```

Both methods automatically convert to valid SLiM code (`sim.addSubpop()`).

### Common SLiM Classes (with abbreviations)
- `Species` (Sp), `SLiMSim` (Ss), `Genome` (Gn), `Individual` (In)
- `Subpopulation` (Sub), `Mutation` (Mu), `GenomicElement` (GE)
- Access documentation: `?sim%.%Species$methodName` or after loading globals `?sim$methodName`

## Package Structure

### Vignettes (Documentation and Examples)
Located in [vignettes/](vignettes/):
- [slimrlang_intro.Rmd](vignettes/slimrlang_intro.Rmd) - Introduction to slimr language features
- [simple_nucleotide_example.Rmd](vignettes/simple_nucleotide_example.Rmd) - Nucleotide-based simulations
- [useful_tables.Rmd](vignettes/useful_tables.Rmd) - Reference tables for SLiM objects

Articles (in [vignettes/articles/](vignettes/articles/)):
- [Custom_vis.Rmd](vignettes/articles/Custom_vis.Rmd) - Custom visualization examples
- [Main_manuscript_example_v2.Rmd](vignettes/articles/Main_manuscript_example_v2.Rmd) - Examples from the paper
- [simple_example_using_migration_and_fst.Rmd](vignettes/articles/simple_example_using_migration_and_fst.Rmd) - Migration models
- [multispecies.Rmd](vignettes/articles/multispecies.Rmd) - Multi-species simulations

### Key Package Dependencies
- **Core**: rlang, vctrs, purrr, dplyr, tidyr, stringr
- **Process management**: processx
- **Code parsing/formatting**: prettycode, glue
- **Optional genomics**: adegenet (for genlight objects), Biostrings (for sequence data), ape (for phylogenies)
- **Optional parallel**: furrr, future
- **Development**: reticulate (for conda-based SLiM installation)

## High-Level Architecture

The typical flow through slimr has 5 major phases:

1. **Script Creation** (slim_script/slim_block)
2. **Processing** (template/inline/output detection)
3. **Rendering** (slim_script_render - substitute values)
4. **Execution** (slim_run - external SLiM invocation)
5. **Output Parsing** (slim_extract_output_data)

## 1. Script Creation & Core Data Structures

### slimr_script - The Central Abstraction

Located in /R/slimr_script.R, this is an S3 record object (using vctrs) that represents a complete SLiM simulation.

Structure (record with fields):
- block_name: Name of each code block
- block_id: User-specified block ID
- start_gen: Start generation for this block
- end_gen: End generation for this block
- callback: SLiM callback type (initialize, early, late, etc)
- code: The actual code (slimr_code object)

Attributes (metadata):
- species: NULL or character for multi-species models
- slimr_template: DataFrame tracking templated variables
- slimr_inline: DataFrame tracking inlined R objects
- slimr_output: DataFrame tracking output captures
- script_info: Rendering status and generation count

### Script Creation Functions

slim_script(...): Main constructor that combines slim_block objects
slim_block(...): Creates individual code blocks with syntax:
  slim_block([id,] [start_gen,] [end_gen,] [callback,] {code})

## 2. The Three-Layer Processing System

When slim_script() is called, code goes through three sequential processing passes:

### Layer 1: Inlining System (/R/slimr_inline.R)

Purpose: Embed R objects directly into SLiM code

Key function: r_inline(object, delay = FALSE)

Process:
1. User calls r_inline(my_vector) inside slim_block
2. Function converts R object to valid SLiM syntax
3. Placeholder symbol generated: .__slmr_inline_object_N___
4. Both SLiM and display versions stored
5. process_inline() replaces placeholders with actual code

### Layer 2: Template System (/R/slimr_template.R)

Purpose: Create placeholder variables for parameter sweeps

Key function: r_template(var_name, default, unquote_strings)

Process:
1. User calls r_template("param_name", default_value)
2. Function stores metadata in resource lists
3. Returns placeholder: ..<var_name>..
4. process_template() gathers and stores in attribute

Rendering via slim_script_render():
- Accepts parameter values (list, data.frame, tibble)
- Uses glue::glue() for substitution
- Returns collection if multiple parameter sets

### Layer 3: Output System (/R/slimr_output.R)

Purpose: Capture simulation output for post-processing

Key function: r_output(slimr_expr, name, do_every, ...)

Process:
1. User calls r_output(sim.outputFull(), "my_output")
2. Function wraps SLiM expression in conditional code
3. Uses XML-like delimiters: <slimr_out:start> ... <slimr_out:end>
4. Stores metadata in resource lists
5. process_output() replaces placeholders

## 3. Code Translation: R to SLiM

Located in /R/slimr_code.R, bidirectional translation system:

R->SLiM (SLiMify):
- Add semicolons
- Replace <- with =
- Remove class prefixes
- Replace $ with %.%
- Adjust dots, ternaries, modulus

SLiM->R (Rify):
- Inverse operations to make code R-parseable
- Validates via parse(text=code)

## 4. Rendering System

slim_script_render() enables parameter substitution:
1. Validates script not already rendered
2. Converts template argument format
3. For each parameter set, calls replace_double_dots()
4. Uses glue::glue() with ".." delimiters
5. Returns slimr_script_coll if multiple sets

## 5. Execution: Running SLiM

slim_run() in /R/slim_run.R has generic dispatch:
- slim_run.slimr_script - Main method
- slim_run.character - Raw SLiM code
- slim_run.slimr_script_coll - Batch execution

Execution pipeline:
1. Validate SLiM installed
2. Auto-render if needed
3. Convert to SLiM text
4. Execute via processx::run()
5. Capture and parse output
6. Return slimr_results object

slimr_results contains:
- output: Raw SLiM output
- exit_status: Exit code
- output_data: Parsed r_output captures
- process: processx object
- error: Error message if failed

## 6. Output Extraction & Parsing

Located in /R/slim_extract.R

slim_extract_output_data(): Low-level output parsing
slim_results_to_data(): High-level type-aware conversion

Parsing strategy:
1. Find XML-like delimiters
2. Extract metadata (generation, name, type)
3. Parse based on type (population, genomes, nucleotides)
4. Convert to R structures (tibbles, DNAStringSet, etc)

## 7. SLiM Language Integration

Class Environments: Package loads SLiM classes at startup creating environment-based stubs for:
- Initialize, Chromosome, Community, Eidos, Genome
- GenomicElement, Individual, Mutation, Species, etc.

Auto-Generated API Stubs: /R/slim_lang.R contains ~23,800 lines of function stubs (one per SLiM method) with full documentation.

## 8. File Organization

Core:
- slimr-package.R: Package initialization
- slimr_script.R: Main data structures
- slimr_scripting.R: Script builders
- slimr_template.R: Template system
- slimr_inline.R: Inline system
- slimr_output.R: Output system

Execution:
- slim_run.R: Execution pipeline
- slim_extract.R: Output parsing

Language:
- slim_lang.R: Auto-generated API
- slim_callbacks.R: Callback definitions
- slimr_code.R: Translation utilities

## 9. Key Design Patterns

1. **Quasiquotation**: Uses rlang for non-standard evaluation
2. **Three-Phase Processing**: Independent layers that compose cleanly
3. **Metadata Attributes**: Information flows via script attributes
4. **Placeholder Tokens**: Unique markers (.__slmr_*___) rather than AST manipulation
5. **vctrs Records**: Type-safe data structures
6. **Tibble Metadata**: Clean tabular format for processing info
7. **Bidirectional Translation**: R ↔ SLiM conversion
8. **Lazy Evaluation**: delay=TRUE in r_inline() for deferred operations

## 10. Integration Points

1. SLiM Discovery: find_slim_path(), slim_version(), auto-installation
2. Process Management: Uses processx for spawning SLiM
3. Data Formats: Converts matrices, genlight to/from SLiM
4. Global Resources: .slim_settings, .slim_assets, .resources

## Data Flow

User Code
  -> slim_script() processes (inline/template/output)
    -> slimr_script object
      -> slim_script_render() substitutes parameters
        -> slimr_script_coll (if multiple sets)
          -> slim_run() executes SLiM
            -> slimr_results
              -> slim_results_to_data() parses
                -> R data structures

## Summary

The slimr architecture enables:
- Intuitive R-first programming
- Seamless SLiM integration
- Parameter sweep automation
- Output capture and parsing
- Type safety and validation
- Lazy evaluation and flexibility

Built on clear separation of concerns, metadata preservation, and elegant placeholder substitution rather than complex AST manipulation.

## Common Workflows

### Basic Simulation Workflow
```r
library(slimr)

# 1. Create a script
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
  slim_block(10000, {
    sim.simulationFinished()
  })
)

# 2. Run the simulation
result <- slim_run(script)

# 3. Check results
result$exit_status  # Should be 0 for success
```

### Parameter Sweep with Templates
```r
# 1. Create script with template variables
script <- slim_script(
  slim_block(initialize(), {
    initializeMutationRate(r_template("mut_rate", 1e-7))
    # ... rest of initialization
  }),
  # ... rest of blocks
)

# 2. Define parameter values to test
params <- data.frame(
  mut_rate = c(1e-7, 1e-6, 1e-5)
)

# 3. Render with parameters
rendered <- slim_script_render(script, template = params)

# 4. Run all parameter combinations (can use parallel = TRUE)
library(future)
plan(multisession, workers = 3)
results <- slim_run(rendered, parallel = TRUE)
```

### Capturing and Extracting Output
```r
# 1. Create script with output capture
script <- slim_script(
  # ... initialization blocks ...
  slim_block(1, 100, {
    slimr_output(p1.outputMSSample(sampleSize = 10),
                 name = "sample", do_every = 10)
  }),
  # ... finish block ...
)

# 2. Run simulation
result <- slim_run(script)

# 3. Extract output data
result$output_data  # Tibble with captured output

# 4. Convert to genlight objects (for genome data)
genlight_data <- slim_extract_genlight(result, by = c("generation"))
```

### Using R Data in SLiM Scripts
```r
# 1. Create R data to inject
migration_matrix <- matrix(c(0, 0.1, 0.1, 0), nrow = 2)

# 2. Use r_inline() to inject into script
script <- slim_script(
  slim_block(initialize(), {
    # ...
  }),
  slim_block(1, {
    sim.addSubpop("p1", 500)
    sim.addSubpop("p2", 500)
  }),
  slim_block(2, {
    p1.setMigrationRates(c(p2), r_inline(migration_matrix[1,2]))
    p2.setMigrationRates(c(p1), r_inline(migration_matrix[2,1]))
  })
)
```

### Debugging and Development
```r
# Convert script to SLiM code for inspection
as_slim(script)

# Check script structure
print(script)
str(script)

# Validate SLiM installation
slim_is_avail()
slim_version()

# Run with verbose output
result <- slim_run(script, throw_error = TRUE, show_output = TRUE)
```

## Related Resources

- **SLiM Manual**: http://benhaller.com/slim/SLiM_Manual.pdf
- **SLiM Website**: https://messerlab.org/slim/
- **slimr Documentation**: https://rdinnager.github.io/slimr/
- **Paper**: Dinnage et al. (2023) Molecular Ecology Resources, https://doi.org/10.1111/1755-0998.13916
- **GitHub Issues**: https://github.com/rdinnager/slimr/issues
