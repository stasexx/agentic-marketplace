#!/bin/sh
# Records which sdd-engineering version is active in this project (trace for releases/rollback)
# and tells the session about it. Reads the version from the installed plugin.json.
root="${CLAUDE_PLUGIN_ROOT:-$(dirname "$0")/..}"
version=$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' "$root/.claude-plugin/plugin.json" | head -n 1)
dir="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/telemetry"
mkdir -p "$dir" 2>/dev/null && printf '{"ts":"%s","plugin":"sdd-engineering","version":"%s","root":"%s"}\n' \
  "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$version" "$root" >> "$dir/sdd-engineering.jsonl"
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"sdd-engineering v%s is active."}}\n' "$version"
