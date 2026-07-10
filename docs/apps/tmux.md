# tmux

tmux is a terminal multiplexer for managing persistent sessions, split panes,
and multiple windows inside a single terminal. In this setup it is the layer
that keeps shell work organized and quick to return to.

## Official Resources

| Resource | URL |
| --- | --- |
| GitHub | [github.com/tmux/tmux](https://github.com/tmux/tmux) |
| Wiki | [github.com/tmux/tmux/wiki](https://github.com/tmux/tmux/wiki) |

## What It Is Used For Here

| Use | Notes |
| --- | --- |
| Sessions | Keep work running after closing a terminal. |
| Panes | Split the terminal for focused multitasking. |
| Windows | Separate related tasks in one tmux session. |
| Navigation | `Ctrl+a` prefix keeps the workflow consistent on macOS. |

## Key Bindings

| Shortcut | Action |
| --- | --- |
| `Ctrl+a` then `c` | New window |
| `Ctrl+a` then `-` | Split pane horizontally |
| `Ctrl+a` then `|` | Split pane vertically |
| `Ctrl+a` then `x` | Kill current pane |
| `Ctrl+a` then `&` | Kill current window |
| `Ctrl+a` then `r` | Reload configuration |
| `Ctrl+a` then `n` | Next window |
| `Ctrl+a` then `p` | Previous window |
| `Alt + Arrow` | Move between panes |
| `Alt + H/J/K/L` | Resize panes |

## Layout Commands

| Command | Layout |
| --- | --- |
| `tmux-dev` | Opens or attaches to a `dev` session with 2 panes side by side. |
| `tmux-agent` | Opens or attaches to an `agent` session with 4 panes in a tiled layout. |

Both commands start in the current directory. You can pass a custom session name
as the first argument:

```sh
tmux-dev project-api
tmux-agent content-workflow
```

## Session Commands

| Command | Action |
| --- | --- |
| `tmux` | Start a new tmux session. |
| `tmux ls` | List running tmux sessions. |
| `tmux attach` | Attach to the latest tmux session. |
| `tmux attach -t <name>` | Attach to a specific session. |
| `tmux new -s <name>` | Start a new named session. |
| `tmux kill-session` | Close the current tmux session and all its windows and panes. |
| `tmux kill-session -t <name>` | Close a specific tmux session. |
| `tmux kill-server` | Close every tmux session. |

## Exiting And Closing

| Command | Action |
| --- | --- |
| `Ctrl+a` then `d` | Detach from tmux without closing the session. |
| `exit` | Close the current shell, pane, or window when it is the last pane. |
| `Ctrl+d` | Same as `exit` in most shells. |
| `Ctrl+a` then `x` | Close the current pane. |
| `Ctrl+a` then `&` | Close the current window. |
| `tmux kill-session` | Close all panes and windows in the current session. |
| `tmux kill-server` | Close all tmux sessions. |

## Notes

The config lives in `tmux/.tmux.conf`. Layout commands live in
`tmux/.local/bin/`.
