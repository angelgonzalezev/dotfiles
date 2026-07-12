#!/usr/bin/env bash
set -euo pipefail

repo_url="${BBLDR_DOTFILES_REPO_URL:-https://github.com/angelgonzalezev/dotfiles.git}"
repo_dir="${BBLDR_DOTFILES_DIR:-$HOME/.config/dotfiles}"
temporary_repo=""

cleanup() {
  [ -z "$temporary_repo" ] || rm -rf "$temporary_repo"
}
trap cleanup EXIT

normalize_repo_url() {
  printf '%s\n' "$1" | sed -E 's#/$##; s#\.git$##'
}

validate_repository() {
  local directory="$1" origin
  [ -x "$directory/bin/bbldr-dotfiles" ] || { echo "Not a bbldr dotfiles repository: $directory" >&2; exit 1; }
  [ -f "$directory/config/packages.tsv" ] || { echo "Missing package registry: $directory" >&2; exit 1; }
  [ -f "$directory/VERSION" ] || { echo "Missing module version: $directory" >&2; exit 1; }
  origin="$(git -C "$directory" config --get remote.origin.url || true)"
  if [ "$(normalize_repo_url "$origin")" != "$(normalize_repo_url "$repo_url")" ]; then
    echo "Repository origin does not match the requested source: $directory" >&2
    echo "Expected: $repo_url" >&2
    echo "Found: ${origin:-none}" >&2
    exit 1
  fi
}

for command_name in git curl; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Missing required command: $command_name" >&2
    exit 1
  fi
done

dry_run=0
for argument in "$@"; do
  [ "$argument" = --dry-run ] && dry_run=1
done

if [ "$dry_run" = 1 ] && [ ! -d "$repo_dir/.git" ]; then
  temporary_repo="$(mktemp -d)"
  git clone --quiet "$repo_url" "$temporary_repo/repo"
  validate_repository "$temporary_repo/repo"
  "$temporary_repo/repo/bin/bbldr-dotfiles" install "$@"
  exit
fi

if [ -d "$repo_dir/.git" ]; then
  validate_repository "$repo_dir"
  if [ -n "$(git -C "$repo_dir" status --porcelain)" ]; then
    echo "The dotfiles repository has local changes: $repo_dir" >&2
    echo "Commit or move them before running the installer again." >&2
    exit 1
  fi
  git -C "$repo_dir" pull --ff-only
elif [ -e "$repo_dir" ]; then
  echo "Install path exists and is not a Git repository: $repo_dir" >&2
  exit 1
else
  mkdir -p "$(dirname "$repo_dir")"
  git clone "$repo_url" "$repo_dir"
  validate_repository "$repo_dir"
fi

exec "$repo_dir/bin/bbldr-dotfiles" install "$@"
