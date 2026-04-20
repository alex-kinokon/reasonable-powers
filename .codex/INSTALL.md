# Installing Superpowers for Codex

Enable superpowers skills in Codex via native skill discovery. Clone the repo,
copy the skills into Codex's user skills directory, then restart Codex.

## Prerequisites

- Git

## Installation

1. **Clone the superpowers repository:**
   ```bash
   git clone https://github.com/alex-kinokon/reasonable-powers.git ~/.codex/superpowers
   ```

2. **Copy the skills:**
   ```bash
   mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
   cp -R ~/.codex/superpowers/skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
   ```

3. **Restart Codex** (quit and relaunch the CLI) to discover the skills.

## Migrating from old bootstrap

If you installed superpowers before native skill discovery, you need to:

1. **Update the repo:**
   ```bash
   cd ~/.codex/superpowers && git pull
   ```

2. **Copy the skills** (step 2 above).

3. **Remove the old bootstrap block** from `~/.codex/AGENTS.md` — any block referencing `superpowers-codex bootstrap` is no longer needed.

4. **Restart Codex.**

## Verify

```bash
ls -la "${CODEX_HOME:-$HOME/.codex}/skills"
```

You should see the Superpowers skill directories.

## Updating

```bash
cd ~/.codex/superpowers && git pull
cp -R ~/.codex/superpowers/skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Restart Codex after updating.

## Uninstalling

```bash
rm -rf "${CODEX_HOME:-$HOME/.codex}/skills"/{brainstorming,executing-plans,finishing-a-development-branch,requesting-code-review,subagent-driven-development,systematic-debugging,test-driven-development,using-git-worktrees,using-superpowers,writing-plans,writing-skills}
```

Optionally delete the clone: `rm -rf ~/.codex/superpowers`.
