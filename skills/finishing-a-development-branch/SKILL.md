---
name: finishing-a-development-branch
description: Use when implementation is complete and you need to verify, merge, create a PR, keep, or discard the branch
---

# Finishing A Development Branch

Finish work by verifying it, presenting clear choices, executing the user's
choice, and cleaning up only when appropriate.

**Core principle:** Verify first, then choose an integration path.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## Process

### 1. Verify Current State

Run the relevant project checks before presenting merge/PR options:

```bash
npm test / cargo test / pytest / go test ./...
```

If checks fail, report the failures and keep the branch in place for fixing:

```text
Checks are failing:
[short failure summary]

I'll keep the branch as-is so these can be fixed before merge or PR.
```

If checks pass, continue.

### 2. Identify Branches And Worktree

Collect:
- current branch
- likely base branch (`main` or `master`, or ask)
- whether the current directory is a git worktree
- relevant commits on the feature branch

Useful commands:

```bash
git branch --show-current
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
git worktree list
git log --oneline <base>..HEAD
```

### 3. Present Four Options

```text
Implementation is verified. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is
4. Discard this work

Which option?
```

Keep the menu concise. Add extra detail only if the repository state is unusual.

### 4. Execute The Choice

#### Option 1: Merge Locally

```bash
git checkout <base-branch>
git pull
git merge <feature-branch>
<test command>
git branch -d <feature-branch>
```

After a successful merge, remove the worktree if one exists.

#### Option 2: Push And Create PR

```bash
git push -u origin <feature-branch>
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary
- <what changed>

## Test Plan
- [ ] <verification performed>
EOF
)"
```

Keep the branch and worktree unless the user asks for cleanup.

#### Option 3: Keep As-Is

Report:

```text
Keeping branch <name>.
Worktree: <path or "none">
```

#### Option 4: Discard

Ask for typed confirmation:

```text
This will permanently delete:
- Branch <name>
- Commits: <commit-list>
- Worktree: <path or "none">

Type 'discard' to confirm.
```

After exact confirmation:

```bash
git checkout <base-branch>
git branch -D <feature-branch>
git worktree remove <worktree-path>
```

Only remove a worktree after leaving it.

## Cleanup Rules

| Option | Branch | Worktree |
|--------|--------|----------|
| Merge locally | delete after successful merge | remove after successful merge |
| Create PR | keep | keep |
| Keep as-is | keep | keep |
| Discard | delete after confirmation | remove after confirmation |

## Safety Checks

- Verify tests before merge or PR.
- Verify tests again after local merge.
- Ask before destructive cleanup.
- Use typed `discard` confirmation for deletion.
- Keep PR branches/worktrees available for review.
- Use force-push only when the user explicitly requests it.

## Integration

Called after `subagent-driven-development` or `executing-plans` completes.
Pairs with `using-git-worktrees` when isolated branch work was used.
