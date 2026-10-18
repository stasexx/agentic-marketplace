# sdd-engineering

Spec-driven engineering for Claude Code.

- `/sdd-engineering:spec <feature>` — `researcher` (research-tools) gathers `path:line` facts, `spec-writer` writes `docs/specs/<slug>.md` using the `spec-template` skill.
- `/sdd-engineering:implement <spec> <R#>` — hands one requirement to `implementer` (code-agents).
- Every session start appends `{"plugin":"sdd-engineering","version":…}` to `.claude/telemetry/sdd-engineering.jsonl` and tells the session which version is active.

Evals: `scripts/eval-workflow.sh <project> smoke|risks-rollback` — runs the real `/sdd-engineering:spec` in a project where the plugin is installed with its dependencies and checks the spec with `scripts/spec-gate.sh`.

## Install

```
/plugin install sdd-engineering --marketplace stasexx/agentic-marketplace
```
