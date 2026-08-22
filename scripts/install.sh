#!/usr/bin/env bash
set -euo pipefail

script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(dirname -- "$script_dir")"
skill_scope="user"
target="all"
project_dir="$(pwd)"
declare -a requested_skills=()

usage() {
  printf '%s\n' \
    "Usage: bash scripts/install.sh [options] [skill-name ...]" \
    "" \
    "Options:" \
    "  --scope user|project       Install globally or into one project (default: user)" \
    "  --target all|codex|claude|cursor" \
    "                             Select the host (default: all)" \
    "  --project-dir PATH         Project root for project scope (default: current directory)" \
    "  -h, --help                 Show this help"
}

while (($#)); do
  case "$1" in
    --scope)
      skill_scope="${2:?missing value for --scope}"
      shift 2
      ;;
    --target)
      target="${2:?missing value for --target}"
      shift 2
      ;;
    --project-dir)
      project_dir="${2:?missing value for --project-dir}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --*)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
    *)
      requested_skills+=("$1")
      shift
      ;;
  esac
done

case "$skill_scope" in
  user|project) ;;
  *) printf 'Invalid scope: %s\n' "$skill_scope" >&2; exit 2 ;;
esac

case "$target" in
  all|codex|claude|cursor) ;;
  *) printf 'Invalid target: %s\n' "$target" >&2; exit 2 ;;
esac

if ((${#requested_skills[@]} == 0)); then
  while IFS= read -r skill_dir; do
    requested_skills+=("$(basename -- "$skill_dir")")
  done < <(find "$repo_root/skills" -mindepth 1 -maxdepth 1 -type d | sort)
fi

if [[ "$skill_scope" == "user" ]]; then
  codex_root="${HOME}/.agents/skills"
  claude_root="${HOME}/.claude/skills"
  cursor_root="${HOME}/.cursor/skills"
else
  project_dir="$(CDPATH= cd -- "$project_dir" && pwd)"
  codex_root="$project_dir/.agents/skills"
  claude_root="$project_dir/.claude/skills"
  cursor_root="$project_dir/.cursor/skills"
fi

declare -a destination_roots=()
case "$target" in
  all) destination_roots+=("$codex_root" "$claude_root") ;;
  codex) destination_roots+=("$codex_root") ;;
  claude) destination_roots+=("$claude_root") ;;
  cursor) destination_roots+=("$cursor_root") ;;
esac

timestamp="$(date +%Y%m%d%H%M%S)"

for skill_name in "${requested_skills[@]}"; do
  source_dir="$repo_root/skills/$skill_name"
  if [[ ! -f "$source_dir/SKILL.md" ]]; then
    printf 'Skill not found or invalid: %s\n' "$skill_name" >&2
    exit 1
  fi

  for destination_root in "${destination_roots[@]}"; do
    mkdir -p "$destination_root"
    destination_dir="$destination_root/$skill_name"
    if [[ -e "$destination_dir" ]]; then
      backup_dir="${destination_dir}.backup.${timestamp}"
      mv -- "$destination_dir" "$backup_dir"
      printf 'Backed up %s to %s\n' "$destination_dir" "$backup_dir"
    fi
    cp -R -- "$source_dir" "$destination_dir"
    printf 'Installed %s to %s\n' "$skill_name" "$destination_dir"
  done
done
