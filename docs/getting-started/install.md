# Install

This guide explains what the installer downloads, which paths it changes, how
to preview the result, and how to return to the previous configuration.

::: warning Read remote scripts first
The installer can install software with Homebrew or APT and replace terminal
configuration with symlinks. Use dry-run first and review the
[security model](/guides/security) and [restore guide](/guides/backups-and-restore).
:::

## Supported Systems

| System | Support | Dependency manager |
| --- | --- | --- |
| macOS, Intel and Apple Silicon | Fully supported and tested | Homebrew |
| Ubuntu 22.04 and 24.04 | Fully supported and tested | APT and official releases |
| Debian 12 and 13 | Supported and tested in Debian 12 | APT and official releases |
| Other Linux distributions | Configuration linking only | Dependencies must be installed manually |

Windows is not currently supported.

## Preview Without Changes

Run the remote installer with `--dry-run`:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)" -- --dry-run
```

When the repository is not installed, dry-run clones it into a temporary
directory, prints the plan, and deletes the temporary clone. It does not create
links, install commands, write backups, or change the final repository path.

The plan shows:

```text
operating system and architecture
selected packages and dependencies
every managed target
new, already managed, or conflicting status
backup directory
global bbldr command path
```

## Interactive Installation

Run from any directory:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)"
```

The installer asks about these dependency groups:

```text
CLI tools required by the selected packages
WezTerm
JetBrainsMono Nerd Font
Oh My Zsh
zsh-autosuggestions
selected dotfiles configuration packages
```

Dependency questions are filtered by package. Selecting only Neovim does not
offer WezTerm or Oh My Zsh, for example. After the questions, the installer
prints the complete plan and asks once more before
making changes. APT or Homebrew may request a password when system software is
installed. The installer does not change the default login shell.

## Fully Automatic Installation

Accept every dependency and configuration prompt:

```sh
BBLDR_ASSUME_YES=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)"
```

Use this only after reviewing dry-run output.

## Select Packages

Available packages are `nvim`, `wezterm`, `tmux`, and `zsh`.

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)" -- nvim
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)" -- tmux zsh
```

After the first installation, use the global command:

```sh
bbldr dotfiles install nvim tmux
```

Install configuration links without optional dependency groups:

```sh
bbldr dotfiles install --config-only nvim tmux
```

Unknown packages and options are rejected before any target is moved.

## Installation Lifecycle

```text
download install.sh
  -> validate git, curl, platform, and command collisions
  -> clone ~/.config/dotfiles
  -> select dependencies and packages
  -> print plan and confirm
  -> install selected dependencies
  -> install bbldr and register bbldr-dotfiles
  -> create timestamped manifest
  -> move conflicting configuration into the backup
  -> simulate GNU Stow
  -> create links
  -> record success and print the restore command
```

If Stow simulation or linking fails after a file has moved, the installer
automatically returns it and marks the run `rolled-back`.

## Installed Dependencies

| Dependency | Purpose |
| --- | --- |
| Git and curl | Download and update the repository and official installers. |
| GNU Stow | Create configuration symlinks. |
| Neovim 0.10+ | Run the editor and its Lua plugins. |
| ripgrep | Power project search through `Space f g`. |
| tmux | Run persistent sessions and predefined layouts. |
| Zsh | Load the shared prompt and shell workflow. |
| WezTerm | Provide the configured terminal application. |
| JetBrainsMono Nerd Font | Render terminal text and status icons. |
| Oh My Zsh | Provide the prompt theme and shell plugin framework. |
| zsh-autosuggestions | Suggest commands from shell history. |

On Linux, a current Neovim release is installed under
`~/.local/opt/bbldr-neovim` when the distribution version is older than 0.10.
WezTerm uses its official APT repository and the font is installed per user.

## Files And Links

The repository is cloned to:

```text
~/.config/dotfiles
```

The ecosystem commands are installed in:

```text
~/.local/bin/bbldr
~/.local/bin/bbldr-dotfiles -> ~/.config/dotfiles/bin/bbldr-dotfiles
```

Configuration targets include:

```text
~/.config/nvim/*             -> <repo>/nvim/.config/nvim/*
~/.config/wezterm/*          -> <repo>/wezterm/.config/wezterm/*
~/.tmux.conf                 -> <repo>/tmux/.tmux.conf
~/.local/bin/tmux-*          -> <repo>/tmux/.local/bin/tmux-*
~/.zshrc                     -> <repo>/zsh/.zshrc
```

Stow uses `--no-folding`: shared target directories remain real directories
and only managed files become links.

## Backups

Installation records live under:

```text
~/.config/bbldr/backups/dotfiles/<timestamp>/manifest.tsv
~/.config/bbldr/backups/dotfiles/<timestamp>/status
~/.config/bbldr/backups/dotfiles/latest
```

List them without reading TSV files manually:

```sh
bbldr dotfiles backups
```

Restore the latest configuration-changing run:

```sh
bbldr dotfiles restore --backup latest
```

## Custom Locations

| Variable | Default | Purpose |
| --- | --- | --- |
| `BBLDR_DOTFILES_REPO_URL` | This GitHub repository | Install a fork or local Git source. |
| `BBLDR_DOTFILES_DIR` | `~/.config/dotfiles` | Select the clone location used by `install.sh`. |
| `BBLDR_DOTFILES_BACKUP_DIR` | `~/.config/bbldr/backups/dotfiles` | Select the backup location. |
| `BBLDR_ASSUME_YES=1` | `0` | Accept prompts for automation. |

## Verify

Open a new Zsh session so `~/.local/bin` is in `PATH`, then run:

```sh
bbldr modules
bbldr dotfiles version
bbldr dotfiles doctor
bbldr dotfiles status
```

Continue with the [daily workflow](/getting-started/daily-workflow), or use
[troubleshooting](/guides/troubleshooting) if any diagnostic fails.
