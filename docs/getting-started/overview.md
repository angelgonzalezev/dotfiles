# Overview

This repository stores personal configuration files for tools that should be
easy to reproduce on a new machine.

## Managed Apps

| App | Package | Target |
| --- | --- | --- |
| Neovim | `nvim` | `~/.config/nvim` |
| WezTerm | `wezterm` | `~/.config/wezterm` |
| tmux | `tmux` | `~/.tmux.conf`, `~/.local/bin/tmux-*` |
| Zsh | `zsh` | `~/.zshrc` |

## How It Works

The repo uses GNU Stow. Each package mirrors the path it should have from
`$HOME`.

```text
nvim/.config/nvim/
wezterm/.config/wezterm/
tmux/.tmux.conf
tmux/.local/bin/
zsh/.zshrc
```

When installed, Stow creates symlinks from your home directory to this repo.
That means edits made in the live config are versioned in Git.

## What Stays Out

Do not add credentials, tokens, caches, logs, local databases, or generated
dependency folders. The repo should only contain files that are safe to publish.
