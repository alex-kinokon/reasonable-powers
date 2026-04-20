# Superpowers for OpenCode

Complete guide for using Superpowers with [OpenCode.ai](https://opencode.ai).

## Installation

Clone the repository and copy the skills into OpenCode's user skill path:

```bash
git clone https://github.com/alex-kinokon/reasonable-powers.git ~/.config/opencode/superpowers
mkdir -p ~/.config/opencode/skills
cp -R ~/.config/opencode/superpowers/skills/* ~/.config/opencode/skills/
```

Restart OpenCode. Skills load on demand through OpenCode's native `skill` tool.

Verify by asking: "Tell me about your superpowers"

### Migrating from the old symlink-based install

If you previously installed superpowers using symlinks or a local plugin, remove the old setup:

```bash
# Remove old symlinks
rm -f ~/.config/opencode/plugins/superpowers.js
rm -rf ~/.config/opencode/skills/superpowers

# Optionally remove the cloned repo
rm -rf ~/.config/opencode/superpowers

# Remove skills.paths from opencode.json if you added one for superpowers
```

Then follow the installation steps above.

## Usage

### Finding Skills

Use OpenCode's native `skill` tool to list all available skills:

```
use skill tool to list skills
```

### Loading a Skill

```
use skill tool to load brainstorming
```

### Personal Skills

Create your own skills in `~/.config/opencode/skills/`:

```bash
mkdir -p ~/.config/opencode/skills/my-skill
```

Create `~/.config/opencode/skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: Use when [condition] - [what it does]
---

# My Skill

[Your skill content here]
```

### Project Skills

Create project-specific skills in `.opencode/skills/` within your project.

**Skill Priority:** Project skills > Personal skills > Superpowers skills

## Updating

Update the checkout and copy the skills again:

```bash
cd ~/.config/opencode/superpowers
git pull
cp -R ~/.config/opencode/superpowers/skills/* ~/.config/opencode/skills/
```

## How It Works

The install copies skill directories into OpenCode's user skill path:

```
~/.config/opencode/skills/<skill-name>/SKILL.md
```

### Tool Mapping

Skills written for Claude Code are automatically adapted for OpenCode:

- `TodoWrite` → `todowrite`
- `Task` with subagents → OpenCode's `@mention` system
- `Skill` tool → OpenCode's native `skill` tool
- File operations → Native OpenCode tools

## Troubleshooting

### Skills not found

1. Use OpenCode's `skill` tool to list available skills
2. Check that `~/.config/opencode/skills/brainstorming/SKILL.md` exists
3. Each skill needs a `SKILL.md` file with valid YAML frontmatter
4. Restart OpenCode after copying or updating skills

## Getting Help

- Report issues: https://github.com/alex-kinokon/reasonable-powers/issues
- Main documentation: https://github.com/alex-kinokon/reasonable-powers
- OpenCode docs: https://opencode.ai/docs/
