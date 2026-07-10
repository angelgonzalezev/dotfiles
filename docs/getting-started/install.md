# Install

Install everything from any terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

Install only Neovim:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- nvim
```

Install only WezTerm:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- wezterm
```

## What The Bootstrap Does

1. Checks that `git` exists.
2. Installs `stow` with Homebrew if it is missing.
3. Clones or updates the repo at `~/.config/dotfiles`.
4. Backs up existing config folders.
5. Links the selected packages into `$HOME`.

## Backups

Existing folders are moved to:

```text
~/.config/dotfiles-backups/
```

The bootstrap does not delete existing config folders.

## Manual Install

```sh
brew install stow
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
bin/dotfiles-install
```
