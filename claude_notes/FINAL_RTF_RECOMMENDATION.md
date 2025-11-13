# RTF-Based Extraction: Perfect Match for slimr's Documentation Needs

## Summary

The **RTF files from SLiM's GitHub repository** are the ideal source for regenerating slimr's documentation for SLiM 5.x. They contain the exact same detailed descriptions currently in `R/slim_lang.R`, because the manual's text is derived from these source files.

**Key Insight**: The current v4 documentation in `R/slim_lang.R` is excellent and complete - we just need to replicate that same quality for SLiM 5.x using an automated extraction from the RTF files instead of manual copy/paste.

---

## Current Documentation Format (Target to Replicate)

### Initialize Functions (Exported)

```r
#'SLiM method initializeAncestralNucleotides
#'
#'Documentation for SLiM function \code{initializeAncestralNucleotides}, which is
#'a method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=647}{SLiM manual: page 647}.
#'
#'@param sequence An object of type integer or string. See details for description.
#'
#'@aliases Initialize$initializeAncestralNucleotides .Init$initializeAncestralNucleotides
#'@family Initialize
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details This function, which may be called only in nucleotide-based models
#'(see section 1.8), supplies an ancestral nucleotide sequence for the model.
#'The sequence parameter may be an integer vector providing nucleotide values
#'(A=0, C=1, G=2, T=3), or a string vector providing single-character nucleotides
#'("A", "C", "G", "T"), or a singleton string providing the sequence as one
#'string ("ACGT..."), or a singleton string providing the filesystem path of a
#'FASTA file which will be read in to provide the sequence (if the file contains
#'than one sequence, the first sequence will be used). Only A/C/G/T nucleotide
#'values may be provided; other symbols, such as those for amino acids, gaps, or
#'nucleotides of uncertain identity, are not allowed. The two semantic meanings of
#'sequence that involve a singleton string value are distinguished heuristically;
#'a singleton string that contains only the letters ACGT will be assumed to be a
#'nucleotide sequence rather than a filename. The length of the ancestral sequence
#'is returned. A utility function, randomNucleotides(), is provided by SLiM to
#'assist in generating simple random nucleotide sequences; see section 25.18.1.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
#'@examples
#'## This just brings up the documentation:
#'initializeAncestralNucleotides()
initializeAncestralNucleotides <- function(sequence) {
  .Init$initializeAncestralNucleotides(sequence)
}
```

###Class Methods (Not Exported)

Class methods are documented but the stub functions are created dynamically in internal data (`R/sysdata.rda`), not as exported functions. Only the roxygen documentation appears in `R/slim_lang.R`.

---

## RTF Files Provide Everything Needed

The RTF files contain:

1. **Class structure** (e.g., "5.2 Class Chromosome")
2. **Property definitions** with read/write status and types
3. **Property descriptions** (complete paragraphs)
4. **Method signatures** with parameters and return types
5. **Method descriptions** (complete paragraphs, same as in manual)
6. **Function signatures** (initialize functions, etc.)
7. **Function descriptions** (complete paragraphs)

This is **exactly the information** currently in `R/slim_lang.R` for v4.

---

## Extraction Workflow

### 1. Download RTF Files

```r
download.file(
  "https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/SLiMgui/SLiMHelpClasses.rtf",
  "data-raw/slim_man/SLiMHelpClasses.rtf"
)

download.file(
  "https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/SLiMgui/SLiMHelpFunctions.rtf",
  "data-raw/slim_man/SLiMHelpFunctions.rtf"
)
```

### 2. Extract Plain Text

```r
library(striprtf)
classes_text <- read_rtf("data-raw/slim_man/SLiMHelpClasses.rtf")
functions_text <- read_rtf("data-raw/slim_man/SLiMHelpFunctions.rtf")
```

**Result**: Plain text with preserved structure (but all on one line - need to split intelligently)

### 3. Parse Structure

The challenge with RTF extraction is that `striprtf` removes ALL formatting, including line breaks. So we get:

```
5.2  Class Chromosome5.2.1  Chromosome propertiescolorSubstitution <–> (string$)The color used to...geneConversionEnabled => (logical$)When gene conversion has...
```

**Solution**: Use the consistent structural markers to split:
- Class headers: `"\\d+\\.\\d+\\s+Class\\s+(\\w+)"`
- Property section headers: `"Chromosome properties"`
- Method section headers: `"Chromosome methods"`
- Property definitions: `"propertyName (<–>|=>) \\(type\\)"`
- Method signatures: `"– \\(returnType\\)methodName\\(params\\)"`

### 4. Extract Descriptions

After each property/method signature, the description text follows until the next signature or section header. Extract these as @details.

### 5. Generate Roxygen Documentation

Use the existing templates from `build_slimrlang.R`:
- `func_template` - for Initialize functions
- `method_code` - for class methods (internal)
- `class_roxy` - for class documentation pages
- `property_roxy` - for property documentation within class pages

### 6. Create Output

**Generated files**:
1. `R/slim_lang_v5.R` - All roxygen documentation + exported Initialize functions
2. `R/sysdata.rda` - Class objects with internal method/property assignments
3. `data/slim_classes.rda` - Public class abbreviation lookup table

---

## Why RTF > Current Manual Approach

| Aspect | Current (Manual) | RTF (Automated) |
|--------|------------------|-----------------|
| **Source** | PDF → manual copy/paste | RTF → striprtf |
| **Time** | Hours of manual work | Seconds (automated) |
| **Accuracy** | Copy/paste errors possible | Exact from source |
| **Updates** | Re-do manual process | Re-run script |
| **Page Numbers** | Hardcoded, brittle | N/A (use markers) |
| **Completeness** | Full (if done carefully) | Full (automatic) |
| **Documentation Quality** | Excellent | Same (same source) |

---

## Implementation Plan (Detailed)

### Phase 1: RTF Parsing Script (4-6 hours)

**File**: `data-raw/build_5/extract_from_rtf.R`

**Steps**:

1. **Download and extract RTF files** (5 min)
   ```r
   # Download
   # Extract with striprtf
   # Split into logical units
   ```

2. **Parse classes file structure** (2 hours)
   ```r
   # Find class boundaries
   # Split into property and method sections
   # Extract property definitions and descriptions
   # Extract method signatures and descriptions
   # Build tibbles matching current format
   ```

3. **Parse functions file structure** (1 hour)
   ```r
   # Find function signatures
   # Extract descriptions
   # Build tibbles matching current format
   ```

4. **Build structured data** (1 hour)
   ```r
   # Create all_methods_data (same format as v4)
   # Create all_properties_data (same format as v4)
   # Create class introductions
   ```

5. **Testing and refinement** (1-2 hours)
   ```r
   # Verify all classes captured
   # Verify all methods/properties captured
   # Compare counts with v4
   # Spot-check descriptions
   ```

**Deliverables**:
- `all_methods_data` - tibble list by class
- `all_properties_data` - tibble list by class
- `slim_lang_intros` - class introduction text

### Phase 2: Generate R Documentation (2-3 hours)

**Reuse existing code from `build_slimrlang.R`**:

1. **Reuse template generators** (30 min)
   - `make_slim_function()` - already works
   - `make_class_funcs()` - already works
   - `create_properties()` - already works
   - `make_class_roxy()` - already works
   - Just update copyright year to 2016-2025

2. **Generate all documentation** (30 min)
   ```r
   # Run existing generators on new data
   all_methods_txt <- ...  # Same as v4 process
   class_roxies <- ...     # Same as v4 process
   property_txt <- ...     # Same as v4 process
   ```

3. **Assemble output** (30 min)
   ```r
   # Combine into r_script
   # Apply text cleanup (quotes, escapes, etc.)
   # Write to R/slim_lang_v5.R
   ```

4. **Generate internal data** (30 min)
   ```r
   # Create class objects (.Init, .Ch, .Co, etc.)
   # Assign methods and properties
   # Save to R/sysdata.rda
   # Save slim_classes to data/
   ```

**Deliverables**:
- `R/slim_lang_v5.R` - Complete documentation file
- `R/sysdata.rda` - Internal class objects
- `data/slim_classes.rda` - Public class lookup

### Phase 3-6: Same as Original Plan

Continue with:
- Breaking changes analysis
- Code updates
- Testing
- Documentation

---

## Key Differences from PDF Approach

1. **Text splitting challenge**
   - PDF: Already has line breaks
   - RTF: All one line, need to split on markers

2. **Section identification**
   - PDF: Uses page layout (columns, positions)
   - RTF: Uses text markers ("Class Chromosome", "properties", "methods")

3. **Parsing approach**
   - PDF: Position-aware (`pdf_data()` with x/y coordinates)
   - RTF: Sequential text scanning with regex

4. **Complexity**
   - PDF: Moderate (column handling, page breaks)
   - RTF: Moderate (splitting, marker identification)

**Both are viable, RTF is preferred because**:
- Source of truth (in SLiM repo)
- No page numbers to maintain
- Version controlled
- Same descriptions as current v4

---

## Expected Output Quality

The RTF approach will generate **identical quality documentation** to the current v4 version in `R/slim_lang.R` because:

✅ Same source material (SLiM official documentation)
✅ Same extraction approach (parse structure, extract descriptions)
✅ Same roxygen templates
✅ Same text cleanup steps

**Result**: Professional, complete R documentation matching current standards.

---

## Recommended Next Steps

1. **Start Phase 1**: Create `data-raw/build_5/extract_from_rtf.R`
   - Parse RTF files
   - Build structured data matching v4 format

2. **Reuse Phase 2**: Adapt `build_slimrlang.R` generators
   - Minimal changes needed (already works with tibble format)
   - Update copyright year
   - Point to new data

3. **Generate v5 documentation**
   - Run generators
   - Create `R/slim_lang_v5.R`
   - Save internal data

4. **Continue with breaking changes analysis and testing**

---

## Success Criteria

✅ All SLiM 5.x classes extracted (expect 15-20 classes)
✅ All methods and properties captured
✅ Descriptions match manual quality
✅ Roxygen documentation validates
✅ Generated help pages display correctly
✅ All autocomplete works (class$method)

---

## Timeline Summary

| Phase | Task | Time |
|-------|------|------|
| 1 | RTF parsing | 4-6 hrs |
| 2 | Generate docs | 2-3 hrs |
| **Total (Phases 1-2)** | | **6-9 hrs** |
| 3 | Breaking changes | 3-5 hrs |
| 4 | Code updates | 4-8 hrs |
| 5 | Testing | 3-5 hrs |
| 6 | Documentation | 2-4 hrs |
| **Grand Total** | | **18-31 hrs** |

---

## Conclusion

The RTF files from SLiM's GitHub are perfect for regenerating slimr's documentation:

1. ✅ **Complete information** - Everything needed for full roxygen docs
2. ✅ **Authoritative** - Maintained by SLiM developers
3. ✅ **Automated** - No manual copying
4. ✅ **Same quality** - Will match current excellent v4 documentation
5. ✅ **Maintainable** - Easy to update for future SLiM versions

This approach will produce the same high-quality, comprehensive documentation that slimr currently has for SLiM 4.x.
