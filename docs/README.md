# Documentation

Quick reference for the applications managed by this dotfiles repository.

## Applications

- [Neovim](nvim.md)
- [WezTerm](wezterm.md)

## Repository Commands

| Command | Purpose |
| --- | --- |
| `bin/dotfiles-status` | Show the Git status for this repository. |
| `bin/dotfiles-doctor` | Check basic dependencies, Git status, and tracked file names that may be sensitive. |
| `bin/dotfiles-install` | Link configured packages into `$HOME` with GNU Stow. Defaults to `nvim` and `wezterm`. |
| `bin/dotfiles-sync` | Show status and print the manual commit/push flow. |

## Install Layout

This repository uses GNU Stow package layout:

```text
nvim/.config/nvim/
wezterm/.config/wezterm/
```

From the repository root, `stow --target="$HOME" nvim` links
`~/.config/nvim` to the tracked Neovim package.
