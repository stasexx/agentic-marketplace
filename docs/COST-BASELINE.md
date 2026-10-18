# Cost baseline — sdd-engineering workflow

**Workflow under measurement:** `/sdd-engineering:spec "Readers can filter the blog post list by tag"`. It runs in a real project ([stasexx/quick-blog](https://github.com/stasexx/quick-blog)) where the plugin is installed from this marketplace together with its dependencies. In the workflow, the `researcher` (research-tools) gathers `path:line` facts, and `spec-writer` writes `docs/specs/<slug>.md`.

**Successful run:** `claude -p` ends with `success` **and** the spec passes the quality gate `scripts/spec-gate.sh`. The gate requires:
- every required section, in order;
- numbered requirements;
- a checklist of acceptance criteria.

Only successful runs count toward "cost per successful workflow".

**How it was measured:**
- `claude -p … --model sonnet --output-format stream-json`, reading `total_cost_usd` from the `result` event. That number is Claude Code's own cost estimate for the run, not a figure checked against billing.
- The active plugin versions are read from the same trace's `init.plugins` paths.
- Runner: `scripts/eval-workflow.sh <project> smoke <runs>`.
- Date: 2026-10-18, Claude Code 2.1.302.

## Baseline — sdd-engineering 1.0.0

| Run | Active versions (trace) | Cost USD | Gate |
|---|---|---|---|
| 1 | sdd-engineering/1.0.0, research-tools/1.0.0, code-agents/1.0.0 | 0.4034 | PASS |
| 2 | sdd-engineering/1.0.0, research-tools/1.0.0, code-agents/1.0.0 | 0.3572 | PASS |
| **Cost per successful workflow** | | **0.380** (2/2 successful) | |

## One optimization — shipped in 1.1.0

- `spec-writer` now runs on **`haiku`** (`model: haiku` in `agents/spec-writer.md`). Writing the spec produces most of the output tokens, and before this change it ran on the session model.
- The researcher is asked for **at most 12 findings**, so the spec is grounded in only the facts it needs. This is one line in `commands/spec.md`.

## After — sdd-engineering 1.1.0

| Run | Active versions (trace) | Cost USD | Gate |
|---|---|---|---|
| 1 | sdd-engineering/1.1.0, research-tools/1.0.0, code-agents/1.0.0 | 0.2042 | PASS |
| 2 | sdd-engineering/1.1.0, research-tools/1.0.0, code-agents/1.0.0 | 0.1404 | PASS |
| **Cost per successful workflow** | | **0.172** (2/2 successful) | |

**Result:** cost per successful workflow fell from **$0.380 to $0.172 (−55%)**. The success rate held at 100% (2/2 → 2/2).

## Quality gate (the optimization only stands if quality holds)

| Check | 1.0.0 | 1.1.0 |
|---|---|---|
| `smoke`: spec sections, numbered R#, checklist ACs | PASS 2/2 | PASS 2/2 |
| `risks-rollback`: new 1.1.0 behaviour (Risks & rollback, Given/When/Then) | n/a | PASS 1/1 ($0.2374) |
| `smoke` after rollback to the stable channel (active sdd-engineering/1.0.0) | PASS 1/1 ($0.2968) | — |

**Rule:** a cost optimization is released only if `smoke` and the cases for the new behaviour stay green. If they don't, revert it, or keep it on `main` without moving `stable`.

## Caveats

- Two runs per arm is a small sample: the 1.1.0 runs varied from $0.14 to $0.20. Treat −55% as a direction, not a precise number.
- 1.1.0 also adds a section to every spec, which costs tokens, so the saving is net of that.
- **Official eval runner:** `claude plugin eval` (Claude Code 2.1.302) loads only the plugin under test. A plugin with `dependencies` therefore cannot load in its sandbox and reports an "unmet dependency". The workflow eval runs instead in a real installation, where the dependencies are resolved.
