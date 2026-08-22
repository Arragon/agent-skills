# Repository guidance

Treat `skills/<skill-name>/` as the only canonical source for every skill. Do not maintain duplicate copies under `.agents/`, `.claude/`, `.codex/`, or `.cursor/`; the installers materialize tool-specific copies.

Every skill directory must contain `SKILL.md`. Its YAML frontmatter must include `name` and `description`, and `name` must exactly match the directory name. Keep the main file focused and move detailed guidance into `references/`, reusable deterministic logic into `scripts/`, and output resources into `assets/`.

Use relative links within a skill and preserve cross-file references when moving files. Register each skill in `skills.json`. Run `python scripts/validate_skills.py` after adding, renaming, or editing a skill.

Keep installation behavior backward compatible. User-level and project-level installation must remain available on Windows PowerShell and macOS/Linux. Back up an existing installed skill before replacement.

## Cursor Cloud specific instructions

This repository has no third-party dependencies. Everything runs with the preinstalled Python 3 standard library and bash, so there is nothing to install.

- Validate / test (same check CI runs): `python3 scripts/validate_skills.py`. CI (`.github/workflows/validate.yml`) invokes it as `python` via `actions/setup-python`, but only `python3` is on PATH here — use `python3` locally.
- Run the installer (the "application"): `bash scripts/install.sh` (add `--scope project --project-dir <dir>` to install into a project instead of `$HOME`). It materializes per-tool copies under `.agents/skills/` and `.claude/skills/` (and `.cursor/skills/` for `--target cursor`); re-running renames any existing install to a timestamped `.backup.<ts>` before copying.
- `scripts/install.ps1` is the Windows PowerShell equivalent and is not exercised here (`pwsh` is not installed by default).
