# Phase 4 Implementation Plan: SLiM 5.x Code Updates

**Created:** 2025-10-21
**Updated:** 2025-10-21 (Clean break approach)
**Status:** In Progress

---

## Overview

This document outlines the comprehensive plan for Phase 4 of the SLiM 5.x upgrade: updating the slimr codebase to support the new API using a **clean break** approach.

**CRITICAL DECISION:** slimr v0.5.0 will support **ONLY** SLiM 5.x. Users needing SLiM 4.x should use slimr v0.4.x releases. No backward compatibility layers.

**Approach:** Test-Driven Development (TDD)
- Write tests FIRST for each breaking change
- Implement fixes to make tests pass
- Verify with integration tests
- Document changes

---

## Breaking Changes Summary

From Phase 3 analysis:

### Critical Changes
1. **Genome → Haplosome** class rename
2. **Properties renamed:**
   - `genome1` → `haploidGenome1`
   - `genome2` → `haploidGenome2`
   - `genomes` → `haplosomes`
   - `genomesNonNull` → `haplosomesNonNull`
3. **SLiMSim removed** (functionality in Community/Species)
4. **57 method signature changes** (mostly generation→tick)
5. **New classes:** Haplosome, Plot (Chromosome existed but enhanced)

### Files Affected (from grep analysis)

**Genome references (9 files):**
- R/slim_lang.R (REPLACE ENTIRE FILE with slim_lang_v5.R)
- R/slimr_blocks.R
- R/slimr-package.R
- R/slim_code.R
- R/slim_extract.R
- R/slim_input.R
- R/slim_classes.R
- R/slim_callbacks.R

**genome*/genomes property references (6 files):**
- R/slimr_output.R
- R/slimr-package.R
- R/slim_code.R
- R/slim_extract.R
- R/slim_callbacks.R

**SLiMSim references (2 files):**
- R/slimr-package.R
- R/slim_classes.R

---

## Implementation Strategy

**Clean Break Approach:**

1. **Replace API documentation** - R/slim_lang.R → R/slim_lang_v5.R
2. **Update sysdata.rda** - Replace v4 class objects with v5
3. **Update all references** - Genome → Haplosome, properties, etc.
4. **No compatibility layers** - Direct updates only
5. **Require SLiM >= 5.0** - Add version check

**Benefits:**
- Simple, straightforward code
- No complex version detection
- Clean, maintainable codebase
- Clear migration path for users

**Drawbacks:**
- Breaking change for existing users
- Must coordinate with SLiM 5.x installation

**Mitigation:**
- Clear documentation in NEWS.md
- Migration guide for users
- Keep v0.4.x available for SLiM 4.x users

---

## Implementation Plan

### Phase 4A: API Replacement (Day 1)

#### 4A.1: Replace API Documentation

**Goal:** Replace old API with new API

**Actions:**
```bash
# Backup old API
mv R/slim_lang.R R/slim_lang_v4_BACKUP.R

# Install new API
mv R/slim_lang_v5.R R/slim_lang.R

# Update sysdata.rda (already done in Phase 3)
# Update data/slim_classes.rda (already done in Phase 3)
```

**Tests to create:**
- `tests/testthat/test-api_v5.R`

**Test scenarios:**
- [x] New classes load correctly (.Ha, .Pl)
- [x] Old classes removed (.G for Genome)
- [x] slim_load_globals() works with v5
- [x] All expected classes present

#### 4A.2: Add Version Requirement Check

**Goal:** Ensure SLiM >= 5.0 is installed

**File to update:**
- `R/slim_run.R` - Add version check before running

**Implementation:**
```r
check_slim_version_v5 <- function() {
  if (!slim_is_avail()) {
    return(FALSE)
  }

  version <- slim_version()
  major_version <- as.numeric(stringr::str_extract(version, "^[0-9]+"))

  if (major_version < 5) {
    stop(
      "slimr v0.5.0+ requires SLiM >= 5.0. You have SLiM ", version, ".\n",
      "Please upgrade SLiM, or use slimr v0.4.x for SLiM 4.x support."
    )
  }

  TRUE
}
```

**Tests:**
- `tests/testthat/test-version_check.R`

**Test scenarios:**
- [x] Accepts SLiM 5.0+
- [x] Rejects SLiM 4.x with helpful message
- [x] Handles missing SLiM gracefully

---

### Phase 4B: Class Name Updates (Day 1-2)

#### 4B.1: Update Genome → Haplosome References

**Files to update:**
- R/slimr_blocks.R
- R/slimr-package.R
- R/slim_code.R
- R/slim_extract.R
- R/slim_input.R
- R/slim_classes.R
- R/slim_callbacks.R

**Search and replace:**
```bash
# Find all Genome references
grep -n "Genome" R/*.R

# Replace with Haplosome where appropriate
# Manual review each occurrence
```

**Tests to create:**
- `tests/testthat/test-haplosome.R`

**Test scenarios:**
- [x] Haplosome class accessible
- [x] Haplosome methods work
- [x] Haplosome properties accessible
- [x] No Genome class references remain

#### 4B.2: Remove SLiMSim References

**Files to update:**
- R/slimr-package.R
- R/slim_classes.R

**Actions:**
- Remove SLiMSim from class lists
- Update documentation referencing SLiMSim
- Redirect to Community/Species where applicable

**Tests:**
- Add to `tests/testthat/test-api_v5.R`

**Test scenarios:**
- [x] SLiMSim not in class list
- [x] Community class accessible
- [x] Species class accessible

---

### Phase 4C: Property Name Updates (Day 2-3)

#### 4C.1: Update Individual Properties

**Files to update:**
- R/slimr_output.R
- R/slim_code.R
- R/slim_extract.R
- R/slim_callbacks.R

**Find and replace:**
- `genome1` → `haploidGenome1`
- `genome2` → `haploidGenome2`
- `genomes` → `haplosomes`
- `genomesNonNull` → `haplosomesNonNull`

**Tests to create:**
- `tests/testthat/test-individual_properties.R`

**Test scenarios:**
- [x] `haploidGenome1` accessible
- [x] `haploidGenome2` accessible
- [x] `haplosomes` accessible
- [x] Old property names don't exist
- [x] Property access in scripts works

#### 4C.2: Update Subpopulation Properties

**Files to update:**
- Same as above

**Find and replace:**
- `genomes` → `haplosomes`
- `genomesNonNull` → `haplosomesNonNull`

**Tests:**
- `tests/testthat/test-subpopulation_properties.R`

**Test scenarios:**
- [x] Subpopulation.haplosomes accessible
- [x] Property access works in real scripts

---

### Phase 4D: Output Parsing Updates (Day 3)

#### 4D.1: Update Output Type Detection

**Goal:** Recognize Haplosome in output

**Files to update:**
- R/slim_extract.R
- R/slimr_output.R

**Implementation:**
- Find all "Genome" type detections
- Replace with "Haplosome"
- Update parsing logic for new property names

**Tests to create:**
- `tests/testthat/test-output_haplosome.R`

**Test scenarios:**
- [x] Detect Haplosome in output
- [x] Parse Haplosome data correctly
- [x] Extract properties with new names
- [x] Convert to R data structures properly

#### 4D.2: Update Extract Functions

**Files to update:**
- R/slim_extract.R - All `slim_extract_*` functions

**Actions:**
- Update type checking for Haplosome
- Update property extraction for new names
- Update data frame column names

**Tests:**
- Add to existing `tests/testthat/test-slim_extract.R`

**Test scenarios:**
- [x] Extract Haplosome data
- [x] Extract Individual with new properties
- [x] Convert to genlight works
- [x] All extraction functions work with v5

---

### Phase 4E: Helper Function Updates (Day 3-4)

#### 4E.1: Update Input Functions

**File to update:**
- R/slim_input.R

**Actions:**
- Update functions creating SLiM input
- Use Haplosome instead of Genome
- Use new property names

**Tests to create:**
- `tests/testthat/test-input_v5.R`

**Test scenarios:**
- [x] Input generation uses v5 API
- [x] Property names correct
- [x] Class names correct

#### 4E.2: Update Callback Functions

**File to update:**
- R/slim_callbacks.R

**Actions:**
- Update callback examples
- Update property references
- Update class references

**Tests to create:**
- `tests/testthat/test-callbacks_v5.R`

**Test scenarios:**
- [x] Callbacks work with v5 API
- [x] Parameter names correct
- [x] Examples run correctly

#### 4E.3: Update Class Management

**File to update:**
- R/slim_classes.R

**Actions:**
- Remove .G (Genome)
- Ensure .Ha (Haplosome) present
- Ensure .Pl (Plot) present
- Remove .SS (SLiMSim)
- Update documentation

**Tests:**
- `tests/testthat/test-class_management.R`

**Test scenarios:**
- [x] All v5 classes present
- [x] v4-only classes absent
- [x] Class abbreviations correct

---

### Phase 4F: Integration Testing (Day 4)

#### 4F.1: Create Full Workflow Tests

**File to create:**
- `tests/testthat/test-integration_v5.R`

**Test scenarios:**
- [x] Create script with v5 API
- [x] Use Haplosome class
- [x] Use new properties
- [x] Run simulation (if SLiM available)
- [x] Parse output successfully
- [x] Extract data correctly
- [x] Template system works
- [x] Inline system works
- [x] Output capture works

#### 4F.2: Run Full Test Suite

**Action:**
```r
devtools::test()
```

**Fix all failures:**
- Update tests using old API
- Update examples using old API
- Fix any regressions

---

### Phase 4G: Documentation Updates (Day 5)

#### 4G.1: Update Package Documentation

**File to update:**
- R/slimr-package.R

**Actions:**
- Update version requirement (SLiM >= 5.0)
- Update class list in documentation
- Update property examples
- Add migration notes

#### 4G.2: Update Function Examples

**Files to check:**
- All R files with `@examples` tags

**Actions:**
- Find examples using old API
- Update to v5 API
- Test that examples run
- Add version notes where helpful

#### 4G.3: Update NEWS.md

**File:** NEWS.md

**Content to add:**
```markdown
# slimr 0.5.0

## Breaking Changes

**IMPORTANT:** slimr 0.5.0 supports ONLY SLiM 5.x. For SLiM 4.x, use slimr 0.4.x.

### API Changes for SLiM 5.x

* **Genome class renamed to Haplosome**
  - All references to `Genome` updated to `Haplosome`
  - Class abbreviation changed from `.G` to `.Ha`

* **Individual properties renamed:**
  - `genome1` → `haploidGenome1`
  - `genome2` → `haploidGenome2`
  - `genomes` → `haplosomes`
  - `genomesNonNull` → `haplosomesNonNull`

* **Subpopulation properties renamed:**
  - `genomes` → `haplosomes`
  - `genomesNonNull` → `haplosomesNonNull`

* **SLiMSim class removed**
  - Functionality moved to Community and Species classes

* **New classes added:**
  - `Plot` - for plotting in SLiMgui

### Migration Guide

See `claude_notes/BREAKING_CHANGES_v4_to_v5.md` for complete list of changes.

**Code migration examples:**

Before (slimr 0.4.x / SLiM 4.x):
```r
ind.genome1
pop.genomes
```

After (slimr 0.5.0 / SLiM 5.x):
```r
ind.haploidGenome1
pop.haplosomes
```
```

---

## Implementation Order

### Day 1: API Replacement
1. ✅ Document version policy in CLAUDE.md and guide
2. ✅ Update implementation plan for clean break
3. ⏳ Replace R/slim_lang.R with R/slim_lang_v5.R
4. ⏳ Add version requirement check
5. ⏳ Create API tests

### Day 2: Class Updates
1. ⏳ Update all Genome → Haplosome references
2. ⏳ Remove SLiMSim references
3. ⏳ Create Haplosome tests
4. ⏳ Start property name updates

### Day 3: Property & Output Updates
1. ⏳ Complete property name updates
2. ⏳ Update output parsing
3. ⏳ Update extract functions
4. ⏳ Create property and output tests

### Day 4: Helper Functions & Integration
1. ⏳ Update input functions
2. ⏳ Update callback functions
3. ⏳ Update class management
4. ⏳ Run full test suite
5. ⏳ Create integration tests

### Day 5: Documentation & Final Testing
1. ⏳ Update package documentation
2. ⏳ Update function examples
3. ⏳ Update NEWS.md
4. ⏳ Run final package check
5. ⏳ Document completion

---

## Test-Driven Development Workflow

For each component:

1. **Write failing test** - Test what SHOULD work in v5
2. **Run test** - Verify it fails (because v4 API still active)
3. **Implement fix** - Update to v5 API
4. **Run test again** - Verify it passes
5. **Run all tests** - Ensure nothing broke

---

## Acceptance Criteria

Phase 4 is complete when:

- [ ] R/slim_lang.R replaced with v5 API
- [ ] R/sysdata.rda contains v5 class objects
- [ ] Version check requires SLiM >= 5.0
- [ ] All Genome references → Haplosome
- [ ] All property names updated to v5
- [ ] SLiMSim references removed
- [ ] Output parsing works with v5
- [ ] All tests pass
- [ ] Examples run without errors
- [ ] Package check passes (`devtools::check()`)
- [ ] Documentation updated
- [ ] NEWS.md reflects breaking changes

---

## Rollback Plan

If Phase 4 encounters major issues:

1. **Restore backup:** `mv R/slim_lang_v4_BACKUP.R R/slim_lang.R`
2. **Keep working in branch:** Don't merge to main until complete
3. **Document issues:** Add to claude_notes for future reference

---

**Status:** Ready to begin implementation - Day 1, API Replacement
