---
name: systematic-debugging
description: Use when encountering a bug, test failure, build failure, or unexpected behavior before proposing fixes
---

# Systematic Debugging

Find the root cause before fixing. Guessing is expensive; evidence is cheaper.

**Core principle:** Reproduce, trace, hypothesize, test, then fix.

## When To Use

Use for:
- test failures
- production bugs
- unexpected behavior
- build or integration failures
- performance problems
- fixes that already failed once

For obvious typos or one-line mistakes, patch directly and verify. For anything
unclear, use this process.

## Process

### 1. Reproduce And Read

Collect the actual failure:
- exact command or user action
- full error message
- stack trace and line numbers
- relevant logs
- current git diff and recent commits

Confirm whether the issue is reproducible. If it is intermittent, gather enough
data to narrow where it varies.

### 2. Localize The Break

Find where the expected state first becomes wrong.

Use the smallest useful tools:
- inspect the failing line
- trace caller/callee data flow
- compare working and broken examples
- add temporary logging at component boundaries
- check environment/config propagation

For deeper tracing, use the references in this directory:
- `root-cause-tracing.md`
- `condition-based-waiting.md`
- `defense-in-depth.md`

### 3. Form One Hypothesis

State the hypothesis:

```text
I think <root cause> because <evidence>.
```

Test one variable at a time. Prefer a small diagnostic or focused test over a
large patch. If the hypothesis fails, update the hypothesis from the new
evidence.

### 4. Fix The Root Cause

Once the root cause is supported by evidence:

1. Add or identify a failing test that reproduces the bug when practical.
2. Use `superpowers:test-driven-development` for behavior fixes.
3. Make one focused production change.
4. Run the targeted test.
5. Run relevant broader verification.

Keep unrelated cleanup separate.

### 5. Reassess After Failed Fixes

If two focused fixes fail, pause and reassess before trying another:
- Is the root cause wrong?
- Is the architecture fighting the desired behavior?
- Is shared state or coupling hiding the real issue?
- Should the task be split or redesigned?

Escalate to the user when the evidence points to an architectural decision.

## Multi-Component Debugging

For flows like CI -> build -> signing, API -> service -> database, or UI ->
client -> server:

1. Log inputs and outputs at each boundary.
2. Verify environment/config at each layer.
3. Identify the first layer where expected data changes or disappears.
4. Investigate that layer in detail.

Example:

```bash
echo "=== Workflow env ==="
env | grep IDENTITY || true

echo "=== Build script env ==="
env | grep IDENTITY || true

echo "=== Signing state ==="
security find-identity -v
```

## Working Examples

When a similar pattern works elsewhere:

1. Read the working implementation.
2. List differences from the broken path.
3. Test the difference most likely to matter.
4. Apply the fix at the source of the mismatch.

## Stop Signals

When you notice these patterns, return to evidence gathering:
- changing code before reproducing the issue
- stacking multiple fixes in one attempt
- relying on "probably"
- fixing a symptom while the source remains unknown
- adding timeouts where condition-based waiting would reveal the state
- repeating failed fixes without a new hypothesis

## Completion

A debugging fix is complete when:
- the root cause is stated
- the fix addresses that root cause
- a focused test or reproduction now passes
- relevant regression checks pass
- remaining uncertainty is documented

## Related Skills

- `superpowers:test-driven-development` for behavior-level regression tests.
