# Superpowers Lite — Agent Guidance

This fork prioritizes low-token, proportionate workflows.

## Core Rules

- Use the lightest workflow that can do the job correctly.
- Prefer direct edits for small, clear changes.
- Use plans, specs, subagents, and review only when task size or risk justifies them.
- Preserve user instructions over skill defaults.
- Verify claims with relevant checks before reporting success.

## Contribution Direction

This fork intentionally diverges from upstream Superpowers. It removes unused
skills and rewrites core skills around triage, task contracts, and adaptive
review. Do not restore upstream ceremony unless a local issue proves it is
needed.

## Pull Requests

If creating a PR from this fork:
- describe the concrete problem solved
- keep changes scoped
- include the relevant local checks
- show the diff to the human before submission

For this fork, practical correctness and reduced agent overhead matter more
than matching upstream wording or workflow philosophy.
