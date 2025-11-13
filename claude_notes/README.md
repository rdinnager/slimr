# Claude Notes Directory

This directory contains documentation, reports, and analysis created by Claude and other AI assistants during slimr package development.

**Purpose:** Keep AI-generated documentation organized and separate from package code/documentation.

**Note:** This directory is excluded from R package builds (listed in `.Rbuildignore`).

---

## Directory Contents

### Process Guides

**[GUIDE_Updating_to_New_SLiM_Version.md](GUIDE_Updating_to_New_SLiM_Version.md)**
- Comprehensive guide for updating slimr when a new major version of SLiM is released
- Covers entire process from RTF extraction through release
- Includes automation guidance for AI agents
- Includes troubleshooting section
- Created: 2025-10-21 (v1.0)

### SLiM 4.x → 5.x Upgrade Documentation

**[BREAKING_CHANGES_v4_to_v5.md](BREAKING_CHANGES_v4_to_v5.md)**
- Detailed analysis of API changes between SLiM 4.x and 5.x
- Impact assessment for each change
- Recommended upgrade approach
- Created: 2025-10-21

**[PHASE_3_COMPLETE.md](PHASE_3_COMPLETE.md)**
- Summary of Phase 3 completion (API extraction and comparison)
- Statistics and verification results
- Next steps for Phase 4
- Created: 2025-10-21

### Investigation Reports

**[PDF_EXTRACTION_REPORT.md](PDF_EXTRACTION_REPORT.md)**
- Initial investigation into extracting API documentation from SLiM PDF manual
- Analysis of various PDF extraction approaches
- Conclusion: RTF approach preferred
- Created: 2025-10-21

**[RTF_EXTRACTION_RECOMMENDATION.md](RTF_EXTRACTION_RECOMMENDATION.md)**
- Investigation into RTF extraction methods
- Comparison of `striprtf` vs `unrtf` packages
- Initial recommendations
- Created: 2025-10-21

**[FINAL_RTF_RECOMMENDATION.md](FINAL_RTF_RECOMMENDATION.md)**
- Final recommendation for RTF extraction approach
- Solution to control character issues
- Implementation details
- Created: 2025-10-21

### Organization Documentation

**[ORGANIZATION_COMPLETE.md](ORGANIZATION_COMPLETE.md)**
- Summary of claude_notes directory organization
- List of all moved files
- Usage examples and guidelines
- Created: 2025-10-21

---

## Usage Guidelines

### For Human Developers

When working on slimr:
1. Check this directory for relevant documentation before starting major tasks
2. Consult the process guides when updating to new SLiM versions
3. Review breaking changes documents when planning upgrades
4. Use investigation reports to understand past decisions

### For AI Assistants

When assisting with slimr development:
1. **Store all documentation here** - Analysis, reports, guides, summaries
2. **Reference existing docs** - Check this directory before recreating analysis
3. **Update guides** - When processes change, update the relevant guides
4. **Create new docs** - Add new documents as needed for major work
5. **Follow naming conventions:**
   - `GUIDE_*.md` for process guides
   - `*_REPORT.md` for investigation reports
   - `PHASE_*_COMPLETE.md` for phase summaries
   - `BREAKING_CHANGES_*.md` for API change analysis
   - `MIGRATION_GUIDE_*.md` for user-facing migration guides

---

## Document Index

### By Topic

**SLiM Version Upgrades:**
- [GUIDE_Updating_to_New_SLiM_Version.md](GUIDE_Updating_to_New_SLiM_Version.md)
- [BREAKING_CHANGES_v4_to_v5.md](BREAKING_CHANGES_v4_to_v5.md)
- [PHASE_3_COMPLETE.md](PHASE_3_COMPLETE.md)

**API Extraction Methods:**
- [PDF_EXTRACTION_REPORT.md](PDF_EXTRACTION_REPORT.md)
- [RTF_EXTRACTION_RECOMMENDATION.md](RTF_EXTRACTION_RECOMMENDATION.md)
- [FINAL_RTF_RECOMMENDATION.md](FINAL_RTF_RECOMMENDATION.md)

### By Date

- **2025-10-21:**
  - GUIDE_Updating_to_New_SLiM_Version.md (v1.0)
  - BREAKING_CHANGES_v4_to_v5.md
  - PHASE_3_COMPLETE.md
  - PDF_EXTRACTION_REPORT.md
  - RTF_EXTRACTION_RECOMMENDATION.md
  - FINAL_RTF_RECOMMENDATION.md

---

## Maintenance

### Adding New Documents

When creating a new document:
1. Save to `claude_notes/` directory
2. Use descriptive filename with appropriate prefix
3. Add entry to this README in relevant sections
4. Include creation date in document
5. Reference from CLAUDE.md if it's a major guide

### Archiving Old Documents

When documents become outdated:
1. Move to `claude_notes/archive/` subdirectory
2. Update this README to mark as archived
3. Keep for historical reference

### Version Control

- All documents in this directory should be committed to git
- Track changes through git history
- Major guide updates should increment version number in document

---

**Last Updated:** 2025-10-21
