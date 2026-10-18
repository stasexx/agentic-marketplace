#!/bin/sh
# Quality gate for an sdd-engineering spec: required sections in order, numbered requirements, checklist ACs.
# usage: spec-gate.sh <spec.md> [--v1.1]   (--v1.1 also requires "Risks & rollback" and Given/When/Then ACs)
f="$1"; [ -f "$f" ] || { echo "FAIL no spec file: $f"; exit 1; }
fail=0
for s in "## Goal" "## Context" "## Requirements" "## Acceptance criteria" "## Out of scope" "## Open questions"; do
  grep -q "^$s" "$f" || { echo "FAIL missing section: $s"; fail=1; }
done
grep -Eq '^- \*?\*?R1' "$f" || grep -Eq 'R1[ .:)]' "$f" || { echo "FAIL no numbered requirement R1"; fail=1; }
grep -q -- '- \[ \]' "$f" || { echo "FAIL acceptance criteria are not a checklist"; fail=1; }
if [ "$2" = "--v1.1" ]; then
  grep -q "^## Risks & rollback" "$f" || { echo "FAIL missing section: ## Risks & rollback"; fail=1; }
  grep -Eqi 'given .* when .* then' "$f" || { echo "FAIL acceptance criteria not in Given/When/Then"; fail=1; }
fi
[ $fail -eq 0 ] && echo "PASS $f"; exit $fail
