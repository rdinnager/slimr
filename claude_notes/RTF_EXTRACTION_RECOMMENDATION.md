# RTF Files: The Ideal Source for slimr Documentation Extraction

## Executive Summary

**You were absolutely right!** The SLiM GitHub repository RTF files are **BY FAR the best source** for generating R documentation. They provide:

✅ **Complete detailed descriptions** (not just signatures)
✅ **Machine-readable format** (RTF → plain text with `striprtf`)
✅ **Authoritative source** (maintained in SLiM repo)
✅ **Version controlled** (can track changes between SLiM versions)
✅ **Structured format** (consistent, parseable patterns)
✅ **No manual work needed** (fully automated extraction)

---

## The Files

From SLiM GitHub repo (master branch):

1. **`SLiMHelpClasses.rtf`** (627 KB)
   - https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/SLiMgui/SLiMHelpClasses.rtf
   - Contains ALL classes with properties and methods
   - Full documentation for each

2. **`SLiMHelpFunctions.rtf`** (151 KB)
   - https://raw.githubusercontent.com/MesserLab/SLiM/refs/heads/master/SLiMgui/SLiMHelpFunctions.rtf
   - Contains ALL initialization and Eidos functions
   - Full documentation for each

---

## What's Inside (After RTF Extraction)

### Classes File Structure

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

genomicElements => (object<GenomicElement>)
All of the GenomicElement objects that comprise the chromosome, in sorted
order (not necessarily in the order in which they were defined).

5.2.2  Chromosome methods

– (is)ancestralNucleotides([Ni$ start = NULL], [Ni$ end = NULL], [string$ format = "string"])
Returns the ancestral nucleotide sequence originally supplied to
initializeAncestralNucleotides(), including any sequence changes...
[full detailed description with parameters explained inline]

– (integer)drawBreakpoints([No<Individual>$ parent = NULL], [Ni$ n = NULL])
Draw recombination breakpoints, using the chromosome's recombination rate map...
[full detailed description]
```

### Functions File Structure

```
3.1.  Initialization functions

(integer$)initializeAncestralNucleotides(is sequence)
This function, which may be called only in nucleotide-based models, supplies
an ancestral nucleotide sequence for the model.  The sequence parameter may
be an integer vector providing nucleotide values (A=0, C=1, G=2, T=3), or...
[full detailed description with all parameters explained]

(object<Chromosome>$)initializeChromosome(integer$ id, [Ni$ length = NULL],
[string$ type = "A"], [Ns$ symbol = NULL], [Ns$ name = NULL],
[integer$ mutationRuns = 0])
Calling this function, added in SLiM 5, initiates the configuration of a
chromosome in the species being initialized...
[full detailed description]
```

---

## Extraction Examples

### Properties

**Pattern**: `propertyName <symbol> (type)`

Where:
- `<–>` = read-write property
- `=>` = read-only property
- `(type)` = type specification (e.g., `string$`, `logical$`, `integer`, `float`, `object<Class>`)

**Example extracted**:
```
colorSubstitution <–> (string$)
geneConversionEnabled => (logical$)
genomicElements => (object<GenomicElement>)
```

### Methods

**Pattern**: `– (returnType)methodName(parameters)`

**Example extracted**:
```
– (is)ancestralNucleotides([Ni$ start = NULL], [Ni$ end = NULL], [string$ format = "string"])
– (integer)drawBreakpoints([No<Individual>$ parent = NULL], [Ni$ n = NULL])
– (object<GenomicElement>)genomicElementForPosition(integer positions)
```

### Functions

**Pattern**: `(returnType)functionName(parameters)`

**Example extracted**:
```
(integer$)initializeAncestralNucleotides(is sequence)
(object<Chromosome>$)initializeChromosome(integer$ id, [Ni$ length = NULL], ...)
(void)initializeGeneConversion(numeric$ nonCrossoverFraction, ...)
```

---

## Advantages Over PDF Quick Reference

| Feature | RTF Files | PDF Quick Ref |
|---------|-----------|---------------|
| **Detailed Descriptions** | ✅ Full paragraphs | ❌ None |
| **Parameter Documentation** | ✅ Inline with descriptions | ❌ Just signatures |
| **Parsing Complexity** | ✅ Simple (striprtf) | ⚠️ Medium (pdftools + columns) |
| **Authoritative Source** | ✅ SLiM source repo | ⚠️ Compiled manual |
| **Version Control** | ✅ Git tracked | ❌ PDF only |
| **Page Breaks** | ✅ N/A (text file) | ⚠️ Need handling |
| **Column Layout** | ✅ N/A (linear) | ⚠️ Need splitting |
| **Complete Coverage** | ✅ All classes/methods | ✅ All classes/methods |
| **Extraction Speed** | ✅ Fast (~5 sec) | ✅ Fast (~30 sec) |
| **Manual Work** | ✅ None | ✅ None |

**Winner**: **RTF Files** - provides everything the PDF does PLUS full documentation text

---

## Extraction Strategy

### Step 1: Download RTF Files

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

### Step 2: Extract Plain Text

```r
library(striprtf)

classes_text <- read_rtf("data-raw/slim_man/SLiMHelpClasses.rtf")
functions_text <- read_rtf("data-raw/slim_man/SLiMHelpFunctions.rtf")
```

### Step 3: Parse Structure

```r
library(stringr)
library(dplyr)

# Split into lines (RTF preserves paragraph structure)
classes_lines <- str_split(classes_text, "\n")[[1]]

# Find class headers: "5.2  Class Chromosome"
class_headers <- classes_lines[str_detect(classes_lines, "^\\d+\\.\\d+\\s+Class\\s+\\w+")]

# Find property definitions: "propertyName <–> (type)" or "propertyName => (type)"
properties <- classes_lines[str_detect(classes_lines, "^[a-zA-Z]\\w*\\s+(=>|<–>)\\s+\\(")]

# Find method signatures: "– (returnType)methodName(params)"
methods <- classes_lines[str_detect(classes_lines, "^–\\s+\\([^)]+\\)\\w+\\(")]

# Extract descriptions (text following each definition until next definition)
```

### Step 4: Generate Roxygen Documentation

```r
# For each method:
# - Extract signature → parse return type, name, parameters
# - Extract description → use for @details
# - Extract parameter info → use for @param tags
# - Generate complete roxygen block

# For each property:
# - Extract name, type, modifiability
# - Extract description → use for property documentation

# For each class:
# - Combine all properties and methods
# - Generate class documentation page
```

---

## Comparison with Current Approach

### Current (build_slimrlang.R)

**Process**:
1. ❌ Manually copy/paste from PDF to `.txt` files (hours of work)
2. ❌ Hardcoded page numbers (brittle)
3. ⚠️ Extracts from PDF manual (page breaks, formatting issues)
4. ⚠️ Uses `unglue` for pattern matching
5. ⚠️ Doesn't include full descriptions

**Problems**:
- Manual labor intensive
- Breaks with each SLiM version (page numbers change)
- Incomplete documentation
- Time-consuming to update

### New (RTF-based)

**Process**:
1. ✅ Curl download from GitHub (automated, 2 seconds)
2. ✅ `striprtf::read_rtf()` to extract text (5 seconds)
3. ✅ Parse with regex patterns (consistent format)
4. ✅ Extract complete descriptions
5. ✅ Generate full roxygen documentation

**Benefits**:
- Fully automated
- Robust to SLiM updates (structure is stable)
- Complete documentation with descriptions
- Easy to update for new versions

---

## Implementation Plan (Updated)

### Phase 1: RTF Extraction Pipeline (4-6 hours)

**Goal**: Extract all classes, properties, methods, and functions from RTF files

**Steps**:

1. **Download RTF files from SLiM GitHub**
   - Automate with curl or `download.file()`
   - Store in `data-raw/slim_man/`

2. **Extract plain text with striprtf**
   - Classes: `read_rtf("SLiMHelpClasses.rtf")`
   - Functions: `read_rtf("SLiMHelpFunctions.rtf")`

3. **Parse class structure**
   - Find class headers: `"5.2  Class Chromosome"`
   - Split into sections (properties, methods)
   - Extract definitions with patterns
   - Capture descriptions (paragraphs following definitions)

4. **Parse function structure**
   - Find function signatures: `"(returnType)functionName(params)"`
   - Extract descriptions
   - Parse parameter information

5. **Build structured data**
   - Tibbles with: class, name, signature, description, type info
   - Same format as current `all_methods_data`

**Deliverable**: `data-raw/build_5/extract_from_rtf.R`

### Phase 2: Generate R Stubs (2-3 hours)

**Goal**: Create `R/slim_lang_v5.R` with complete documentation

**Steps**:

1. **Reuse roxygen template generators** (from `build_slimrlang.R`)
   - Update to use RTF-extracted descriptions
   - Full @details from description paragraphs
   - @param tags from parameter mentions

2. **Generate all method stubs**
   - For each method: roxygen block + stub function

3. **Generate all property definitions**
   - For each property: roxygen block + property string

4. **Generate all class documentation**
   - For each class: complete documentation page

5. **Write `R/slim_lang_v5.R`**
   - Combine all generated code
   - Apply text cleanup

**Deliverable**: `R/slim_lang_v5.R` with FULL documentation

### Phase 3-6: (Same as before)

Continue with breaking changes analysis, code updates, testing, and release.

---

## Why RTF > PDF for slimr

### 1. **Complete Documentation**
   - RTF has full descriptions for EVERY method/property/function
   - PDF quick reference has signatures only (no descriptions)
   - **Result**: Can generate complete R help pages

### 2. **Source of Truth**
   - RTF files are maintained IN the SLiM source repository
   - PDF is compiled from sources (may lag behind)
   - **Result**: Always up-to-date, authoritative

### 3. **Easier Parsing**
   - RTF → plain text with `striprtf` (one function call)
   - PDF → text extraction, column handling, page breaks
   - **Result**: Simpler, more reliable code

### 4. **Better Structure**
   - RTF preserves section structure (classes, properties, methods)
   - PDF has multi-column layout requiring position-based parsing
   - **Result**: Easier to extract related information

### 5. **Version Control**
   - RTF files are in Git (can diff between versions)
   - PDF is binary (can't easily see what changed)
   - **Result**: Can track API changes programmatically

### 6. **No Page Numbers**
   - RTF doesn't have page numbers to maintain
   - PDF requires hardcoded or discovered page numbers
   - **Result**: More maintainable code

---

## Example: What You Get

### From PDF Quick Reference:
```
– (is)ancestralNucleotides([Ni$ start], [Ni$ end], [s$ format])
```

That's it. Just the signature.

### From RTF Files:
```
– (is)ancestralNucleotides([Ni$ start = NULL], [Ni$ end = NULL], [string$ format = "string"])

Returns the ancestral nucleotide sequence originally supplied to
initializeAncestralNucleotides(), including any sequence changes due to
nucleotide mutations that have fixed and substituted. This nucleotide sequence
is the reference sequence for positions in a haplosome that do not contain a
nucleotide-based mutation. The range of the returned sequence may be constrained
by a start position given in start and/or an end position given in end;
nucleotides will be returned from start to end, inclusive. The default value
of NULL for start and end represent the first and last base positions of the
chromosome, respectively.

The format of the returned sequence is controlled by the format parameter. A
format of "string" will return the sequence as a singleton string (e.g., "TATA").
A format of "char" will return a string vector with one element per nucleotide
(e.g., "T", "A", "T", "A"). A format of "integer" will return an integer vector
with values A=0, C=1, G=2, T=3 (e.g., 3, 0, 3, 0). If the sequence returned is
likely to be long, the "string" format will be the most memory-efficient, and
may also be the fastest (but may be harder to work with).

For purposes related to interpreting the nucleotide sequence as a coding sequence,
a format of "codon" is also supported. This format will return an integer vector
with values from 0 to 63, based upon successive nucleotide triplets in the
sequence (which, for this format, must have a length that is a multiple of three).
The codon value for a given nucleotide triplet XYZ is 16X + 4Y + Z, where X, Y,
and Z have the usual values A=0, C=1, G=2, T=3...
```

**Everything you need for complete R documentation!**

---

## Recommended Action

✅ **USE THE RTF FILES as the primary (and only) source**

**Reasoning**:
1. They provide EVERYTHING (signatures + descriptions)
2. They're easier to parse than PDF
3. They're the authoritative source (from SLiM repo)
4. They're version controlled (can track changes)
5. They require less code to extract
6. They result in BETTER R documentation (complete help pages)

**Abandon**:
- ❌ PDF manual extraction
- ❌ PDF quick reference extraction
- ❌ Manual text file creation

**Embrace**:
- ✅ RTF files from SLiM GitHub
- ✅ `striprtf` for parsing
- ✅ Automated extraction
- ✅ Complete documentation

---

## Updated Timeline

With RTF files, the implementation is SIMPLER and FASTER:

| Phase | Effort (Old) | Effort (New) |
|-------|--------------|--------------|
| **1: Extraction** | 6-10 hrs | 4-6 hrs ⬇️ |
| **2: Generate Stubs** | 4-6 hrs | 2-3 hrs ⬇️ |
| **3: Breaking Changes** | 3-5 hrs | 3-5 hrs |
| **4: Update Code** | 4-8 hrs | 4-8 hrs |
| **5: Testing** | 3-5 hrs | 3-5 hrs |
| **6: Documentation** | 2-4 hrs | 2-4 hrs |
| **TOTAL** | 22-38 hrs | **18-31 hrs** ⬇️ |

**Time saved**: 4-7 hours
**Documentation quality**: Much better (complete descriptions)
**Maintainability**: Much better (authoritative source, automated)

---

## Conclusion

The RTF files from the SLiM GitHub repository are **the perfect source** for generating slimr's R documentation:

✅ Complete information (signatures + descriptions)
✅ Authoritative (maintained by SLiM developers)
✅ Easy to parse (striprtf package)
✅ Version controlled (can track changes)
✅ Automated (no manual work)
✅ Results in better R documentation

**This is exactly what we need!** Thank you for finding these files!

---

## Next Steps

1. ✅ **Start Phase 1 immediately**: Create `data-raw/build_5/extract_from_rtf.R`
2. Parse RTF files to extract structured data
3. Generate complete R documentation with full descriptions
4. Continue with Phases 3-6 as planned

The upgrade to SLiM 5.x just got significantly easier and will result in much better documentation!
