# Install

This page explains exactly how to install the project, what each mode does, and
what can change on your machine.

::: warning Review before installing
Dotfiles affect your shell, terminal, editor, and tmux workflow. The installer
backs up existing files before replacing them with symlinks, but you should
still read this page before running it on a machine with important local config.
:::

## Installation Layers

This project has two installation layers:

| Layer | Command | Purpose |
| --- | --- | --- |
| Bootstrap | `bin/bootstrap` | Installs optional apps/tools, clones or updates the repo, backs up existing files, and links packages. |
| Stow install | `bin/dotfiles-install` | Only links selected dotfiles packages into `$HOME`. |

Use `bootstrap` on a new machine. Use `dotfiles-install` when the repo already
exists locally and you only want to relink configuration files.

## Recommended Path

For a new user, the clearest path is:

1. Clone the repo.
2. Run the interactive bootstrap.
3. Answer each install question.
4. Open a new terminal.
5. Check the installed commands.

```sh
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
~/.config/dotfiles/bin/bootstrap
```

The installer will ask:

```text
Install CLI tools with Homebrew (stow, neovim, tmux)? [y/N]
Install WezTerm with Homebrew Cask? [y/N]
Install Oh My Zsh? [y/N]
Install zsh-autosuggestions? [y/N]
Install dotfiles packages (nvim wezterm tmux zsh)? [y/N]
```

::: tip Recommended answers for a fresh Mac
Answer `y` to every prompt if you want the complete workflow: editor, terminal,
tmux, shell prompt, suggestions, and linked config files.
:::

## Quick Install

Install the default configuration packages from any terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

This mode is intentionally conservative. Because the script is streamed through
standard input, it cannot reliably ask interactive questions. It installs the
default dotfiles packages and only installs `stow` if it is missing.

::: info Why this mode does not ask questions
`curl | bash` uses standard input to feed the script into Bash. Interactive
questions also need standard input. To avoid confusing behavior, the installer
only asks questions when it is run from a local file in a normal terminal.
:::

## Automatic Install

Run every install step without prompts:

```sh
DOTFILES_ASSUME_YES=1 ~/.config/dotfiles/bin/bootstrap
```

This mode can install:

```text
Homebrew
stow
neovim
tmux
WezTerm
Oh My Zsh
zsh-autosuggestions
dotfiles packages
```

Use it only when you are comfortable with the installer making all supported
changes.

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

## What Gets Linked

When all packages are selected, these links are created:

```text
~/.config/nvim/init.lua           -> ~/.config/dotfiles/nvim/.config/nvim/init.lua
~/.config/wezterm/wezterm.lua     -> ~/.config/dotfiles/wezterm/.config/wezterm/wezterm.lua
~/.tmux.conf                      -> ~/.config/dotfiles/tmux/.tmux.conf
~/.local/bin/tmux-dev             -> ~/.config/dotfiles/tmux/.local/bin/tmux-dev
~/.local/bin/tmux-agent           -> ~/.config/dotfiles/tmux/.local/bin/tmux-agent
~/.zshrc                          -> ~/.config/dotfiles/zsh/.zshrc
```

## What The Bootstrap Does

1. Checks that `git` exists.
2. Asks which optional apps/tools to install when running interactively.
3. Installs selected dependencies.
4. Installs `stow` if config packages are selected and `stow` is missing.
5. Clones or updates the repo at `~/.config/dotfiles`.
6. Backs up existing config files and folders.
7. Links the selected packages into `$HOME`.

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
~/.config/dotfiles-backups/<timestamp>/
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

::: warning Existing `.zshrc`
If you already have a large `.zshrc`, move machine-specific SDK paths, tokens,
and generated exports into `~/.zshrc.local` before installing the `zsh` package.
The tracked `.zshrc` loads `~/.zshrc.local` automatically.
:::

## Environment Variables

| Variable | Use |
| --- | --- |
| `DOTFILES_REPO_URL` | Override the Git repository URL. |
| `DOTFILES_DIR` | Override where the repo is cloned or updated. |
| `DOTFILES_BACKUP_DIR` | Override where existing files are backed up. |
| `DOTFILES_ASSUME_YES=1` | Accept every install prompt automatically. |

Example:

```sh
DOTFILES_DIR="$HOME/dev/dotfiles" ~/.config/dotfiles/bin/bootstrap
```

## Verify The Install

After installation, run:

```sh
ls -la ~/.zshrc
ls -la ~/.tmux.conf
command -v tmux-dev
command -v tmux-agent
```

You can also run the project doctor:

```sh
cd ~/.config/dotfiles
bin/dotfiles-doctor
```

## Manual Install

Manual install only links config files. It does not install apps or optional
dependencies.

```sh
brew install stow
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
bin/dotfiles-install
```
