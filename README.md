# dotfiles

An open source terminal workspace created by Angel Gonzalez to make development
faster, cleaner, reproducible, and easier to maintain.

It installs and documents an opinionated configuration for Neovim, WezTerm,
tmux, and Zsh on macOS and Ubuntu/Debian. GNU Stow links the tracked files into
the user's home directory without copying them.

Created by [Angel Gonzalez](https://www.youtube.com/@byangelgonzalez) and
licensed under the [MIT License](LICENSE).

## What It Solves

| Problem | How this workspace helps |
| --- | --- |
| Rebuilding a terminal setup takes time. | One installer applies the complete environment. |
| Existing configuration could be lost. | Conflicts are backed up before links are created. |
| Terminal commands are easy to forget. | The documentation records the actual shortcuts and workflows. |
| Config drifts between computers. | Shared files remain versioned in Git and linked with Stow. |
| Recovery is unclear. | Every installation produces a manifest that supports safe restore and uninstall. |
| Contributors repeat manual steps. | A package registry, scaffold command, tests, and agent skills define the workflow. |

## Install

Run the interactive installer from any directory:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)"
```

The installer detects the platform, asks which dependencies to install, shows
every target and backup action, and requests a final confirmation.

Preview the same plan without changing the system:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)" -- --dry-run
```

After installation, the workspace can be managed from any directory:

```sh
bbldr dotfiles status
bbldr dotfiles doctor
bbldr dotfiles update
bbldr dotfiles backups
bbldr dotfiles restore --backup latest
```

Existing configuration is stored under:

```text
~/.config/bbldr/backups/dotfiles/
```

Read the [complete installation guide](docs/getting-started/install.md) before
using automatic mode on a machine with an existing terminal setup.

## What Gets Configured

| Package | Result |
| --- | --- |
| `nvim` | Neovim plugins, project search, navigation, buffers, statusline, and common editing shortcuts. |
| `wezterm` | Terminal theme, font, opacity, padding, title controls, tabs, and keyboard navigation. |
| `tmux` | Prefix, windows, panes, persistent sessions, layouts, status bar, and helper commands. |
| `zsh` | Prompt, shared history, suggestions, Homebrew activation, local commands, and private overrides. |

The installer can also install GNU Stow, Neovim 0.10+, ripgrep, tmux, Zsh,
WezTerm, JetBrainsMono Nerd Font, Oh My Zsh, and zsh-autosuggestions.

## The `bbldr` Ecosystem

`bbldr` is a small dispatcher for Become Builder tools. This repository adds
the `dotfiles` module through an executable named `bbldr-dotfiles`.

```text
bbldr dotfiles doctor
  |     |        `-- module command
  |     `----------- installed module
  `----------------- ecosystem dispatcher
```

Future repositories can add their own `bbldr-<module>` executable without
changing this project.

## Documentation

- [Overview](docs/getting-started/overview.md)
- [Install](docs/getting-started/install.md)
- [Daily workflow](docs/getting-started/daily-workflow.md)
- [FAQ](docs/getting-started/faq.md)
- [Commands](docs/reference/commands.md)
- [Backups and restore](docs/guides/backups-and-restore.md)
- [Troubleshooting](docs/guides/troubleshooting.md)
- [Security](docs/guides/security.md)
- [Contributing](CONTRIBUTING.md)

## Repository Layout

```text
bin/
  bbldr                 Generic Become Builder dispatcher
  bbldr-dotfiles        Dotfiles module and commands
config/
  packages.tsv          Package metadata
  targets.tsv           Managed paths and Stow sources
nvim/ wezterm/ tmux/ zsh/
  Stow packages
docs/
  VitePress documentation
tests/
  CLI, install, restore, uninstall, and documentation checks
install.sh              Remote installation entry point
```

## Contributing

Fork the repository, create a focused branch, update behavior and docs together,
and run:

```sh
npm ci
npm run check
```

To scaffold a new application package:

```sh
bbldr dotfiles scaffold app <name>
```

Do not commit credentials, tokens, histories, caches, generated state, or
machine-specific private configuration. Use `~/.zshrc.local` for local-only
shell values.
