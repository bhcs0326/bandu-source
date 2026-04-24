# Third-Party Licenses

This file is a working checklist for third-party software, content, and service
dependencies that may matter when this derivative workspace is redistributed.

It is intentionally conservative: it helps reduce release risk, but it is not
legal advice.

## Upstream base project

- `HKUDS/DeepTutor`
  - Usage: upstream base project for this derivative workspace
  - Source: https://github.com/HKUDS/DeepTutor
  - License: Apache License 2.0
  - Required handling:
    - retain upstream `LICENSE`
    - keep attribution-related notices that still apply
    - mark modified files and derivative status when redistributing
    - avoid implying official endorsement

## Runtime dependency sets to review before any external release

- Python dependencies declared in:
  - `pyproject.toml`
  - `requirements/`
- Node dependencies declared in:
  - `web/package.json`
  - `web/package-lock.json`
- Frontend assets:
  - logos
  - icons
  - fonts
  - screenshots
  - illustrations
- Documentation assets and embedded media
- External model providers and API services configured through `.env`
- Search providers and content-ingestion services

## Release checklist

- Verify third-party package licenses are compatible with the intended
  distribution model.
- Verify any bundled fonts, icons, logos, images, and example assets are
  redistributable.
- Verify that any branding used in the derivative build is owned by you or is
  otherwise properly licensed.
- Verify external API usage complies with each provider's terms of service.
- Do not include secrets, local `.env` files, runtime caches, logs, or
  proprietary data in release bundles.
- Keep `LICENSE`, `NOTICE`, and `MODIFICATIONS.md` with any source distribution.
- If any upstream `NOTICE` file is introduced in future upstream releases,
  carry forward the required notice text when redistributing derivative builds.
