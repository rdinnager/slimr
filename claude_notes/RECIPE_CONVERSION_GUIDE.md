# SLiM → slimr Recipe Conversion Guide

**Purpose**: Essential patterns and solutions for converting SLiM recipes to slimr format.

**For agents**: Add brief notes about NEW patterns or issues. Avoid recipe-by-recipe details (those belong in recipe comments). Focus on REUSABLE lessons.

---

## Core Syntax Conversions

### 1. Basic Structure
```r
# SLiM: initialize() { ... }
# slimr:
slim_block(initialize(), { ... })

# SLiM: 1000 early() { ... }
# slimr:
slim_block(1000, early(), { ... })
```

### 2. Property Access
```r
# SLiM: sim.addSubpop("p1", 500)
# slimr (either works):
sim$addSubpop("p1", 500)  # Preferred (R-like)
sim.addSubpop("p1", 500)  # Also valid (dots pass through)
```

### 3. Generation Ranges
```r
# SLiM: 1000:1099 early() { ... }
# slimr:
slim_block(1000, 1099, early(), { ... })

# SLiM: 1000: early() { ... }  (open-ended)
# slimr:
slim_block(1000, .., early(), { ... })  # Use .. symbol!
```

### 4. Comments
```r
# SLiM: // comment
# slimr:
# comment
```

### 5. Return Statements ⭐ CRITICAL
**Issue**: SLiM uses `return value;` syntax, but slimr requires R syntax with parentheses.

**Solution**: ALWAYS use `return(value)` with parentheses IN CALLBACKS
```r
# ❌ WRONG - SLiM syntax doesn't work in slimr
mutationEffect(NULL) {
  return asFloat(1.0 + effect);
}

# ✅ CORRECT - Use R syntax with parentheses
mutationEffect(NULL) {
  return(asFloat(1.0 + effect));
}

# ❌ WRONG - SLiM syntax in mateChoice()
mateChoice() {
  return weights * individual.relatedness(sourceSubpop.individuals);
}

# ✅ CORRECT - R syntax with parentheses
mateChoice() {
  return(weights * individual.relatedness(sourceSubpop.individuals));
}
```

### 6. Early Return in Script Blocks ⭐ CRITICAL BUG
**Issue**: Early return statements (without values) don't work in script blocks. `return()` causes parse errors.

**Solution**: Use if-else structure instead of early return
```r
# SLiM original:
# if (sim.cycle % 1000 != 0) return;
# ... rest of code ...

# ❌ WRONG - doesn't work in slimr
slim_block(1, .., early(), {
  if (sim$cycle %% 1000 != 0)
    return()  # Parse error!

  # ... rest of code ...
})

# ✅ CORRECT - restructure with if
slim_block(1, .., early(), {
  if (sim$cycle %% 1000 == 0) {
    # ... rest of code goes here ...
  }
})
```

**Key points**:
- Early `return` (no value) doesn't work in script blocks (known bug)
- `return(value)` works in callbacks (required for returning values)
- Workaround: Invert the condition and use if statement instead of early return

---

## Critical Type Handling

### 1. asFloat() for Callback Returns ⭐ CRITICAL
**Issue**: mutationEffect() and similar callbacks expect float returns. Integer literals cause type errors.

**Solution**: Wrap ALL numeric returns in asFloat()
```r
# ❌ WRONG - causes type error
mutationEffect(NULL) {
  return 1.0 + effect;  # SLiM drops .0, becomes integer
}

# ✅ CORRECT
mutationEffect(NULL) {
  return asFloat(1.0 + effect);
}
```

### 2. ifelse() Type Consistency ⭐ CRITICAL
**Issue**: slimr drops decimal points from integer-valued floats (2.0 → 2), causing type errors in ifelse().

**Solution**: Wrap EACH value in asFloat() individually
```r
# ❌ WRONG - type mismatch
weights <- ifelse(sim$cycle > 100, 0.5, 1)

# ✅ CORRECT
weights <- ifelse(sim$cycle > 100, asFloat(0.5), asFloat(1))
```

### 3. Boolean Constants ⭐ CRITICAL
**Issue**: SLiM uses `T` and `F`, not `TRUE` and `FALSE`.

**Solution**: Use T/F in SLiM blocks
```r
# ❌ WRONG
while(TRUE) { ... }

# ✅ CORRECT
while(T) { ... }
```

### 4. Ternary Operator ⭐ IMPORTANT
**Issue**: SLiM's ternary operator `(cond ? val1 else val2)` doesn't parse in R.

**Solution**: Use slimr's special ternary operators `%?%` and `%else%`
```r
# SLiM syntax:
# optimum = (subpop == p1 ? 10.0 else -10.0);

# ❌ WRONG - R parse error
optimum <- (subpop == p1 ? 10.0 else -10.0)

# ❌ ALSO WORKS but verbose
optimum <- ifelse(subpop == p1, asFloat(10.0), asFloat(-10.0))

# ✅ CORRECT - slimr's ternary operator
optimum <- (subpop == p1) %?% 10.0 %else% -10.0
```

**Key points**:
- Use `%?%` for the condition check
- Use `%else%` for the alternative value
- Parentheses around condition recommended for clarity
- Automatically translates to SLiM's `(cond ? val1 else val2)` syntax

---

## Common Gotchas

### 1. Empty Blocks Need NULL
```r
# ❌ WRONG - causes error
slim_block(1000, late(), {
  # Just a comment - block is empty
})

# ✅ CORRECT
slim_block(1000, late(), {
  NULL  # Need at least NULL statement
})
```

### 2. SLiM 5.x Property Names
```r
# SLiM 4.x: individual.genomes, genome1, genome2
# SLiM 5.x: individual.haplosomes, haploidGenome1, haploidGenome2
```

### 3. Array Indexing is 0-Based ⭐ CRITICAL
```r
# ❌ WRONG - 1-based indexing causes "subscript out of range"
for (i in 1:3) {
  type <- c("A", "X", "Y")[i]  # Fails when i=3 in SLiM (0-based)
}

# ✅ CORRECT - use 0-based loop
types <- c("A", "X", "Y")
for (i in 0:2) {  # i = 0, 1, 2 in SLiM
  initializeChromosome(i + 1, 1e6, type = types[i])
}
```

### 6. pmax/pmin Type Consistency ⭐ CRITICAL
**Issue**: pmax/pmin require both arguments to be same type.

**Solution**: Wrap numeric constants in asFloat()
```r
# ❌ WRONG - type mismatch error
pref <- pmax(pmin(pref, 1.0), 0.0)

# ✅ CORRECT
pref <- pmax(pmin(pref, asFloat(1.0)), asFloat(0.0))
```

### 7. getValue() Results Need asFloat() ⭐ CRITICAL
**Issue**: getValue() may return values that need type coercion for fitnessScaling.

**Solution**: Wrap getValue() results in asFloat() when assigning to fitnessScaling
```r
# ❌ WRONG - type error
inds$fitnessScaling <- inds$getValue("penalty")

# ✅ CORRECT
inds$fitnessScaling <- asFloat(inds$getValue("penalty"))
```

### 4. do-while Loop Conversion ⭐ CRITICAL

**Issue**: SLiM's `do { statement } while (condition)` syntax doesn't parse in R.

```r
# ❌ WRONG - doesn't parse in R
do breaks <- rdunif(2, max = L - 1)
while (breaks[0] == breaks[1])

# ✅ CORRECT - Pattern 1: Initial assignment + while loop
breaks <- rdunif(2, max = L - 1)
while (breaks[0] == breaks[1])
  breaks <- rdunif(2, max = L - 1)

# ✅ CORRECT - Pattern 2: while(T) with break
while(T) {
  breaks <- rdunif(2, max = L - 1)
  if (breaks[0] != breaks[1])
    break
}
```

**Key points**:
- Pattern 1 is more natural and matches SLiM's logic (execute once, then check)
- Pattern 2 is more verbose but works when Pattern 1 isn't suitable
- R doesn't have `do...while` syntax, so must restructure

### 5. Method Chaining Requires $ ⭐ CRITICAL
**Issue**: R parser doesn't support dot chaining after R functions.

```r
# ❌ WRONG - syntax error
sample(p1.haplosomes, 20).addNewDrawnMutation(m1, 50000)

# ✅ CORRECT
sample(p1$haplosomes, 20)$addNewDrawnMutation(m1, 50000)
```

---

## NonWF Model Patterns (Recipe 15.x series)

### 1. self.active = 0 for Big Bang Reproduction ⭐ IMPORTANT
**Purpose**: Deactivate reproduction() callback after all individuals reproduce.

**Usage**: Synchronized breeding where all reproduction happens at once
```r
slim_block(reproduction(), {
  # Iterate through all individuals
  for (ind in subpop$individuals) {
    subpop$addCrossed(ind, subpop$sampleIndividuals(1))
  }

  # Deactivate callback for this cycle
  self$active <- 0
})
```

**Key points**:
- Callback automatically reactivates next cycle
- Mimics organisms with discrete breeding seasons
- Contrast: without self.active = 0, callback fires once per individual

### 2. survival() Callback ⭐ NEW in SLiM 5.x
**Purpose**: Control individual survival with explicit return values.

**Usage**: Deterministic survival based on age or other properties
```r
slim_block(survival(), {
  # Survival is independent of fitness; parents die, offspring live
  return(individual$age == 0)
})
```

**Key points**:
- Fires for each individual during survival determination
- Access to `surviving` boolean (will individual survive?)
- Return T (survive) or F (die), or NULL (no modification)
- Cleaner than setting fitnessScaling = 0.0 for deterministic death
- Must use return() with parentheses (R syntax)

### 3. reproduction() Callback Variants
**Female-only reproduction**:
```r
slim_block(reproduction(NULL, "F"), {
  mate <- subpop$sampleIndividuals(1, sex = "M")
  if (mate$size())
    subpop$addCrossed(individual, mate)
})
```

**Generation-specific reproduction**:
```r
# Runs only at generation 1000
slim_block(1000, reproduction(), {
  # Special reproduction logic for this generation
  # ...
  self$active <- 0  # Don't run again this cycle
})
```

**Key points**:
- reproduction(NULL, "F") fires only for females
- Generation-specific: slim_block(gen, reproduction(), {...})
- Can have multiple reproduction() blocks for different generations

### 4. Dynamic Population Structure
**Creating subpopulations dynamically**:
```r
# Create empty subpopulation (for later seeding)
slim_block(999, late(), {
  sim$addSubpop("p3", 0)$setValue("K", 750)
})

# Seed it in next generation
slim_block(1000, reproduction(), {
  # Generate founders from other populations
  founderCount <- rdunif(1, 10, 20)
  # ... create offspring into p3 ...
  self$active <- 0
})
```

**Removing subpopulations**:
```r
# Kill all individuals via fitnessScaling
c(p1, p2)$fitnessScaling <- asFloat(0.0)
```

**Key points**:
- Create with size 0, then seed via special reproduction() callback
- Use setValue/getValue for population-specific parameters (e.g., K)
- Remove by setting fitnessScaling = 0.0 for all individuals

### 5. Non-overlapping Generations in nonWF
**Pattern 1: Via fitnessScaling**:
```r
slim_block(early(), {
  inds <- sim$subpopulations$individuals
  inds[inds$age > 0]$fitnessScaling <- asFloat(0.0)
})
```

**Pattern 2: Via survival() callback**:
```r
slim_block(survival(), {
  return(individual$age == 0)  # Only juveniles survive
})
```

**Key points**:
- survival() is cleaner but Pattern 1 is more common
- Both implement discrete, non-overlapping generations
- Useful for Wright-Fisher approximations in nonWF

---

## SLiM-Specific Patterns

### 1. File I/O with r_inline()
**Purpose**: Use R functions to locate package files

```r
# Use r_inline() to evaluate R expression and inject path
lines <- readFile(r_inline(
  system.file("extdata/recipe_resources/data.csv", package = "slimr")
))
```

### 2. Block Deregistration
**Purpose**: Stop executing a block once condition is met

```r
slim_block(1000, .., early(), {
  newSize <- calculate_size()
  if (newSize >= 2000) {
    newSize <- 2000
    community$deregisterScriptBlock(self)  # Stop running this block
  }
  p1$setSubpopulationSize(newSize)
})
```

### 3. Custom Functions with slim_function() ⭐ CRITICAL

**CRITICAL Issues**:
1. Must use `body = function()` syntax (NOT curly braces directly)
2. Must be at SAME LEVEL as `slim_block()` calls (NOT nested inside)

```r
# ❌ WRONG - nested inside slim_block()
slim_script(
  slim_block(initialize(), {
    slim_function("float x", ...) {  # WRONG - nested
      ...
    }
  })
)

# ❌ WRONG - curly braces directly
slim_function("float x", name = "myFunc", return_type = "float", {
  return x * 2.0;
})

# ✅ CORRECT - at same level as slim_block(), using body parameter
recipe_script <- slim_script(
  slim_block(initialize(), {
    # Regular initialization code here
    defineConstant("K", 100)
  }),

  slim_block(1, early(), {
    # Can call the function here
    result <- myFunc(5.0)
  }),

  # slim_function() at same level as slim_block()
  slim_function("float x", name = "myFunc", return_type = "float",
    body = function(x) {
      return(x * 2.0)
    }
  )
)

# Multiple parameters example
slim_function("s$ path", "[string$ sep = ',']",
              name = "readMatrix",
              return_type = "+",
              body = function(path, sep) {
                if (!fileExists(path))
                  stop("File not found: " + path)
                df <- readCSV(path, colNames = F, sep = sep)
                return(df$asMatrix())
              })

# For void functions, specify "void" parameter
slim_function("void", name = "setup", return_type = "void",
              body = function() {
                # ... code ...
              })
```

**Key points**:
- `slim_function()` creates a slim_block internally - don't nest it!
- Place at same indentation level as other `slim_block()` calls
- Use `body = function(param1, param2) { ... }` syntax
- Parameter names in function signature must match parameter names in body
- Optional parameters use `[type$ name = default]` syntax
- Return type must match actual return value type

### 4. Circular Chromosomes and addRecombinant()

**Purpose**: Model horizontal gene transfer, clonal reproduction with recombination

```r
# Initialize circular chromosome
initialize() {
  initializeChromosome(1, L, type = "H")  # "H" for circular (head-to-tail)
}

# Horizontal gene transfer example
reproduction() {
  if (runif(1) < HGT_probability) {
    # Get donor haplosomes
    donor <- p1$sampleIndividuals(1, exclude = individual)$haplosomes

    # Generate two distinct breakpoints
    breaks <- rdunif(2, max = L - 1)
    while (breaks[0] == breaks[1])
      breaks <- rdunif(2, max = L - 1)

    # Handle circular wrapping: if breaks[0] > breaks[1], transfer wraps around
    if (breaks[0] > breaks[1])
      breaks <- c(0, breaks[1], breaks[0])

    # Create recombinant offspring
    subpop$addRecombinant(
      individual$haplosomes,  # Recipient
      donor,                   # Donor
      breaks,                  # Breakpoint vector
      NULL, NULL, NULL,        # Sex parameters (not used for haploids)
      randomizeStrands = F     # Deterministic strand selection
    )
  } else {
    # Clonal reproduction
    subpop$addCloned(individual)
  }
}
```

**Key points**:
- `type = "H"` creates circular chromosome (vs `type = "X"` for linear)
- For circular chromosomes, breaks wrap around: `[0, end_pos, start_pos]`
- `addRecombinant()` takes haplosome vectors, not Individual objects
- Use `NULL` for sex-related parameters when not applicable (e.g., haploids)
- `randomizeStrands = F` ensures deterministic recombination
- Breakpoints are 0-based positions (rdunif generates 0 to max)

---

## Testing and Output ⭐ CRITICAL

### 1. Reading Output - ALWAYS Use result$output_file

**CRITICAL**: Output handling in slimr works as follows:
- `result$output_file` - ALWAYS contains the path to the output file (read with `readLines()`)
- `result$output` - ONLY populated if `capture_output = TRUE` in `slim_run()`

**Standard approach (ALWAYS works)**:
```r
result <- slim_run(script)
output_content <- readLines(result$output_file)
# Now you can check output_content
```

**Alternative (requires explicit flag)**:
```r
result <- slim_run(script, capture_output = TRUE)
# Then result$output is populated as a string
```

**IMPORTANT**: ALWAYS read from `result$output_file` in tests. Don't rely on `result$output` unless you set `capture_output = TRUE`.

**Robust pattern with fallback** (for maximum reliability):
```r
# Run with capture_output = TRUE
result <- slim_run(script, capture_output = TRUE)

# Robust output reading with fallback
if (length(result$output) > 0) {
  output <- paste(result$output, collapse = "\n")
} else if (file.exists(result$output_file)) {
  output <- paste(readLines(result$output_file), collapse = "\n")
} else {
  output <- ""
}

# Now you can safely check output
expect_true(grepl("expected pattern", output))
```

**When to use each approach**:
- Use `result$output_file` for most cases (simple, reliable)
- Use `capture_output = TRUE` + fallback when output might be empty or redirected
- Use fallback pattern for recipes that may finish without producing output

### 2. Standard Test Template with Output Checks
```r
test_that("Recipe X.Y: [Title] works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_X_Y.R", package = "slimr"))
  result <- slim_run(recipe_X_Y_script)

  expect_equal(result$exit_status, 0)

  # ALWAYS read output from result$output_file
  output <- readLines(result$output_file)

  # Add recipe-specific checks:
  # expect_true(any(grepl("expected pattern", output)))
  # expect_true(length(output) > 0)
})
```

### 3. Testing Output - PERSIST, Don't Give Up!

**IMPORTANT**: Always test output when recipes produce it. Don't skip output tests just because they seem difficult. Use `readLines(result$output_file)` and check for expected patterns.

### 4. Testing Stochastic Models ⭐ IMPORTANT
**Issue**: Models with stochastic outcomes (e.g., extinction) may fail randomly.

**Solution**: Use throw_error=FALSE and capture_output=TRUE to handle both success and valid failures
```r
test_that("Recipe with stochastic outcome works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_X_Y.R", package = "slimr"))

  # Don't throw error on controlled stops
  result <- slim_run(recipe_X_Y_script, throw_error = FALSE, capture_output = TRUE)

  # Accept either success or controlled stop
  expect_true(result$exit_status %in% c(0, 1))

  # Check for valid outcome (success OR expected failure message)
  output <- paste(result$output, collapse = "\n")
  has_success <- grepl("expected pattern", output)
  has_valid_failure <- grepl("Extinction", output)
  expect_true(has_success || has_valid_failure)
})
```

**Key points**:
- throw_error = FALSE prevents test failure on stop() calls
- capture_output = TRUE captures console output for checking messages
- Test both success and expected failure paths
- Use paste(result$output, collapse = "\n") for vector output

---

## Advanced Patterns

### 1. LogFile with Custom Columns
```r
log <- community$createLogFile("sim_log.txt", logInterval = 10)
log$addCycle()  # Adds generation column
log$addCustomColumn("FST", "calcFST(p1.haplosomes, p2.haplosomes);")
# Note: Custom column expressions are SLiM code STRINGS
```

### 2. Population Lookup by ID
```r
subpops <- sim$subpopulations
p_i <- subpops[subpops.id == i]  # Get population with ID i
```

### 3. Mutation Tracking with References
```r
# In initialize block - define constant for later reference
sweep_mut <- p1$haplosomes$addNewDrawnMutation(m2, 50000)
defineConstant("SWEEP_MUT", sweep_mut[0])

# Later - check status
if (SWEEP_MUT.isFixed) {
  # Mutation has fixed
}
```

### 4. Conditional SLiMgui Code
```r
# Run only in GUI, not in slimr
if (exists("slimgui")) {
  # GUI-specific plotting code
}
```

### 5. fitnessScaling Property ⭐ CRITICAL
**Issue**: fitnessScaling property requires float type, but numeric literals lose decimal points.

**Solution**: ALWAYS use asFloat() when setting fitnessScaling
```r
# ❌ WRONG - causes type error "value cannot be type integer"
sample(sim$subpopulations$individuals, 100)$fitnessScaling <- 0.0

# ✅ CORRECT - use asFloat() to ensure float type
sample(sim$subpopulations$individuals, 100)$fitnessScaling <- asFloat(0.0)
```

**Key points**:
- fitnessScaling is a per-individual fitness multiplier (default 1.0)
- Final fitness = genetic_fitness × fitnessScaling
- Setting to asFloat(0.0) kills individuals (fitness 0, no reproduction)
- Most efficient method for non-genetic mortality (no callback overhead)

---

## Recipe-Specific Notes

### Property Access on Mutation Objects in Array Filtering - Recipe 14.10

**Issue**: When filtering mutation arrays by properties (tag, position, etc.), using `$` syntax causes errors: "property accessed before being set"

**Solution**: Use `.` (dot) notation for property access in array filtering operations

**Example**:
```r
# ❌ WRONG - causes "property tag accessed on mutation before being set"
all_disabledTEs <- sim$mutationsOfType(m3)
disabledTE <- all_disabledTEs[all_disabledTEs$tag == te$tag]

# ✅ CORRECT - use dot notation for property access in filters
all_disabledTEs <- sim$mutationsOfType(m3)
disabledTE <- all_disabledTEs[all_disabledTEs.tag == te.tag]
```

**Key points**:
- Affects: tag, position, and other mutation properties
- Use in: Array subsetting/filtering operations
- Setting properties: Can use either `.` or `$` (e.g., `mut.tag <- value` or `mut$tag <- value`)
- Reading properties in filters: Must use `.` (e.g., `muts[muts.tag == value]`)

### mutation() Callback Return Values - Recipe 14.13 I/II

**Issue**: mutation() callbacks have different return semantics than other callbacks

**Solution**: mutation() callbacks can return either:
- A mutation object (to replace the new mutation with an existing one - "uniquing down")
- T (to allow the mutation to be created normally)

**Example**:
```r
# Return a canonical mutation object (uniquing)
slim_block(mutation(m2), {
  return(MUT2[mut$position])  # Replace with canonical mutation
})

# Return T to allow normal mutation creation
slim_block(mutation(m3), {
  if (haplosome$containsMarkerMutation(m2, mut$position))
    return(T)  # Allow stacking for back mutation

  return(MUT[mut$position])  # Otherwise unique down
})
```

**Key points**:
- Different from modifyChild() which always returns T
- Used for "uniquing down" to canonical mutations (identity-by-state)
- Can implement biallelic loci with back mutation
- Must use `return(object)` syntax with parentheses

### Biallelic Loci Implementation Approaches - Recipes 14.13-14.14

**Issue**: Multiple ways to model biallelic loci, each with trade-offs

**Solution**: Three main approaches available:

**Approach 1 (Recipe 14.13 I)**: Two mutation types with uniquing
- m2 = "A" allele, m3 = "a" allele
- mutation() callbacks return canonical mutations
- Uses mutationStackGroup to enforce mutual exclusivity
- Memory efficient, tracks both alleles explicitly

**Approach 2 (Recipe 14.13 II)**: Presence/absence with back mutation
- m2 = "A" allele, absence = "a" allele
- m3 is helper type for new mutations
- Stacked m2+m3 signals back mutation (removed in late() block)
- Simpler conceptually, more complex back mutation handling

**Approach 3 (Recipe 14.14)**: Pure script implementation
- No mutations used, store genomes as boolean vectors
- Manual recombination and mutation in modifyChild()
- Complete control, easier to understand
- Can be slower for many loci

**Choose based on**:
- Need for back mutation
- Computational efficiency requirements
- Clarity vs. performance trade-offs

### Capital Letter + $ Bug - Recipe 16.10 ⭐ CRITICAL BUG

**Issue**: Variable names ending with capital letters followed by `$` cause method name merging

**Solution**: Use dot notation `.` instead of `$` for these cases

**Example**:
```r
# ❌ WRONG - capital F gets merged with method name
parentF <- p1$sampleIndividuals(1, sex = "F")
strands_F_P1 <- parentF$haplosomesForChromosomes(CHR_P1)
# Error: "unrecognized function name parenthaplosomesForChromosomes"

# ✅ CORRECT - use dot notation
strands_F_P1 <- parentF.haplosomesForChromosomes(CHR_P1)
strands_M_P1 <- parentM.haplosomesForChromosomes(CHR_P1)
```

**Key points**:
- Affects variables ending in capitals: `parentF`, `parentM`, `CHR_X`, `CHR_Y`
- Bug in slimr code translator (see slimr_development_notes.md for details)
- Dot notation `.` works correctly, `$` causes capital letter to merge with method name
- Both should work equivalently but bug makes `$` fail for these cases

### hemizygousDominanceCoeff Requires asFloat() - Recipe 16.8

**Issue**: Property assignment requires float type

**Solution**: Wrap numeric values in asFloat()

**Example**:
```r
# ❌ WRONG
m1$hemizygousDominanceCoeff <- 1.0  # Error: "value cannot be type integer"

# ✅ CORRECT
m1$hemizygousDominanceCoeff <- asFloat(1.0)
```

### sexRatio Parameter Requires asFloat() - Recipe 16.8

**Issue**: addSubpop() sexRatio parameter requires float type

**Solution**: Wrap numeric values in asFloat()

**Example**:
```r
# ❌ WRONG
sim$addSubpop("p1", 100, sexRatio = 1.0, haploid = T)  # Error

# ✅ CORRECT
sim$addSubpop("p1", 100, sexRatio = asFloat(1.0), haploid = T)
```

### survival() Callback Can Return Subpopulation - Recipe 16.6

**Issue**: survival() has multiple return value semantics

**Solution**: Understand the three return types

**Example**:
```r
# Return subpopulation to move individual (not kill)
slim_block(survival(p1), {
  if (!surviving)
    if (individual$sex == "M")
      return(p1000)  # Move to cold storage subpopulation
  return(NULL)  # Default behavior
})

# Return T/F to force survival
slim_block(survival(p1000), {
  return(individual$tag == 1)  # Only survive if tag==1
})
```

**Key points**:
- `return(subpopulation)` - moves individual to that subpopulation
- `return(T)` or `return(F)` - force survival/death
- `return(NULL)` - use default behavior
- Enables "cold storage" patterns for dead individuals still needed

### addPatternFor*() Functions - Recipes 16.9, 16.10

**Issue**: Multi-chromosome inheritance requires Dictionary-based patterns

**Solution**: Use addPatternFor*() to build inheritance dictionaries

**Example**:
```r
# Create pattern dictionary
pattern <- Dictionary()

# Clone chromosome from parent
sim$addPatternForClone("P", pattern, individual)

# Cross chromosomes between parents
sim$addPatternForCross("R", pattern, individual, mate)

# Recombinant with specific breakpoints
sim$addPatternForRecombinant("S", pattern,
                             haplosome1, haplosome2, breaks,
                             NULL, NULL, NULL)

# Add null haplosome (for haploid sex chromosomes)
sim$addPatternForNull(CHR_Y, pattern, sex = sex)

# Generate offspring with all patterns
subpop$addMultiRecombinant(pattern, parent1 = individual,
                          parent2 = mate, sex = sex)
```

**Key points**:
- Dictionary stores per-chromosome inheritance patterns
- addPatternForClone() - maternal/paternal inheritance only
- addPatternForCross() - standard sexual reproduction
- addPatternForRecombinant() - custom breakpoints and strand selection
- addPatternForNull() - placeholder for missing chromosomes
- All patterns applied together with addMultiRecombinant()

### Testing Long Simulations - Recipe 16.10

**Issue**: Some recipes run for 25,000+ ticks (too slow for routine testing)

**Solution**: Create shortened test version with reduced runtime

**Example**:
```r
# Full recipe runs 25,000 ticks
# Create test version with 100 ticks
test_that("Long recipe works", {
  # Redefine constants in test version
  recipe_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("N", 50)  # Smaller population
      defineConstant("RUNTIME", 100)  # Shorter runtime
      # ... rest of init ...
    }),
    slim_block(100, early(), {
      sim$simulationFinished()  # End early
    })
  )

  result <- slim_run(recipe_test)
  expect_equal(result$exit_status, 0)
})
```

**Key points**:
- Don't skip tests for long recipes - create shorter versions
- Reduce N (population size) and RUNTIME
- Test that code runs, not full scientific results
- Original recipe still available for users who need full simulation

### SLiM Constants vs R Variables for Generation Timing - Recipe 16.10 ⭐ CRITICAL

**Issue**: SLiM constants can't be used in R context for slim_block() generation numbers

**Solution**: Define R variables separately for use in slim_block() calls

**Example**:
```r
# ❌ WRONG - REC is defined in SLiM, not available in R context
recipe <- slim_script(
  slim_block(initialize(), {
    defineConstant("REC", 5000)
  }),
  slim_block(REC, late(), {  # ERROR: object 'REC' not found
    # ...
  })
)

# ✅ CORRECT - define R variable for slim_block() timing
N_val <- 500
REC_val <- N_val * 10  # R variable

recipe <- slim_script(
  slim_block(initialize(), {
    defineConstant("N", 500)  # SLiM constant
    defineConstant("REC", N * 10)  # SLiM constant
  }),
  slim_block(REC_val, late(), {  # Use R variable
    # Code can use REC constant here
  })
)
```

**Key points**:
- slim_block() generation parameters evaluated in R, not SLiM
- SLiM constants (defineConstant) don't exist at script creation time
- Need parallel R variables if using computed generation numbers
- Inside blocks, can use SLiM constants normally

### Indexed Property Assignment Parse Error - Recipe 16.11 ⭐ CRITICAL

**Issue**: R parser cannot handle indexed property assignments like `object[i].property <- value`

**Solution**: Use vectorized assignment or intermediate variables

**Example**:
```r
# ❌ WRONG - R parse error
for (i in 0:(n - 1)) {
  individuals[i].tag <- values[i]  # Error: unexpected symbol
}

# ✅ CORRECT - Option 1: Vectorized assignment
individuals.tag <- values  # Assign all at once

# ✅ CORRECT - Option 2: Intermediate variable
for (i in 0:(n - 1)) {
  ind <- individuals[i]
  ind.tag <- values[i]
}

# ✅ CORRECT - Option 3: Subset then assign
unmated <- individuals[indices]
unmated.tag <- value
```

**Key points**:
- R parser treats `.property` as separate statement, not part of indexed access
- SLiM allows `object[i].property <- value` but R syntax doesn't parse
- Vectorized assignment is most efficient when possible
- This affects loops that assign to properties of indexed elements
- Works fine without indexing: `individuals.tag <- value` (no problem)
- Problem only occurs with combination: `individuals[i].tag <- value`

**Common scenarios**:
- Tagging individuals in loops
- Setting fitness scaling for subsets
- Updating age or other properties by index
- Any property assignment within indexed access

### first() Callback Timing - Recipe 16.11

**Issue**: Callback execution order within a tick

**Solution**: Understand SLiM's callback sequence

**Example**:
```r
slim_block(first(), {
  # Runs FIRST in the tick, before reproduction() and other callbacks
  # Good for: mate pairing, pre-reproduction setup, cleanup
})

slim_block(early(), {
  # Runs after first(), before reproduction()
})

slim_block(reproduction(), {
  # Runs after early()
})

slim_block(late(), {
  # Runs last in tick
})
```

**Key points**:
- first() → early() → reproduction() → late() order
- Use first() for setup that must happen before reproduction
- Mate pairing, widow detection, tag management fit in first()
- Clean separation of concerns across callback types

### Vectorized Property Assignment - Recipe 16.11

**Issue**: Need to assign properties to multiple individuals efficiently

**Solution**: Use vectorized assignment instead of loops

**Example**:
```r
# ❌ SLOWER - loop-based assignment
for (i in 0:(n - 1)) {
  ind <- individuals[i]
  ind.tag <- values[i]
}

# ✅ FASTER - vectorized assignment
individuals.tag <- values  # Assigns values[i] to individuals[i].tag for all i

# Also works for subset assignment
mated_individuals.tag <- -1  # Set all to -1
unmated_F.tag <- new_tags    # Set females to new tags
```

**Key points**:
- Much faster for large populations
- Cleaner code, easier to read
- SLiM handles vectorization efficiently
- Works with both single values (broadcast) and vectors (parallel)
- Prefer this over indexed loops when possible

---

## Spatial Model Patterns (Recipe 17.x series)

### Spatial Coordinate Type Safety - Recipes 17.9 ⭐ CRITICAL

**Issue**: Spatial properties (x, y, z) require float type, not integer

**Solution**: ALWAYS use asFloat() when assigning to spatial coordinates

**Example**:
```r
# ❌ WRONG - causes "value cannot be type integer for read-write property z"
p1$individuals$z <- 0.0  # Literal gets coerced to integer!

# ✅ CORRECT - use asFloat() wrapper
p1$individuals$z <- asFloat(0.0)

# Also applies to x and y coordinates
p1$individuals$x <- asFloat(5.0)
p1$individuals$y <- asFloat(3.0)
```

**Key points**:
- SLiM spatial properties are strictly typed as float
- Numeric literals like 0.0 can be coerced to integer by slimr
- Always wrap in asFloat() to ensure correct type
- Applies to x, y, z properties on Individual objects

### interaction() Callback - Recipe 17.6

**Purpose**: Custom interaction strength calculation between individuals

**Solution**: Use interaction() callback with exerter and receiver parameters

**Example**:
```r
# Define non-spatial interaction (empty dimensionality string)
initializeInteractionType(1, "", reciprocal = T)

# interaction() callback calculates strength between individuals
slim_block(interaction(i1), {
  # exerter: individual exerting influence
  # receiver: individual receiving influence
  # Return interaction strength (float)
  return(asFloat(dnorm(exerter$tagF, receiver$tagF, SIGMA_C) / NORM))
})

# Use in fitness calculations
slim_block(1, .., late(), {
  i1$evaluate(p1)
  competition <- sapply(inds, "sum(i1.strength(applyValue));")
  effects <- asFloat(1.0 - competition / size(inds))
  inds$fitnessScaling <- asFloat(inds$fitnessScaling * effects)
})
```

**Key points**:
- Alternative to spatial interactions for custom distance metrics
- `exerter` and `receiver` are available parameters
- Return value is interaction strength (must be float)
- Non-spatial interactions use `dimensionality=""` (empty string)
- Less efficient than spatial interactions but more flexible

### Phenotype as Spatial Dimension - Recipe 17.7

**Purpose**: Model phenotypic competition using spatial machinery (more efficient)

**Solution**: Set individual position equal to phenotype value

**Example**:
```r
# Enable 1D spatial positioning
initializeSLiMOptions(dimensionality = "x")

# Set spatial bounds to cover phenotype range
p1$setSpatialBounds(c(0.0, 10.0))

# Initialize spatial interaction for competition
initializeInteractionType(1, "x", reciprocal = T, maxDistance = SIGMA_C * 3)
i1$setInteractionFunction("n", 1.0, SIGMA_C)

# Each generation: set position = phenotype
slim_block(1, .., late(), {
  phenotypes <- inds$sumOfMutationsOfType(m2)
  inds$x <- phenotypes  # Position equals phenotype!

  # Spatial competition now = phenotypic competition
  i1$evaluate(p1)
  competition <- sapply(inds, "sum(i1.strength(applyValue));")
  effects <- asFloat(1.0 - competition / size(inds))
  inds$fitnessScaling <- asFloat(inds$fitnessScaling * effects)
})
```

**Key points**:
- More efficient than interaction() callback approach
- Uses SLiM's optimized spatial interaction machinery
- Phenotypic distance = spatial distance automatically
- Works for 1D, 2D, or 3D phenotype spaces
- No custom interaction callback needed

### 3D Spatial Models (Geography + Phenotype) - Recipe 17.9

**Purpose**: Combine geographic space with phenotype space

**Solution**: Use xyz dimensionality where x,y = geography, z = phenotype

**Example**:
```r
# Enable 3D spatial positioning
initializeSLiMOptions(dimensionality = "xyz")

# Set bounds: [x_min, y_min, z_min, x_max, y_max, z_max]
p1$setSpatialBounds(c(0.0, 0.0, -SLOPE, 1.0, 1.0, SLOPE))

# Offspring dispersal only in x,y (geographic), not z (phenotype)
slim_block(modifyChild(), {
  # Access only x,y coordinates with [0:1] indexing
  pos <- c(parent1$spatialPosition[0:1] + rnorm(2, 0, 0.005), 0.0)
  while (!p1$pointInBounds(pos))
    pos <- c(parent1$spatialPosition[0:1] + rnorm(2, 0, 0.005), 0.0)
  child$setSpatialPosition(pos)
  return(T)
})

# Spatially varying selection based on x-position
slim_block(1, .., late(), {
  phenotypes <- inds$sumOfMutationsOfType(m2)
  optima <- (inds$x - 0.5) * SLOPE  # Optimum varies with geography
  inds$fitnessScaling <- asFloat(1.0 + dnorm(phenotypes, optima, SIGMA_K))
  inds$z <- phenotypes  # Set z-coordinate to phenotype
})
```

**Key points**:
- `dimensionality="xyz"` for 3D space
- x,y typically represent geographic coordinates
- z typically represents phenotype or other trait
- `spatialPosition[0:1]` accesses only x,y dimensions
- Enables modeling of spatially varying selection (clines)
- Competition/mating considers all 3 dimensions

### Spatial Maps from Images - Recipe 17.10

**Purpose**: Use real-world geographic data for habitat constraints

**Solution**: Load image files and create spatial maps

**Example**:
```r
slim_block(1, late(), {
  sim$addSubpop("p1", 1000)
  p1$setSpatialBounds(c(0.0, 0.0, 539.0, 216.0))

  # Load image file (PNG or JPEG)
  mapImage <- Image("world_map_540x217.png")

  # Create spatial map from grayscale channel
  # floatK extracts grayscale as float values [0, 1]
  map <- p1$defineSpatialMap("world", "xy", 1.0 - mapImage$floatK,
                            valueRange = c(0.0, 1.0),
                            colors = c("#0000CC", "#55FF22"))
  defineConstant("WORLD", map)
})

# Query map value at position
slim_block(modifyChild(), {
  pos <- parent1$spatialPosition + rnorm(2, 0, 2.0)
  while (!p1$pointInBounds(pos))
    pos <- parent1$spatialPosition + rnorm(2, 0, 2.0)

  # Prevent dispersal into unsuitable habitat
  if (WORLD$mapValue(pos) == 0.0)
    return(F)  # Offspring dies (absorbing boundary)

  child$setSpatialPosition(pos)
  return(T)
})
```

**Key points**:
- `Image()` class loads PNG/JPEG files
- `floatK` property extracts grayscale channel as float [0, 1]
- `defineSpatialMap()` creates SpatialMap from matrix/image data
- `mapValue(pos)` queries map value at spatial position
- Can use for habitat suitability, elevation, climate, etc.
- 0.0 typically represents unsuitable habitat
- Maps can be used in fitness calculations or dispersal constraints

### Multiple Interaction Types at Different Scales - Recipes 17.4, 17.8

**Purpose**: Model different ecological processes (competition, mating) at different spatial scales

**Solution**: Initialize multiple interaction types with different maxDistance

**Example**:
```r
slim_block(initialize(), {
  # Competition at larger scale
  initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3)
  i1$setInteractionFunction("n", 3.0, 0.1)

  # Mate choice at smaller scale (more local)
  initializeInteractionType(2, "xy", reciprocal = T, maxDistance = 0.1)
  i2$setInteractionFunction("n", 1.0, 0.02)
})

# Evaluate both interactions each generation
slim_block(1, .., late(), {
  i1$evaluate(p1)  # Competition
  # ... use i1 for fitness calculations
})

slim_block(2, .., first(), {
  i2$evaluate(p1)  # Mate choice (before reproduction)
})

slim_block(mateChoice(), {
  return(i2$strength(individual))  # Use i2 for mate selection
})
```

**Key points**:
- Different ecological processes operate at different spatial scales
- Competition often has larger interaction distance than mating
- Each interaction type has its own maxDistance and kernel function
- Evaluate interactions in appropriate callback stages
- i1, i2, i3, etc. for multiple interaction types
- Enables realistic modeling of multi-scale ecological dynamics

---

## Multispecies Model Patterns (Recipe 17.19, 19.x, 20.x series)

### Multispecies Syntax ⭐ CRITICAL

**Issue**: Multispecies models require special syntax in slim_block()

**Solution**: Use named parameters, NOT `species = "name"`

**Example**:
```r
# ❌ WRONG - using species parameter
slim_block(species = "all", initialize(), { ... })
slim_block(species = "host", initialize(), { ... })

# ✅ CORRECT - use named parameters
slim_script(
  slim_block(all = initialize(), {
    initializeSLiMModelType("nonWF")
    # ... shared initialization ...
  }),

  slim_block(host = initialize(), {
    initializeSpecies(avatar = "🐛", color = "blue")
    initializeSLiMOptions(dimensionality = "xy")
  }),

  slim_block(parasitoid = initialize(), {
    initializeSpecies(avatar = "🦟", color = "red")
    initializeSLiMOptions(dimensionality = "xy")
  }),

  # Timed events for all species
  slim_block(all = 1, early(), { ... }),

  # Species-specific callbacks
  slim_block(host = reproduction(), { ... })
)
```

**Key points**:
- `all = ...` for blocks shared across all species
- `species_name = ...` for species-specific blocks (use actual species name)
- Works with initialize(), callbacks, and timed events
- initializeSpecies() sets avatar and color for SLiMgui visualization
- Each species has independent populations and genetics

### reproduction() Callback Return Policy ⭐ CRITICAL

**Issue**: reproduction() callbacks must NOT return any value (void return type)

**Solution**: Remove return statements, use if-else structure instead

**Example**:
```r
# ❌ WRONG - returning NULL is not allowed
slim_block(reproduction(), {
  litterSize <- rpois(1, 0.5)
  if (litterSize == 0)
    return(NULL)  # ERROR: must not return a value

  mate <- i2$nearestNeighbors(individual, 1)
  if (mate$size() == 0)
    return(NULL)  # ERROR

  subpop$addCrossed(individual, mate, count = litterSize)
})

# ✅ CORRECT - use nested if-else
slim_block(reproduction(), {
  litterSize <- rpois(1, 0.5)

  if (litterSize > 0) {
    mate <- i2$nearestNeighbors(individual, 1)

    if (mate$size() > 0) {
      subpop$addCrossed(individual, mate, count = litterSize)
    }
  }
  # No return statement
})
```

**Key points**:
- reproduction() changed in SLiM 4+: must return void (no value)
- Early return with `return(NULL)` causes error
- Restructure with nested if statements instead
- Other callbacks have different return requirements:
  - modifyChild() returns T/F
  - mateChoice() returns weights/mate/float(0)
  - survival() returns T/F or subpopulation or NULL

### Tag Property Type Requirements ⭐ IMPORTANT

**Issue**: Float tag properties (tagF) require asFloat() wrapper

**Solution**: Use asFloat() for all float tag assignments

**Example**:
```r
# ❌ WRONG - integer type error
individual$tagF <- 10.0

# ✅ CORRECT
individual$tagF <- asFloat(10.0)
```

**Key points**:
- tagF is the float-valued tag property
- tagL0, tagL1, tagL2, tagL3, tagL4 are integer-valued (don't need asFloat)
- Similar to fitnessScaling, spatial coordinates, and other float properties
- General pattern: any SLiM property expecting float type needs asFloat() in slimr

## Tree-Sequence Recording Patterns (Recipe 18.x series)

### 1. Tree-Sequence Initialization and Configuration

**Basic setup**:
```r
initializeTreeSeq()  # Enable tree-sequence recording
```

**Advanced configuration**:
```r
# For recapitation (adding coalescent history before simulation)
initializeTreeSeq(simplificationRatio = INF, timeUnit = "generations")

# For performance optimization
initializeTreeSeq(simplificationInterval = 1000)

# For coalescence detection
initializeTreeSeq(checkCoalescence = T)
```

**Key points**:
- `simplificationRatio=INF`: Never simplify automatically (preserves full history)
- `simplificationInterval=N`: Simplify every N generations (trade memory for speed)
- `timeUnit="generations"`: Record absolute times (needed for recapitation)
- `checkCoalescence=T`: Enable coalescence detection

### 2. readFromPopulationFile() for Coalescent Initialization

**Purpose**: Initialize SLiM simulation with pre-existing coalescent genealogy

**Pattern**:
```r
slim_block(1, late(), {
  # Load population state and genealogy from tree sequence
  sim$readFromPopulationFile("coalescent.trees")

  # Can then add mutations or modify population
  target <- sample(sim$subpopulations$haplosomes, 1)
  target$addNewDrawnMutation(m2, 10000)
})
```

**Key points**:
- Loads both population state AND genealogical history
- Typically used with tree sequences generated by msprime (Python)
- Enables studying selection on realistic neutral backgrounds
- Works with both WF and nonWF models

### 3. treeSeqRememberIndividuals() for Ancestry Tracking

**Purpose**: Mark specific individuals to track their ancestry in tree sequence

**Pattern**:
```r
slim_block(1, late(), {
  sim$addSubpop("p1", 500)
  sim$addSubpop("p2", 500)

  # Remember founding individuals for ancestry analysis
  sim$treeSeqRememberIndividuals(sim$subpopulations$individuals)
})
```

**Key points**:
- Essential for admixture and migration studies
- Preserves ancestry information even after simplification
- Enables Python/tskit analysis of local ancestry

### 4. Testing Long-Running Tree-Sequence Recipes

**Issue**: Some recipes run for tens of thousands of generations (too slow for routine testing)

**Solution**: Create shortened test versions with reduced parameters

**Pattern**:
```r
test_that("Long recipe works", {
  # Create test version with reduced parameters
  recipe_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("N", 100)        # Reduced from 10,000
      defineConstant("L", 1e6)        # Reduced from 1e8
      initializeTreeSeq()
      # ... rest of init ...
    }),

    # Shortened runtime
    slim_block(1000, late(), {        # Reduced from 100,000
      sim$treeSeqOutput("test.trees")
    })
  )

  result <- slim_run(recipe_test)
  expect_equal(result$exit_status, 0)
})
```

**Key points**:
- Reduce N (population size) by 10-100x
- Reduce L (chromosome length) by 10-100x
- Reduce runtime by 10-100x
- Test that code runs correctly, not full scientific results
- Original recipe still available for users

### 5. Generating Prerequisite Tree-Sequence Files in Tests

**Issue**: Some recipes require tree-sequence files as input (normally from Python/msprime)

**Solution**: Generate minimal tree sequences programmatically in test setup

**Pattern**:
```r
test_that("Recipe requiring tree-sequence input works", {
  # Part 1: Generate prerequisite tree sequence
  setup_script <- slim_script(
    slim_block(initialize(), {
      initializeTreeSeq()
      # ... init ...
    }),
    slim_block(100, late(), {
      sim$treeSeqOutput("input.trees")
    })
  )

  result1 <- slim_run(setup_script)
  expect_true(file.exists("input.trees"))

  # Part 2: Run actual recipe that reads tree sequence
  source(system.file("extdata/slim_recipes/converted/recipe_X_Y.R", package = "slimr"))
  result2 <- slim_run(recipe_X_Y_script)

  # Cleanup
  unlink("input.trees")
})
```

**Key points**:
- Generate files in test setup, not external dependencies
- Ensures tests are self-contained and reproducible
- Use minimal simulations (short runtime, small N) for file generation

---

## Multispecies Models (Recipe 20.x series)

### 1. Multispecies Syntax - Named Parameters ⭐ CRITICAL

**Issue**: SLiM 5.x multispecies models use special `species` and `ticks` keywords. Conversion requires named parameters, NOT string arguments.

**Solution**: Use named parameters in slim_block() calls

**Pattern**:
```r
# SLiM: species sim initialize() { ... }
# ❌ WRONG - don't use species = "sim"
slim_block(species = "sim", initialize(), { ... })

# ✅ CORRECT - use sim = initialize()
slim_block(sim = initialize(), { ... })

# SLiM: species host initialize() { ... }
# ✅ CORRECT
slim_block(host = initialize(), { ... })

# SLiM: ticks all 1 early() { ... }
# ✅ CORRECT
slim_block(all = 1, early(), { ... })

# SLiM: ticks all late() { ... }  (no generation number)
# ✅ CORRECT - use 1, .., for "every generation"
slim_block(all = 1, .., late(), { ... })

# SLiM: ticks mouse early() { ... }  (no generation)
# ✅ CORRECT - species-specific, every generation
slim_block(mouse = 1, .., early(), { ... })
```

**Key points**:
- Named parameters: `species_name = callback()` NOT `species = "name"`
- `all = ...` for blocks running across all species
- Species-specific: `host = ...`, `parasitoid = ...`
- No generation = use `1, .., callback()`
- Each species can have independent genetic systems

### 2. Unicode Characters in Variable Names ⭐ CRITICAL

**Issue**: Unicode prime character (′) and other special Unicode characters don't parse in R

**Solution**: Use standard ASCII variable names only

**Example**:
```r
# SLiM: x1′ = x1 * exp(R - x1/K - A*x2)  # Uses Unicode prime ′
# ❌ WRONG - Unicode doesn't parse
x1′ <- x1 * exp(R - x1/K - A*x2)

# ✅ CORRECT - Use standard names
x1_next <- x1 * exp(R - x1/K - A*x2)
x2_next <- x1 * (1 - exp(-A*x2))
```

**Key points**:
- Use `_next`, `_prime`, or other ASCII suffixes
- Applies to all Unicode: ′ ″ ³ α β etc.
- R parser rejects non-ASCII in identifiers

### 3. Parallel Iteration Loops ⭐ CRITICAL

**Issue**: SLiM's parallel iteration syntax `for (x in X, y in Y)` doesn't exist in R

**Solution**: Convert to indexed loops with manual indexing

**Example**:
```r
# SLiM: for (p in parasites, h in chosen_hosts) { ... }
# ❌ WRONG - parallel iteration not supported in R
for (p in parasites, h in chosen_hosts) {
  # ...
}

# ✅ CORRECT - use indexed loop
for (i in 0:(size(parasites) - 1)) {
  p <- parasites[i]
  h <- chosen_hosts[i]
  # ... rest of loop body ...
}
```

**Key points**:
- SLiM uses 0-based indexing: `0:(size(x) - 1)`
- Extract elements manually: `x[i]`
- Both vectors must have same length
- Common in multispecies models for host-pathogen pairing

### 4. Multiple Script Blocks with Same Signature

**Issue**: SLiM allows multiple blocks with identical callback signatures (e.g., multiple `ticks all early()` blocks)

**Solution**: Create separate slim_block() calls for each

**Example**:
```r
# SLiM has three separate "ticks all early()" blocks
# ticks all early() { // monkey regulation }
# ticks all early() { // horizontal transmission }
# ticks all early() { // disease outcomes }

# ✅ CORRECT - create three separate blocks
slim_block(all = 1, .., early(), {
  # monkey population regulation
  p1$fitnessScaling <- asFloat(K_MONKEY / p1$individualCount)
}),

slim_block(all = 1, .., early(), {
  # horizontal transmission
  # ... transmission code ...
}),

slim_block(all = 1, .., early(), {
  # disease outcomes
  # ... outcome code ...
})
```

**Key points**:
- Each SLiM block becomes a slim_block() call
- Order matters - blocks execute in order defined
- Useful for organizing complex logic into stages
- Common in Recipe 20.8 (within-host dynamics)

### 5. Species-Specific Tick Schedules

**Issue**: Different species can run on different time scales using `tickModulo` and `tickPhase`

**Solution**: Specify in initializeSpecies() - slimr handles automatically

**Example**:
```r
# Fast-evolving pathogens: every cycle
slim_block(pathogen = initialize(), {
  initializeSpecies(avatar = "🦠")  # Default: tickModulo=1
}),

# Slow-evolving hosts: every 20 cycles
slim_block(monkey = initialize(), {
  initializeSpecies(tickModulo = 20, avatar = "🐵")
}),

# Species-specific callbacks run on their schedule
slim_block(monkey = 1, .., early(), {
  # Runs every 20th cycle
}),

slim_block(pathogen = 1, .., early(), {
  # Runs every cycle
})
```

**Key points**:
- `tickModulo`: cycle interval (1 = every cycle, 20 = every 20th)
- `tickPhase`: offset for starting (default 1)
- `all = ...` blocks run at absolute cycle numbers
- Models generation time differences (fast pathogens, slow hosts)

### 6. Pedigree-Based Host Tracking

**Issue**: Multispecies models often need to track which individuals belong together (e.g., pathogens inside hosts)

**Solution**: Use pedigree IDs with keepPedigrees=T and tag properties

**Example**:
```r
# Enable pedigrees in host species
slim_block(host = initialize(), {
  initializeSLiMOptions(keepPedigrees = T)
}),

# Store host ID in pathogen subpopulation
slim_block(all = 1, early(), {
  # Create pathogen subpop for each infected host
  for (host in infected_hosts) {
    pathogen_subpop <- pathogen$addSubpop(next_id, 1)
    pathogen_subpop$tag <- host$pedigreeID  # Link to host!
    next_id <- next_id + 1
  }
}),

# Later: find pathogens inside specific host
slim_block(all = 1, .., early(), {
  hostID <- individual$pedigreeID
  pathogenSubpop <- pathogen$subpopulations[pathogen$subpopulations$tag == hostID]
  # Now have pathogens inside this host
})
```

**Key points**:
- Pedigree IDs persist even if individuals die
- Store in tag properties (integers/floats) or use getValue/setValue for complex data
- Critical for within-host dynamics (Recipe 20.8)
- Enables horizontal transmission tracking

---

**Last updated**: 2025-10-27
**Created from**: 182 recipes converted (Recipe 4-20 series COMPLETE!)
**Original notes**: See `recipe_conversion_notes.md` for historical session details
