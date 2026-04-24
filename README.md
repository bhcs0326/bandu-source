<div align="center">

<img src="assets/bandu.png" alt="Bandu" width="144" style="border-radius: 18px;">

# Bandu

Chinese-first intelligent learning workspace derived from
[`HKUDS/DeepTutor`](https://github.com/HKUDS/DeepTutor).

[![Python 3.11+](https://img.shields.io/badge/Python-3.11%2B-3776AB?style=flat-square&logo=python&logoColor=white)](https://www.python.org/downloads/)
[![Next.js 16](https://img.shields.io/badge/Next.js-16-000000?style=flat-square&logo=next.js&logoColor=white)](https://nextjs.org/)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue?style=flat-square)](LICENSE)
[![Derivative Notice](https://img.shields.io/badge/Status-Non--official%20Derivative-1F6BB8?style=flat-square)](NOTICE)
[![Modifications](https://img.shields.io/badge/Changes-Tracked-2FA66A?style=flat-square)](MODIFICATIONS.md)

</div>

## Derivative Notice

This repository is a community-maintained derivative workspace. It is not an
official HKUDS release channel and should not be presented as one.

If you redistribute or further modify this repository:

- keep the upstream `LICENSE`
- keep and review `NOTICE`
- keep and update `MODIFICATIONS.md`
- review `THIRD_PARTY_LICENSES.md`
- avoid implying endorsement by HKUDS or The University of Hong Kong

## What This Repository Contains

- Python backend source under `deeptutor/`
- CLI source under `deeptutor_cli/`
- Next.js frontend source under `web/`
- packaging scripts under `packaging/`
- tests and public documentation

Internal handoff notes, local packaging logs, machine-specific caches, and
private workspace traces are intentionally excluded from this public snapshot.

## Quick Start

### Backend

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -e ".[all]"
```

### Frontend

```bash
cd web
npm install
npm run build
```

### Run the app

```bash
python scripts/start_tour.py
```

Or follow the local setup guides in:

- `docs/`
- `docs/zh/`
- `assets/README/README_CN.md`

## Open Source Files

Please keep these files with any source redistribution:

- `LICENSE`
- `NOTICE`
- `MODIFICATIONS.md`
- `THIRD_PARTY_LICENSES.md`

## Contributing

See `CONTRIBUTING.md` for contribution expectations, testing guidance, and
public-repo safety rules.

## Open Source Readiness

This directory was prepared as a public-source snapshot separate from the main
development workspace and the release-packaging copy.

See `OPEN_SOURCE_READINESS.md` for the cleanup summary and final checks that
should be completed before publishing the repository.
