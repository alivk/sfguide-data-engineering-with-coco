#!/bin/bash
# validate-bash.sh — PreToolUse hook for the bash tool.
# Blocks any dbt command that targets production directly.

INPUT=$(cat)

if command -v jq >/dev/null 2>&1; then
  COMMAND=$(printf '%s' "$INPUT" | jq -r '.tool_input.command // empty')
else
  COMMAND=$(printf '%s' "$INPUT" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))')
fi

# Only police dbt invocations.
if [[ ! "$COMMAND" =~ (^|[[:space:];&|])dbt([[:space:]]|$) ]]; then
  exit 0
fi

# Match --target prod, --target=prod, -t prod, and -t=prod (also the "production" spelling).
if [[ "$COMMAND" =~ (--target|-t)[[:space:]]*=?[[:space:]]*prod(uction)?([[:space:]]|$) ]]; then
  cat >&2 <<'EOF'
Blocked: direct production dbt runs are not allowed.

This command targets the prod environment (--target prod). Running dbt against
production from a local machine bypasses code review and leaves no audit trail.

Use the CI/CD pipeline instead: open a PR from a feature/<description> branch and
let the pipeline deploy to prod after merge to main.

To validate locally, run the same command against the dev target, for example:
  dbt build --project-dir dbt/
EOF
  exit 2
fi

exit 0
