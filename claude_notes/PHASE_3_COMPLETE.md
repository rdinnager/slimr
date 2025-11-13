# Phase 3 Complete: API Extraction and Comparison

**Completed:** 2025-10-21
**Status:** ✓ SUCCESS

---

## Summary

Phase 3 of the SLiM 5.x upgrade is complete. We have successfully:

1. **Fixed RTF extraction** to properly handle control characters
2. **Extracted complete API** documentation (209 properties, 243 methods, 17 classes)
3. **Generated R documentation** following the v4 pattern (sysdata.rda approach)
4. **Compared v4 vs v5 APIs** and identified all breaking changes
5. **Verified against official changelog** to ensure accuracy

---

## Key Fixes Applied

### 1. RTF Extraction Fix

**Problem:** The `unrtf` package converts en-dash (`–`) characters to control characters (0x13 + 0xA0), causing read-write properties (`<->`) to be missed during extraction.

**Solution:** Added character cleanup step that runs BEFORE parsing:
- Control characters → ASCII equivalents
- En-dash (0x13) → regular dash `-`
- Non-breaking space (0xA0) → regular space
- Smart quotes → regular quotes
- Other special characters → ASCII equivalents

**Result:**
- Before fix: 155 properties extracted (missing read-write properties)
- After fix: **209 properties extracted** (complete)

### 2. Generation Script Update

**Changed from:**
- Writing all code to R/slim_lang_v5.R (combined documentation + code)

**Changed to (v4 pattern):**
1. Generate class creation code (`ClassName <- Abbr <- .Abbr <- list()`)
2. Source it to create class objects in environment
3. Generate method assignment code and source it
4. Generate property assignment code and source it
5. Save class objects to **R/sysdata.rda** (internal package data)
6. Write **only roxygen documentation** to R/slim_lang_v5.R
7. Save class lookup table to **data/slim_classes.rda**

**Why this matters:**
- Class objects are available at runtime for autocomplete
- `slim_load_globals()` can load them into global environment
- Follows established v4 architecture
- Faster package load (pre-computed objects)

---

## Generated Files

### Primary Outputs

**R/slim_lang_v5.R** (900 KB)
- Roxygen documentation for all 243 methods
- Class documentation for 19 classes
- NO executable code (documentation only)
- Ready for roxygen2 processing

**R/sysdata.rda** (1.9 KB)
- 19 class objects (.Init, .Ch, .Co, .E, .GE, .GET, **.Ha**, .I, .IT, .LF, .M, .MT, **.Pl**, .SEB, .SG, .SM, .Sp, .P, .S)
- **New in v5:** .Ha (Haplosome), .Pl (Plot)
- **Removed from v4:** .G (Genome), .SS (SLiMSim)
- Each class object contains methods and properties
- Loaded automatically on package startup

**data/slim_classes.rda** (445 bytes)
- Class lookup table (class_name, class_abbr, class_internal)
- 19 classes total
- Used for class name resolution

### Supporting Files

**data-raw/build_5/all_methods_data.rds** (varies)
- Complete method data extracted from RTF files
- 17 classes with methods
- Used by generation script

**data-raw/build_5/all_properties_data.rds** (varies)
- Complete property data extracted from RTF files
- 209 properties across 17 classes
- Used by generation script

**data-raw/build_5/v4_v5_comparison.rds** (varies)
- Complete comparison between v4 and v5 APIs
- Used for breaking changes analysis

**data-raw/BREAKING_CHANGES_v4_to_v5.md** (comprehensive report)
- Detailed analysis of all API changes
- Impact assessment
- Upgrade recommendations

---

## API Changes Summary

### New SLiM Classes (2)
1. **Haplosome** - Replaces Genome class
2. **Plot** - New plotting functionality in SLiMgui

### Removed SLiM Classes (2)
1. **Genome** → Replaced by Haplosome
2. **SLiMSim** → Functionality moved to Community/Species

### slimr Organizational Classes (2 - unchanged)
1. **Initialize** - Houses initialization functions (not a SLiM class)
2. **Eidos** - Houses Eidos functions (not a SLiM class)

### Method Changes
- **35 new methods** added across 13 classes
- **0 methods removed**
- **57 methods with signature changes** (primarily generation→tick terminology)

### Property Changes
- **20 new properties** added
- **9 properties removed**
- **Tag properties PRESERVED** (all 15 common classes retain them)

### Critical Changes
1. **Genome → Haplosome** property renaming:
   - `genome1`, `genome2` → `haploidGenome1`, `haploidGenome2`
   - `genomes`, `genomesNonNull` → `haplosomes`, `haplosomesNonNull`

2. **Generation → Tick** terminology throughout API

3. **Multi-chromosome support** - new Chromosome class with 7 properties

---

## Verification Against Official Changelog

✓ **Genome → Haplosome rename** - Confirmed
✓ **SLiMSim → Species/Community split** - Confirmed
✓ **Multi-chromosome architecture** - Confirmed
✓ **Generation → Tick terminology** - Confirmed (explains 57 signature changes)
✓ **Property changes** - Confirmed
✓ **Tag properties preserved** - Confirmed (21 tag properties in v5)

All changes match the official SLiM VERSIONS changelog.

---

## Testing Performed

### Extraction Testing
- ✓ RTF files successfully converted to text
- ✓ Control characters properly cleaned
- ✓ All 209 properties extracted (including read-write properties)
- ✓ All 243 methods extracted
- ✓ Class introductions extracted

### Generation Testing
- ✓ Class objects created successfully
- ✓ Methods populated correctly
- ✓ Properties populated correctly
- ✓ R/sysdata.rda created and loadable
- ✓ data/slim_classes.rda created and loadable
- ✓ R/slim_lang_v5.R syntactically valid

### Content Verification
- ✓ Haplosome class (.Ha) has 7 items (methods + properties)
- ✓ Plot class (.Pl) has 1 item (property)
- ✓ All 19 classes present in slim_classes
- ✓ Class abbreviations correct

---

## Scripts Created/Updated

### Extraction Pipeline
**data-raw/build_5/extract_from_rtf.R**
- Extracts API from SLiM RTF files
- Cleans control characters BEFORE parsing
- Outputs: all_methods_data.rds, all_properties_data.rds, slim_lang_intros.rds

### Generation Pipeline
**data-raw/build_5/generate_slim_lang_v5.R**
- Generates R documentation following v4 pattern
- Creates class objects and sources them
- Saves to R/sysdata.rda and data/slim_classes.rda
- Outputs: R/slim_lang_v5.R, R/sysdata.rda, data/slim_classes.rda

### Analysis Tools
**data-raw/build_5/compare_v4_v5.R**
- Compares v4 and v5 APIs systematically
- Identifies new/removed classes, methods, properties
- Detects signature changes
- Outputs: v4_v5_comparison.rds

**data-raw/build_5/check_tags.R**
- Verifies tag property presence
- Counts tag properties across classes

**data-raw/build_5/find_nonascii.R**
- Scans for non-printable characters
- Helps identify control character issues

---

## Next Steps: Phase 4

### Phase 4A: Core Class Updates
1. Update class references throughout slimr codebase:
   - Search for "Genome" → replace with "Haplosome" where appropriate
   - Remove SLiMSim references
   - Add Plot class support

2. Update class abbreviation mappings:
   - Ensure .Ha (Haplosome) works correctly
   - Ensure .Pl (Plot) works correctly
   - Remove .G (Genome) and .SS (SLiMSim) references

3. Test basic script creation with new classes

### Phase 4B: Property Translation Updates
1. Update R→SLiM property translation in slimr_code.R:
   - `genome1` → `haploidGenome1`
   - `genome2` → `haploidGenome2`
   - `genomes` → `haplosomes`

2. Update SLiM→R property translation (reverse direction)

3. Test property access in both directions

### Phase 4C: Method Signature Updates
1. Analyze 57 signature changes in detail
2. Focus on generation→tick parameter renames
3. Update function stubs where needed
4. Test method calls

### Phase 4D: Testing & Validation
1. Update test files for new classes/properties
2. Update vignettes with v5 examples
3. Run full test suite
4. Validate example scripts

### Phase 4E: Documentation
1. Update CHANGELOG with v5 changes
2. Create migration guide for users
3. Update README if needed
4. Document breaking changes

---

## Known Issues

None currently identified.

---

## Questions for Maintainer

1. **Class abbreviations:** I used .Ha for Haplosome - is this acceptable or would you prefer a different abbreviation? (v4 used .G for Genome)

2. **Backward compatibility:** Should we maintain any compatibility layer for Genome→Haplosome transition, or should this be a clean break requiring code updates?

3. **Testing priority:** Which vignettes/examples are most critical to update first?

4. **Release timing:** Is this planned for a major version bump (2.0.0) given the breaking changes?

---

**Status:** Ready for Phase 4 implementation

**Contact:** Available for questions/clarifications
