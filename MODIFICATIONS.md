# Modifications

This repository is a locally maintained derivative workspace based on
`HKUDS/DeepTutor`.

## Current modification areas

- Added derivative-work attribution and compliance documents:
  - `NOTICE`
  - `MODIFICATIONS.md`
  - `THIRD_PARTY_LICENSES.md`
- Added a Windows installer packaging scaffold with explicit derivative-work
  disclosure, publisher metadata, and release-bundle compliance notes for
  future `setup.exe` builds.
- Replaced the repository communication note with a neutral local-workspace
  statement so the project is not presented as an official HKUDS community
  channel.
- Added a derivative-work notice to `README.md` to reduce confusion between the
  official upstream project and this local derivative workspace.
- Created local runtime configuration and validation notes for running the
  latest upstream `v1.0.2` in this workspace.

## Important current intent

- The runtime and feature chain of the upstream project should remain the
  primary baseline.
- Future customization is intended to focus first on:
  - branding shell
  - localization refinements
  - compliance and packaging clarity
- Functional changes should not be introduced casually. Any product-behavior
  divergence from upstream should be reviewed deliberately before implementation.

## Attribution note

Upstream-derived portions of the codebase remain subject to the original Apache
License 2.0 terms in `LICENSE`.

This file is informational and does not replace the upstream license.
