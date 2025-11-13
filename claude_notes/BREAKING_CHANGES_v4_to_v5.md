# SLiM 4.x to 5.x: Breaking Changes Analysis

**Generated:** 2025-10-21 (Updated with corrected property extraction)
**Purpose:** Document API changes between SLiM 4.x and 5.x to guide slimr package upgrade

---

## Executive Summary

The upgrade from SLiM 4.x to 5.x introduces **significant breaking changes**:

- **4 new classes** (Eidos, Haplosome, Initialize, Plot)
- **2 removed classes** (Genome, SLiMSim)
- **35 new methods** across 13 classes
- **57 methods with signature changes** (primarily due to generation→tick terminology)
- **20 new properties**
- **9 removed properties**

### Major Breaking Changes

1. **Genome class removed** → Replaced by **Haplosome class**
2. **SLiMSim class removed** → Functionality moved to Community/Species
3. **Generation → Tick terminology** across entire API (explains most signature changes)
4. **Multi-chromosome support** - major new feature requiring structural changes
5. **Genome properties on Individual/Subpopulation** → Replaced by haplosome properties

---

## 1. New Classes in v5

### 1.1 Haplosome
**Purpose:** Replaces the Genome class from v4

**Impact:** HIGH - Major breaking change
- All references to `Genome` must be updated to `Haplosome`
- Individual properties `genome1`/`genome2` → `haploidGenome1`/`haploidGenome2`
- New property: `haplosomes` (returns vector of all haplosomes)

**slimr Action Required:**
- Update class definitions in R/slim_lang.R
- Update documentation references
- Update example code in vignettes

### 1.2 Plot
**Purpose:** New plotting functionality in SLiMgui

**Impact:** LOW - New feature, no breaking changes
- Adds graphical output capabilities
- Related methods: `SLiMgui$createPlot()`, `SLiMgui$plotWithTitle()`

**slimr Action Required:**
- Add Plot class definition
- Document new plotting capabilities

### 1.3 Initialize
**Purpose:** Dedicated class for initialization functions

**Impact:** MEDIUM - Reorganization of existing functions
- Initialization functions now under dedicated class
- Was previously under mixed namespace

**slimr Action Required:**
- Add Initialize class
- Verify all initialization functions are captured

### 1.4 Eidos
**Purpose:** Dedicated class for Eidos language functions

**Impact:** MEDIUM - Reorganization
- Eidos-specific functions now under dedicated class

**slimr Action Required:**
- Add Eidos class
- Document Eidos-specific functionality

---

## 2. Removed Classes from v4

### 2.1 Genome → Haplosome
**Impact:** HIGH - Complete replacement

**Removed:** `Genome` class
**Replaced by:** `Haplosome` class

**Property Changes:**
- Individual: `genome1`, `genome2` → `haploidGenome1`, `haploidGenome2`
- Individual: `genomes`, `genomesNonNull` → `haplosomes`, `haplosomesNonNull`
- Subpopulation: `genomes`, `genomesNonNull` → `haplosomes`, `haplosomesNonNull`

**slimr Action Required:**
- Replace all Genome references with Haplosome
- Update property accessors
- Update translation logic in slimr_code.R
- Update test cases

### 2.2 SLiMSim → Community/Species
**Impact:** MEDIUM - Functionality redistributed

**Removed:** `SLiMSim` class
**Replaced by:** Distributed to `Community` and `Species` classes

**Property Migration:**
- `SLiMSim` properties distributed to Community and Species
- Check method ownership changes

**slimr Action Required:**
- Remove SLiMSim class references
- Verify method routing to correct class
- Update documentation

---

## 3. Property Changes by Class

### 3.1 Major Property Changes

#### Genome → Haplosome Properties (CRITICAL)
**Individual class changes:**
- REMOVED: `genome1`, `genome2`, `genomes`, `genomesNonNull`
- ADDED: `haploidGenome1`, `haploidGenome1NonNull`, `haploidGenome2`, `haploidGenome2NonNull`, `haplosomes`, `haplosomesNonNull`

**Subpopulation class changes:**
- REMOVED: `genomes`, `genomesNonNull`
- ADDED: `haplosomes`, `haplosomesNonNull`

**Impact:** CRITICAL - Core property replacement

**slimr Action Required:**
- Update all genome property accessors to haplosome equivalents
- Update R→SLiM translation for these properties
- Update test cases and examples

#### Multi-Chromosome Properties (NEW)
**Chromosome class gained 7 new properties:**
- `id` - Unique identifier
- `intrinsicPloidy` - Ploidy level
- `isSexChromosome` - Boolean flag
- `length` - Chromosome length
- `name` - Chromosome name
- `symbol` - Symbol representation
- `type` - Chromosome type

**Species class gained:**
- `chromosomes` - Access to chromosome objects
- `sexChromosomes` - Sex chromosome subset

**Species class removed:**
- `chromosomeType` - Replaced by Chromosome objects with `type` property

**Impact:** MEDIUM - Enhanced multi-chromosome metadata

#### Haploid/Hemizygous Dominance (TERMINOLOGY)
**MutationType class:**
- REMOVED: `haploidDominanceCoeff`
- ADDED: `hemizygousDominanceCoeff`

**Impact:** LOW - Terminology update for multi-chromosome context

#### Chromosome References (NEW)
**Mutation and Substitution classes:**
- ADDED: `chromosome` property to track which chromosome

**Impact:** LOW - New metadata for multi-chromosome models

#### LogFile Properties
**LogFile class:**
- REMOVED: `allKeys` property

**Impact:** LOW - Internal property removal

### 3.2 Major Property Additions

#### Chromosome (6 new properties)
- `id` - Unique identifier
- `intrinsicPloidy` - Ploidy level
- `isSexChromosome` - Boolean flag
- `length` - Chromosome length
- `symbol` - Symbol representation
- `type` - Chromosome type

**Impact:** MEDIUM - Enhanced chromosome metadata

#### Individual (6 new properties)
- `haploidGenome1`, `haploidGenome1NonNull` - Replaces genome1
- `haploidGenome2`, `haploidGenome2NonNull` - Replaces genome2
- `haplosomes`, `haplosomesNonNull` - Replaces genomes

**Impact:** HIGH - Core property replacement

#### Species (2 new properties)
- `chromosomes` - Access to chromosome objects
- `sexChromosomes` - Sex chromosome subset

**Impact:** MEDIUM - Enhanced chromosome access

---

## 4. Method Changes by Class

### 4.1 Chromosome

**New Methods (3):**
- `ancestralNucleotides()` - Get ancestral sequence
- `genomicElementForPosition()` - Find element at position
- `hasGenomicElementForPosition()` - Check element existence

**Signature Changes (6):**
- `drawBreakpoints()`
- `setAncestralNucleotides()`
- `setGeneConversion()`
- `setHotspotMap()`
- `setMutationRate()`
- `setRecombinationRate()`

**Impact:** MEDIUM - Parameter changes likely

### 4.2 Community

**New Methods (3):**
- `createLogFile()` - Create logging file
- `estimatedLastTick()` - Estimate completion
- `subpopulationsWithNames()` - Name-based lookup

**Signature Changes (15):**
Multiple core functions changed - see full list in comparison output

**Impact:** HIGH - Many fundamental operations affected

### 4.3 Individual

**New Methods (3):**
- `containsMutations()` - Check mutation presence
- `haplosomesForChromosomes()` - Get haplosomes by chromosome
- `mutationsFromHaplosomes()` - Extract mutations from haplosomes

**Signature Changes (5):**
- `countOfMutationsOfType()`
- `relatedness()`
- `sharedParentCount()`
- `sumOfMutationsOfType()`
- `uniqueMutationsOfType()`

**Impact:** HIGH - Core individual operations

### 4.4 Species

**New Methods (9):**
- `addPatternForClone()` - Clone pattern
- `addPatternForCross()` - Cross pattern
- `addPatternForNull()` - Null pattern
- `addPatternForRecombinant()` - Recombinant pattern
- `addSubpop()` - Add subpopulation
- `chromosomesOfType()` - Get chromosomes by type
- `chromosomesWithIDs()` - Get chromosomes by ID
- `chromosomesWithSymbols()` - Get chromosomes by symbol
- `substitutionsOfType()` - Get substitutions

**Signature Changes (27):**
Nearly all major Species methods changed - extensive updates needed

**Impact:** CRITICAL - Species is central to SLiM simulations

### 4.5 Subpopulation

**New Methods (6):**
- `addCloned()` - Add cloned individuals
- `addMultiRecombinant()` - Multiple recombination
- `deviatePositions()` - Position deviation
- `deviatePositionsWithMap()` - Map-based deviation
- `haplosomesForChromosomes()` - Get haplosomes
- `pointUniformWithMap()` - Map-based uniform point

**Signature Changes (31):**
Most extensive changes - nearly all methods affected

**Impact:** CRITICAL - Subpopulation methods heavily used

---

## 5. Impact Assessment

### Critical Changes (Require Immediate Action)

1. **Genome → Haplosome class replacement**
   - Update: R/slim_lang.R class definitions
   - Update: Translation in slimr_code.R
   - Update: All vignettes and examples
   - Update: Test cases

2. **Individual/Subpopulation property changes**
   - `genome1/genome2` → `haploidGenome1/haploidGenome2`
   - `genomes` → `haplosomes`
   - Update all property accessors

3. **Species method signature changes (27 methods)**
   - Need detailed signature comparison
   - Update function stubs
   - Update documentation

4. **Subpopulation method signature changes (31 methods)**
   - Most extensive changes
   - Careful review needed

### High Priority Changes

1. **Community method changes (5 signature changes)**
2. **InteractionType changes (11 signature changes)**
3. **LogFile changes (3 signature changes)**
4. **SpatialMap changes (3 signature changes)**
5. **Generation → Tick terminology** (affects many method signatures)

### Medium Priority Changes

1. New class additions (Initialize, Eidos, Plot)
2. Chromosome enhancements
3. Method additions (35 new methods)

### Low Priority Changes

1. Display/color property removals (GUI-related)
2. Documentation updates

---

## 6. Recommended Upgrade Approach

### Phase A: Core Class Updates
1. Update slim_lang_v5.R (already generated)
2. Update class abbreviation mappings
3. Update Genome → Haplosome translation
4. Test basic script creation

### Phase B: Property Updates
1. Update all genome → haplosome property accessors
2. Add new multi-chromosome property support
3. Update haploidDominanceCoeff → hemizygousDominanceCoeff
4. Test property access

### Phase C: Method Signature Updates
1. Detailed analysis of 57 signature changes
2. Update function stubs where needed (focus on generation→tick renames)
3. Update argument parsing
4. Test method calls

### Phase D: Code Translation Updates
1. Update slimr_code.R for Genome/Haplosome
2. Update R→SLiM conversion rules
3. Update SLiM→R conversion rules
4. Test bidirectional translation

### Phase E: Testing & Validation
1. Update all test files
2. Update all vignettes
3. Run full test suite
4. Validate example scripts

### Phase F: Documentation
1. Update CHANGELOG
2. Update README
3. Update vignettes
4. Create migration guide

---

## 7. Detailed Signature Change Analysis Needed

The comparison identified 57 methods with signature changes. Many are due to generation→tick terminology updates. These need detailed analysis to determine:

1. **Parameter name changes** (e.g., generation → tick) - Medium impact, mostly rename
2. **Parameter order changes** (low impact)
3. **Parameter type changes** (high impact if any)
4. **New required parameters** (high impact)
5. **Removed parameters** (high impact)

**Primary Focus:** The generation→tick terminology change likely explains most signature changes and should be straightforward to update.

**Action:** Create detailed signature comparison for the 57 changed methods.

---

## 8. Testing Strategy

### Unit Tests to Update
- [ ] Test Genome → Haplosome
- [ ] Test Individual properties (genome* → haploidGenome*/haplosomes)
- [ ] Test Subpopulation properties (genomes → haplosomes)
- [ ] Test Species methods (19 signature changes)
- [ ] Test Subpopulation methods (13 signature changes)
- [ ] Test new Chromosome class and properties
- [ ] Test new classes (Initialize, Eidos, Plot, Haplosome)

### Integration Tests to Update
- [ ] Full simulation workflows
- [ ] Vignette examples
- [ ] Recipe scripts
- [ ] Template system
- [ ] Inline system
- [ ] Output system

### Validation Tests
- [ ] Compare v4 vs v5 simulation output
- [ ] Verify backward compatibility where possible
- [ ] Test error messages for deprecated features

---

## 9. Next Steps

1. **Review this document** with package maintainers
2. **Detailed signature analysis** for 142 changed methods
3. **Create detailed migration guide** for users
4. **Implement Phase A** (core class updates)
5. **Begin systematic testing**

---

## Appendix: Full Change Lists

### New Methods by Class
```
Chromosome (3): ancestralNucleotides, genomicElementForPosition, hasGenomicElementForPosition
Community (3): createLogFile, estimatedLastTick, subpopulationsWithNames
GenomicElement (1): setGenomicElementType
GenomicElementType (1): setMutationFractions
Individual (3): containsMutations, haplosomesForChromosomes, mutationsFromHaplosomes
InteractionType (1): clippedIntegral
LogFile (1): addCustomColumn
Mutation (1): setMutationType
MutationType (1): drawSelectionCoefficient
SLiMgui (4): createPlot, logFileData, openDocument, plotWithTitle
SpatialMap (1): add
Species (9): addPatternForClone, addPatternForCross, addPatternForNull, addPatternForRecombinant, addSubpop, chromosomesOfType, chromosomesWithIDs, chromosomesWithSymbols, substitutionsOfType
Subpopulation (6): addCloned, addMultiRecombinant, deviatePositions, deviatePositionsWithMap, haplosomesForChromosomes, pointUniformWithMap
```

### Property Changes Summary
```
NEW PROPERTIES (20):
- Chromosome (7): id, intrinsicPloidy, isSexChromosome, length, name, symbol, type
- Individual (6): haploidGenome1, haploidGenome1NonNull, haploidGenome2, haploidGenome2NonNull, haplosomes, haplosomesNonNull
- Mutation (1): chromosome
- MutationType (1): hemizygousDominanceCoeff
- Species (2): chromosomes, sexChromosomes
- Subpopulation (2): haplosomes, haplosomesNonNull
- Substitution (1): chromosome

REMOVED PROPERTIES (9):
- Individual (4): genome1, genome2, genomes, genomesNonNull
- LogFile (1): allKeys
- MutationType (1): haploidDominanceCoeff
- Species (1): chromosomeType
- Subpopulation (2): genomes, genomesNonNull

NOTE: Tag properties are PRESERVED in v5 (present in all 15 common classes)
```

---

**End of Breaking Changes Analysis**
