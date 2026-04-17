---
name: requesting-code-review
description: Use when a completed change is high-risk, broad, security-sensitive, or ready for final review before merge
---

# Requesting Code Review

Use an independent reviewer when review is likely to catch defects that local
verification may miss. Keep review focused and proportional to risk.

**Core principle:** Review where it reduces real risk.

## When To Request Review

Request review for:
- auth, permissions, billing, data migration, data loss, or security-sensitive changes
- public APIs, cross-module architecture, or broad refactors
- large features after implementation
- final review before merge/PR when the change is non-trivial
- work where you are uncertain after verification

Use self-review plus tests for:
- tiny mechanical edits
- low-risk single-file changes
- literal docs/config updates
- reviewer comments that are Minor and easy to assess locally

## How To Request

### 1. Identify Scope

Collect:
- what changed
- why it changed
- requirements or task contract
- base and head SHAs
- specific review focus

```bash
BASE_SHA=$(git merge-base HEAD main 2>/dev/null || git rev-parse HEAD~1)
HEAD_SHA=$(git rev-parse HEAD)
```

### 2. Dispatch Reviewer

Use the `superpowers:code-reviewer` prompt from `code-reviewer.md`.

Fill:
- `{WHAT_WAS_IMPLEMENTED}`
- `{PLAN_OR_REQUIREMENTS}`
- `{BASE_SHA}`
- `{HEAD_SHA}`
- `{DESCRIPTION}`

Add a focused review instruction when useful:

```text
Review focus: authorization boundaries and tenant isolation.
```

### 3. Act On Feedback

- **Critical:** fix before proceeding.
- **Important:** fix before merge unless there is a clear technical reason to defer.
- **Minor:** fix if cheap, otherwise note as non-blocking.
- **Incorrect feedback:** push back with code, tests, or repository context.

Use focused re-checks for blocking fixes. A full second review is useful only
when the fix changes the shape of the implementation.

## Workflow Integration

**Subagent-driven development:** Use the review policy in
`superpowers:subagent-driven-development`. This skill supplies the review
template when that policy says independent review is warranted.

**Executing plans:** Review after a risky task, a meaningful batch, or the final
implementation. Implement task contracts and verification first.

**Ad-hoc development:** Review before merge when the diff is broad, risky, or
hard to validate with tests alone.

## Example

```text
Task: Add billing report download authorization
Risk: authorization + sensitive data
Review focus: ownership checks, tenant isolation, error behavior
Base: a7981ec
Head: 3df7661
```

Reviewer returns:

```text
Issues:
- Important: export endpoint checks role but not tenant ownership.
- Minor: error message could be clearer.
```

Fix the Important issue, re-check ownership behavior, and decide whether the
Minor message change is worth doing now.

See template at: `requesting-code-review/code-reviewer.md`
