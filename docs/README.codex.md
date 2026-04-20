# Superpowers for Codex

Guide for using Superpowers with OpenAI Codex via native skill discovery.

## Installation

### Prerequisites

- OpenAI Codex CLI
- Git

### Steps

1. Clone the repo:
   ```bash
   git clone https://github.com/alex-kinokon/reasonable-powers.git ~/.codex/superpowers
   ```

2. Copy the skills into Codex's user skills directory:
   ```bash
   mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
   cp -R ~/.codex/superpowers/skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
   ```

3. Restart Codex.

4. **For subagent skills** (optional): Skills like `subagent-driven-development` require Codex's multi-agent feature. Add to your Codex config:
   ```toml
   [features]
   multi_agent = true
   ```

## How It Works

Codex has native skill discovery. User-scoped skills install under
`$CODEX_HOME/skills`, which defaults to `~/.codex/skills`.

```
~/.codex/skills/<skill-name>/SKILL.md
```

The `using-superpowers` skill is discovered automatically and enforces skill usage discipline — no additional configuration needed.

## Usage

Skills are discovered automatically. Codex activates them when:
- You mention a skill by name (e.g., "use brainstorming")
- The task matches a skill's description
- The `using-superpowers` skill directs Codex to use one

### Personal Skills

Create your own skills in `${CODEX_HOME:-$HOME/.codex}/skills/`:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills/my-skill"
```

Create `${CODEX_HOME:-$HOME/.codex}/skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: Use when [condition] - [what it does]
---

# My Skill

[Your skill content here]
```

The `description` field is how Codex decides when to activate a skill automatically — write it as a clear trigger condition.

## Updating

```bash
cd ~/.codex/superpowers && git pull
cp -R ~/.codex/superpowers/skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Restart Codex after updating.

## Uninstalling

```bash
rm -rf ~/.codex/skills/{brainstorming,executing-plans,finishing-a-development-branch,requesting-code-review,subagent-driven-development,systematic-debugging,test-driven-development,using-git-worktrees,using-superpowers,writing-plans,writing-skills}
```

Optionally delete the clone: `rm -rf ~/.codex/superpowers`.

## Troubleshooting

### Skills not showing up

1. Check installed skills: `ls ~/.codex/skills`
2. Check source skills exist: `ls ~/.codex/superpowers/skills`
3. Restart Codex — skills are discovered at startup

## Getting Help

- Report issues: https://github.com/alex-kinokon/reasonable-powers/issues
- Main documentation: https://github.com/alex-kinokon/reasonable-powers
