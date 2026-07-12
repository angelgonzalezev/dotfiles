#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_root="$(mktemp -d)"
trap 'rm -rf "$tmp_root"' EXIT

PATH="$repo_root/bin:$PATH"
export PATH

[ "$(bbldr version)" = "bbldr 0.1.0" ]
[ "$(bbldr dotfiles version)" = "bbldr dotfiles 0.2.0" ]
bbldr modules | grep -qx dotfiles
bbldr help | grep -q '^Usage: bbldr'
bbldr dotfiles help | grep -q '^Usage: bbldr dotfiles'
packages_output="$(bbldr dotfiles packages)"
printf '%s\n' "$packages_output" | grep -q '^nvim'

for command_name in install update status doctor packages backups restore uninstall scaffold check purge version help; do
  bbldr dotfiles "$command_name" --help | grep -q '^Usage: bbldr dotfiles'
done

for command_name in install update status doctor packages backups restore uninstall scaffold check purge version help; do
  if bbldr dotfiles "$command_name" --invalid >/dev/null 2>&1; then
    echo "$command_name must reject unknown options"
    exit 1
  fi
done

if bbldr missing-module >/dev/null 2>&1; then
  echo "unknown modules must fail"
  exit 1
fi

dry_home="$tmp_root/dry-home"
mkdir -p "$dry_home"
env HOME="$dry_home" BBLDR_DOTFILES_BACKUP_DIR="$dry_home/backups" BBLDR_ASSUME_YES=1 \
  "$repo_root/bin/bbldr-dotfiles" install --dry-run --config-only tmux >/dev/null
[ ! -e "$dry_home/.local/bin/bbldr" ]
[ ! -e "$dry_home/backups" ]

if env HOME="$dry_home" BBLDR_DOTFILES_BACKUP_DIR="$dry_home/.config/nvim/backups" BBLDR_ASSUME_YES=1 \
  "$repo_root/bin/bbldr-dotfiles" install --dry-run --config-only nvim >/dev/null 2>&1; then
  echo "backup directories must not overlap managed targets"
  exit 1
fi

escaped_home="$tmp_root/escaped-home"
escaped_target="$tmp_root/escaped-target"
mkdir -p "$escaped_home" "$escaped_target"
ln -s "$escaped_target" "$escaped_home/.config"
if env HOME="$escaped_home" BBLDR_DOTFILES_BACKUP_DIR="$escaped_home/backups" BBLDR_ASSUME_YES=1 \
  "$repo_root/bin/bbldr-dotfiles" install --dry-run --config-only nvim >/dev/null 2>&1; then
  echo "managed targets must not resolve outside HOME"
  exit 1
fi

dependency_plan="$(env HOME="$dry_home" BBLDR_DOTFILES_BACKUP_DIR="$dry_home/backups" BBLDR_ASSUME_YES=1 \
  "$repo_root/bin/bbldr-dotfiles" install --dry-run nvim)"
printf '%s\n' "$dependency_plan" | grep -q 'CLI tools: yes'
printf '%s\n' "$dependency_plan" | grep -q 'WezTerm: no'
printf '%s\n' "$dependency_plan" | grep -q 'Oh My Zsh: no'
[ ! -e "$dry_home/.local/bin/bbldr" ]
[ ! -e "$dry_home/backups" ]

collision_home="$tmp_root/collision-home"
mkdir -p "$collision_home/.local/bin"
printf '#!/usr/bin/env bash\n' > "$collision_home/.local/bin/bbldr"
chmod +x "$collision_home/.local/bin/bbldr"
if env HOME="$collision_home" BBLDR_ASSUME_YES=1 "$repo_root/bin/bbldr-dotfiles" install --dry-run --config-only tmux >/dev/null 2>&1; then
  echo "an unrelated bbldr command must not be overwritten"
  exit 1
fi

echo "CLI tests passed"
