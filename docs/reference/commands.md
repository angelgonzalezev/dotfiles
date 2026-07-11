# Commands

This page collects every project-provided executable and the main external
commands used by the installer, daily workflow, tmux, Zsh, and terminal setup.

Project scripts under `bin/` are run from the repository. Commands installed by
the `tmux` package live in `~/.local/bin` and can be run from any directory
because the Zsh package adds that directory to `PATH`.

## `bin/bootstrap`

Full installer. It can install dependencies, update the repo, back up existing
config files, and link packages.

Quick install:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

This mode links dotfiles packages and installs `stow` if needed. It does not ask
interactive questions because the script is streamed through standard input.

Interactive remote run:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)"
```

This mode can ask before installing CLI tools, WezTerm, Oh My Zsh,
JetBrainsMono Nerd Font, `zsh-autosuggestions`, and dotfiles packages.

Non-interactive run that accepts every install step:

```sh
DOTFILES_ASSUME_YES=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)"
```

Install selected packages only:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap)" -- nvim tmux zsh
```

Useful environment variables:

```sh
DOTFILES_REPO_URL=https://github.com/angelgonzalezev/dotfiles.git
DOTFILES_DIR=~/.config/dotfiles
DOTFILES_BACKUP_DIR=~/.config/dotfiles-backups
DOTFILES_ASSUME_YES=1
```

| Exit result | Meaning |
| --- | --- |
| `0` | Installation or intentional skip completed successfully. |
| Non-zero | A requirement, update, backup, simulation, or Stow step failed. |

On a linking failure, bootstrap attempts rollback before returning a non-zero
status. The final output always includes the installation record and restore
command after a successful config install.

## `bin/dotfiles-install`

Links packages into `$HOME` with GNU Stow.

```sh
bin/dotfiles-install
bin/dotfiles-install nvim
bin/dotfiles-install wezterm
bin/dotfiles-install tmux
bin/dotfiles-install zsh
```

This command never installs apps. It only creates symlinks.

Unlike bootstrap, it does not create a backup manifest. Use bootstrap when
installing on a machine with existing configuration.

## `bin/dotfiles-restore`

Safely removes managed links and restores files recorded by bootstrap:

```sh
bin/dotfiles-restore --backup latest
bin/dotfiles-restore --backup latest --yes
bin/dotfiles-restore --backup <timestamp> tmux zsh
```

It refuses to overwrite files that no longer point to this repository.

Options:

| Option | Behavior |
| --- | --- |
| `--backup latest` | Use the latest installation that changed a target. This is the default. |
| `--backup <timestamp>` | Select an exact installation record. |
| `--yes` / `-y` | Skip the interactive confirmation. |
| `--help` / `-h` | Print command usage. |
| Package names | Restore only `nvim`, `wezterm`, `tmux`, or `zsh`. |

## Maintenance Commands

| Command | Purpose |
| --- | --- |
| `bin/dotfiles-doctor` | Checks required/optional commands, managed links, Git status, and suspicious tracked filenames. |
| `bin/dotfiles-status` | Shows compact Git status for the repo. |
| `bin/dotfiles-sync` | Shows status and prints the manual commit/push flow. |
| `bin/dotfiles-check` | Runs syntax, install/restore, config, docs, and whitespace checks. |

```sh
bin/dotfiles-doctor
bin/dotfiles-status
bin/dotfiles-sync
bin/dotfiles-check
```

`bin/dotfiles-check` is the broadest contributor check. It validates Bash and
Zsh syntax, isolated install/restore scenarios, documentation links, WezTerm,
Neovim, tmux when sockets are available, VitePress, and Git whitespace.

## tmux Layout Commands

| Command | Purpose |
| --- | --- |
| `tmux-dev` | Opens or attaches to a tmux session named `dev` with two panes side by side. |
| `tmux-agent` | Opens or attaches to a tmux session named `agent` with four panes in a tiled layout. |

```sh
tmux-dev
tmux-dev project-api
tmux-agent
tmux-agent content-workflow
tmux-dev project-api "$HOME/Projects/api"
tmux-agent agents "$HOME/Projects/automation"
```

Both commands accept `[session-name] [starting-directory]`. Existing sessions
are reused instead of rebuilding their panes.

## tmux Status Bar Commands

| Command | Purpose |
| --- | --- |
| `~/.local/bin/tmux-status` | Prints the dynamic right-side tmux status segments. |
| `tmux source-file ~/.tmux.conf` | Reloads tmux configuration. |
| `tmux show-options -g status-right` | Shows the current right-side status configuration. |
| `bin/dotfiles-install tmux` | Reinstalls tmux symlinks, including `tmux-status`. |
| `tmux list-keys MouseUp1Control0` | Shows the CPU segment click binding. |

```sh
~/.local/bin/tmux-status
tmux source-file ~/.tmux.conf
tmux show-options -g status-right
tmux list-keys MouseUp1Control0
```

## Common tmux Commands

| Command | Purpose |
| --- | --- |
| `tmux` | Start a new session. |
| `tmux ls` | List sessions. |
| `tmux attach` | Attach to the latest session. |
| `tmux attach -t dev` | Attach to a named session. |
| `tmux new -s dev` | Create a named session. |
| `tmux kill-session` | Close the current session. |
| `tmux kill-session -t dev` | Close a named session. |
| `tmux kill-server` | Close every tmux session. |
| `exit` | Close the current shell or pane. |
| `tmux display-message -p '#S:#I.#P'` | Print current session, window, and pane identifiers. |

::: warning
Use `tmux kill-server` only when you want to close every tmux session at once.
:::

## Shell And Terminal Commands

| Command | Purpose |
| --- | --- |
| `source ~/.zshrc` | Reload Zsh config after editing. |
| `open -a WezTerm` | Open WezTerm from a shell. |
| `open -a WezTerm ~/Desktop` | Open WezTerm in the Desktop folder. |
| `command -v tmux-dev` | Check that local tmux commands are available. |
| `zsh -n ~/.zshrc` | Validate Zsh syntax without starting an interactive shell. |
| `wezterm show-keys` | Print effective WezTerm shortcuts. |
| `wezterm ls-fonts` | Print fonts visible to WezTerm. |
| `nvim --headless -i NONE -u ~/.config/nvim/init.lua +qa` | Load Neovim config without opening the UI. |

## Git Workflow Commands

```sh
cd ~/.config/dotfiles
git status --short
git diff
git add -- <files>
git commit -m "Update dotfiles"
git push
```
