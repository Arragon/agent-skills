# Repository guidance

Treat `skills/<skill-name>/` as the only canonical source for every skill. Do not maintain duplicate copies under `.agents/`, `.claude/`, `.codex/`, or `.cursor/`; the installers materialize tool-specific copies.

Every skill directory must contain `SKILL.md`. Its YAML frontmatter must include `name` and `description`, and `name` must exactly match the directory name. Keep the main file focused and move detailed guidance into `references/`, reusable deterministic logic into `scripts/`, and output resources into `assets/`.

Use relative links within a skill and preserve cross-file references when moving files. Register each skill in `skills.json`. Run `python scripts/validate_skills.py` after adding, renaming, or editing a skill.

Keep installation behavior backward compatible. User-level and project-level installation must remain available on Windows PowerShell and macOS/Linux. Back up an existing installed skill before replacement.
