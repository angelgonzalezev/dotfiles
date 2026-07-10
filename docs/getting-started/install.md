# Install

This project has two installation layers:

| Layer | Command | Purpose |
| --- | --- | --- |
| Bootstrap | `bin/bootstrap` | Installs optional apps/tools, clones or updates the repo, backs up existing files, and links packages. |
| Stow install | `bin/dotfiles-install` | Only links selected dotfiles packages into `$HOME`. |

Use `bootstrap` on a new machine. Use `dotfiles-install` when the repo already
exists locally and you only want to relink configuration files.

## Quick Install

Install the default packages from any terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

This mode is intentionally conservative: because the script is received through
standard input, it cannot reliably ask interactive questions. It installs the
default dotfiles packages and only installs `stow` if it is missing.

## Interactive Install

Clone the repo first, then run the installer from a normal terminal:

```sh
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
~/.config/dotfiles/bin/bootstrap
```

The interactive installer asks before installing each optional dependency group:

```text
Install CLI tools with Homebrew (stow, neovim, tmux)? [y/N]
Install WezTerm with Homebrew Cask? [y/N]
Install Oh My Zsh? [y/N]
Install zsh-autosuggestions? [y/N]
Install dotfiles packages (nvim wezterm tmux zsh)? [y/N]
```

Answer `y` only for the parts you want the installer to change.

## Automatic Install

Run every install step without prompts:

```sh
DOTFILES_ASSUME_YES=1 ~/.config/dotfiles/bin/bootstrap
```

This can install Homebrew-managed packages, WezTerm, Oh My Zsh,
`zsh-autosuggestions`, and the dotfiles packages.

## Package Selection

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

From a local clone:

```sh
~/.config/dotfiles/bin/bootstrap nvim tmux zsh
```

## Zsh Requirements

The `zsh` package works without Oh My Zsh, but it is designed to use Oh My Zsh
when available.

Install Oh My Zsh manually:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Before installing `zsh` on an existing machine, move local SDK paths, tokens,
and generated tool exports to `~/.zshrc.local`.

## What The Bootstrap Does

1. Checks that `git` exists.
2. Optionally installs tools and apps.
3. Installs `stow` with Homebrew if configs are selected and it is missing.
4. Clones or updates the repo at `~/.config/dotfiles`.
5. Backs up existing config files and folders.
6. Links the selected packages into `$HOME`.

## Installed Dependencies

When selected interactively, bootstrap can install:

| Dependency | Method | Used by |
| --- | --- | --- |
| Homebrew | Official installer | Package manager for macOS dependencies. |
| `stow` | `brew install stow` | Symlink management. |
| `neovim` | `brew install neovim` | Neovim config. |
| `tmux` | `brew install tmux` | tmux config and workspace scripts. |
| WezTerm | `brew install --cask wezterm` | Terminal app. |
| Oh My Zsh | Official install script | Zsh prompt and plugin framework. |
| `zsh-autosuggestions` | Git clone into Oh My Zsh custom plugins | Shell suggestions. |

## Backups

Existing files and folders are moved to:

```text
~/.config/dotfiles-backups/
```

The bootstrap does not delete existing config files or folders.

Example backup paths:

```text
~/.config/dotfiles-backups/<timestamp>/.config/nvim
~/.config/dotfiles-backups/<timestamp>/.config/wezterm
~/.config/dotfiles-backups/<timestamp>/.tmux.conf
~/.config/dotfiles-backups/<timestamp>/.local/bin/tmux-dev
~/.config/dotfiles-backups/<timestamp>/.local/bin/tmux-agent
~/.config/dotfiles-backups/<timestamp>/.zshrc
```

## Environment Variables

| Variable | Use |
| --- | --- |
| `DOTFILES_REPO_URL` | Override the Git repository URL. |
| `DOTFILES_DIR` | Override where the repo is cloned or updated. |
| `DOTFILES_BACKUP_DIR` | Override where existing files are backed up. |
| `DOTFILES_ASSUME_YES=1` | Accept every install prompt automatically. |

## Manual Install

```sh
brew install stow
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
bin/dotfiles-install
```

Manual install does not install apps or dependencies beyond what you install
yourself.
