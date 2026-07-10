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

Install only tmux:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- tmux
```

Install only Zsh:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- zsh
```

Install Oh My Zsh before installing the `zsh` package:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Before installing `zsh` on an existing machine, move local SDK paths, tokens,
and generated tool exports to `~/.zshrc.local`.

## What The Bootstrap Does

1. Checks that `git` exists.
2. Installs `stow` with Homebrew if it is missing.
3. Clones or updates the repo at `~/.config/dotfiles`.
4. Backs up existing config files and folders.
5. Links the selected packages into `$HOME`.

## Backups

Existing files and folders are moved to:

```text
~/.config/dotfiles-backups/
```

The bootstrap does not delete existing config files or folders.

## Manual Install

```sh
brew install stow
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
bin/dotfiles-install
```
