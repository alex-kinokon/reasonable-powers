#!/usr/bin/env bash
# Static regression checks for the lite workflow direction.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail() {
  echo "[FAIL] $*" >&2
  exit 1
}

pass() {
  echo "[PASS] $*"
}

removed_skills=(
  "skills/dispatching-"parallel-agents
  "skills/verification-"before-completion
  "skills/receiving-"code-review
)

removed_pattern="dispatching-"parallel-agents"|verification-"before-completion"|receiving-"code-review

for removed in "${removed_skills[@]}"; do
  [ ! -e "$removed" ] || fail "removed skill still exists: $removed"
done
pass "Removed orphan skills are absent"

if rg -n "$removed_pattern" \
  README.md skills docs/README.codex.md docs/testing.md scripts tests \
  >/tmp/superpowers-removed-skill-refs.txt
then
  cat /tmp/superpowers-removed-skill-refs.txt >&2
  fail "Removed skill references found"
fi
pass "Removed skill names are not referenced in active docs/tests"

if [ -e commands ]; then
  fail "legacy Claude command directory still exists"
fi

if rg -n '"commands"' .claude-plugin .cursor-plugin package.json >/tmp/superpowers-command-refs.txt; then
  cat /tmp/superpowers-command-refs.txt >&2
  fail "Plugin manifests still advertise commands"
fi
pass "Legacy command surface is absent"

heavy_bootstrap_patterns=(
  "1% "chance
  "ABSOLUTELY "MUST
  "IF A SKILL "APPLIES
  "mandatory "ceremony
  "Every project goes through this "process
)

for pattern in "${heavy_bootstrap_patterns[@]}"; do
  if rg -n "$pattern" \
    skills/using-superpowers/SKILL.md skills/brainstorming/SKILL.md README.md \
    >/tmp/superpowers-heavy-bootstrap.txt
  then
    cat /tmp/superpowers-heavy-bootstrap.txt >&2
    fail "Heavy bootstrap/brainstorming language found"
  fi
done
pass "Bootstrap and brainstorming stay triage-first"

heavy_execution_patterns=(
  "complete code in every "step
  "two-stage review after "each
  "fresh subagent per "task
  "review after EACH "task
  "After each task in subagent-driven "development
  "Review early, review "often
  "Activates between "tasks
  "Follow each step "exactly
  "plan has bite-sized "steps
  "implementer + 2 reviewers per "task
)

for pattern in "${heavy_execution_patterns[@]}"; do
  if rg -n "$pattern" \
    skills README.md docs/testing.md tests/claude-code tests/explicit-skill-requests \
    >/tmp/superpowers-heavy-execution.txt
  then
    cat /tmp/superpowers-heavy-execution.txt >&2
    fail "Heavy planning/execution language found"
  fi
done
pass "Planning and execution stay adaptive"

if ! rg -q "cachedBootstrapContent" .opencode/plugins/superpowers.js; then
  fail "OpenCode bootstrap cache missing"
fi
pass "OpenCode bootstrap cache present"

echo "Lite workflow static checks passed"
