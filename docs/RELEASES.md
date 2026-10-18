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
Rollback = switch the project's marketplace ref to `stable`, refresh the catalog, update the plugin → it returns to the verified version; then run the smoke eval.

## Release log
| Tag | Commit | Notes |
|---|---|---|
