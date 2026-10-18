---
description: Research the codebase and write a reviewable spec for a feature to docs/specs/<slug>.md
argument-hint: <feature request>
---

Feature request: $ARGUMENTS

Spec-driven workflow (sdd-engineering):

1. Delegate to the `researcher` agent (from research-tools): find the files, routes, models and tests this feature touches. Ask for `path:line` evidence and at most 12 findings — only what the spec needs.
2. Delegate to the `spec-writer` agent with the feature request and the researcher's findings. It writes `docs/specs/<slug>.md` following the `spec-template` skill.
3. Do NOT implement anything. Reply with the spec path, the list of requirement ids, and the line `sdd-engineering spec ready`.
