# Agentic Marketplace

Claude Code plugin marketplace for spec-driven engineering (GoIT AI Agentic Engineering, L08).
Catalog UI: **https://stasexx.github.io/agentic-marketplace/** (reads this repo's manifests live).

| Plugin | What it gives you | Depends on |
|---|---|---|
| `sdd-engineering` | `/sdd-engineering:spec`, `/sdd-engineering:implement`, `spec-template` skill, `spec-writer` agent, version telemetry hook | `research-tools@^1.0.0`, `code-agents@^1.0.0` |
| `research-tools` | read-only `researcher` agent | — |
| `code-agents` | `implementer` agent | — |

## Install

```bash
claude plugin marketplace add stasexx/agentic-marketplace          # latest channel (main)
claude plugin install sdd-engineering@agentic-marketplace          # dependencies are installed too
claude plugin list --json
```

Project-level setup (commit it so the whole team gets the same plugin) — `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "agentic-marketplace": { "source": { "source": "github", "repo": "stasexx/agentic-marketplace", "ref": "stable" } }
  },
  "enabledPlugins": { "sdd-engineering@agentic-marketplace": true }
}
```

## Channels

| Channel | Git ref | Use |
|---|---|---|
| latest | `main` | newest released versions |
| stable | `stable` | the last version that passed the smoke eval in a real project — the rollback target |

See [docs/RELEASES.md](docs/RELEASES.md) for release, update and rollback, and [docs/COST-BASELINE.md](docs/COST-BASELINE.md) for the cost experiment.
