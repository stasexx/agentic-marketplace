---
name: spec-template
description: Use whenever you write or review a feature spec (a request like "spec out", "write a spec", "/spec"). Defines the exact sections and rules of an sdd-engineering spec so every spec is reviewable the same way.
---

# Spec template (sdd-engineering)

A spec is Markdown with exactly these sections, in this order:

```
# Spec: <feature title>

## Goal
One or two sentences: the user-visible outcome.

## Context
What exists today, with `path:line` evidence from the codebase (from the researcher).

## Requirements
- R1 … — numbered, each one testable.

## Acceptance criteria
- [ ] AC1 (R1) Given <state>, when <action>, then <observable result>.
  Every requirement maps to at least one criterion; each is written as Given / When / Then.

## Out of scope
- What this spec deliberately does not cover.

## Risks & rollback
- Risk: <what can break> — Mitigation: <how we prevent or detect it>.
- Rollback: <the exact step that returns the system to the previous state> (feature flag, revert, down-migration…).

## Open questions
- Anything the human must decide (or "None").
```

Rules:
- No requirement without an acceptance criterion; no vague words ("fast", "nice") without a number.
- Context cites real files only — if the researcher found nothing, say so.
- Every acceptance criterion is Given / When / Then.
- Risks & rollback lists at least two risks with a mitigation each and one concrete rollback step.
- Keep it under ~90 lines; it is a contract, not an essay.
