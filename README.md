# dotfiles

My personal workspace for terminal setup, workflow, and documentation, built to
make development faster, cleaner, and easier to maintain.

Created by [Angel Gonzalez](https://www.youtube.com/@byangelgonzalez). Licensed
under MIT. See [LICENSE](LICENSE).

## What This Project Is

This is an open source dotfiles repository. It stores the configuration for the
tools I use to work in the terminal: Neovim, WezTerm, tmux, and Zsh.

The goal is to make a development machine reproducible. Instead of configuring
every app manually on every computer, the configuration lives in Git, can be
installed with scripts, and is documented in one place.

## What It Helps With

| Problem | Solution |
| --- | --- |
| Setting up a new Mac takes too long. | Bootstrap can install tools and link config files. |
| Terminal shortcuts are easy to forget. | The docs explain the commands used daily. |
| Config files drift between machines. | Shared config is versioned and symlinked with Stow. |
| Local machine config can leak into Git. | Local-only shell config lives in `~/.zshrc.local`. |
| Terminal work gets disorganized. | tmux layouts and WezTerm tabs create repeatable workspaces. |

## Managed Packages

| Package | Installs config for | Main benefit |
| --- | --- | --- |
| `nvim` | Neovim | Keyboard-first editor with project search and plugins. |
| `wezterm` | WezTerm | Terminal UI, tabs, theme, font, and navigation. |
| `tmux` | tmux | Persistent sessions, panes, and workspace layout commands. |
| `zsh` | Zsh / Oh My Zsh | Prompt, history, suggestions, and local command path. |

## Install

Install the default configuration packages from any terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

Run the interactive installer from a local clone:

```sh
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
~/.config/dotfiles/bin/bootstrap
```

The interactive installer can ask before installing CLI tools, WezTerm, Oh My
Zsh, `zsh-autosuggestions`, and the selected dotfiles packages.

Run every install step without prompts:

```sh
DOTFILES_ASSUME_YES=1 ~/.config/dotfiles/bin/bootstrap
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

## Documentation

Start here:

- [Docs index](docs/index.md)
- [Overview](docs/getting-started/overview.md)
- [Install](docs/getting-started/install.md)
- [Daily Workflow](docs/getting-started/daily-workflow.md)

Apps:

- [Neovim](docs/apps/nvim.md)
- [WezTerm](docs/apps/wezterm.md)
- [tmux](docs/apps/tmux.md)
- [Zsh](docs/apps/zsh.md)

Guides:

- [Backups and Restore](docs/guides/backups-and-restore.md)
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
zsh/
  .zshrc
bin/
  bootstrap
  dotfiles-doctor
  dotfiles-install
  dotfiles-status
  dotfiles-sync
```

## Manual Install

```sh
brew install stow
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
bin/dotfiles-install
```

This links:

```text
~/.config/nvim    -> ~/.config/dotfiles/nvim/.config/nvim
~/.config/wezterm -> ~/.config/dotfiles/wezterm/.config/wezterm
~/.tmux.conf      -> ~/.config/dotfiles/tmux/.tmux.conf
~/.local/bin/*    -> ~/.config/dotfiles/tmux/.local/bin/*
~/.zshrc          -> ~/.config/dotfiles/zsh/.zshrc
```

## Contributing

This is an open source project. You can fork it, adapt it, and propose changes
with pull requests.

Before publishing changes:

```sh
bin/dotfiles-doctor
npm run docs:build
git status --short
```

Do not commit credentials, tokens, local state, caches, logs, generated
dependency folders, or machine-specific private files.
