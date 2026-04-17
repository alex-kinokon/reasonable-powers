#!/usr/bin/env bash
# Test: subagent-driven-development skill
# Verifies that the skill is loaded and follows correct workflow
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: subagent-driven-development skill ==="
echo ""

# Test 1: Verify skill can be loaded
echo "Test 1: Skill loading..."

output=$(run_claude "What is the subagent-driven-development skill? Describe its key steps briefly." 30)

if assert_contains "$output" "subagent-driven-development\|Subagent-Driven Development\|Subagent Driven" "Skill is recognized"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Load Plan\|read.*plan\|extract.*tasks" "Mentions loading plan"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 2: Verify adaptive review order
echo "Test 2: Adaptive review ordering..."

output=$(run_claude "In the subagent-driven-development skill, when both spec compliance and code quality review are needed, what order should they run in?" 30)

if assert_order "$output" "spec.*compliance" "code.*quality" "Spec compliance before code quality"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 3: Verify self-review is mentioned
echo "Test 3: Self-review requirement..."

output=$(run_claude "Does the subagent-driven-development skill require implementers to do self-review? What should they check?" 30)

if assert_contains "$output" "self-review\|self review" "Mentions self-review"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "completeness\|Completeness" "Checks completeness"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 4: Verify plan is read once
echo "Test 4: Plan reading efficiency..."

output=$(run_claude "In subagent-driven-development, how many times should the controller read the plan file? When does this happen?" 30)

if assert_contains "$output" "once\|one time\|single" "Read plan once"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Step 1\|beginning\|start\|Load Plan" "Read at beginning"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 5: Verify review is risk-based
echo "Test 5: Risk-based review policy..."

output=$(run_claude "In subagent-driven-development, should every low-risk task receive both a spec compliance reviewer and a code quality reviewer? What review policy should be used?" 30)

if assert_contains "$output" "adaptive\|risk\|where.*risk\|review.*needed\|high-risk\|low-risk" "Mentions adaptive/risk-based review"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "spec.*before.*code.*quality\|spec compliance.*first\|scope.*before.*quality" "Keeps spec before quality when both are used"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 6: Verify focused re-review
echo "Test 6: Focused re-review requirements..."

output=$(run_claude "In subagent-driven-development, what happens if a reviewer finds Critical, Important, or Minor issues?" 30)

if assert_contains "$output" "Critical\|Important\|blocking\|fix.*re-review\|focused.*re-check" "Blocking issues get fixed and re-checked"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Minor\|non-blocking\|note\|cheap" "Minor issues are handled lightly"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 7: Verify full task text is provided
echo "Test 7: Task context provision..."

output=$(run_claude "In subagent-driven-development, how does the controller provide task information to the implementer subagent? Does it make them read a file or provide it directly?" 30)

if assert_contains "$output" "provide.*directly\|full.*text\|paste\|include.*prompt" "Provides text directly"; then
    : # pass
else
    exit 1
fi

if assert_not_contains "$output" "read.*file\|open.*file" "Doesn't make subagent read file"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 8: Verify worktree choice
echo "Test 8: Worktree choice..."

output=$(run_claude "What does subagent-driven-development say about using git worktrees before execution?" 30)

if assert_contains "$output" "ask\|optional\|consent\|preference\|project config\|user" "Worktree is choice/config driven"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 9: Verify main branch warning
echo "Test 9: Main branch red flag..."

output=$(run_claude "In subagent-driven-development, is it okay to start implementation directly on the main branch?" 30)

if assert_contains "$output" "worktree\|feature.*branch\|consent\|permission\|ask\|user" "Requires user consent or explicit branch choice"; then
    : # pass
else
    exit 1
fi

echo ""

echo "=== All subagent-driven-development skill tests passed ==="
