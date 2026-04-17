---
name: executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute all tasks, report when complete.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

**Note:** On platforms with subagent support, `superpowers:subagent-driven-development`
can improve quality for independent or high-risk tasks. Present the tradeoff and
honor the user's selected execution mode.

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute Tasks

For each task:
1. Mark as in_progress
2. Implement the task contract
3. Satisfy acceptance criteria
4. Run verifications as specified
5. Mark as completed

### Step 3: Complete Development

After all tasks complete and verified:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **Next skill:** Use superpowers:finishing-a-development-branch
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask for Help

Pause execution and ask when:
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- An instruction needs clarification
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

Pause at blockers and ask.

## Remember
- Review plan critically first
- Implement task contracts and acceptance criteria
- Run verifications
- Reference skills when plan says to
- Stop when blocked and ask
- Get explicit user consent before starting implementation on main/master

## Integration

**Required workflow skills:**
- **superpowers:using-git-worktrees** - Optional/ask first unless user or project config requires it
- **superpowers:writing-plans** - Creates the plan this skill executes
- **superpowers:finishing-a-development-branch** - Complete development after all tasks
