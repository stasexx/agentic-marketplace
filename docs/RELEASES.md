# Releases — versions, tags, channels, rollback

## Versioning
Each plugin has its own SemVer `version` in `plugins/<name>/.claude-plugin/plugin.json`. Users receive an update only when that field changes. Dependencies are released first, then the consumer.

## Release checklist
1. Change the plugin, update its `CHANGELOG.md`, bump `version`.
2. Add or update an eval for the new behaviour; run old + new cases: `claude plugin eval plugins/<name> --trust-plugin`.
3. Commit, then create an immutable tag `<plugin>-v<version>` and record the commit SHA below.
4. Push `main` (= **latest** channel). The catalog page picks the new version up automatically.
5. Move `stable` forward only after the smoke eval passed in a real installation.

## Channels
- **latest** — marketplace source ref `main`.
- **stable** — marketplace source ref `stable` (a branch that only moves forward to a verified release tag).

A project picks its channel in `.claude/settings.json` → `extraKnownMarketplaces.agentic-marketplace.source.ref`.

## Update and rollback
```bash
claude plugin marketplace update agentic-marketplace     # refresh the catalog
claude plugin update sdd-engineering@agentic-marketplace # update the installed plugin
```
### Rollback to the stable channel (verified on Claude Code 2.1.302)
`plugin update` never downgrades, and `marketplace update` keeps the ref the marketplace was added with, so a channel switch is a re-add:
```bash
claude plugin marketplace remove agentic-marketplace                                   # also uninstalls its plugins
claude plugin marketplace add "stasexx/agentic-marketplace#stable" --scope project     # clone at ref: stable
claude plugin install sdd-engineering@agentic-marketplace --scope project              # → 1.0.0 + dependencies
claude plugin list --json                                                              # sdd-engineering 1.0.0 enabled
scripts/eval-workflow.sh <project> smoke                                               # smoke must stay green
```
The project's `.claude/settings.json` then carries `"ref": "stable"`, so every teammate gets the verified version.

## Release log
| Tag | Commit | Notes |
|---|---|---|
| `research-tools--v1.0.0` | `b38be84` | read-only `researcher` agent |
| `code-agents--v1.0.0` | `b38be84` | `implementer` agent |
| `sdd-engineering--v1.0.0` | `b38be84` | `/spec`, `/implement`, `spec-template`, version telemetry; **`stable` points here** |
| `sdd-engineering--v1.1.0` | `ff51dda` | Risks & rollback + Given/When/Then; `spec-writer` on haiku (−55% cost, see COST-BASELINE) |
