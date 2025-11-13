# Agent Launch Prompts for Recipe Conversion

**Purpose**: Use these prompts to launch new AI agents to continue recipe conversion work.

**Last updated**: 2025-10-23

---

## Recommended Prompt (Concise)

Use this for most situations - it's brief but directs the agent to all necessary documentation:

```
You are contributing to SLiM recipe conversion for the slimr package.

Read these files in order to get oriented:
1. claude_notes/RECIPE_CONVERSION_PLAN.md (the overall process)
2. claude_notes/RECIPE_CONVERSION_GUIDE.md (essential conversion patterns)
3. claude_notes/CURRENT_STATUS.md (current progress and what's next)

Then continue converting SLiM recipes to slimr format.

Note: recipe_conversion_notes.md contains historical session details if you need deeper context.
```

---

## Medium Detail Prompt

Use this if you want a bit more context in the prompt itself:

```
You are contributing to the SLiM recipe conversion project for the slimr R package.

FIRST, read the documentation in this order:
1. claude_notes/RECIPE_CONVERSION_PLAN.md - Understand the overall process and goals
2. claude_notes/RECIPE_CONVERSION_GUIDE.md - Essential conversion patterns (MUST READ!)
3. claude_notes/CURRENT_STATUS.md - See current progress and what to work on next

Then convert recipes following the established workflow:
- Understand the original recipe's purpose
- Convert to slimr syntax
- Create and RUN test file
- Update metadata CSV
- Add notes to guide (only for NEW reusable patterns)

The conversion guide contains critical patterns like .. syntax for open-ended ranges, asFloat() for callbacks, 0-based indexing, etc. Read it carefully!
```

---

## Detailed Prompt

Use this for maximum hand-holding:

```
You are contributing to the SLiM recipe conversion project for the slimr R package. Goal: convert official SLiM recipes to slimr format with tests and documentation.

Read the documentation in this order:
1. claude_notes/RECIPE_CONVERSION_PLAN.md - Understand the overall process, goals, and workflow
2. claude_notes/RECIPE_CONVERSION_GUIDE.md - Essential conversion patterns, solutions, and examples (MUST READ!)
3. claude_notes/CURRENT_STATUS.md - Current progress and what recipe to start with

The conversion guide is critical - it contains patterns like:
- Open-ended ranges: 1000: → slim_block(1000, .., ...)
- asFloat() for callback returns (CRITICAL!)
- 0-based array indexing in loops (CRITICAL!)
- Method chaining requires $ not .
- Common mistakes to avoid

Follow the workflow: understand recipe → convert → test → update metadata → update guide (if NEW pattern).

All infrastructure is in place. The CURRENT_STATUS file will tell you exactly where to begin.
```

---

## Minimal Prompt (For Experienced Agents)

If the agent has worked on this before or you just want minimal direction:

```
Continue converting SLiM recipes to slimr format. Read claude_notes/CURRENT_STATUS.md for current progress and claude_notes/RECIPE_CONVERSION_GUIDE.md for patterns.
```

---

## Tips for Using These Prompts

1. **Keep them evergreen** - These prompts work regardless of current progress
2. **Let agents discover the current state** - CURRENT_STATUS.md shows what's next
3. **Concise is usually better** - The documentation is comprehensive, so a brief prompt works well
4. **Point to docs, don't repeat them** - Let agents discover patterns from the well-organized notes
5. **Update CURRENT_STATUS.md** - Keep that file current so agents know where to start

---

## What NOT to Include in Prompts

❌ Don't repeat all the conversion patterns (they're in RECIPE_CONVERSION_GUIDE.md)
❌ Don't list all completed recipes (that's in CURRENT_STATUS.md)
❌ Don't explain the entire workflow in detail (that's in RECIPE_CONVERSION_PLAN.md)
✅ DO point agents to the right documentation files in the right order

---

## After Launching an Agent

The agent should automatically:
1. Read the three documentation files
2. Pick up where previous agents left off
3. Follow established patterns
4. Update documentation as they work
5. Leave clear notes for the next agent

If an agent doesn't read the documentation files, gently remind them to do so before converting recipes.
