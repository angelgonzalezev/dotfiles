# Commands

## `bin/bootstrap`

One-command installer intended to run from any terminal.

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

This mode links dotfiles packages and installs `stow` if needed. It does not ask
interactive questions because the script is streamed through standard input.

Interactive local run:

```sh
~/.config/dotfiles/bin/bootstrap
```

This mode can ask before installing CLI tools, WezTerm, Oh My Zsh,
`zsh-autosuggestions`, and dotfiles packages.

Non-interactive run that accepts every install step:

```sh
DOTFILES_ASSUME_YES=1 ~/.config/dotfiles/bin/bootstrap
```

Install selected packages only:

```sh
~/.config/dotfiles/bin/bootstrap nvim tmux zsh
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

## `bin/dotfiles-doctor`

Checks the repo path, Stow availability, Git status, and tracked file names that
look sensitive.

```sh
bin/dotfiles-doctor
```

## `bin/dotfiles-status`

Shows compact Git status for the repo.

```sh
bin/dotfiles-status
```

## `bin/dotfiles-sync`

Shows status and prints the manual commit/push flow.

```sh
bin/dotfiles-sync
```

## `tmux-dev`

Opens or attaches to a tmux session named `dev` with two panes side by side.

```sh
tmux-dev
tmux-dev project-api
```

## `tmux-agent`

Opens or attaches to a tmux session named `agent` with four panes in a tiled
layout.

```sh
tmux-agent
tmux-agent content-workflow
```

## Common tmux Commands

```sh
tmux
tmux ls
tmux attach
tmux attach -t dev
tmux new -s dev
tmux kill-session
tmux kill-session -t dev
tmux kill-server
exit
```

Use `tmux kill-session` to close the current session. Use `tmux kill-server`
only when you want to close every tmux session at once.

## Shell And Terminal Commands

```sh
source ~/.zshrc
open -a WezTerm
open -a WezTerm ~/Desktop
```

Use `source ~/.zshrc` after editing the shell prompt. Use `open -a WezTerm` to
open the terminal app from any shell.
