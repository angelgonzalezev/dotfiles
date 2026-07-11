# Install

This guide explains the supported systems, every installation mode, what the
installer changes, and how to recover if the result is not right for you.

::: warning Read before running remote scripts
The bootstrap can install software and replace terminal configuration with
symlinks. Read the prompts and review the
[restore guide](/guides/backups-and-restore) before using automatic mode.
:::

## Supported Systems

| System | Support | Dependency manager |
| --- | --- | --- |
| macOS | Fully supported and tested | Homebrew |
| Ubuntu 22.04/24.04 | Fully supported and tested | APT plus official releases when needed |
| Debian 12/13 | Supported | APT plus official releases when needed |
| Other Linux distributions | Config linking only | Install dependencies manually |

The installer supports Intel/AMD 64-bit and ARM64 machines. Windows is not
currently supported.

## Recommended Interactive Install

Run this from any directory:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)"
```

The script asks before each group of changes:

```text
Install CLI tools (stow, Neovim, tmux, ripgrep and Zsh)? [y/N]
Install WezTerm? [y/N]
Install JetBrainsMono Nerd Font? [y/N]
Install Oh My Zsh? [y/N]
Install zsh-autosuggestions? [y/N]
Install dotfiles packages (nvim wezterm tmux zsh)? [y/N]
```

Answer `y` to all prompts for the complete environment. On Linux, package
installation may request your `sudo` password. The installer does not change
your default login shell automatically.

## Automatic Install

Install every supported dependency and configuration without questions:

```sh
DOTFILES_ASSUME_YES=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)"
```

Use this only when you accept all the changes listed below.

## Config-Only Install

Streaming a script through standard input leaves no input available for
questions. This form installs selected configurations and Stow if required,
but skips optional application groups:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

## Select Packages

Available packages are `nvim`, `wezterm`, `tmux`, and `zsh`.

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- nvim
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- tmux zsh
```

Use selected packages with interactive dependency prompts:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)" -- nvim tmux
```

Unknown package names are rejected before any files are changed.

## What Gets Installed

| Dependency | Why it is needed |
| --- | --- |
| Git and curl | Download the repository, plugins, and official installers. |
| GNU Stow | Create and remove managed symlinks. |
| Neovim 0.10+ | Run the Lua editor configuration and current plugins. |
| ripgrep | Power `Space f g` project search in Neovim. |
| tmux | Persistent sessions, windows, panes, and predefined layouts. |
| Zsh | Run the shared shell configuration. |
| WezTerm | Provide the configured terminal interface. |
| JetBrainsMono Nerd Font | Render text and status icons correctly. |
| Oh My Zsh | Provide the prompt theme and plugin framework. |
| zsh-autosuggestions | Suggest commands from shell history. |

On macOS, Homebrew is installed when required and activated immediately with
`brew shellenv`. On Ubuntu/Debian, old distribution versions of Neovim are
replaced by an official current release under `~/.local/opt/nvim`.

WezTerm on Ubuntu/Debian is installed from its official APT repository. The
Nerd Font is installed in the user font directory, not system-wide.

## What Gets Linked

Stow uses `--no-folding`, so directories remain real directories and the
managed files inside them are symlinks:

```text
~/.config/nvim/init.lua       -> <repo>/nvim/.config/nvim/init.lua
~/.config/nvim/lazy-lock.json -> <repo>/nvim/.config/nvim/lazy-lock.json
~/.config/wezterm/wezterm.lua -> <repo>/wezterm/.config/wezterm/wezterm.lua
~/.tmux.conf                  -> <repo>/tmux/.tmux.conf
~/.local/bin/tmux-dev         -> <repo>/tmux/.local/bin/tmux-dev
~/.local/bin/tmux-agent       -> <repo>/tmux/.local/bin/tmux-agent
~/.local/bin/tmux-status      -> <repo>/tmux/.local/bin/tmux-status
~/.zshrc                      -> <repo>/zsh/.zshrc
```

## What Each Package Configures

| Package | User-visible result |
| --- | --- |
| `nvim` | Editor appearance, search shortcuts, plugin manager, statusline, and open-buffer line. |
| `wezterm` | Terminal font, colors, opacity, padding, title buttons, tab appearance, and custom tab navigation. |
| `tmux` | Prefix, panes, windows, copy mode, status bar, and the `tmux-dev`, `tmux-agent`, and `tmux-status` commands. |
| `zsh` | Prompt, history, Git integration, suggestions, `PATH`, Homebrew activation, and private local override loading. |

Installing a configuration package does not imply that its application is
installed. Choose the dependency prompts on a new machine, or install the apps
manually before using config-only mode.

## Safety And Idempotency

Before linking anything, bootstrap:

1. Validates package names and required commands.
2. Clones or fast-forwards the repository.
3. Creates a timestamped installation record.
4. Detects paths already linked to this repository.
5. Moves conflicting user configuration into the backup.
6. Simulates Stow before making changes.
7. Links all selected packages.
8. Rolls moved files back automatically if linking fails.

Running bootstrap again does not back up correctly managed links as if they
were user files. It records them as `managed` and leaves them in place.

## Installation Records

Every config installation creates:

```text
~/.config/dotfiles-backups/<timestamp>/manifest.tsv
~/.config/dotfiles-backups/<timestamp>/status
~/.config/dotfiles-backups/latest
```

The manifest records `absent`, `managed`, or `moved` for each target. `latest`
contains the most recent successful installation that actually changed a
target. An idempotent reinstall does not replace the previous restore point.

At the end, bootstrap prints the exact restore command for that run.

## Custom Locations

| Variable | Default | Purpose |
| --- | --- | --- |
| `DOTFILES_REPO_URL` | GitHub repository | Use a fork or local Git repository. |
| `DOTFILES_DIR` | `~/.config/dotfiles` | Choose where the repo is stored. |
| `DOTFILES_BACKUP_DIR` | `~/.config/dotfiles-backups` | Choose where installation records live. |
| `DOTFILES_ASSUME_YES=1` | `0` | Accept all dependency and config prompts. |

```sh
DOTFILES_DIR="$HOME/dev/dotfiles" DOTFILES_BACKUP_DIR="$HOME/dotfiles-backups" bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)"
```

## Verify Installation

Open a new shell, then run:

```sh
~/.config/dotfiles/bin/dotfiles-doctor
command -v nvim tmux rg wezterm tmux-dev tmux-agent tmux-status
```

If the repository uses a custom location, run its `bin/dotfiles-doctor`.

::: tip Next steps
Continue with the [daily workflow](/getting-started/daily-workflow), or open
[troubleshooting](/guides/troubleshooting) if any check fails.
:::
