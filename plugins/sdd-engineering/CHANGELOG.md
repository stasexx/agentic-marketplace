# Changelog — sdd-engineering

## 1.1.0
- New: specs carry a **Risks & rollback** section (≥2 risks with mitigations + one concrete rollback step).
- New: acceptance criteria are written as **Given / When / Then** and reference their requirement.
- Cost: `spec-writer` runs on `haiku`; the researcher is asked for at most 12 findings (see docs/COST-BASELINE.md).
- Eval case `risks-rollback` (scripts/eval-workflow.sh) covers the new behaviour; `smoke` unchanged.

## 1.0.0
- `/sdd-engineering:spec`: researcher → spec-writer → `docs/specs/<slug>.md`.
- `/sdd-engineering:implement`: hands one requirement to `implementer`.
- `spec-template` skill (Goal, Context, Requirements, Acceptance criteria, Out of scope, Open questions).
- SessionStart telemetry: active version → `.claude/telemetry/sdd-engineering.jsonl`.
- Eval case `smoke` (spec sections) via scripts/eval-workflow.sh.
- Depends on `research-tools@^1.0.0`, `code-agents@^1.0.0`.
