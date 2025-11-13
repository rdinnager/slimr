# Recipe Conversion - Current Status

**Last updated**: 2025-10-27

## 🚀 Getting Started

**New agent?** Read these files in order:

1. **`RECIPE_CONVERSION_PLAN.md`** - Understand the overall process and goals ⭐ START HERE
2. **`RECIPE_CONVERSION_GUIDE.md`** - Essential patterns and solutions ⭐ MUST READ
3. **THIS FILE** (`CURRENT_STATUS.md`) - Current progress and what to work on next

The plan gives you the big picture, the guide gives you the critical patterns (like `..` syntax, asFloat() for callbacks, 0-based indexing), and this file tells you where to jump in!

*Optional*: `recipe_conversion_notes.md` has detailed historical session notes if you need more context.

---

## Quick Stats

- **Total recipes available**: ~188+ (Recipes 4-6, 8-20 series identified)
- **Recipes converted**: 182 (Recipe 20.x series COMPLETE!)
- **Completion rate**: ~97% (of 188)
- **All tests passing**: Yes ✅
- **Major milestones**: Recipe 4-20 series COMPLETE! (182 recipes total)

## Completed Recipes

1. ✅ Recipe 4.1 - A basic neutral simulation
2. ✅ Recipe 4.1.10 - Using defineConstant() for parameterization
3. ✅ Recipe 4.2.1 - Basic output - Entire population
4. ✅ Recipe 4.2.2 - Basic output - Sampling
5. ✅ Recipe 4.2.3 - Migration and weighted sampling
6. ✅ Recipe 4.2.4 - Output fixed mutations
7. ✅ Recipe 4.2.5 - Log files with FST
8. ✅ Recipe 4.2.6 - MS-format output
9. ✅ Recipe 5.1.1 - Population size changes - Bottleneck
10. ✅ Recipe 5.1.2_I - Exponential growth
11. ✅ Recipe 5.1.2_II - Exponential growth variant II
12. ✅ Recipe 5.1.2_III - Exponential growth with population cap
13. ✅ Recipe 5.1.2_IV - Exponential growth with cap (alternative)
14. ✅ Recipe 5.1.2_V - Exponential growth with self-deregistering block
15. ✅ Recipe 5.1.4 - Oscillating population size
16. ✅ Recipe 5.1.5 - Fitness-dependent population size
17. ✅ Recipe 5.2.1 - Migration between subpopulations
18. ✅ Recipe 5.2.2 - Removing subpopulations
19. ✅ Recipe 5.2.3 - Splitting subpopulations
20. ✅ Recipe 5.2.4 - Joining subpopulations
21. ✅ Recipe 5.3.1 - Stepping-stone migration model
22. ✅ Recipe 5.3.2 - A non-spatial metapopulation
23. ✅ Recipe 5.3.3 - A two-dimensional subpopulation matrix
24. ✅ Recipe 5.3.4 - A random, sparse spatial metapopulation
25. ✅ Recipe 5.3.5 - Reading migration matrix from file
26. ✅ Recipe 5.4_I - Gravel et al. (2011) human evolution model
27. ✅ Recipe 5.4_II - Gravel model with Jump Menu annotations
28. ✅ Recipe 5.5_I - Rescaling (original/baseline version)
29. ✅ Recipe 5.5_II - Rescaling (rescaled for 10x speedup)
30. ✅ Recipe 6.1 - Mutation types and fitness effects
31. ✅ Recipe 6.2 - Genomic element types
32. ✅ Recipe 6.3 - Chromosome organization
33. ✅ Recipe 6.4 - Custom display colors in SLiMgui
34. ✅ Recipe 8.1.1 - Enabling separate sexes
35. ✅ Recipe 8.1.2 I - Sex ratios at population creation
36. ✅ Recipe 8.1.2 II - Dynamic sex ratio changes
37. ✅ Recipe 8.1.3 - Selfing in hermaphroditic populations
38. ✅ Recipe 8.1.4 I - Basic clonal reproduction
39. ✅ Recipe 8.1.4 II - Sex-specific cloning rates
40. ✅ Recipe 8.2.1 - Making a random recombination map
41. ✅ Recipe 8.2.2 - Reading a recombination map from a file
42. ✅ Recipe 8.2.3 - Unlinked loci
43. ✅ Recipe 8.2.4 - Gene conversion
44. ✅ Recipe 8.3.1 - Multiple diploid autosomes
45. ✅ Recipe 8.3.2 - Clonal haploids and chromosome types
46. ✅ Recipe 8.3.3 - Haploids with recombination
47. ✅ Recipe 8.3.4 - Sex-chromosome evolution and null haplosomes
48. ✅ Recipe 8.3.5 - Modeling the full human genome
49. ✅ Recipe 8.3.6 - A model of bryophytes with UV sex determination
50. ✅ Recipe 8.3.7 - Output from multiple-chromosome models
51. ✅ Recipe 9.1 - Introducing adaptive mutations
52. ✅ Recipe 9.2 - Making sweeps conditional on fixation
53. ✅ Recipe 9.3 - Making sweeps conditional on establishment
54. ✅ Recipe 9.4 - Partial sweeps
55. ✅ Recipe 9.5.1 - Soft sweeps from recurrent de novo mutations
56. ✅ Recipe 9.5.2 - Soft sweeps with fixed de novo mutation schedule
57. ✅ Recipe 9.5.3 - Soft sweeps with random de novo mutation schedule
58. ✅ Recipe 9.6.1 - Standing variation at random locus
59. ✅ Recipe 9.6.2 - Standing variation at predetermined locus
60. ✅ Recipe 9.7 - Adaptive introgression
61. ✅ Recipe 9.8 - Hill-Robertson interference
62. ✅ Recipe 9.9 - Keeping a reference to a sweep mutation
63. ✅ Recipe 9.10 - Tracking the fate of background mutations
64. ✅ Recipe 9.11 - Effective population size versus census size
65. ✅ Recipe 9.12 - Site frequency spectrum (SFS) during sweeps
66. ✅ Recipe 10.1 - Temporally varying selection
67. ✅ Recipe 10.2 - Spatially varying selection
68. ✅ Recipe 10.3.1 I - Epistasis I
69. ✅ Recipe 10.3.1 II - Epistasis II
70. ✅ Recipe 10.4.1 I - Frequency-dependent selection I
71. ✅ Recipe 10.4.1 II - Frequency-dependent selection II
72. ✅ Recipe 10.4.1 III - Frequency-dependent selection III
73. ✅ Recipe 10.4.2 - Cultural effects on fitness
74. ✅ Recipe 10.4.3 - Kin selection and green-beard effect
75. ✅ Recipe 10.5 - Changing selection coefficients
76. ✅ Recipe 10.6 I - Varying dominance I
77. ✅ Recipe 10.6 II - Varying dominance II
78. ✅ Recipe 11.1 - Assortative mating
79. ✅ Recipe 11.2 I - Sequential mate search I
80. ✅ Recipe 11.2 II - Sequential mate search II
81. ✅ Recipe 11.3 - Gametophytic self-incompatibility
82. ✅ Recipe 12.1 - Social learning of cultural traits
83. ✅ Recipe 12.2 I - Lethal epistasis I
84. ✅ Recipe 12.2 II - Lethal epistasis II
85. ✅ Recipe 12.3 - Simulating gene drive
86. ✅ Recipe 12.4 - Suppressing hermaphroditic selfing
87. ✅ Recipe 12.5 - Tracking separate sexes in script
88. ✅ Recipe 13.1 - Basic polygenic selection
89. ✅ Recipe 13.2 - Variable QTL effect sizes
90. ✅ Recipe 13.3 - Discrete QTL effects with multiple chromosomes
91. ✅ Recipe 13.4 - Heritability model
92. ✅ Recipe 13.5 - Two traits with pleiotropy
93. ✅ Recipe 13.6 I - Stabilizing selection (Gaussian fitness)
94. ✅ Recipe 13.6 II - Directional selection (linear fitness)
95. ✅ Recipe 13.6 III - Disruptive selection (inverted Gaussian)
96. ✅ Recipe 13.6 IV - Truncation selection (threshold)
97. ✅ Recipe 13.7 - Negative frequency-dependence on a quantitative trait
98. ✅ Recipe 14.1 - Relatedness, inbreeding, and heterozygosity
99. ✅ Recipe 14.2 I - Mortality-based fitness (mutationEffect)
100. ✅ Recipe 14.2 II - Mortality-based fitness (tag-based)
101. ✅ Recipe 14.2 III - Mortality-based fitness (fitnessScaling)
102. ✅ Recipe 14.3 I - Reading initial state from MS output file I
103. ✅ Recipe 14.3 II - Reading initial state from MS output file II
104. ✅ Recipe 14.4 - Modeling chromosomal inversions with recombination() callback
105. ✅ Recipe 18.1 - A minimal tree-seq model
106. ✅ Recipe 18.3 I - Simulation conditional upon fixation (preserving ancestry I)
107. ✅ Recipe 18.3 II - Simulation conditional upon fixation (preserving ancestry II)
108. ✅ Recipe 18.4 - Detecting the dip in diversity (analyzing tree heights in Python)
109. ✅ Recipe 18.5 - Mapping admixture (analyzing ancestry in Python)
110. ✅ Recipe 18.6 I - Measuring the coalescence time of a model I
111. ✅ Recipe 18.6 II - Measuring the coalescence time of a model II
112. ✅ Recipe 18.7 - Analyzing selection coefficients in Python with tskit
113. ✅ Recipe 18.8 - Starting a hermaphroditic WF model with a coalescent history
114. ✅ Recipe 18.9 - Starting a sexual nonWF model with a coalescent history
115. ✅ Recipe 18.10 - Adding a neutral burn-in after simulation with recapitation
116. ✅ Recipe 18.11 - Optimizing tree-sequence simplification
117. ✅ Recipe 19.1 - A simple neutral nucleotide-based model
118. ✅ Recipe 19.2 - Reading an ancestral nucleotide sequence from a FASTA file
119. ✅ Recipe 19.3 - Sequence output from nucleotide-based models
120. ✅ Recipe 19.4 - Back-mutations, independent mutational lineages, and VCF output
121. ✅ Recipe 19.5 - Modeling elevated CpG mutation rates and equilibrium nucleotide frequencies
122. ✅ Recipe 19.6 - A nucleotide-based model with introduced non-nucleotide-based mutations
123. ✅ Recipe 19.7 - Using standard SLiM fitness effects with nucleotides (modeling synonymous sites)
124. ✅ Recipe 19.8 - Defining sequence-based fitness effects at the nucleotide level
125. ✅ Recipe 19.9 - Defining sequence-based fitness effects at the amino acid level
126. ✅ Recipe 19.10 - Varying the mutation rate along the chromosome in a nucleotide-based model
127. ✅ Recipe 19.11 - Modeling GC-biased gene conversion (gBGC)
128. ✅ Recipe 19.12 - Reading VCF files to create nucleotide-based SNPs
129. ✅ Recipe 19.13 - Tree-sequence recording and nucleotide-based models I
130. ✅ Recipe 19.14 - Modeling identity by state (IBS) (uniquing mutations with a mutation() callback)
131. ✅ Recipe 19.15 - Modeling identity by state (IBS) (uniquing back-mutations to the ancestral state)
132. ✅ Recipe 20.1 - A simple multispecies model
133. ✅ Recipe 20.2 - A two-species model
134. ✅ Recipe 20.3 - A deterministic host-parasitoid model
135. ✅ Recipe 20.4 I - An individual-based host-parasitoid model I
136. ✅ Recipe 20.4 II - An individual-based host-parasitoid model II
137. ✅ Recipe 20.5 - A continuous-space host-parasitoid model
138. ✅ Recipe 20.6 - A coevolutionary host-parasitoid trait-matching model
139. ✅ Recipe 20.7 - A coevolutionary host-parasite matching-allele model
140. ✅ Recipe 20.8 - Within-host reproduction in a host-pathogen model

## Next Up (Recommended Order)

Start here for the next session:
1. **Recipe 7.x series** - Other topics (if any exist)
2. Check for any remaining unconverted recipes

**RECIPE 4-20 SERIES COMPLETE!** Total: 182 recipes!
- Recipe 4.x: 7 recipes ✅
- Recipe 5.x: 13 recipes ✅
- Recipe 6.x: 4 recipes ✅
- Recipe 8.x: 11 recipes ✅
- Recipe 9.x: 15 recipes ✅
- Recipe 10.x: 12 recipes ✅
- Recipe 11.x: 4 recipes ✅
- Recipe 12.x: 6 recipes ✅
- Recipe 13.x: 10 recipes ✅
- Recipe 14.x: 21 recipes ✅
- Recipe 15.x: 16 recipes ✅
- Recipe 16.x: 11 recipes ✅
- Recipe 17.x: 24 recipes ✅
- Recipe 18.x: 12 recipes ✅
- Recipe 19.x: 15 recipes ✅
- Recipe 20.x: 9 recipes ✅ COMPLETE! (all 9 done as of 2025-10-27)

## Key Patterns Documented

All documented in `recipe_conversion_notes.md`:

1. ✅ Property access (. vs $)
2. ✅ Generation ranges (1000:1099)
3. ✅ **Open-ended ranges (1000: → slim_block(1000, .., ...))**  ← IMPORTANT!
4. ✅ Empty blocks (need NULL)
5. ✅ SLiM 5.x terminology (haplosomes)
6. ✅ Output handling (use output_file)
7. ✅ LogFile custom columns
8. ✅ Block deregistration
9. ✅ Blocks running every generation
10. ✅ defineConstant()
11. ✅ Programmatic population creation
12. ✅ Complete migration graph (nested loops with i≠j check)
13. ✅ 2D grid coordinate mapping (x,y to linear IDs)
14. ✅ Random migration rates (runif for heterogeneous connectivity)
15. ✅ Population removal/habitat fragmentation (setSubpopulationSize(0))
16. ✅ Beneficial mutation introduction (addNewDrawnMutation)
17. ✅ File I/O with r_inline() (reading external data files)
18. ✅ String parsing (substr, strsplit, asInteger, asFloat)
19. ✅ Population lookup by ID (subpops[subpops.id == i])
20. ✅ Population splits (addSubpopSplit for founder events)
21. ✅ Complex migration matrices (multi-population gene flow)
22. ✅ Burn-in periods (10×N generations for equilibrium)
23. ✅ Parameter rescaling (composite parameters: 4Nμ, 4Ns, 4Nr)
24. ✅ Jump Menu annotations (structured comments for navigation)
25. ✅ **do-while loop conversion (while(T) + break pattern)**  ← IMPORTANT!
26. ✅ **Boolean constants (T/F not TRUE/FALSE)**  ← CRITICAL!
27. ✅ Mutation type fitness distributions (fixed, gamma, exponential)
28. ✅ Genomic element types with mutation proportions
29. ✅ Random chromosome structure generation
30. ✅ Color properties for SLiMgui visualization
31. ✅ **Gradual migration establishment (progress variables)**  ← NEW!
32. ✅ **Population removal/extinction (setSubpopulationSize(0))**
33. ✅ **addSubpop vs addSubpopSplit (independent vs founder events)**
34. ✅ **Population merger technique (migration-based admixture)**
35. ✅ **Early/late callbacks in same generation (proper sequencing)**
36. ✅ **Random recombination maps (sort/sample for heterogeneous rates)**  ← NEW!
37. ✅ **Reading recombination maps from files (initializeRecombinationRateFromFile)**  ← NEW!
38. ✅ **Unlinked loci (r=0.5 for free recombination/independent assortment)**  ← NEW!
39. ✅ **Gene conversion (initializeGeneConversion for non-reciprocal transfer)**  ← NEW!
40. ✅ **0-based array indexing in loops (for (i in 0:2) not for (i in 1:3))**  ← CRITICAL!
41. ✅ **Multiple chromosome initialization (initializeChromosome)**
42. ✅ **Haploid chromosome types (type="H")**
43. ✅ **Sex chromosome systems (XY with types "X" and "Y")**
44. ✅ **UV sex determination (haploid sex chromosomes in bryophytes)**
45. ✅ **Indexed loops for multi-chromosome models (cleaner than sequential)**
46. ✅ **VCF output (outputIndividualsToVCF for genomics interoperability)**
47. ✅ **slim_function() requires R function body (NOT curly braces)**  ← CRITICAL!
48. ✅ **Mutation object references (defineConstant for efficient tracking)**
49. ✅ **Property access with dot notation (object.property not object$property)**
50. ✅ **Conditional sweeps (save/restore with establishment checks)**
51. ✅ **Soft sweeps (multiple beneficial alleles, setMutationFractions)**
52. ✅ **Standing variation (convert existing mutations with setSelectionCoeff)**
53. ✅ **Mutation tracking (isSegregating, isFixed properties)**
54. ✅ **Pedigree tracking (initializeSLiMOptions(keepPedigrees=T))**
55. ✅ **SLiMgui detection (exists("slimgui") for conditional plotting)**
56. ✅ **Void functions require "void" parameter specification**
57. ✅ **LogFile with custom columns (addMeanSDColumns, addCustomColumn)**
58. ✅ **Site frequency spectrum (calcSFS for allele frequency distribution)**
59. ✅ **asFloat() for mutationEffect() returns (CRITICAL - prevents type errors)**  ← NEW!
60. ✅ **Numeric literal preservation (use asFloat() to maintain type)**  ← NEW!
61. ✅ **mutationEffect() callbacks (temporal, spatial, frequency-dependent fitness)**  ← NEW!
62. ✅ **Epistasis patterns (countOfMutationsOfType + convertToSubstitution=F)**  ← NEW!
63. ✅ **Frequency-dependent selection (balancing and positive)**  ← NEW!
64. ✅ **Gene-culture coevolution (tags for cultural traits)**  ← NEW!
65. ✅ **Green-beard effect (self-recognition and cooperation)**  ← NEW!
66. ✅ **setSelectionCoeff() alternative (dynamic coefficient modification)**  ← NEW!
67. ✅ **mutation() callbacks (per-mutation initialization, must return T)**  ← NEW!
68. ✅ **Dominance variation (setValue/getValue vs multiple types)**  ← NEW!
69. ✅ **Tag-based fitness tracking (accumulating costs/benefits)**  ← NEW!
70. ✅ **Quantitative trait loci (QTLs) via sumOfMutationsOfType()**  ← NEW!
71. ✅ **asFloat() for ALL dnorm() arguments (prevents integer coercion errors)**  ← CRITICAL!
72. ✅ **Ternary operator with %?% and %else% ((cond) %?% val1 %else% val2)**  ← NEW!
73. ✅ **Matrix type consistency for rbind() (both matrices need asFloat())**  ← NEW!
74. ✅ **Script DFE string format ("if (cond) val1 else val2;" NOT double semicolon)**  ← NEW!
75. ✅ **Pleiotropy models with multivariate normal (dmvnorm/rmvnorm)**  ← NEW!
76. ✅ **Frequency-dependent competition (sapply with Gaussian kernel)**  ← NEW!
77. ✅ **Fitness functions: stabilizing, directional, disruptive, truncation**  ← NEW!

## Testing Command

```bash
Rscript -e "Sys.setenv(TEST_RECIPES='true'); Sys.setenv(SLIM_PATH='C:/Users/dinnage/AppData/Local/r-miniconda/envs/slimr-conda/Library/bin/slim.exe'); devtools::load_all('.'); testthat::test_file('tests/testthat/test-recipe_X_Y.R')"
```

## Files to Update Per Recipe

1. `inst/extdata/slim_recipes/converted/recipe_X_Y.R` (the converted script)
2. `tests/testthat/test-recipe_X_Y.R` (the test file)
3. `data-raw/slim_recipes/recipe_metadata.csv` (add row with metadata)
4. `claude_notes/RECIPE_CONVERSION_GUIDE.md` (add notes ONLY for NEW reusable patterns)

## Resources

- **Main plan**: `claude_notes/RECIPE_CONVERSION_PLAN.md`
- **Conversion guide**: `claude_notes/RECIPE_CONVERSION_GUIDE.md` (essential patterns - primary reference)
- **This file**: `claude_notes/CURRENT_STATUS.md`
- **Launch prompts**: `claude_notes/AGENT_LAUNCH_PROMPTS.md` (for starting new agents)
- **Historical notes**: `claude_notes/recipe_conversion_notes.md` (optional, detailed session history)

## Success Criteria

✅ Recipe runs without errors (exit_status = 0)
✅ Test file created and passing
✅ Original SLiM code stored as attribute
✅ Clear description written
✅ Metadata updated
✅ Notes appended (not overwritten!)

---

**Ready for next agent!** ENTIRE RECIPE 8.x, 9.x, 10.x, AND 11.x SERIES COMPLETE (48 recipes)! Recipes 4.x, 5.x, 6.x, 8.x, 9.x, 10.x, and 11.x all done. Continue with Recipe 12.x (check what's available).

**Session 2025-10-24 (8.2.x and 8.3.x)**: Completed Recipe 8.2.x and 8.3.x series (11 recipes total). **8.2.x (recombination)**: Random recombination maps, empirical maps from files, unlinked loci (r=0.5), gene conversion. **8.3.x (multiple chromosomes)**: Multiple autosomes, haploid types, XY sex chromosomes with realistic sizes, full human genome (24 chromosomes from GRCh38.p14), UV haploid sex system (bryophytes), VCF output methods. **CRITICAL NEW PATTERN**: 0-based array indexing in loops - use `for (i in 0:2)` not `for (i in 1:3)` when indexing into SLiM arrays! **KEY INSIGHTS**: (1) Indexed loops with 0-based indexing replace SLiM's parallel iteration, (2) Haploid chromosomes (type="H") with h=1.0, (3) Sex chromosomes need initializeSex() first, (4) Y chromosomes lack recombination (leads to degeneration), (5) Full human genome (3.1 Gb) is computationally intensive but manageable. All 11 tests passing!

**Session 2025-10-24 (9.x continuation)**: Completed ENTIRE Recipe 9.x series (15 recipes total: 9.1-9.12). **Adaptive evolution and selective sweeps**: Beneficial mutations, conditional sweeps (fixation/establishment), partial sweeps, soft sweeps (recurrent/scheduled), standing variation (random/predetermined locus), adaptive introgression, Hill-Robertson interference, mutation object references, genetic hitchhiking, effective population size estimation, site frequency spectrum. **CRITICAL BUG DISCOVERY**: `slim_function()` curly braces syntax DOES NOT WORK - must use R function body: `slim_function("type$ param", name="fn", return_type="type", body=function(param) {...})`. **NEW PATTERNS**: (1) Mutation references with `defineConstant("NAME", mut)` for efficient tracking, (2) Use `result$output_file` for reading SLiM output (preferred pattern), (3) Dot notation `.` for SLiM object properties vs `$` for R-side access, (4) Custom functions need curly braces for if/else blocks, (5) Void functions require "void" parameter, (6) `exists("slimgui")` to conditionally run GUI-specific code, (7) Population IDs are 1-based but array indices are 0-based. **KEY INSIGHTS**: Standing variation allows faster adaptation without waiting for new mutations; soft sweeps occur when beneficial alleles arise multiple times; Hill-Robertson interference reduces fixation probability when beneficial mutations compete; pedigree tracking enables Ne estimation. All 15 tests passing!

**Session 2025-10-25 (10.x series)**: Completed ENTIRE Recipe 10.x series (12 recipes total: 10.1-10.6 II). **Selection topics**: Temporally varying selection, spatially varying selection, epistasis (gene interactions), frequency-dependent selection (balancing, positive, with dominance), gene-culture coevolution, kin selection (green-beard effect), dynamic selection coefficient modification, dominance variation. **CRITICAL DISCOVERIES**: (1) `asFloat()` REQUIRED for mutationEffect() callback returns - prevents type errors, (2) Numeric literals lose decimal points (`100.0` → `100`) causing type mismatches in min()/max() - use `asFloat()` wrapper, (3) Parallel iteration `for (x in A, y in B)` doesn't work - convert to indexed loops with `seqAlong()`. **NEW PATTERNS**: (1) mutationEffect() callbacks with available variables (mut, effect, homozygous, individual), (2) Epistasis via countOfMutationsOfType() + convertToSubstitution=F, (3) Frequency-dependent selection via sim$mutationFrequencies(), (4) Gene-culture coevolution via tag properties, (5) Green-beard effect (self-recognition and cooperation), (6) setSelectionCoeff() alternative to mutationEffect(), (7) mutation() callbacks for per-mutation initialization (must return T), (8) Dominance variation via setValue/getValue or multiple mutation types, (9) Tag-based fitness tracking. **KEY INSIGHTS**: Balancing selection maintains variation; epistasis requires preventing conversion to substitutions; cultural traits can drive genetic evolution; green-beard alleles can maintain altruism without relatedness. All 12 tests passing!

**Session 2025-10-25 (11.x series - Mating systems)**: Completed ENTIRE Recipe 11.x series (4 recipes: 11.1, 11.2 I, 11.2 II, 11.3). **Mating systems**: Assortative mating, sequential mate search (basic and optimized), gametophytic self-incompatibility (plant reproduction). **CRITICAL NEW PATTERN**: ifelse() type consistency - use asFloat() on EACH value individually: ifelse(cond, asFloat(0.5), asFloat(1)). Slimr drops decimal points from integer-valued floats (2.0 -> 2), causing type errors when mixed with true floats. **NEW CALLBACKS**: (1) mateChoice() - returns modified weights OR selected mate OR float(0) for mating failure, (2) modifyChild() - returns T (accept) or F (reject), accesses child/parent haploid genomes. **PATTERNS**: (1) Assortative mating via tags and precalculated weights, (2) Sequential mate search with for loops and probability-based acceptance, (3) GSI via modifyChild checking pollen-style S-allele matches, (4) Tag caching (tagF) for efficiency - calculate once per generation, use many times. **SLiM 5.x**: haploidGenome1/haploidGenome2 (not genome1/genome2). **KEY INSIGHTS**: Fixed mutations counted separately (multiply by 2 for diploid contribution); identical() compares mutation sets; float(0) indicates mating failure. All 4 tests passing!

**Session 2025-10-25 (12.x series - Advanced gene interactions)**: Completed 4 recipes (12.1, 12.2 I, 12.2 II, 12.3) out of 6 in Recipe 12.x series. **Topics**: Gene-culture coevolution, lethal epistasis (any-any and dosage-dependent), CRISPR gene drive. **CRITICAL DISCOVERY**: Method chaining requires $ not . in R context - `sample(p1$haplosomes, 20)$addNewDrawnMutation()` NOT `sample(p1.haplosomes, 20).addNewDrawnMutation()`. R parser error with dot chaining after R functions. **NEW PATTERNS**: (1) Social learning via modifyChild() with probabilistic cultural transmission, (2) Epistasis with any() for presence vs sum() for dosage counting, (3) Gene drive homing mechanism with containsMutations() and addMutations(), (4) Spatially varying fitness with subpop.id, (5) Asymmetric migration for source-sink dynamics, (6) Reading cat() output from result$output_file. **KEY INSIGHTS**: Culture can drive genetic evolution; epistasis types vary by dosage requirements; gene drive spreads via super-Mendelian inheritance + migration. All 4 tests passing! Remaining in series: 12.4 (selfing suppression), 12.5 (sex tracking).

**Session 2025-10-25 (12.x series COMPLETION)**: Completed ENTIRE Recipe 12.x series (6 recipes: 12.1, 12.2 I, 12.2 II, 12.3, 12.4, 12.5). **Topics**: Gene-culture coevolution, lethal epistasis (any-any and dosage-dependent), CRISPR gene drive, selfing suppression, manual sex tracking. **CRITICAL DISCOVERY**: Method chaining requires $ not . in R context - `sample(p1$haplosomes, 20)$addNewDrawnMutation()` NOT with dots. **NEW PATTERNS**: (1) Social learning via modifyChild() with probabilistic cultural transmission, (2) Epistasis with any() for presence vs sum() for dosage, (3) Gene drive homing with containsMutations() and addMutations(), (4) Spatially varying fitness with subpop.id, (5) parent1 == parent2 for selfing check, (6) repEach() for creating sex groups, (7) tagL0 for manual sex tracking (F=female, T=male), (8) initializeSLiMOptions(preventIncidentalSelfing=T) as modern alternative to callback. **KEY INSIGHTS**: Recipe 12.4 is obsolete (kept for education); modern selfing suppression uses config flag. Manual sex tracking offers flexibility for custom sex determination. All 6 tests passing! **MILESTONE**: Recipe 12.x series COMPLETE!

**Session 2025-10-25 (13.x series - Quantitative traits and QTL models)**: Completed ENTIRE Recipe 13.x series (10 recipes: 13.1, 13.2, 13.3, 13.4, 13.5, 13.6 I-IV, 13.7). **Topics**: Polygenic selection, quantitative trait loci (QTLs), variable effect sizes, discrete effects across chromosomes, heritability models with environmental variance, pleiotropy (two-trait covariance), fitness functions (stabilizing, directional, disruptive, truncation), negative frequency-dependence with competition. **CRITICAL DISCOVERIES**: (1) asFloat() REQUIRED for ALL dnorm() arguments (not just returns) - prevents integer coercion errors, (2) Ternary operator supported via `%?%` and `%else%`: `(cond) %?% val1 %else% val2`, (3) Matrix type consistency for rbind() - both matrices must use asFloat() for all values, (4) Script DFE format: `"if (cond) val1 else val2;"` (single semicolon at end, NOT double), (5) Vector generation times `c(2, 2001)` NOT supported - use separate blocks. **BUG REPORTS FILED**: (1) return() for early returns in late() blocks should work but doesn't, (2) Vector generation times need support. **NEW PATTERNS**: (1) QTLs via sumOfMutationsOfType() for additive effects, (2) Pleiotropy with dmvnorm/rmvnorm for correlated traits, (3) Heritability calculation with environmental noise, (4) Fitness functions: stabilizing (Gaussian), directional (linear), disruptive (inverted Gaussian), truncation (threshold), (5) Frequency-dependent competition via sapply() with Gaussian kernel, (6) Script DFE for discrete effect distributions. **KEY INSIGHTS**: Stabilizing selection maintains variation around optimum; directional selection drives trait mean; disruptive selection favors extremes; truncation selection has sharp threshold; frequency-dependence creates "squashed" stabilizing selection; pleiotropy constrains trait evolution via genetic covariance. All 10 tests passing! **MILESTONE**: Recipe 13.x series COMPLETE!

**Session 2025-10-25 (14.x series - Advanced modeling)**: Converted 7 recipes (14.1, 14.2 I-III, 14.3 I-II, 14.4). **Topics**: Pedigree tracking and relatedness, mortality-based fitness (three approaches), MS format I/O, chromosomal inversions with recombination suppression. **CRITICAL DISCOVERIES**: (1) **return() MUST use R syntax with parentheses**: `return(value)` NOT `return value` - ADDED TO CONVERSION GUIDE, (2) fitnessScaling property requires float type - use `asFloat(0.0)` not `0.0` - ADDED TO CONVERSION GUIDE, (3) mateChoice() callback uses individual.relatedness() for assortative mating. **NEW PATTERNS**: (1) initializeSLiMOptions(keepPedigrees=T) enables pedigree tracking, (2) Three mortality approaches: mutationEffect() (genotype-dependent), fitnessEffect()+tagL0 (environmental), fitnessScaling (fastest), (3) MS format I/O: outputMSSample() writes, readFile()+parsing reads, dummy subpopulation technique for mutation creation, (4) recombination() callback: haplosome1/haplosome2 available, breakpoints is mutable vector, return(T) uses modified breakpoints, recursive callback via sim$chromosomes$drawBreakpoints(), (5) Chromosomal inversions: marker mutations denote boundaries, containsMarkerMutation() checks presence, heterozygotes require even crossover count. **KEY INSIGHTS**: Mortality selection has three methods for different use cases; MS format enables neutral burn-in separation; inversions suppress recombination in heterozygotes via recursive resampling; frequency-dependent fitness maintains inversion polymorphism. All 7 tests passing!

**Session 2025-10-26 (14-16 COMPLETE, 17.x started)**: **MAJOR MILESTONE**: Discovered that Recipe 14.x (21 recipes), 15.x (16 recipes), and 16.x (11 recipes) were ALREADY COMPLETE from previous sessions! Total: 48 additional recipes done. Started Recipe 17.x series (continuous-space/spatial models). **Completed**: 17.1 (simple 2D model), 17.2 (spatial competition), 17.3 I-V (boundary conditions: stopping, reflecting, absorbing, reprising, dispersal kernels), 17.4 (spatial mate choice with kernel), 17.5 (nearest-neighbor mate choice). Total: 9 recipes from 17.x. **SPATIAL PATTERNS**: (1) `initializeSLiMOptions(dimensionality="xy")` enables 2D space, (2) Spatial positioning methods: setSpatialPosition(), pointUniform(), pointStopped(), pointReflected(), pointInBounds(), spatialPosition property, (3) Boundary condition types: stopping (clamp to edge), reflecting (bounce back), absorbing (death if out of bounds), reprising (redraw until valid), periodic (wrap around), (4) deviatePositions() for population-level dispersal (alternative to modifyChild()), (5) InteractionType for spatial competition and mate choice, (6) Multiple interactions with different spatial scales (i1 for competition, i2 for mating), (7) mateChoice() returns interaction strengths OR selected mate OR float(0) for failure, (8) nearestNeighbors() for k-nearest neighbor searches, (9) fitnessScaling for efficient competition fitness (alternative to callback). **KEY INSIGHTS**: Spatial structure creates genetic clustering; boundary conditions affect edge dynamics and genetic structure; spatial mate choice restricts gene flow; multiple spatial processes (competition, mating) operate at different scales; nearest-neighbor mate choice creates tighter clustering than distance-weighted. All 9 tests passing! **NEXT**: Continue with Recipe 17.6-17.19 (15 more spatial recipes).

**Session 2025-10-26 (17.x COMPLETE!)**: **MILESTONE ACHIEVED**: Completed ENTIRE Recipe 17.x series (24 recipes total: 17.1-17.19). **Completed this session**: 17.11 (local adaptation on heterogeneous landscape), 17.12 (periodic boundaries/toroidal space), 17.13 (density-dependent fecundity with summarizeIndividuals), 17.14 (directed dispersal with SpatialMap), 17.15 (spatial competition + mate choice in nonWF), 17.16 (carrying-capacity density), 17.17 (spatial SIR epidemiology model), 17.18 (sexual age-structured spatial model), 17.19 (multispecies indirect competition). Total: 9 new recipes. **CRITICAL DISCOVERIES**: (1) z property requires asFloat(0.0), (2) Capital letter + $ bug affects OPTIMUM.mapValue() - use dot notation, (3) setSpatialPosition vectors need asFloat() wrapper, (4) **Multispecies syntax**: use named parameters (all = ..., species_name = ...) NOT species = "name", (5) **reproduction() callbacks must NOT return any value** - restructure with if-else instead of early returns, (6) tagF property requires asFloat(). **NEW PATTERNS ADDED TO GUIDE**: (1) Multispecies model syntax, (2) reproduction() callback return policy (void/no return), (3) Tag property type requirements. **ADVANCED SPATIAL**: (1) defineSpatialMap() + mapValue() + mapColor() for heterogeneous landscapes, (2) summarizeIndividuals() for grid-based spatial summaries, (3) localPopulationDensity() for carrying capacity, (4) sampleNearbyPoint() for directed dispersal, (5) SpatialMap manipulation (interpolate, rescale, smooth), (6) pointPeriodic() for toroidal space, (7) setConstraints() + nearestInteractingNeighbors() for age/sex-limited interactions, (8) killIndividuals() for explicit mortality, (9) deviatePositions() for population dispersal, (10) drawByStrength() for contact-based disease transmission, (11) sexSegregation="FM" for reproduction interactions. **EPIDEMIOLOGY**: S-I-R model with spatial transmission, tag-based health states, strength-weighted contacts. **MULTISPECIES**: resourceNode + forager model with indirect competition via resource sharing. All 9 tests passing! **TOTAL PROGRESS**: Recipe 4-17 series COMPLETE (146 recipes)!

**Session 2025-10-26 (18.x series - Tree-sequence recording)**: Started Recipe 18.x series (tree-sequence recording). **Completed**: 18.1 (minimal tree-seq model), 18.3 I (conditional sweep with save/restore), 18.3 II (conditional sweep with tree-seq and metadata), 18.6 I (coalescence detection), 18.6 II (coalescence with deferred scheduling). Total: 5 recipes from 18.x (5/12 done). **TREE-SEQUENCE PATTERNS**: (1) initializeTreeSeq() enables genealogical tracking, (2) initializeTreeSeq(checkCoalescence=T) for coalescence detection, (3) treeSeqOutput() saves tree sequence with optional metadata Dictionary, (4) treeSeqMetadata() retrieves metadata from files, (5) treeSeqCoalesced() checks if all genealogies coalesced, (6) readFromPopulationFile() for save/restore on mutation loss, (7) Metadata preservation via Dictionary for tags and pedigree IDs, (8) Tree-seq more memory-efficient than outputFull() for large simulations. **CRITICAL LIMITATION DISCOVERED**: Deferred scheduling with expression-based generations (e.g., `COALESCE+100 late()`) NOT supported in slimr. Workaround: use conditional logic with exists() and tick comparison. Added to slimr_development_notes.md. **WORKAROUND**: Recipe 18.6 II uses `if (exists("COALESCE")) { if (community$tick >= COALESCE + 100) {...} }` instead of `COALESCE+100 late()`. **KEY INSIGHTS**: Tree-sequence recording separates coalescent history (expensive) from neutral mutations (cheap overlay with Python/tskit); conditional sweeps useful for studying successful sweeps only; coalescence detection measures genealogical depth (~4N for neutral WF). All 5 tests passing!

**Session 2025-10-27 (18.x series COMPLETE!)**: **MILESTONE ACHIEVED**: Completed ENTIRE Recipe 18.x series (12 recipes total: 18.1, 18.3 I-II, 18.4-5, 18.6 I-II, 18.7-11). **Completed this session**: 18.4 (detecting diversity dip with linked selection), 18.5 (mapping admixture ancestry), 18.7 (analyzing selection coefficients), 18.8 (WF model with coalescent initialization), 18.9 (sexual nonWF with coalescent), 18.10 (recapitation workflow), 18.11 (optimizing tree-sequence simplification). Total: 7 new recipes. **NEW TREE-SEQUENCE PATTERNS ADDED TO GUIDE**: (1) Tree-sequence initialization and configuration (simplificationRatio, simplificationInterval, timeUnit, checkCoalescence), (2) readFromPopulationFile() for coalescent initialization, (3) treeSeqRememberIndividuals() for ancestry tracking, (4) Testing long-running recipes with shortened versions, (5) Generating prerequisite tree-sequence files programmatically in tests. **KEY TECHNIQUES**: (1) simplificationRatio=INF prevents automatic simplification (preserves full history for recapitation), (2) timeUnit="generations" records absolute times (needed for Python/msprime recapitation), (3) simplificationInterval=N controls simplification frequency (trade memory for speed), (4) readFromPopulationFile() loads both population state AND genealogical history from tree sequences, (5) treeSeqRememberIndividuals() preserves ancestry info for admixture analysis. **TESTING PATTERNS**: For recipes with long runtimes (50,000+ generations), create shortened test versions with reduced N (10-100x), L (10-100x), and runtime (10-100x) - test code correctness, not full scientific results. For recipes requiring tree-sequence input files, generate minimal prerequisite files programmatically in test setup (self-contained, reproducible tests). **KEY INSIGHTS**: Tree-sequence recording enables efficient tracking of genealogical history; recapitation workflow combines coalescent (msprime) + forward (SLiM) simulations; simplification parameters control memory vs speed tradeoff; coalescent initialization enables studying selection on realistic neutral backgrounds. All 7 tests passing! **TOTAL PROGRESS**: Recipe 4-18 series COMPLETE (158 recipes)! 🎉

**Session 2025-10-27 (19.x series COMPLETE!)**: **MILESTONE ACHIEVED**: Completed ENTIRE Recipe 19.x series (15 recipes total: 19.1-19.15). **Completed this session**: 19.10 (variable mutation rate with hotspot maps), 19.11 (GC-biased gene conversion), 19.12 (reading VCF files), 19.13 (tree-seq + nucleotide models), 19.14 (IBS with mutation callback), 19.15 (IBS with back-mutation removal). Total: 6 new recipes. **NUCLEOTIDE-BASED PATTERNS**: (1) initializeHotspotMap() creates variable mutation rates along chromosome with log-normally distributed multipliers, (2) initializeGeneConversion() models gBGC with parameters (nonCrossoverFraction, meanLength, bias, simpleConversionFraction), (3) readHaplosomesFromVCF() loads empirical SNP data from VCF files, (4) initializeAncestralNucleotides() can read FASTA files and returns sequence length, (5) Tree-sequence recording compatible with nucleotide-based models. **IBS MODELING**: (1) mutation() callback can return existing mutation for "uniquing" (identity by state without identity by descent), (2) subsetMutations(position=, nucleotide=) finds mutations at specific locations, (3) late() callback can remove back-mutations to ancestral state, (4) community$tick gets current generation (alternative to sim$cycle for multispecies), (5) removeMutations() removes mutations from all genomes. **CRITICAL FIXES**: (1) asFloat() required for mmJukesCantor(0.0) - bare 0.0 gets converted to integer 0, causing type errors, (2) slim_block() generation ranges use separate start/end parameters, NOT vectors: `slim_block(1, 5000, early(), {...})` NOT `slim_block(c(1, 5000), early(), {...})`. **TESTING PATTERNS**: For VCF/FASTA recipes, generate minimal mock files programmatically in test setup. For long-running simulations (500,001 generations!), create shortened test versions (5000-10000 generations). **KEY INSIGHTS**: GC-biased gene conversion can systematically shift nucleotide composition over evolutionary time; VCF files enable initialization with realistic empirical variation; IBS uniquing reduces memory for high mutation rates; back-mutation removal makes ancestral state implicit (no mutation object needed). All 6 tests passing! **TOTAL PROGRESS**: Recipe 4-19 series COMPLETE (173 recipes)! 🎉 Recipe 20.x (multispecies models) is next!

**Session 2025-10-27 (20.x series COMPLETE!)**: **MILESTONE ACHIEVED**: Completed ENTIRE Recipe 20.x series (9 recipes total: 20.1-20.8). **Multispecies models**: Simple/two-species foundation, deterministic host-parasitoid (Nicholson-Bailey), individual-based host-parasitoid (two approaches), continuous-space host-parasitoid, coevolutionary trait-matching (Red Queen), matching-allele gene-for-gene, within-host pathogen dynamics. **CRITICAL DISCOVERIES ADDED TO GUIDE**: (1) **Multispecies syntax uses named parameters** - `slim_block(all = initialize(), {...})` NOT `species = "all"`, (2) **Unicode characters don't parse in R** - use ASCII names (`x1_next` not `x1′`), (3) **Parallel iteration doesn't exist in R** - convert `for (p in X, h in Y)` to indexed loop with 0-based indices, (4) **Multiple blocks with same signature** - create separate slim_block() calls for each, (5) **Species-specific tick schedules** - tickModulo/tickPhase for different generation times, (6) **Pedigree-based host tracking** - keepPedigrees=T + tag properties. **NEW PATTERNS**: (1) `all = callback()` for blocks running across all species, (2) Species-specific: `host = initialize()`, `pathogen = reproduction()`, (3) No generation number → `1, .., callback()`, (4) initializeSpecies(tickModulo, tickPhase, avatar), (5) individualsWithPedigreeIDs() for linking pathogens to hosts, (6) takeMigrants() for horizontal transmission, (7) removeSubpopulation() for pathogen/host death, (8) Multiple `ticks all early()` blocks become multiple slim_block() calls. **KEY INSIGHTS**: Multispecies models enable host-pathogen, predator-prey, and symbiont dynamics; tick schedules model generation time differences (fast pathogens, slow hosts); pedigree tracking enables within-host modeling; coevolution drives Red Queen dynamics. All 9 tests passing! **TOTAL PROGRESS**: Recipe 4-20 series COMPLETE (182 recipes)! 🎉 **MAJOR MILESTONE**: 97% of all recipes converted!
