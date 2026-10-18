#!/bin/bash
# Workflow eval for sdd-engineering, run in a real project where the plugin is installed WITH its dependencies
# (`claude plugin eval` loads only the plugin under test, so a plugin with `dependencies` cannot load there).
# usage: eval-workflow.sh <project-dir> <case: smoke|risks-rollback> [runs=1] [model=sonnet]
# Prints one line per run: case, run, cost_usd, active plugin versions (trace), gate verdict; exits 1 if any run fails.
set -u
dir=$1; case=$2; runs=${3:-1}; model=${4:-sonnet}; here=$(cd "$(dirname "$0")" && pwd)
case "$case" in
  smoke)          feature="Readers can filter the blog post list by tag"; flag="" ;;
  risks-rollback) feature="Authors can schedule a post to be published at a future date and time"; flag="--v1.1" ;;
  *) echo "unknown case: $case"; exit 2 ;;
esac
fail=0; cd "$dir"
for i in $(seq 1 "$runs"); do
  rm -rf docs/specs; out=$(mktemp)
  claude -p "/sdd-engineering:spec $feature" --model "$model" --permission-mode acceptEdits \
    --allowedTools "Read Glob Grep Write Skill Task Agent" --output-format stream-json --verbose > "$out" 2>/dev/null
  meta=$(python3 - "$out" <<'PY'
import json,sys
cost=0; vers=[]
for l in open(sys.argv[1]):
    try: o=json.loads(l)
    except ValueError: continue
    if o.get('type')=='system' and o.get('subtype')=='init':
        vers=['/'.join(p['path'].rstrip('/').split('/')[-2:]) for p in o.get('plugins',[]) if 'agentic-marketplace' in p.get('path','')]
    if o.get('type')=='result': cost=o.get('total_cost_usd') or 0
print(f"cost_usd={cost:.4f} active={','.join(vers)}")
PY
)
  spec=$(ls docs/specs/*.md 2>/dev/null | head -1)
  if gate=$("$here/spec-gate.sh" "${spec:-none}" $flag); then verdict="PASS"; else verdict="FAIL ($gate)"; fail=1; fi
  echo "case=$case run=$i $meta gate=$verdict"; rm -f "$out"
done
exit $fail
