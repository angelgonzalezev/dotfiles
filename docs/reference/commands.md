# Commands

`bbldr` is the Become Builder dispatcher. The second word selects an installed
module and the third selects a command from that module.

```text
bbldr dotfiles doctor
  |     |        `-- command
  |     `----------- module
  `----------------- dispatcher
```

## Ecosystem Commands

| Command | Purpose |
| --- | --- |
| `bbldr help` | Show dispatcher usage. |
| `bbldr version` | Print dispatcher version. |
| `bbldr modules` | Discover `bbldr-*` modules available in `PATH`. |
| `bbldr <module> help` | Show commands belonging to one module. |

Unknown modules return exit code `127`; unknown module commands return `2`.

## Install

```sh
bbldr dotfiles install
bbldr dotfiles install nvim
bbldr dotfiles install tmux zsh
bbldr dotfiles install --config-only nvim
bbldr dotfiles install --dry-run
bbldr dotfiles install --yes
```

| Option | Behavior |
| --- | --- |
| `--dry-run` | Print dependencies, target states, and backups without writing. |
| `--config-only` | Skip optional dependency groups and install selected links. |
| `--yes`, `-y` | Accept prompts for non-interactive automation. |
| Package names | Limit configuration linking to the selected packages. |

With no package names, every default package in `config/packages.tsv` is used.

## Update And Status

```sh
bbldr dotfiles update
bbldr dotfiles status
```

`update` refuses to proceed when the repository contains local changes. It
performs a fast-forward-only pull, refreshes the global commands, and runs the
doctor. `status` never modifies anything; it shows Git state, managed targets,
and the latest restore point.

## Doctor

```sh
bbldr dotfiles doctor
```

The doctor checks required and optional commands, the `bbldr` installation,
every target from the package registry, Git state, and suspicious tracked file
names. It returns non-zero when required checks fail.

## Backups And Restore

```sh
bbldr dotfiles backups
bbldr dotfiles restore --backup latest
bbldr dotfiles restore --backup latest --yes
bbldr dotfiles restore --backup 20260711-154500 tmux zsh
```

| Restore option | Behavior |
| --- | --- |
| `--backup latest` | Use the latest installation that changed a target. |
| `--backup <id>` | Use an exact installation record. |
| `--yes`, `-y` | Skip restore confirmation. |
| Package names | Restore only selected packages from the record. |

Restore refuses to replace a path modified after installation.

## Uninstall

```sh
bbldr dotfiles uninstall
bbldr dotfiles uninstall tmux
bbldr dotfiles uninstall --yes nvim zsh
```

Uninstall finds the original configuration-changing record for every selected
package, removes managed links, and restores previous files. It keeps installed
applications, the repository, `bbldr`, and all backup records.

## Contributor Commands

```sh
bbldr dotfiles scaffold app myapp
bbldr dotfiles check
npm run check
```

`scaffold` adds package metadata, a default `~/.config/<name>` mapping, an empty
source directory, and an application documentation template. Add real config
files and tests before installing or opening a PR.

`check` runs shell syntax, ShellCheck when available, isolated CLI/install/
restore/uninstall tests, documentation validation, application config parsing,
the VitePress build, and Git whitespace checks.

## tmux Layouts

| Command | Purpose |
| --- | --- |
| `tmux-dev [name] [directory]` | Attach to or create a two-pane session. |
| `tmux-agent [name] [directory]` | Attach to or create a four-pane session. |
| `tmux ls` | List sessions. |
| `tmux attach -t dev` | Attach to a session. |
| `tmux kill-session -t dev` | Close one session. |
| `tmux kill-server` | Close every tmux session. |
| `exit` | Close the active shell or pane. |

::: warning
`tmux kill-server` terminates every tmux session and every process running in
those sessions.
:::

## Shell, Terminal, And Editor Checks

```sh
source ~/.zshrc
command -v bbldr tmux-dev tmux-agent
zsh -n ~/.zshrc
wezterm show-keys
wezterm ls-fonts
nvim --headless -i NONE -u ~/.config/nvim/init.lua +qa
```

See the individual application pages for their complete custom shortcuts.
