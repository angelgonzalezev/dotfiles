# Commands

## `bin/bootstrap`

One-command installer intended to run from any terminal.

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

## `bin/dotfiles-install`

Links packages into `$HOME` with GNU Stow.

```sh
bin/dotfiles-install
bin/dotfiles-install nvim
bin/dotfiles-install wezterm
bin/dotfiles-install tmux
```

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
