# Third-Party Licenses

This document records the main third-party software, assets, and external
services that matter when this derivative repository is redistributed.

It is intentionally conservative. It is a practical release record for this
repository, not legal advice.

## Scope

This file currently covers:

- upstream base project attribution
- direct Python dependencies declared in `pyproject.toml` and `requirements/`
- direct Node.js dependencies declared in `web/package.json`
- visible branding and asset categories that should be reviewed before public
  release
- external API and service integrations that have separate terms of service

This file does not claim to be a full transitive dependency audit of every
package inside `package-lock.json`, every wheel, or every Docker layer.

## Upstream Base Project

- Project: `HKUDS/DeepTutor`
- Source: <https://github.com/HKUDS/DeepTutor>
- License: Apache License 2.0
- Handling required for redistribution:
  - keep upstream `LICENSE`
  - keep attribution-related notices that still apply
  - keep this repository's derivative-work notice and modifications record
  - avoid implying endorsement by HKUDS or The University of Hong Kong

## Direct Python Dependencies

The following entries are based on the dependency declarations in this
repository and package metadata reviewed on 2026-04-24.

| Package | Role | License |
|---|---|---|
| `python-dotenv` | env loading | BSD-3-Clause |
| `PyYAML` | YAML parsing | MIT |
| `Jinja2` | templating | BSD-style |
| `openai` | OpenAI SDK | Apache-2.0 |
| `tiktoken` | tokenization | MIT |
| `aiohttp` | async HTTP | Apache-2.0 AND MIT |
| `httpx` | HTTP client | BSD-3-Clause |
| `requests` | HTTP client | Apache-2.0 |
| `ddgs` | DuckDuckGo search client | MIT |
| `nest-asyncio` | event loop helper | BSD |
| `tenacity` | retry helper | Apache-2.0 |
| `pydantic` | data validation | MIT |
| `pydantic-settings` | settings management | MIT |
| `aiosqlite` | async SQLite | MIT |
| `typer` | CLI framework | MIT |
| `rich` | terminal UI | MIT |
| `prompt_toolkit` | interactive CLI | BSD-style |
| `anthropic` | Anthropic SDK | MIT |
| `dashscope` | DashScope SDK | Apache-2.0 |
| `perplexityai` | Perplexity client | Apache-2.0 |
| `oauth-cli-kit` | OAuth helper | MIT |
| `fastapi` | API framework | MIT |
| `uvicorn` | ASGI server | BSD-3-Clause |
| `websockets` | websocket runtime | BSD-3-Clause |
| `python-multipart` | file upload parsing | Apache-2.0 |
| `llama-index` | RAG framework | MIT |
| `numpy` | numerical routines | BSD-3-Clause with bundled subcomponents under additional permissive licenses |
| `arxiv` | arXiv API client | MIT |
| `pytest` | test framework | MIT |
| `pytest-asyncio` | async test support | Apache-2.0 |
| `pre-commit` | local dev tooling | MIT |
| `safety` | dependency audit tool | MIT |
| `bandit` | security linting | Apache-2.0 |
| `manim` | animation rendering | MIT |

## Python Dependency Requiring Special Attention

- `PyMuPDF`
  - Role: PDF parsing / ingestion
  - License reported by package metadata: `GNU AGPL 3.0 or Artifex Commercial License`
  - Why this matters:
    - this is not a simple permissive dependency like MIT or Apache-2.0
    - if this dependency is distributed or used in a way that triggers AGPL
      obligations, additional compliance work may be required
  - Release guidance:
    - do not assume it is safe just because the rest of the stack is permissive
    - review whether your public repository, packaged builds, and deployment
      model rely on `PyMuPDF`
    - if needed, replace it, isolate it, or obtain appropriate commercial
      licensing before a broader public release

## Direct Node.js Dependencies

The following entries are based on `web/package.json` and package metadata
reviewed on 2026-04-24.

| Package | Role | License |
|---|---|---|
| `chart.js` | charts | MIT |
| `clsx` | class merging helper | MIT |
| `cytoscape` | graph rendering | MIT |
| `framer-motion` | animation | MIT |
| `html2canvas` | DOM screenshot rendering | MIT |
| `i18next` | i18n core | MIT |
| `jspdf` | PDF export | MIT |
| `lucide-react` | icon components | ISC |
| `mermaid` | diagrams | MIT |
| `next` | web framework | MIT |
| `react` | UI library | MIT |
| `react-chartjs-2` | React chart binding | MIT |
| `react-dom` | React DOM runtime | MIT |
| `react-i18next` | React i18n binding | MIT |
| `react-markdown` | markdown rendering | MIT |
| `react-syntax-highlighter` | code highlighting | MIT |
| `rehype-katex` | KaTeX integration | MIT |
| `rehype-raw` | raw HTML support | MIT |
| `remark-gfm` | GFM markdown features | MIT |
| `remark-math` | math markdown features | MIT |
| `tailwind-merge` | class merge helper | MIT |
| `@playwright/test` | browser testing | Apache-2.0 |
| `@types/node` | TypeScript typings | MIT |
| `@types/react` | TypeScript typings | MIT |
| `@types/react-dom` | TypeScript typings | MIT |
| `@types/react-syntax-highlighter` | TypeScript typings | MIT |
| `autoprefixer` | CSS processing | MIT |
| `eslint` | linting | MIT |
| `eslint-config-next` | Next.js lint config | MIT |
| `postcss` | CSS pipeline | MIT |
| `tailwindcss` | CSS framework | MIT |
| `typescript` | type checker / compiler | Apache-2.0 |

## Assets, Branding, and Documentation Media

The repository includes visible non-code assets such as:

- logos
- icons
- screenshots
- GIF demos
- illustrations

These assets should not be assumed to inherit the same terms as the software
dependencies above.

Release guidance:

- confirm the `Bandu` branding assets are owned by you or are otherwise safe to
  redistribute
- confirm screenshots and GIFs do not reveal private data, unpublished product
  material, or third-party copyrighted content you do not want to publish
- if any inherited upstream artwork remains, verify that it is appropriate for
  redistribution in this derivative repository

## External Services and Terms

This codebase can be configured to talk to third-party services whose licenses
are separate from the source code license of this repository. Examples include:

- OpenAI
- Anthropic
- DashScope / Alibaba Cloud
- Perplexity
- Brave Search
- Tavily
- Jina
- arXiv

Release guidance:

- source redistribution of this repository does not grant rights to those
  external services
- each operator must supply their own credentials where required
- usage must comply with each provider's own API terms and policies

## What Must Stay in Source Redistribution

Keep these files with any public source distribution of this derivative
repository:

- `LICENSE`
- `NOTICE`
- `MODIFICATIONS.md`
- this `THIRD_PARTY_LICENSES.md`

## Remaining Review Recommended Before Public Release

- perform a deeper transitive dependency audit from `web/package-lock.json`
  and the resolved Python environment if you want a publication-grade license
  record
- re-check whether `PyMuPDF` is acceptable for your intended distribution model
- confirm all branding and image assets are redistributable
- do not include secrets, local `.env` files, runtime caches, logs, or private
  workspace records in public releases
