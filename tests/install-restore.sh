#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_root="$(mktemp -d)"
trap 'rm -rf "$tmp_root"' EXIT

fixture_repo="$tmp_root/repo"
mkdir -p "$fixture_repo"
COPYFILE_DISABLE=1 tar -C "$repo_root" --exclude=.git --exclude=node_modules --exclude=.tmp-tmux --exclude=docs/.vitepress/dist --exclude=docs/.vitepress/cache -cf - . | COPYFILE_DISABLE=1 tar -C "$fixture_repo" -xf -
export GIT_CONFIG_GLOBAL="$tmp_root/gitconfig"
git -C "$fixture_repo" init -q
git config --global --add safe.directory "$fixture_repo"
git -C "$fixture_repo" add .
git -C "$fixture_repo" -c user.name=Dotfiles -c user.email=dotfiles@example.invalid commit -qm fixture

assert_link() { [ -L "$1" ] || { echo "expected symlink: $1"; exit 1; }; }
assert_file_text() { [ "$(cat "$1")" = "$2" ] || { echo "unexpected content: $1"; exit 1; }; }

run_install() {
  local home="$1"; shift
  env HOME="$home" BBLDR_DOTFILES_BACKUP_DIR="$home/backups" BBLDR_ASSUME_YES=1 PATH="$PATH" \
    bash "$fixture_repo/bin/bbldr-dotfiles" install --config-only "$@"
}

run_restore() {
  local home="$1"; shift
  env HOME="$home" BBLDR_DOTFILES_BACKUP_DIR="$home/backups" PATH="$home/.local/bin:$PATH" \
    bash "$fixture_repo/bin/bbldr-dotfiles" restore --yes "$@"
}

installer_home="$tmp_root/home-installer"
mkdir -p "$installer_home"
env HOME="$installer_home" BBLDR_DOTFILES_REPO_URL="$fixture_repo" BBLDR_DOTFILES_DIR="$installer_home/repo" \
  BBLDR_DOTFILES_BACKUP_DIR="$installer_home/backups" BBLDR_ASSUME_YES=1 \
  bash "$fixture_repo/install.sh" --dry-run --config-only tmux >/dev/null
[ ! -e "$installer_home/repo" ]
[ ! -e "$installer_home/backups" ]
[ ! -e "$installer_home/.local/bin/bbldr" ]

home_clean="$tmp_root/home-clean"
run_install "$home_clean" tmux
first_restore_point="$(cat "$home_clean/backups/latest")"
assert_link "$home_clean/.tmux.conf"
assert_link "$home_clean/.local/bin/tmux-dev"
assert_link "$home_clean/.local/bin/tmux-agent"
assert_link "$home_clean/.local/bin/tmux-status"
[ -x "$home_clean/.local/bin/bbldr" ]
assert_link "$home_clean/.local/bin/bbldr-dotfiles"
env HOME="$home_clean" PATH="$home_clean/.local/bin:$PATH" bbldr dotfiles version | grep -q '0.2.0'
env HOME="$home_clean" PATH="/usr/bin:/bin" "$home_clean/.local/bin/bbldr" dotfiles version | grep -q '0.2.0'
env HOME="$home_clean" BBLDR_DOTFILES_BACKUP_DIR="$home_clean/backups" PATH="$home_clean/.local/bin:$PATH" \
  bbldr dotfiles status >/dev/null
env HOME="$home_clean" BBLDR_DOTFILES_BACKUP_DIR="$home_clean/backups" PATH="$home_clean/.local/bin:$PATH" \
  bbldr dotfiles backups | grep -q "$first_restore_point"
env HOME="$home_clean" BBLDR_DOTFILES_BACKUP_DIR="$home_clean/backups" PATH="$home_clean/.local/bin:$PATH" \
  bbldr dotfiles doctor tmux >/dev/null
[ "$(cat "$home_clean/backups/$first_restore_point/manifest-version")" = 2 ]

run_install "$home_clean" tmux
[ "$(cat "$home_clean/backups/latest")" = "$first_restore_point" ]
grep -q $'managed\ttmux' "$home_clean/backups"/*/manifest.tsv
run_restore "$home_clean" --backup "$first_restore_point" tmux
[ ! -e "$home_clean/.tmux.conf" ] && [ ! -L "$home_clean/.tmux.conf" ]
[ ! -e "$home_clean/.local/bin/tmux-status" ] && [ ! -L "$home_clean/.local/bin/tmux-status" ]

home_nvim="$tmp_root/home-nvim"
mkdir -p "$home_nvim/.config/nvim/lua"
printf 'old init\n' > "$home_nvim/.config/nvim/init.lua"
printf 'local module\n' > "$home_nvim/.config/nvim/lua/local.lua"
run_install "$home_nvim" nvim
assert_link "$home_nvim/.config/nvim/init.lua"
[ ! -L "$home_nvim/.config/nvim/lua/local.lua" ]
assert_file_text "$home_nvim/.config/nvim/lua/local.lua" "local module"
run_restore "$home_nvim" nvim
assert_file_text "$home_nvim/.config/nvim/init.lua" "old init"
assert_file_text "$home_nvim/.config/nvim/lua/local.lua" "local module"

home_restore="$tmp_root/home-restore"
mkdir -p "$home_restore/.local/bin"
printf 'old tmux\n' > "$home_restore/.tmux.conf"
printf 'old dev\n' > "$home_restore/.local/bin/tmux-dev"
printf 'old agent\n' > "$home_restore/.local/bin/tmux-agent"
printf 'old status\n' > "$home_restore/.local/bin/tmux-status"
run_install "$home_restore" tmux
run_restore "$home_restore" tmux
assert_file_text "$home_restore/.tmux.conf" "old tmux"
assert_file_text "$home_restore/.local/bin/tmux-status" "old status"

home_reconcile="$tmp_root/home-reconcile"
mkdir -p "$home_reconcile/.config/nvim"
printf 'personal file\n' > "$home_reconcile/.config/nvim/personal.lua"
run_install "$home_reconcile" nvim
mkdir -p "$fixture_repo/nvim/.config/nvim/lua"
printf 'return {}\n' > "$fixture_repo/nvim/.config/nvim/lua/new-feature.lua"
git -C "$fixture_repo" add nvim/.config/nvim/lua/new-feature.lua
git -C "$fixture_repo" -c user.name=Dotfiles -c user.email=dotfiles@example.invalid commit -qm 'add config file'
run_install "$home_reconcile" nvim
assert_link "$home_reconcile/.config/nvim/lua/new-feature.lua"
assert_file_text "$home_reconcile/.config/nvim/personal.lua" "personal file"
env HOME="$home_reconcile" BBLDR_DOTFILES_BACKUP_DIR="$home_reconcile/backups" PATH="$home_reconcile/.local/bin:$PATH" \
  bash "$fixture_repo/bin/bbldr-dotfiles" uninstall --yes nvim
[ ! -e "$home_reconcile/.config/nvim/lua/new-feature.lua" ]
assert_file_text "$home_reconcile/.config/nvim/personal.lua" "personal file"

remote_repo="$tmp_root/remote.git"
update_repo="$tmp_root/update-repo"
home_update="$tmp_root/home-update"
update_tools="$tmp_root/update-tools"
fixture_branch="$(git -C "$fixture_repo" branch --show-current)"
git clone -q --bare "$fixture_repo" "$remote_repo"
git clone -q "$remote_repo" "$update_repo"
mkdir -p "$update_tools"
printf '%s\n' '#!/usr/bin/env bash' 'exit 0' > "$update_tools/nvim"
printf '%s\n' '#!/usr/bin/env bash' 'exit 0' > "$update_tools/rg"
chmod +x "$update_tools/nvim" "$update_tools/rg"
env HOME="$home_update" BBLDR_DOTFILES_BACKUP_DIR="$home_update/backups" BBLDR_ASSUME_YES=1 PATH="$update_tools:$PATH" \
  bash "$update_repo/bin/bbldr-dotfiles" install --config-only nvim >/dev/null
assert_link "$home_update/.config/nvim/lua/new-feature.lua"
git -C "$fixture_repo" remote add test-origin "$remote_repo"
git -C "$fixture_repo" rm -q nvim/.config/nvim/lua/new-feature.lua
mkdir -p "$fixture_repo/nvim/.config/nvim/lua"
printf 'return { updated = true }\n' > "$fixture_repo/nvim/.config/nvim/lua/update-added.lua"
git -C "$fixture_repo" add nvim/.config/nvim/lua/update-added.lua
git -C "$fixture_repo" -c user.name=Dotfiles -c user.email=dotfiles@example.invalid commit -qm 'replace config file'
git -C "$fixture_repo" push -q test-origin "HEAD:$fixture_branch"
env HOME="$home_update" BBLDR_DOTFILES_BACKUP_DIR="$home_update/backups" PATH="$home_update/.local/bin:$update_tools:$PATH" \
  bash "$update_repo/bin/bbldr-dotfiles" update >/dev/null
[ ! -e "$home_update/.config/nvim/lua/new-feature.lua" ] && [ ! -L "$home_update/.config/nvim/lua/new-feature.lua" ]
assert_link "$home_update/.config/nvim/lua/update-added.lua"

home_uninstall="$tmp_root/home-uninstall"
mkdir -p "$home_uninstall"
printf 'original zsh\n' > "$home_uninstall/.zshrc"
run_install "$home_uninstall" zsh
env HOME="$home_uninstall" BBLDR_DOTFILES_BACKUP_DIR="$home_uninstall/backups" PATH="$home_uninstall/.local/bin:$PATH" \
  bash "$fixture_repo/bin/bbldr-dotfiles" uninstall --yes zsh
assert_file_text "$home_uninstall/.zshrc" "original zsh"
[ -x "$home_uninstall/.local/bin/bbldr" ]

home_modified="$tmp_root/home-modified"
run_install "$home_modified" zsh
rm "$home_modified/.zshrc"
printf 'user change\n' > "$home_modified/.zshrc"
if run_restore "$home_modified" zsh; then
  echo "restore should reject modified files"
  exit 1
fi
assert_file_text "$home_modified/.zshrc" "user change"

if run_install "$tmp_root/home-invalid" unknown; then
  echo "install should reject unknown packages"
  exit 1
fi

home_rollback="$tmp_root/home-rollback"
fake_bin="$tmp_root/fake-bin"
mkdir -p "$home_rollback" "$fake_bin"
printf 'original zsh\n' > "$home_rollback/.zshrc"
# shellcheck disable=SC2016 # The generated fake Stow script must receive literal "$@".
printf '%s\n' '#!/usr/bin/env bash' 'for argument in "$@"; do' '  if [ "$argument" = --simulate ]; then exit 0; fi' 'done' 'exit 1' > "$fake_bin/stow"
chmod +x "$fake_bin/stow"
if env HOME="$home_rollback" BBLDR_DOTFILES_BACKUP_DIR="$home_rollback/backups" BBLDR_ASSUME_YES=1 PATH="$fake_bin:$PATH" \
  bash "$fixture_repo/bin/bbldr-dotfiles" install --config-only zsh; then
  echo "install should fail when Stow fails"
  exit 1
fi
assert_file_text "$home_rollback/.zshrc" "original zsh"
grep -q '^rolled-back$' "$home_rollback/backups"/*/status

home_backup_failure="$tmp_root/home-backup-failure"
failing_bin="$tmp_root/failing-bin"
mkdir -p "$home_backup_failure/.local/bin" "$failing_bin"
printf 'old tmux\n' > "$home_backup_failure/.tmux.conf"
printf 'old dev\n' > "$home_backup_failure/.local/bin/tmux-dev"
printf 'old agent\n' > "$home_backup_failure/.local/bin/tmux-agent"
printf 'old status\n' > "$home_backup_failure/.local/bin/tmux-status"
# shellcheck disable=SC2016 # The generated mv wrapper needs literal shell expressions.
printf '%s\n' '#!/usr/bin/env bash' 'count_file="${BBLDR_TEST_MV_COUNT:?}"' 'count=0' '[ ! -f "$count_file" ] || count="$(cat "$count_file")"' 'count=$((count + 1))' 'printf "%s\n" "$count" > "$count_file"' '[ "$count" -ne 2 ] || exit 1' 'exec /bin/mv "$@"' > "$failing_bin/mv"
chmod +x "$failing_bin/mv"
if env HOME="$home_backup_failure" BBLDR_DOTFILES_BACKUP_DIR="$home_backup_failure/backups" BBLDR_TEST_MV_COUNT="$tmp_root/mv-count" BBLDR_ASSUME_YES=1 PATH="$failing_bin:$PATH" \
  bash "$fixture_repo/bin/bbldr-dotfiles" install --config-only tmux; then
  echo "install should roll back when a backup move fails"
  exit 1
fi
assert_file_text "$home_backup_failure/.tmux.conf" "old tmux"
assert_file_text "$home_backup_failure/.local/bin/tmux-dev" "old dev"
grep -q '^rolled-back$' "$home_backup_failure/backups"/*/status

home_remote="$tmp_root/home-remote"
mkdir -p "$home_remote"
env HOME="$home_remote" BBLDR_DOTFILES_REPO_URL="$fixture_repo" BBLDR_DOTFILES_DIR="$home_remote/repo" \
  BBLDR_DOTFILES_BACKUP_DIR="$home_remote/backups" BBLDR_ASSUME_YES=1 \
  bash "$fixture_repo/install.sh" --config-only tmux >/dev/null
assert_link "$home_remote/.tmux.conf"
[ -x "$home_remote/.local/bin/bbldr" ]
env HOME="$home_remote" BBLDR_DOTFILES_BACKUP_DIR="$home_remote/backups" PATH="$home_remote/.local/bin:$PATH" \
  bash "$home_remote/repo/bin/bbldr-dotfiles" purge --yes >/dev/null
[ ! -e "$home_remote/repo" ]
[ ! -e "$home_remote/.tmux.conf" ] && [ ! -L "$home_remote/.tmux.conf" ]
[ ! -e "$home_remote/.local/bin/bbldr" ]
[ -d "$home_remote/backups" ]

wrong_repo="$tmp_root/wrong-repo"
git clone -q "$fixture_repo" "$wrong_repo"
if env HOME="$tmp_root/home-wrong" BBLDR_DOTFILES_REPO_URL="$tmp_root/different-source" BBLDR_DOTFILES_DIR="$wrong_repo" \
  bash "$fixture_repo/install.sh" --dry-run --config-only tmux >/dev/null 2>&1; then
  echo "installer must reject a repository with an unexpected origin"
  exit 1
fi

bash "$fixture_repo/bin/bbldr-dotfiles" scaffold app sampleapp >/dev/null
grep -q $'^sampleapp\t' "$fixture_repo/config/packages.tsv"
grep -q $'^sampleapp\t.config/sampleapp\tsampleapp/.config/sampleapp$' "$fixture_repo/config/targets.tsv"
[ -d "$fixture_repo/sampleapp/.config/sampleapp" ]
[ -f "$fixture_repo/docs/apps/sampleapp.md" ]
if bash "$fixture_repo/bin/bbldr-dotfiles" scaffold app sampleapp >/dev/null 2>&1; then
  echo "scaffold must not overwrite an existing package"
  exit 1
fi

if env HOME="$home_clean" BBLDR_DOTFILES_BACKUP_DIR="$home_clean/backups" PATH="$home_clean/.local/bin:$PATH" \
  bash "$fixture_repo/bin/bbldr-dotfiles" restore --backup ../../outside --yes tmux >/dev/null 2>&1; then
  echo "restore must reject backup path traversal"
  exit 1
fi

tampered_id=20990101-010101
tampered_dir="$home_clean/backups/$tampered_id"
mkdir -p "$tampered_dir/files"
printf 'complete\n' > "$tampered_dir/status"
printf '2\n' > "$tampered_dir/manifest-version"
printf 'old value\n' > "$tampered_dir/files/original"
printf 'state\tpackage\ttarget\tsource\tbackup\n' > "$tampered_dir/manifest.tsv"
printf 'moved\ttmux\t%s/../outside\t%s/tmux/.tmux.conf\t%s/files/original\n' "$home_clean" "$fixture_repo" "$tampered_dir" >> "$tampered_dir/manifest.tsv"
if env HOME="$home_clean" BBLDR_DOTFILES_BACKUP_DIR="$home_clean/backups" PATH="$home_clean/.local/bin:$PATH" \
  bash "$fixture_repo/bin/bbldr-dotfiles" restore --backup "$tampered_id" --yes tmux >/dev/null 2>&1; then
  echo "restore must reject traversal inside manifest rows"
  exit 1
fi
if env HOME="$tmp_root/home-update" bash "$fixture_repo/bin/bbldr-dotfiles" update >/dev/null 2>&1; then
  echo "update should reject a dirty repository"
  exit 1
fi

echo "install, restore, and uninstall tests passed"
