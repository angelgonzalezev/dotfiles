# Commands

This page collects the commands used by the installer, daily workflow, tmux,
Zsh, and macOS terminal setup.

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
`zsh-autosuggestions`, and dotfiles packages.

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

## Maintenance Commands

| Command | Purpose |
| --- | --- |
| `bin/dotfiles-doctor` | Checks the repo path, Stow availability, Git status, and suspicious tracked file names. |
| `bin/dotfiles-status` | Shows compact Git status for the repo. |
| `bin/dotfiles-sync` | Shows status and prints the manual commit/push flow. |

```sh
bin/dotfiles-doctor
bin/dotfiles-status
bin/dotfiles-sync
```

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
```

## tmux Status Bar Commands

| Command | Purpose |
| --- | --- |
| `~/.local/bin/tmux-status` | Prints the dynamic right-side tmux status segments. |
| `tmux source-file ~/.tmux.conf` | Reloads tmux configuration. |
| `tmux show-options -g status-right` | Shows the current right-side status configuration. |
| `bin/dotfiles-install tmux` | Reinstalls tmux symlinks, including `tmux-status`. |

```sh
~/.local/bin/tmux-status
tmux source-file ~/.tmux.conf
tmux show-options -g status-right
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

## Git Workflow Commands

```sh
cd ~/.config/dotfiles
git status --short
git diff
git add -- <files>
git commit -m "Update dotfiles"
git push
```
