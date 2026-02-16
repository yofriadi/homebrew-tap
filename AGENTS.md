# AGENTS.md

Repository rules for humans and coding agents.

## Scope
These rules apply to the whole repository.

## CI/CD Rules
1. **Use PR-style publish flow only (no direct push publish).**
   - `.github/workflows/publish.yml` must not include a `push-publish` job.
   - Publishing is done via `pr-pull` only.
2. **Publish must be gated by successful CI first.**
   - `.github/workflows/publish.yml` is triggered by `workflow_run` from **Tap Homebrew CI**.
   - Expected order: `push`/`pull_request` → `Tap Homebrew CI` → `brew publish` (PR path only).
3. **Keep PR bottle flow working.**
   - Manual/PR `pr-pull` path in `publish.yml` must remain supported.
4. **Avoid duplicate publish runs.**
   - Keep workflow-level `concurrency` in `publish.yml` (`cancel-in-progress: true`).

## Formula Update Rules
1. For version bumps, update `url` + `sha256` together.
2. Remove stale `revision` on upstream version bumps unless explicitly needed.
3. Remove stale `bottle` blocks tied to old versions/revisions.
4. Run `brew audit --strict <tap/formula>` before finalizing changes.

## Branch Rules
- Primary branch is `master` (also keep compatibility with `main` where workflows already include it).

## Change Hygiene
- Keep changes minimal and scoped.
- Do not modify unrelated files.
- Prefer explicit commit messages (e.g. `weathr: bump to 1.3.0`, `ci: ...`).
