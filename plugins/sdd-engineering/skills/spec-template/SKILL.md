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
- [ ] AC1 … — measurable checks; every requirement maps to at least one.

## Out of scope
- What this spec deliberately does not cover.

## Open questions
- Anything the human must decide (or "None").
```

Rules:
- No requirement without an acceptance criterion; no vague words ("fast", "nice") without a number.
- Context cites real files only — if the researcher found nothing, say so.
- Keep it under ~80 lines; it is a contract, not an essay.
