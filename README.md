# Superpowers

Superpowers is a lightweight set of coding-agent skills for planning, testing,
debugging, review, and branch finishing. It helps agents choose the right amount
of process for the task instead of forcing every request through the same
workflow.

## How it works

The agent starts by triaging the work. A tiny doc fix or obvious one-file patch
stays direct. A medium feature gets a short plan. A high-risk change can still
get a design note, task contracts, isolated work, tests, and review.

The skills are composable. `brainstorming` clarifies unclear work,
`writing-plans` turns approved designs into task contracts,
`test-driven-development` keeps behavior changes test-first, and
`subagent-driven-development` uses subagents only where fresh context or review
reduces real risk.

The goal is simple: keep the reliability benefits of structured agent workflows
while cutting token burn, review loops, surprise worktrees, and unnecessary
planning ceremony.


## Installation

This fork is installed from git. It is not published through plugin
marketplaces.

### OpenAI Codex CLI

Install the skills into Codex's user skills directory, then restart Codex:

```bash
git clone https://github.com/alex-kinokon/reasonable-powers.git ~/.codex/superpowers
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R ~/.codex/superpowers/skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

To update:

```bash
cd ~/.codex/superpowers
git pull
cp -R ~/.codex/superpowers/skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

**Detailed docs:** [docs/README.codex.md](docs/README.codex.md)

### Cursor

Cursor plugin marketplace install is not supported for this fork. This README
does not currently document a verified git-only Cursor install path; use one of
the supported CLI harnesses below.

### OpenCode

OpenCode does not document `git+` plugin entries. Install the skills by cloning
the repo and copying the skill directories into OpenCode's user skill path:

```bash
git clone https://github.com/alex-kinokon/reasonable-powers.git ~/.config/opencode/superpowers
mkdir -p ~/.config/opencode/skills
cp -R ~/.config/opencode/superpowers/skills/* ~/.config/opencode/skills/
```

Restart OpenCode after installing.

**Detailed docs:** [docs/README.opencode.md](docs/README.opencode.md)

### GitHub Copilot CLI

Install directly from the GitHub repository:

```bash
copilot plugin install alex-kinokon/reasonable-powers
```

### Gemini CLI

```bash
gemini extensions install https://github.com/alex-kinokon/reasonable-powers
```

To update:

```bash
gemini extensions update superpowers
```

Restart Gemini CLI after installing or updating extensions.

## The Basic Workflow

1. **brainstorming** - Available for medium or larger unclear work. Refines rough ideas through questions, explores alternatives, and writes a design document when it helps.

2. **using-git-worktrees** - Available when isolated branch work is useful. Creates isolated workspace on request, runs project setup, verifies clean test baseline.

3. **writing-plans** - Activates for medium or larger approved designs. Writes task contracts with exact file paths, acceptance criteria, and verification steps.

4. **subagent-driven-development** or **executing-plans** - Activates with a plan. Uses inline execution for small work, subagents where isolation helps, and adaptive review where risk justifies it.

5. **test-driven-development** - Available for behavior changes. Uses RED-GREEN-REFACTOR: write failing test, watch it fail, write minimal code, watch it pass, then refactor.

6. **requesting-code-review** - Available for risky or broad changes. Reviews focused scope and reports issues by severity.

7. **finishing-a-development-branch** - Activates when tasks complete. Verifies tests, presents options (merge/PR/keep/discard), cleans up worktree.

**The agent triages each task before choosing workflow weight.** Skills scale up when risk justifies them.

## What's Inside

### Skills Library

**Testing**
- **test-driven-development** - RED-GREEN-REFACTOR cycle (includes testing anti-patterns reference)

**Debugging**
- **systematic-debugging** - 4-phase root cause process (includes root-cause-tracing, defense-in-depth, condition-based-waiting techniques)

**Collaboration** 
- **brainstorming** - Socratic design refinement
- **writing-plans** - Contract-based implementation plans
- **executing-plans** - Batch execution with checkpoints
- **requesting-code-review** - Pre-review checklist
- **using-git-worktrees** - Optional isolated development branches
- **finishing-a-development-branch** - Merge/PR decision workflow
- **subagent-driven-development** - Adaptive subagent execution and review

**Meta**
- **writing-skills** - Create new skills following best practices (includes testing methodology)
- **using-superpowers** - Introduction to the skills system

## Philosophy

- **Test-Driven Development** - Write tests first for behavior changes
- **Systematic over ad-hoc** - Process over guessing
- **Complexity reduction** - Simplicity as primary goal
- **Evidence over claims** - Verify before declaring success

## Contributing

The general contribution process for Superpowers is below. We accept new skills when they are broadly useful, well tested, and appropriate for all supported coding agents.

1. Fork the repository
2. Switch to the 'dev' branch
3. Create a branch for your work
4. Follow the `writing-skills` skill for creating and testing new and modified skills
5. Submit a PR, being sure to fill in the pull request template.

See `skills/writing-skills/SKILL.md` for the complete guide.

## Updating

Superpowers updates are somewhat coding-agent dependent, but are often automatic.

## License

MIT License - see LICENSE file for details

## Project

- **Issues**: https://github.com/alex-kinokon/reasonable-powers/issues
