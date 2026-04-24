Contributing to Bandu

Thank you for your interest in improving Bandu. This repository is a public
source snapshot of a Chinese-first learning workspace derived from
`HKUDS/DeepTutor`.

## Scope

- Use this repository for source changes, bug reports, and documentation fixes.
- Keep derivative-work attribution intact. Do not remove or rewrite
  `LICENSE`, `NOTICE`, `MODIFICATIONS.md`, or `THIRD_PARTY_LICENSES.md`.
- Avoid adding secrets, local logs, machine-specific paths, or packaged
  release artifacts.

## Before You Start

1. Fork the repository and clone your fork.
2. Create a feature branch from the default development branch used by the
   repository.
3. Read `README.md`, `NOTICE`, and `MODIFICATIONS.md` so changes stay aligned
   with the derivative-work obligations.

## Development Setup

### Python

```bash
python -m venv .venv
.venv\\Scripts\\activate
pip install -e ".[all]"
```

### Frontend

```bash
cd web
npm install
```

## Suggested Checks

Run the checks that match the area you changed:

```bash
pre-commit run --all-files
pytest
cd web && npm run build
```

If your environment does not support one of these commands, describe what you
were able to run in the pull request.

## Coding Expectations

- Prefer small, reviewable pull requests.
- Add or update tests when behavior changes.
- Keep user-facing naming consistent with the `Bandu` product brand unless a
  file is intentionally documenting upstream attribution.
- Use portable paths and avoid machine-specific absolute directories.
- Document any redistribution, packaging, or legal-impacting changes in
  `MODIFICATIONS.md` when appropriate.

## Security and Privacy

- Never commit API keys, tokens, `.env` files, or personal data.
- Do not include runtime caches, generated installers, local notebooks, or
  internal handoff notes.
- If you find a security issue, use the repository's private reporting path if
  one is available. Otherwise, contact the maintainer before public disclosure.

## Pull Requests

Please include:

- what changed
- why it changed
- how you tested it
- any follow-up work that remains

If your change affects licensing, bundled assets, branding, or redistribution,
call that out explicitly in the pull request summary.
