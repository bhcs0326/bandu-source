# Windows Release Checklist

This checklist is for producing a non-official derivative `setup.exe` build of Bandu based on `HKUDS/DeepTutor`.

## Identity and attribution

- Present the build as a non-official derivative, not an official HKUDS or DeepTutor release.
- Keep the publisher metadata aligned with the actual distributor:
  - Publisher: `于大治`
  - Contact: `36034729@qq.com`
- Preserve upstream attribution to `HKUDS/DeepTutor`.

## Required files to ship with the installer

- `LICENSE`
- `NOTICE`
- `MODIFICATIONS.md`
- `THIRD_PARTY_LICENSES.md`
- `packaging/windows/INSTALLER_NOTICE.txt`
- `.env.example`
- `.env.example_CN`

## Do not bundle

- `.env`
- `data/`
- `output/`
- `.codex_logs/`
- `web/.next/cache/`
- local secrets, API keys, user chats, notebooks, memories, or logs

## Asset and branding review

- Reconfirm all bundled logos, icons, fonts, screenshots, and illustrations are safe to redistribute.
- Avoid any wording that implies official HKUDS, DeepTutor, Data Intelligence Lab, or HKU endorsement.
- If a specific logo asset is not clearly owned or licensed for redistribution, replace it before release.

## Build inputs

- Re-run the production frontend build before packaging.
- Stage only the release bundle that is intended for end users.
- Ensure the staged app can run without relying on local development paths.

## Before public release

- Verify third-party dependency licenses for the exact bundle contents.
- Verify any external provider integrations comply with their service terms.
- Test install, launch, uninstall, and legal-file visibility on a clean Windows machine.
- If the release is public, publish the source and derivative notices alongside the binary release.
