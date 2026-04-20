# Installing Superpowers for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed

## Installation

Clone the repository and copy the skills into OpenCode's user skill path:

```bash
git clone https://github.com/alex-kinokon/reasonable-powers.git ~/.config/opencode/superpowers
mkdir -p ~/.config/opencode/skills
cp -R ~/.config/opencode/superpowers/skills/* ~/.config/opencode/skills/
```

Restart OpenCode. Skills load on demand through OpenCode's native `skill` tool.

Verify by asking: "Tell me about your superpowers"

## Migrating from the old symlink-based install

If you previously installed superpowers using `git clone` and symlinks, remove the old setup:

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

Use OpenCode's native `skill` tool:

```
use skill tool to list skills
use skill tool to load brainstorming
```

## Updating

Update the checkout and copy the skills again:

```bash
cd ~/.config/opencode/superpowers
git pull
cp -R ~/.config/opencode/superpowers/skills/* ~/.config/opencode/skills/
```

## Troubleshooting

### Skills not found

1. Use `skill` tool to list what's discovered
2. Check that `~/.config/opencode/skills/brainstorming/SKILL.md` exists
3. Restart OpenCode after copying or updating skills

### Tool mapping

When skills reference Claude Code tools:
- `TodoWrite` → `todowrite`
- `Task` with subagents → `@mention` syntax
- `Skill` tool → OpenCode's native `skill` tool
- File operations → your native tools

## Getting Help

- Report issues: https://github.com/alex-kinokon/reasonable-powers/issues
- Full documentation: https://github.com/alex-kinokon/reasonable-powers/blob/main/docs/README.opencode.md
