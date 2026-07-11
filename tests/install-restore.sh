#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_root="$(mktemp -d)"
trap 'rm -rf "$tmp_root"' EXIT

fixture_repo="$tmp_root/source"
mkdir -p "$fixture_repo"
COPYFILE_DISABLE=1 tar -C "$repo_root" --exclude=.git --exclude=node_modules --exclude=.tmp-tmux --exclude=docs/.vitepress/dist --exclude=docs/.vitepress/cache -cf - . | COPYFILE_DISABLE=1 tar -C "$fixture_repo" -xf -
git -C "$fixture_repo" init -q
git -C "$fixture_repo" add .
git -C "$fixture_repo" -c user.name=Dotfiles -c user.email=dotfiles@example.invalid commit -qm fixture

assert_link() { [ -L "$1" ] || { echo "expected symlink: $1"; exit 1; }; }
assert_file_text() { [ "$(cat "$1")" = "$2" ] || { echo "unexpected content: $1"; exit 1; }; }

run_bootstrap() {
  local home="$1" clone="$2"; shift 2
  env HOME="$home" DOTFILES_DIR="$clone" DOTFILES_BACKUP_DIR="$home/backups" DOTFILES_REPO_URL="$fixture_repo" PATH="$PATH" bash "$fixture_repo/bin/bootstrap" "$@"
}

home_clean="$tmp_root/home-clean"
run_bootstrap "$home_clean" "$tmp_root/clone-clean" tmux
first_restore_point="$(cat "$home_clean/backups/latest")"
assert_link "$home_clean/.tmux.conf"
assert_link "$home_clean/.local/bin/tmux-dev"
assert_link "$home_clean/.local/bin/tmux-agent"
assert_link "$home_clean/.local/bin/tmux-status"

run_bootstrap "$home_clean" "$tmp_root/clone-clean" tmux
[ "$(cat "$home_clean/backups/latest")" = "$first_restore_point" ]
grep -q $'managed\ttmux' "$home_clean/backups"/*/manifest.tsv
env HOME="$home_clean" DOTFILES_BACKUP_DIR="$home_clean/backups" "$tmp_root/clone-clean/bin/dotfiles-restore" --backup latest --yes tmux
[ ! -e "$home_clean/.tmux.conf" ] && [ ! -L "$home_clean/.tmux.conf" ]
[ ! -e "$home_clean/.local/bin/tmux-status" ] && [ ! -L "$home_clean/.local/bin/tmux-status" ]

home_nvim="$tmp_root/home-nvim"
mkdir -p "$home_nvim/.config/nvim/lua"
printf 'old init\n' > "$home_nvim/.config/nvim/init.lua"
printf 'local module\n' > "$home_nvim/.config/nvim/lua/local.lua"
run_bootstrap "$home_nvim" "$tmp_root/clone-nvim" nvim
assert_link "$home_nvim/.config/nvim/init.lua"
env HOME="$home_nvim" DOTFILES_BACKUP_DIR="$home_nvim/backups" "$tmp_root/clone-nvim/bin/dotfiles-restore" --backup latest --yes nvim
assert_file_text "$home_nvim/.config/nvim/init.lua" "old init"
assert_file_text "$home_nvim/.config/nvim/lua/local.lua" "local module"

home_restore="$tmp_root/home-restore"
mkdir -p "$home_restore/.local/bin"
printf 'old tmux\n' > "$home_restore/.tmux.conf"
printf 'old dev\n' > "$home_restore/.local/bin/tmux-dev"
printf 'old agent\n' > "$home_restore/.local/bin/tmux-agent"
printf 'old status\n' > "$home_restore/.local/bin/tmux-status"
run_bootstrap "$home_restore" "$tmp_root/clone-restore" tmux
env HOME="$home_restore" DOTFILES_BACKUP_DIR="$home_restore/backups" "$tmp_root/clone-restore/bin/dotfiles-restore" --backup latest --yes tmux
assert_file_text "$home_restore/.tmux.conf" "old tmux"
assert_file_text "$home_restore/.local/bin/tmux-status" "old status"

home_modified="$tmp_root/home-modified"
run_bootstrap "$home_modified" "$tmp_root/clone-modified" zsh
rm "$home_modified/.zshrc"
printf 'user change\n' > "$home_modified/.zshrc"
if env HOME="$home_modified" DOTFILES_BACKUP_DIR="$home_modified/backups" "$tmp_root/clone-modified/bin/dotfiles-restore" --backup latest --yes zsh; then
  echo "restore should reject modified files"
  exit 1
fi
assert_file_text "$home_modified/.zshrc" "user change"

if run_bootstrap "$tmp_root/home-invalid" "$tmp_root/clone-invalid" unknown; then
  echo "bootstrap should reject unknown packages"
  exit 1
fi

home_rollback="$tmp_root/home-rollback"
fake_bin="$tmp_root/fake-bin"
mkdir -p "$home_rollback" "$fake_bin"
printf 'original zsh\n' > "$home_rollback/.zshrc"
printf '%s\n' '#!/usr/bin/env bash' 'for argument in "$@"; do' '  if [ "$argument" = --simulate ]; then exit 0; fi' 'done' 'exit 1' > "$fake_bin/stow"
chmod +x "$fake_bin/stow"
if env HOME="$home_rollback" DOTFILES_DIR="$tmp_root/clone-rollback" DOTFILES_BACKUP_DIR="$home_rollback/backups" DOTFILES_REPO_URL="$fixture_repo" PATH="$fake_bin:$PATH" bash "$fixture_repo/bin/bootstrap" zsh; then
  echo "bootstrap should fail when Stow fails"
  exit 1
fi
assert_file_text "$home_rollback/.zshrc" "original zsh"
grep -q '^rolled-back$' "$home_rollback/backups"/*/status

echo "install/restore tests passed"
