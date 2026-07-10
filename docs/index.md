# dotfiles docs

Welcome to Angel Gonzalez's personal dotfiles project: an open source workspace
for terminal setup, development workflow, and living documentation.

This project exists to make a development machine easier to reproduce, faster
to use, and safer to maintain over time. It collects the configuration for the
tools used every day, documents how they work, and provides installation scripts
so the setup can be applied again on a new machine without rebuilding everything
from memory.

::: tip What this gives you
A consistent terminal, editor, shell, tmux workflow, and documentation site that
can be installed, reviewed, improved, and versioned through Git.
:::

## What Problem It Solves

| Problem | How this project helps |
| --- | --- |
| Recreating a development setup takes too long. | The installer links known-good config files from one repo. |
| Keyboard shortcuts are easy to forget. | Each app has a documentation page with the most used commands. |
| Local configuration gets messy over time. | Shared config is tracked; local-only config is kept out of Git. |
| Switching machines is painful. | The repo can be cloned and installed again with the same workflow. |
| Terminal work lacks structure. | tmux layouts, shell prompt, and WezTerm config provide a repeatable workspace. |

## What It Installs

The project currently manages these packages:

| Package | Tool | What it improves |
| --- | --- | --- |
| `nvim` | Neovim | Fast terminal-based code editing, search, buffers, theme, and plugins. |
| `wezterm` | WezTerm | Terminal UI, tabs, font, theme, opacity, and navigation shortcuts. |
| `tmux` | tmux | Persistent sessions, panes, windows, and reusable workspace layouts. |
| `zsh` | Zsh / Oh My Zsh | Prompt, history, suggestions, local command path, and local overrides. |

::: info Open source
This project is created and maintained by Angel Gonzalez. It is licensed under
MIT, so you can use it, adapt it, fork it, and contribute improvements through
pull requests.
:::

## Recommended Reading Path

Start here if you are new:

1. [Overview](getting-started/overview.md)
2. [Install](getting-started/install.md)
3. [Daily Workflow](getting-started/daily-workflow.md)
4. [Neovim](apps/nvim.md)
5. [WezTerm](apps/wezterm.md)
6. [tmux](apps/tmux.md)
7. [Zsh](apps/zsh.md)

## Getting Started

| Page | Use it for |
| --- | --- |
| [Overview](getting-started/overview.md) | Understand what this repo manages and why it exists. |
| [Install](getting-started/install.md) | Install the configurations, apps, and optional dependencies. |
| [Daily Workflow](getting-started/daily-workflow.md) | Update, edit, commit, and sync changes safely. |

## Guides

| Page | Use it for |
| --- | --- |
| [Managing Configurations](guides/managing-configurations.md) | Add, install, or remove packages from the repo. |
| [Backups and Restore](guides/backups-and-restore.md) | Understand backups and recover previous files. |
| [macOS Terminal Shortcut](guides/macos-terminal-shortcut.md) | Open WezTerm from commands and keyboard shortcuts. |

## Apps

| Page | Use it for |
| --- | --- |
| [Neovim](apps/nvim.md) | Keyboard shortcuts, plugins, UI notes, and daily editor commands. |
| [WezTerm](apps/wezterm.md) | Terminal shortcuts, tabs, panes, visual config, and macOS behavior. |
| [tmux](apps/tmux.md) | Sessions, panes, layout commands, and terminal workflow. |
| [Zsh](apps/zsh.md) | Shell prompt, Oh My Zsh, plugins, emoji prompt, and local overrides. |

## Reference

| Page | Use it for |
| --- | --- |
| [Repository Layout](reference/repository-layout.md) | Understand the folder structure and Stow targets. |
| [Commands](reference/commands.md) | See what each script and command does. |
| [Contributing](reference/contributing.md) | Learn how to propose changes safely. |

## Links

| Link | URL |
| --- | --- |
| GitHub | [github.com/angelgonzalezev/dotfiles](https://github.com/angelgonzalezev/dotfiles) |
| X / Twitter | [x.com/angelgonzaleh](https://x.com/angelgonzaleh) |
| YouTube | [youtube.com/@byangelgonzalez](https://www.youtube.com/@byangelgonzalez) |
