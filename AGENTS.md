# AGENTS.md

Repository rules for humans and coding agents.

## Scope
These rules apply to the whole repository.

## CI/CD Rules
1. **Do not run publish directly on `push`.**
   - `.github/workflows/publish.yml` must be triggered by `workflow_run` from **Weathr Homebrew CI**.
2. **Publish must be gated by successful CI first.**
   - Expected order: `push` → `Weathr Homebrew CI` → `brew publish`.
3. **Avoid workflow loops.**
   - Keep bot-actor guards (e.g. skip when actor is `github-actions[bot]`) for push-publish paths.
4. **Keep PR bottle flow working.**
   - Manual/PR `pr-pull` path in `publish.yml` should remain supported.

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
