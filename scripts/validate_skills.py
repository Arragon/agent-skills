#!/usr/bin/env python3
from __future__ import annotations

import json
import re
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
SKILLS_ROOT = REPO_ROOT / "skills"
MANIFEST_PATH = REPO_ROOT / "skills.json"
NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
LINK_RE = re.compile(r"\]\(([^)]+)\)")


def parse_frontmatter(skill_file: Path) -> dict[str, str]:
    text = skill_file.read_text(encoding="utf-8")
    lines = text.splitlines()
    if not lines or lines[0].strip() != "---":
        raise ValueError("missing opening YAML frontmatter marker")

    try:
        closing = next(i for i, line in enumerate(lines[1:], start=1) if line.strip() == "---")
    except StopIteration as exc:
        raise ValueError("missing closing YAML frontmatter marker") from exc

    values: dict[str, str] = {}
    for line in lines[1:closing]:
        match = re.match(r"^(name|description):\s*(.+?)\s*$", line)
        if match:
            values[match.group(1)] = match.group(2).strip().strip('"\'')
    return values


def validate_links(skill_dir: Path, skill_file: Path) -> list[str]:
    errors: list[str] = []
    text = skill_file.read_text(encoding="utf-8")
    for raw_target in LINK_RE.findall(text):
        target = raw_target.split("#", 1)[0].strip()
        if not target or "://" in target or target.startswith(("#", "mailto:")):
            continue
        resolved = (skill_dir / target).resolve()
        if skill_dir.resolve() not in resolved.parents and resolved != skill_dir.resolve():
            errors.append(f"{skill_file}: link escapes skill directory: {raw_target}")
        elif not resolved.exists():
            errors.append(f"{skill_file}: missing linked file: {raw_target}")
    return errors


def main() -> int:
    errors: list[str] = []
    if not MANIFEST_PATH.is_file():
        print("ERROR: skills.json is missing", file=sys.stderr)
        return 1

    manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
    manifest_entries = manifest.get("skills", [])
    manifest_names = {entry.get("name") for entry in manifest_entries}
    skill_dirs = sorted(path for path in SKILLS_ROOT.iterdir() if path.is_dir())
    directory_names = {path.name for path in skill_dirs}

    if manifest_names != directory_names:
        missing = sorted(directory_names - manifest_names)
        stale = sorted(manifest_names - directory_names)
        if missing:
            errors.append(f"skills.json missing entries: {', '.join(missing)}")
        if stale:
            errors.append(f"skills.json has stale entries: {', '.join(stale)}")

    for skill_dir in skill_dirs:
        skill_file = skill_dir / "SKILL.md"
        if not skill_file.is_file():
            errors.append(f"{skill_dir}: SKILL.md is missing")
            continue

        try:
            frontmatter = parse_frontmatter(skill_file)
        except ValueError as exc:
            errors.append(f"{skill_file}: {exc}")
            continue

        name = frontmatter.get("name", "")
        description = frontmatter.get("description", "")
        if name != skill_dir.name:
            errors.append(f"{skill_file}: name '{name}' does not match directory '{skill_dir.name}'")
        if not NAME_RE.fullmatch(name):
            errors.append(f"{skill_file}: invalid skill name '{name}'")
        if not description:
            errors.append(f"{skill_file}: description is missing")

        errors.extend(validate_links(skill_dir, skill_file))

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1

    print(f"Validated {len(skill_dirs)} skill(s): {', '.join(sorted(directory_names))}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
