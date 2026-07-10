# Daily Workflow

## Update Local Configs

```sh
cd ~/.config/dotfiles
git pull --ff-only
```

## Edit Configs

After installation, these paths are symlinks into the repo:

```text
~/.config/nvim
~/.config/wezterm
```

Edit the live config normally. The changes will appear in the dotfiles repo.

## Save Changes

```sh
cd ~/.config/dotfiles
git status --short
git add -- <files>
git commit -m "Update dotfiles"
git push
```

## Check Before Publishing

```sh
bin/dotfiles-doctor
git status --short
```
