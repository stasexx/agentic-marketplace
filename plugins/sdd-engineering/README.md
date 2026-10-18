# sdd-engineering

Spec-driven engineering for Claude Code.

- `/sdd-engineering:spec <feature>` — `researcher` (research-tools) gathers `path:line` facts, `spec-writer` writes `docs/specs/<slug>.md` using the `spec-template` skill.
- `/sdd-engineering:implement <spec> <R#>` — hands one requirement to `implementer` (code-agents).
- Every session start appends `{"plugin":"sdd-engineering","version":…}` to `.claude/telemetry/sdd-engineering.jsonl` and tells the session which version is active.

Evals: `claude plugin eval plugins/sdd-engineering` (cases in `evals/`).

## Install

```
/plugin install sdd-engineering --marketplace stasexx/agentic-marketplace
```
