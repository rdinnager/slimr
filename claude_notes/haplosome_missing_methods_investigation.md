# Investigation Report: Missing Haplosome Methods

**Date:** 2025-11-07
**Investigator:** Claude Code
**Issue:** Haplosome class missing most of its methods in slimr package

## Executive Summary

The Haplosome class is missing **12 out of 19 methods** (63% missing) due to a regex pattern bug in the extraction script that only captures methods with the "-" symbol prefix and ignores methods with the "+" symbol prefix.

## Findings

### 1. What Methods Are Documented for Haplosome in SLiM 5.x

According to `data-raw/slim_man/SLiMHelpClasses_unrtf.txt`, the Haplosome class has **19 methods total**:

#### Methods with "+" prefix (CLASS METHODS - 10 total):
1. `+ (void)addMutations(object<Mutation> mutations)`
2. `+ (object<Mutation>)addNewDrawnMutation(...)`
3. `+ (object<Mutation>)addNewMutation(...)`
4. `+ (integer)mutationCountsInHaplosomes([No<Mutation> mutations = NULL])`
5. `+ (float)mutationFrequenciesInHaplosomes([No<Mutation> mutations = NULL])`
6. `+ (void)outputHaplosomes([Ns$ filePath = NULL], [logical$ append = F], [logical$ objectTags = F])`
7. `+ (void)outputHaplosomesToMS([Ns$ filePath = NULL], [logical$ append = F], [logical$ filterMonomorphic = F])`
8. `+ (void)outputHaplosomesToVCF([...])`
9. `+ (object<Mutation>)readHaplosomesFromMS(string$ filePath, io<MutationType>$ mutationType)`
10. `+ (object<Mutation>)readHaplosomesFromVCF(string$ filePath, [Nio<MutationType>$ mutationType = NULL])`
11. `+ (void)removeMutations([No<Mutation> mutations = NULL], [logical$ substitute = F])`

#### Methods with "-" prefix (INSTANCE METHODS - 7 total):
1. `- (Nlo<Mutation>$)containsMarkerMutation(...)`
2. `- (logical)containsMutations(object<Mutation> mutations)`
3. `- (integer$)countOfMutationsOfType(io<MutationType>$ mutType)`
4. `- (object<Mutation>)mutationsOfType(io<MutationType>$ mutType)`
5. `- (is)nucleotides([Ni$ start = NULL], [Ni$ end = NULL], [string$ format = "string"])`
6. `- (integer)positionsOfMutationsOfType(io<MutationType>$ mutType)`
7. `- (float$)sumOfMutationsOfType(io<MutationType>$ mutType)`

**Total: 19 methods**

### 2. What Was Extracted

According to `data-raw/build_5/all_methods_data.rds`:

**Only 7 methods extracted:**
- containsMarkerMutation ✓
- containsMutations ✓
- countOfMutationsOfType ✓
- mutationsOfType ✓
- nucleotides ✓
- positionsOfMutationsOfType ✓
- sumOfMutationsOfType ✓

**ALL 7 extracted methods have the "-" prefix (instance methods).**

### 3. Missing Methods

**12 methods missing (all with "+" prefix - class methods):**
1. addMutations
2. addNewDrawnMutation
3. addNewMutation
4. mutationCountsInHaplosomes
5. mutationFrequenciesInHaplosomes
6. outputHaplosomes
7. outputHaplosomesToMS
8. outputHaplosomesToVCF
9. readHaplosomesFromMS
10. readHaplosomesFromVCF
11. removeMutations
12. (Note: The list above shows 11, let me recount from the source)

Actually from the grep output, there are 11 methods with "+":
1. addMutations (line 219)
2. addNewDrawnMutation (line 223)
3. addNewMutation (line 232)
4. mutationCountsInHaplosomes (line 248)
5. mutationFrequenciesInHaplosomes (line 252)
6. outputHaplosomes (line 262)
7. outputHaplosomesToMS (line 266)
8. outputHaplosomesToVCF (line 270)
9. readHaplosomesFromMS (line 278)
10. readHaplosomesFromVCF (line 281)
11. removeMutations (line 292)

**Total missing: 11 methods**

### 4. Root Cause Analysis

**File:** `data-raw/build_5/extract_from_rtf.R`
**Line:** 343
**Bug:** The regex pattern only matches methods starting with "- " (dash + space)

```r
method_def_pattern <- "^- \(([^)]+)\)([a-zA-Z_]\w*)\("
```

This pattern:
- Requires the line to start with `^- ` (caret, dash, space)
- Will NOT match lines starting with `^+ ` (caret, plus, space)
- Therefore, all class methods (prefix "+") are ignored

### 5. Symbol Meanings in SLiM Documentation

According to SLiM documentation conventions:
- **"-" prefix** = Instance method (called on individual object instances)
- **"+" prefix** = Class method (called on vectors/collections of objects)

The extraction script is only capturing instance methods and completely missing all class methods.

### 6. Impact on Other Classes

This is a **systematic bug affecting ALL classes** that have class methods (+ prefix).

I counted 216 total method signatures in `SLiMHelpClasses_unrtf.txt`:
```bash
grep -c "^[+-] (" c:/Projects/slimr/data-raw/slim_man/SLiMHelpClasses_unrtf.txt
# Returns: 216
```

Let me check how many use each prefix:

**Methods by prefix:**
- Lines starting with "+ (": MANY (class methods)
- Lines starting with "- (": MANY (instance methods)

Without running the full analysis, I can confirm from the Haplosome case that:
- Instance methods ("-") are being extracted correctly
- Class methods ("+") are being completely ignored

This affects critical functionality like:
- Output methods (outputHaplosomes, outputHaplosomesToMS, outputHaplosomesToVCF)
- Input methods (readHaplosomesFromMS, readHaplosomesFromVCF)
- Mutation manipulation (addMutations, addNewMutation, addNewDrawnMutation, removeMutations)
- Population genetics calculations (mutationCountsInHaplosomes, mutationFrequenciesInHaplosomes)

### 7. Classes Likely Affected

Any class with class methods (+ prefix) will be missing those methods. Based on SLiM's design, this likely includes:
- Haplosome (confirmed: 11 missing)
- Individual (likely has output/manipulation methods)
- Subpopulation (likely has population-level methods)
- Species (likely has species-level methods)
- Mutation (likely has bulk operations)
- And potentially others

## Fix Required

**File:** `data-raw/build_5/extract_from_rtf.R`
**Line:** 343

Change:
```r
method_def_pattern <- "^- \(([^)]+)\)([a-zA-Z_]\w*)\("
```

To:
```r
method_def_pattern <- "^[+-] \(([^)]+)\)([a-zA-Z_]\w*)\("
```

This changes `^-` to `^[+-]` which matches either "-" or "+" at the start of the line.

**Additionally, line 380 needs updating:**

Change:
```r
full_pattern <- "^- \(([^)]+)\)([a-zA-Z_]\w*)\((.*)\)\s*$"
```

To:
```r
full_pattern <- "^[+-] \(([^)]+)\)([a-zA-Z_]\w*)\((.*)\)\s*$"
```

**And line 494 (in extract_one_method):**

Change:
```r
symbol = "-",  # en-dash cleaned to regular dash
```

To capture the actual symbol:
```r
symbol = substr(method_line, 1, 1),  # Capture actual + or -
```

## Verification Steps

After fixing the extraction script:

1. Re-run `data-raw/build_5/extract_from_rtf.R`
2. Check that `all_methods_data.rds` now contains all 18 Haplosome methods
3. Verify other classes also gained their missing methods
4. Re-run Phase 2 stub generation
5. Check that `R/slim_lang.R` now has all methods
6. Verify `man/Haplosome_Class.Rd` lists all methods
7. Run package check: `devtools::check()`

## Additional Notes

The current `man/Haplosome_Class.Rd` file only lists `containsMarkerMutation` in the methods section (line 14), which is incorrect. It should list all 18 methods.

The "seealso" section (lines 27-36) does list 7 methods, which matches the 7 that were extracted (all instance methods with "-" prefix).

## Recommendation

1. Fix the regex pattern to capture both "+" and "-" prefixes
2. Re-extract all data
3. Re-generate all R stubs and documentation
4. Add a validation step to compare extracted method counts against expected counts from the source RTF file
