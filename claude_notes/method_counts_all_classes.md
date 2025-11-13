# Method Counts Analysis - All Classes

## Methods Extracted vs Available in Source

Based on the investigation, here's what we know:

### Source File Statistics
- **Total method signatures in SLiMHelpClasses_unrtf.txt:** 216
- Methods with "+" prefix (class methods): Unknown exact count
- Methods with "-" prefix (instance methods): Unknown exact count

### Extraction Pattern Bug

**Current pattern (line 343):**
```r
method_def_pattern <- "^- \(([^)]+)\)([a-zA-Z_]\w*)\("
```

**Problem:** Only matches "-" prefix, ignores "+" prefix

**Impact:** ALL class methods (+ prefix) across ALL classes are missing

### Classes in System

According to extracted data, 18 classes total:
1. Initialize
2. Chromosome  
3. Community
4. Haplosome
5. GenomicElement
6. GenomicElementType
7. Individual
8. InteractionType
9. LogFile
10. Mutation
11. MutationType
12. Plot
13. SLiMgui
14. SpatialMap
15. Species
16. Subpopulation
17. SLiMBuiltin
18. Eidos

### Known Case: Haplosome Class

**Total methods in documentation:** 18
- Class methods (+ prefix): 11
- Instance methods (- prefix): 7

**Extracted:** 7 methods (100% of instance methods, 0% of class methods)

**Missing:** 11 methods (all class methods):
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

### Critical Missing Functionality

The bug affects essential operations:

#### Data Output/Export
- outputHaplosomes
- outputHaplosomesToMS  
- outputHaplosomesToVCF
- (Likely similar methods in Individual, Subpopulation, Species)

#### Data Input
- readHaplosomesFromMS
- readHaplosomesFromVCF
- (Likely similar methods in Individual class)

#### Mutation Operations
- addMutations
- addNewMutation
- addNewDrawnMutation
- removeMutations

#### Population Genetics Calculations
- mutationCountsInHaplosomes
- mutationFrequenciesInHaplosomes

### Estimated Impact

If Haplosome's ratio (61% missing) is representative:
- **216 total methods in source**
- **~132 methods likely missing** (61% of 216)
- **~84 methods extracted** (39% of 216)

This is a **critical bug** that removes majority of functionality from the SLiM API wrapper.

### Next Steps

1. Fix the regex pattern to match both [+-] prefixes
2. Re-extract all methods
3. Compare before/after counts for all classes
4. Re-generate documentation
5. Test key functionality
