---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write implementation plans as task contracts. A good plan tells a capable
engineer what outcome is required, where to work, what constraints matter, and
how to verify completion. Prefer contracts and acceptance criteria; include full
implementation code when the task is purely mechanical or exact content is the
requirement.

Assume the executor is a skilled developer who can read the codebase and make
local implementation decisions. Give enough context to keep them oriented while
leaving room for engineering judgment.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Context:** Use a dedicated worktree when the user or project workflow wants isolated branch work.

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`
- (User preferences for plan location override this default)

## Scope Check

If the spec covers multiple independent subsystems, suggest separate plans, one
per subsystem. Each plan should produce working, testable software on its own.

## Detail Budget

Scale the plan detail to the work:

| Work type | Plan detail |
|-----------|-------------|
| Tiny or small change | 3-8 bullet checklist; create a plan file when requested |
| Medium change | Task contracts in one concise file |
| Large change | Overview file plus one task file per phase/task |
| High-risk change | Include invariants, rollback/safety notes, and focused review points |

Before writing a long plan, estimate its weight. If the plan is likely to exceed
300 lines or 10 tasks, prefer a plan directory:

```text
docs/superpowers/plans/<feature>/
  overview.md
  task-01-<name>.md
  task-02-<name>.md
```

The overview should contain the goal, architecture, task index, dependencies,
and global constraints. Each task file should be readable on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for. This is where decomposition decisions get locked in.

- Design units with clear boundaries and well-defined interfaces. Each file should have one clear responsibility.
- You reason best about code you can hold in context at once, and your edits are more reliable when files are focused. Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns. If a file you're modifying has grown unwieldy, include a targeted split when it serves the current goal.

This structure informs the task decomposition. Each task should produce self-contained changes that make sense independently.

## Task Granularity

Each task should produce a coherent, reviewable change. State the required
testing discipline and acceptance criteria once at the task level.

Good task size:
- touches a focused set of files
- can be verified with a targeted command
- leaves the system in a working state
- can be committed independently if the executor chooses

## Plan Document Header

Start each implementation plan with this header:

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Triage before executing. Use inline execution for small/low-risk work. Use `superpowers:subagent-driven-development` only when isolated task execution or review will materially help. Use `superpowers:executing-plans` for sequential inline execution.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---
```

## Task Structure

```markdown
### Task N: [Component Name]

**Why:** [How this task advances the goal]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Contract:**
- Public API, function signatures, data shapes, routes, commands, or schemas this task must provide
- Important invariants and compatibility requirements
- Boundaries: what should remain stable or out of scope

**Acceptance:**
- Observable behavior that must work
- Edge cases that must be covered
- Regression or compatibility expectations

**Verification:**
- `pytest tests/path/test.py`
- Any manual check or build command needed

**Review focus:** [Optional: only for risky tasks]
```

### When To Include Exact Code

Include exact code or file contents only when one of these is true:
- the task is to create a literal config, fixture, prompt, migration, or generated file
- a short snippet makes the exact API surface clearer
- the snippet is short and clarifies a tricky invariant
- the user explicitly requested a copy-paste implementation plan

Prefer signatures, examples, and acceptance criteria over full bodies.

## Concrete Content

Each task contains enough concrete information to execute. These are
**plan failures** — replace them with concrete content:
- "TBD", "TODO", "implement later", "fill in details"
- "Add appropriate error handling" / "add validation" / "handle edge cases"
- "Write tests for the above" (replace with behaviors or cases to test)
- "Similar to Task N" (repeat the relevant contract — the engineer may be reading tasks out of order)
- References to types, functions, or methods not defined by the spec, existing code, or another task

## Remember
- Exact file paths always
- Contracts and acceptance criteria by default; full implementation bodies only when they add value
- Verification commands for each task or task group
- DRY, YAGNI, TDD where it fits, and proportionate review

## Self-Review

After writing the complete plan, look at the spec with fresh eyes and check the plan against it. Run this checklist inline.

**1. Spec coverage:** Skim each section/requirement in the spec. Can you point to a task that implements it? List any gaps.

**2. Concrete content scan:** Search your plan for red flags — any of the patterns from the "Concrete Content" section above. Fix them.

**3. Type consistency:** Do the types, method signatures, and property names you used in later tasks match what you defined in earlier tasks? A function called `clearLayers()` in Task 3 but `clearFullLayers()` in Task 7 is a bug.

**4. Detail budget:** Did the plan include full code, repeated commit steps, or repeated TDD ceremony where a contract would be enough? Condense it.

**5. Execution fit:** Does the plan say when inline execution is enough and when subagents/review are justified?

If you find issues, fix them inline and move on. If you find a spec requirement with no task, add the task.

## Execution Handoff

After saving the plan, offer an execution choice that reflects task size and any
project/user preferences:

**"Plan complete and saved to `docs/superpowers/plans/<filename>.md`. Suggested execution: [inline/subagent] because [reason]. Options:**

**1. Inline Execution** - Best for small or tightly coupled work; lower token cost

**2. Subagent-Driven** - Best when tasks are independent, context isolation helps, or review risk is high

**Which approach?"**

**If Subagent-Driven chosen:**
- **Next skill:** Use superpowers:subagent-driven-development
- Adaptive reviews; use reviewers where risk justifies them

**If Inline Execution chosen:**
- **Next skill:** Use superpowers:executing-plans
- Batch execution with checkpoints for review
