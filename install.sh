#!/usr/bin/env bash
set -euo pipefail

repo_url="${BBLDR_DOTFILES_REPO_URL:-https://github.com/angelgonzalezev/dotfiles.git}"
repo_dir="${BBLDR_DOTFILES_DIR:-$HOME/.config/dotfiles}"
temporary_repo=""

cleanup() {
  [ -z "$temporary_repo" ] || rm -rf "$temporary_repo"
}
trap cleanup EXIT

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
  "$temporary_repo/repo/bin/bbldr-dotfiles" install "$@"
  exit
fi

if [ -d "$repo_dir/.git" ]; then
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
fi

exec "$repo_dir/bin/bbldr-dotfiles" install "$@"
