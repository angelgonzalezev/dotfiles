# dotfiles

My personal workspace for terminal setup, workflow, and documentation, built to
make development faster, cleaner, and easier to maintain.

Created by [Angel Gonzalez](https://www.youtube.com/@byangelgonzalez). Licensed
under MIT. See [LICENSE](LICENSE).

## What This Project Is

This is an open source dotfiles repository for macOS and Ubuntu/Debian. It
stores the configuration for the tools I use to work in the terminal: Neovim,
WezTerm, tmux, and Zsh.

The goal is to make a development machine reproducible. Instead of configuring
every app manually on every computer, the configuration lives in Git, can be
installed with scripts, and is documented in one place.

## What It Helps With

| Problem | Solution |
| --- | --- |
| Setting up a new machine takes too long. | Bootstrap can install tools and link config files on supported macOS and Linux systems. |
| Terminal shortcuts are easy to forget. | The docs explain the commands used daily. |
| Config files drift between machines. | Shared config is versioned and symlinked with Stow. |
| Local machine config can leak into Git. | Local-only shell config lives in `~/.zshrc.local`. |
| Terminal work gets disorganized. | tmux layouts and WezTerm tabs create repeatable workspaces. |

## Managed Packages

| Package | Installs config for | Main benefit |
| --- | --- | --- |
| `nvim` | Neovim 0.10+ and ripgrep | Keyboard-first editor with project search and plugins. |
| `wezterm` | WezTerm | Terminal UI, tabs, theme, font, and navigation. |
| `tmux` | tmux | Persistent sessions, panes, and workspace layout commands. |
| `zsh` | Zsh / Oh My Zsh | Prompt, history, suggestions, and local command path. |

## Install

Run the interactive installer from any terminal:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)"
```

The installer can ask before installing CLI tools, WezTerm, JetBrainsMono Nerd
Font, Oh My Zsh, `zsh-autosuggestions`, and selected dotfiles packages.

Install the default configuration packages without interactive prompts:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

Run every install step without prompts:

```sh
DOTFILES_ASSUME_YES=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)"
```

To install only one package:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- nvim
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- wezterm
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- tmux
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- zsh
```

Existing config files are backed up automatically to:

```text
~/.config/dotfiles-backups/
```

Restore the previous configuration at any time:

```sh
~/.config/dotfiles/bin/dotfiles-restore --backup latest
```

See the [complete install guide](docs/getting-started/install.md) for supported
systems, dependencies, safety behavior, and verification.

## Documentation

Start here:

- [Docs index](docs/index.md)
- [Overview](docs/getting-started/overview.md)
- [Install](docs/getting-started/install.md)
- [Daily Workflow](docs/getting-started/daily-workflow.md)

Apps:

- [GNU Stow](docs/apps/stow.md)
- [Neovim](docs/apps/nvim.md)
- [WezTerm](docs/apps/wezterm.md)
- [tmux](docs/apps/tmux.md)
- [Zsh](docs/apps/zsh.md)

Guides:

- [Backups and Restore](docs/guides/backups-and-restore.md)
- [Troubleshooting](docs/guides/troubleshooting.md)
- [Managing Configurations](docs/guides/managing-configurations.md)
- [macOS Terminal Shortcut](docs/guides/macos-terminal-shortcut.md)

## Layout

Packages are arranged for GNU Stow. Each package mirrors the target path from
`$HOME`.

```text
nvim/
  .config/
    nvim/
wezterm/
  .config/
    wezterm/
tmux/
  .tmux.conf
  .local/
    bin/
      tmux-agent
      tmux-dev
      tmux-status
zsh/
  .zshrc
bin/
  bootstrap
  dotfiles-check
  dotfiles-doctor
  dotfiles-install
  dotfiles-restore
  dotfiles-status
  dotfiles-sync
```

## Relink After Installation

After bootstrap runs once, the repo exists at `~/.config/dotfiles`. From there,
you can relink config files without downloading the installer again.

```sh
brew install stow
cd ~/.config/dotfiles
bin/dotfiles-install
```

This links:

```text
~/.config/nvim/init.lua       -> ~/.config/dotfiles/nvim/.config/nvim/init.lua
~/.config/wezterm/wezterm.lua -> ~/.config/dotfiles/wezterm/.config/wezterm/wezterm.lua
~/.tmux.conf                  -> ~/.config/dotfiles/tmux/.tmux.conf
~/.local/bin/tmux-*           -> ~/.config/dotfiles/tmux/.local/bin/tmux-*
~/.zshrc                      -> ~/.config/dotfiles/zsh/.zshrc
```

## Contributing

This is an open source project. You can fork it, adapt it, and propose changes
with pull requests.

Before publishing changes:

```sh
bin/dotfiles-doctor
bin/dotfiles-check
npm run docs:build
git status --short
```

Do not commit credentials, tokens, local state, caches, logs, generated
dependency folders, or machine-specific private files.
