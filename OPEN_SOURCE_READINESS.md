# Open Source Readiness

This directory is a public-source preparation snapshot created from the legacy
Bandu/DeepTutor-1.0.2 main workspace.

It is intentionally separate from the packaging/release copy so public cleanup
does not affect release work.

## What has already been cleaned

- removed internal handoff and memory notes under `docs/workspace_notes/`
- removed local frontend build output under `web/.next/`
- removed `web/node_modules/`
- removed `web/.env.local`
- removed `deeptutor.egg-info/`
- removed local agent and browser-tool traces
- removed `__pycache__`, `*.pyc`, and `*.pyo`
- updated `README.md` so it no longer links to internal-only notes
- updated `.gitignore` to keep internal traces and local files out of Git
- rewrote `CONTRIBUTING.md` for a public derivative repository
- replaced Windows packaging scripts with public-safe versions that no longer
  hard-code local machine paths

## Files that should remain in the public repository

- `LICENSE`
- `NOTICE`
- `MODIFICATIONS.md`
- `THIRD_PARTY_LICENSES.md`
- source code under `deeptutor/`, `deeptutor_cli/`, and `web/`
- documentation that does not expose internal paths or private process notes

## Checks still recommended before publishing

- verify that all redistributed logos, icons, screenshots, and bundled images
  are owned by you or are otherwise safe to redistribute
- complete the package-level review referenced by `THIRD_PARTY_LICENSES.md`
- confirm `README.md` rendering and text encoding look correct on GitHub
- review `.github/` workflows and issue templates before making the repo public
- confirm there are no secrets in historical commits if this directory is
  initialized as a fresh Git repository

## Current release judgment

This directory is much closer to public-safe than the original main workspace
or packaging copy. It is suitable as the basis for a GitHub source repository,
but it should still receive one final human review for branding assets,
third-party license completeness, and README display quality before being made
public.
