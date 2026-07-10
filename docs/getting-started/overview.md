# Overview

This repository stores a personal development environment as code. It is a
dotfiles project, which means it tracks configuration files that normally live
inside your home directory, such as `~/.zshrc`, `~/.tmux.conf`, and
`~/.config/nvim`.

The goal is not to install a random set of tools. The goal is to create a
repeatable workflow: open the terminal, navigate quickly, edit code efficiently,
keep long-running work alive, and document the shortcuts that matter.

::: tip Built by Angel Gonzalez
This is Angel Gonzalez's personal terminal and workflow setup. It is open
source so others can learn from it, adapt it, or contribute improvements.
:::

## Who This Is For

This project is useful if you:

| You want to... | This project helps by... |
| --- | --- |
| Set up a new Mac faster | Providing a bootstrap installer and documented packages. |
| Keep terminal configuration versioned | Storing shared config in Git instead of only on one machine. |
| Work faster in the terminal | Providing Neovim, tmux, WezTerm, and Zsh defaults. |
| Avoid forgetting shortcuts | Documenting the most used commands per app. |
| Share improvements | Keeping the project open source and contribution-friendly. |

## Managed Apps

| App | Package | Target | Main benefit |
| --- | --- | --- | --- |
| Neovim | `nvim` | `~/.config/nvim` | Fast keyboard-first editing. |
| WezTerm | `wezterm` | `~/.config/wezterm` | Consistent terminal UI. |
| tmux | `tmux` | `~/.tmux.conf`, `~/.local/bin/tmux-*` | Persistent terminal workspaces. |
| Zsh | `zsh` | `~/.zshrc` | Shell prompt, history, and local command path. |

## How It Works

The repo uses GNU Stow. Each package mirrors the final path it should have from
`$HOME`.

```text
nvim/.config/nvim/        -> ~/.config/nvim
wezterm/.config/wezterm/  -> ~/.config/wezterm
tmux/.tmux.conf           -> ~/.tmux.conf
tmux/.local/bin/          -> ~/.local/bin
zsh/.zshrc                -> ~/.zshrc
```

When installed, Stow creates symlinks from your home directory to this repo.
That means the live config and the versioned config are the same file.

::: info Why symlinks matter
If you edit `~/.tmux.conf`, you are really editing
`~/.config/dotfiles/tmux/.tmux.conf`. Git can then show, commit, and push that
change.
:::

## What Changes On Your Machine

Depending on what you choose during installation, the project can:

| Area | Possible change |
| --- | --- |
| Apps/tools | Install `stow`, `neovim`, `tmux`, WezTerm, Oh My Zsh, and `zsh-autosuggestions`. |
| Config files | Link `nvim`, `wezterm`, `tmux`, and `zsh` configs into your home directory. |
| Existing files | Move existing configs to `~/.config/dotfiles-backups/<timestamp>/`. |
| Shell behavior | Add `~/.local/bin` to `PATH` and show the `👼` prompt icon. |
| tmux workflow | Add `tmux-dev` and `tmux-agent` workspace commands. |

## What Stays Out

The repo intentionally avoids machine-specific or private state.

Do not commit:

```text
credentials
tokens
API keys
local databases
logs
caches
generated dependency folders
machine-specific SDK paths
```

Use `~/.zshrc.local` for private shell exports and machine-specific paths.

## Project Values

| Value | Meaning |
| --- | --- |
| Reproducible | A new machine should be easier to configure. |
| Documented | Shortcuts and install steps should be visible and searchable. |
| Conservative | Only curated, safe-to-publish config belongs in Git. |
| Open | People can fork the project or propose changes with pull requests. |
