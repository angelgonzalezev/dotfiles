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
| Set up a new Mac or Linux machine faster | Providing an interactive installer and documented packages. |
| Keep terminal configuration versioned | Storing shared config in Git instead of only on one machine. |
| Work faster in the terminal | Providing Neovim, tmux, WezTerm, and Zsh defaults. |
| Avoid forgetting shortcuts | Documenting the most used commands per app. |
| Share improvements | Keeping the project open source and contribution-friendly. |

## Managed Apps

GNU Stow is the installation layer rather than an end-user configuration
package. Read its [application guide](/apps/stow) to understand how repository
files become live configuration.

| App | Package | Target | Main benefit |
| --- | --- | --- | --- |
| Neovim | `nvim` | Files inside `~/.config/nvim` | Fast keyboard-first editing and project search. |
| WezTerm | `wezterm` | `~/.config/wezterm/wezterm.lua` | Consistent terminal UI. |
| tmux | `tmux` | `~/.tmux.conf`, `~/.local/bin/tmux-*` | Persistent terminal workspaces. |
| Zsh | `zsh` | `~/.zshrc` | Shell prompt, history, and local command path. |

## How The Tools Work Together

| Layer | Tool | Responsibility |
| --- | --- | --- |
| Terminal application | WezTerm | Draw the terminal window, tabs, fonts, colors, and native shortcuts. |
| Interactive shell | Zsh | Read commands, manage history, render the prompt, and expose local scripts. |
| Persistent workspace | tmux | Keep sessions alive and organize shells into windows and panes. |
| Editor | Neovim | Edit files and search projects without leaving the terminal. |
| Link manager | GNU Stow | Connect files in this repository to their expected paths under `$HOME`. |

A typical session looks like this:

```text
Open WezTerm
  -> Zsh loads prompt, history, and ~/.local/bin
  -> run tmux-dev or tmux-agent
  -> open Neovim in one pane
  -> run tests, servers, or Git in the other panes
  -> detach from tmux and return later without losing the workspace
```

::: info Two different kinds of tabs
WezTerm tabs belong to the terminal application and disappear when the app
closes. tmux windows belong to a persistent tmux session and can survive a
closed terminal. Neovim's top bar shows editor buffers, which are open files.
:::

## How It Works

The repo uses GNU Stow. Each package mirrors the final path it should have from
`$HOME`.

```text
nvim/.config/nvim/init.lua       -> ~/.config/nvim/init.lua
wezterm/.config/wezterm/wezterm.lua -> ~/.config/wezterm/wezterm.lua
tmux/.tmux.conf           -> ~/.tmux.conf
tmux/.local/bin/          -> ~/.local/bin
zsh/.zshrc                -> ~/.zshrc
```

When installed, Stow creates file-level symlinks from your home directory to
this repo. That means the live config and the versioned config are the same
file, while unrelated files can remain in the surrounding directory.

::: info Why symlinks matter
If you edit `~/.tmux.conf`, you are really editing
`~/.config/dotfiles/tmux/.tmux.conf`. Git can then show, commit, and push that
change.
:::

## What Changes On Your Machine

Depending on what you choose during installation, the project can:

| Area | Possible change |
| --- | --- |
| Apps/tools | Install Stow, Neovim 0.10+, ripgrep, tmux, Zsh, WezTerm, a Nerd Font, Oh My Zsh, and suggestions. |
| Config files | Link `nvim`, `wezterm`, `tmux`, and `zsh` configs into your home directory. |
| Existing files | Move only conflicting destination files to `~/.config/bbldr/backups/dotfiles/<timestamp>/`. |
| Shell behavior | Add `~/.local/bin` to `PATH` and show the `👼` prompt icon. |
| tmux workflow | Add `tmux-dev` and `tmux-agent` workspace commands. |
| Safety | Record every target and provide a package-aware restore command. |

## Package Configuration Summary

| Package | Main configuration applied |
| --- | --- |
| `nvim` | Catppuccin theme, relative numbers, smart-case search, Snacks pickers, Lualine, and a custom buffer line. |
| `wezterm` | Nerd Font, Catppuccin colors, opacity, padding, native macOS controls, custom tabs, and tab navigation. |
| `tmux` | `Ctrl+a` prefix, pane/window shortcuts, Vi copy mode, persistent layouts, and a system status bar. |
| `zsh` | Oh My Zsh theme, angel prompt, shared history, Git plugin, suggestions, Homebrew activation, and local overrides. |

## Platform Support

| Platform | Automated dependencies | Config support |
| --- | --- | --- |
| macOS | Homebrew | Full |
| Ubuntu/Debian | APT and official releases | Full |
| Other Linux | Manual | Stow packages can be linked after dependencies are installed |

macOS-specific blur and title buttons are enabled only on macOS. Linux uses
portable WezTerm decorations and reads tmux system information from `/proc` and
`/sys` when available.

Exact tested versions and runtime boundaries are recorded in
[Compatibility](/getting-started/compatibility).

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
