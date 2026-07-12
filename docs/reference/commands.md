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
Every dotfiles subcommand supports `--help`; unknown options fail without
running the operation.

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
bbldr dotfiles packages
```

`update` refuses to proceed when the repository contains local changes. It
remembers the installed packages, performs a fast-forward-only pull, removes
their obsolete project links, refreshes the global commands, creates links for
new files belonging to those packages, and diagnoses that selection. It never
enables a package that was not already installed.

`status` never modifies anything; it shows Git state, aggregate target state,
and the latest restore point. `packages` lists every registered package, its
dependency groups, installation state, and documentation route.

## Doctor

```sh
bbldr dotfiles doctor
bbldr dotfiles doctor tmux
bbldr dotfiles doctor nvim zsh
bbldr dotfiles doctor --all
```

With no arguments, doctor checks detected installed packages. Package arguments
limit the check, and `--all` checks the complete registry. It validates
package-specific commands, `bbldr`, managed targets, Git state, and suspicious
tracked filenames. It returns non-zero for missing dependencies, unmanaged
targets, or security findings.

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

## Purge

```sh
bbldr dotfiles purge
bbldr dotfiles purge --yes
```

Purge restores all packages, removes managed `bbldr` commands, and deletes the
clean dotfiles repository. It retains backups, applications, fonts, package
managers, Oh My Zsh, and plugins. It refuses to continue if Git has local
changes or any configuration cannot be restored safely.

## Contributor Commands

```sh
bbldr dotfiles scaffold app myapp
bbldr dotfiles check
npm run check
```

`scaffold` validates both registries and refuses to overwrite an existing
package directory or documentation page. It then adds metadata, a default
`~/.config/<name>` mapping, an empty source directory, and an application
documentation template. Add real config files and tests before installing or
opening a PR.

`check` runs shell syntax, ShellCheck when available, isolated CLI/install/
restore/uninstall/purge tests, registry and documentation validation,
application config parsing, the VitePress build, and Git whitespace checks.

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
