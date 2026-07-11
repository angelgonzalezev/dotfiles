# tmux

tmux is a terminal multiplexer for managing persistent sessions, split panes,
and multiple windows inside a single terminal. In this setup it is the layer
that keeps shell work organized and quick to return to.

::: tip Why it matters
tmux lets you keep terminal work alive, split your workspace into panes, and
reopen sessions without losing context.
:::

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
| Status bar | Catppuccin Macchiato-inspired bottom bar. |

## Problems It Solves

| Problem | Solution in this setup |
| --- | --- |
| Closing the terminal kills your workflow. | Detach with `Ctrl+a` then `d` and attach later. |
| Running multiple commands needs many windows. | Split panes inside one tmux session. |
| Recreating layouts wastes time. | `tmux-dev` and `tmux-agent` create reusable layouts. |
| Default prefix is awkward. | Prefix is changed from `Ctrl+b` to `Ctrl+a`. |

## First Steps

Start tmux:

```sh
tmux
```

Detach without closing anything:

```text
Ctrl+a
d
```

Reattach:

```sh
tmux attach
```

Start a two-pane workspace:

```sh
tmux-dev
```

Start a four-pane workspace:

```sh
tmux-agent
```

::: info Prefix key
`Ctrl+a` is the tmux prefix. Press it first, release it, then press the command
key. For example, `Ctrl+a` then `c` creates a new window.
:::

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
| `Ctrl+a` then `h/j/k/l` | Move between panes left, down, up, or right |
| `Ctrl+a` then `q` | Show pane numbers briefly |
| `Opt + 1/2/3/4` | Jump to pane 1, 2, 3, or 4 in the current window |
| `Opt + Arrow` | Move between panes |
| `Opt + H/J/K/L` | Resize panes |

All shortcuts in this table are explicitly configured in `.tmux.conf`, except
`Ctrl+a` then `d` and `Ctrl+a` then `q`, which remain standard tmux bindings
under the new prefix.

### Prefix And Direct Shortcuts

There are two types of shortcuts:

| Type | How it works | Example |
| --- | --- | --- |
| Prefix command | Press and release `Ctrl+a`, then press another key. | `Ctrl+a`, then `c` creates a window. |
| Direct binding | Hold Option/Alt and press the key without using the prefix. | `Opt+2` selects pane 2. |

The direct `Opt` bindings depend on the terminal sending Alt/Meta combinations.
They are verified with this project's WezTerm setup. If another terminal
captures Option for special characters, use the prefix plus `h/j/k/l` instead.

For most users, the easiest pane navigation is:

```text
Opt + 1 / 2 / 3 / 4
```

Use `Opt + 1` to `Opt + 4` when you want to jump directly to a pane. Use
`h/j/k/l` when you want to move relative to the current pane. The `Opt +
Arrow` bindings are there as a faster alternative when the terminal sends the
keys correctly.

On macOS, `Opt` is the `Alt` key.

If you forget which pane is which, press `Ctrl+a` then `q` and tmux will show
the pane numbers for a moment.

## Complete Session Configuration

| Setting | Value | Effect |
| --- | --- | --- |
| Prefix | `Ctrl+a` | Replaces the default `Ctrl+b`. |
| Mouse | Enabled | Select panes, resize borders, scroll, and click status elements. |
| Scrollback | `100000` lines | Keeps substantially more terminal history per pane. |
| First window | `1` | Window numbering starts at 1 instead of 0. |
| First pane | `1` | Pane numbering matches the `Opt+1` to `Opt+4` shortcuts. |
| Renumber windows | Enabled | Removes gaps after a window is closed. |
| Automatic names | Enabled | Window names follow the active command unless manually renamed. |
| Terminal titles | Enabled | Exposes tmux session/window information to WezTerm. |
| Repeat time | `300 ms` | Allows repeatable key bindings to be pressed again briefly without another prefix. |
| Copy mode | Vi | Uses familiar Vim movement and selection keys. |
| Escape delay | `10 ms` | Reduces delay when leaving Neovim insert mode inside tmux. |

New panes and windows inherit the current pane's working directory. This is why
splitting while working in a project opens the new shell in the same project.

## Pane And Window Lifecycle

| Goal | Command |
| --- | --- |
| Create a new window in the current directory | `Ctrl+a`, then `c` |
| Split into left/right panes | `Ctrl+a`, then `\|` |
| Split into top/bottom panes | `Ctrl+a`, then `-` |
| Close only the active pane | `Ctrl+a`, then `x`, or run `exit` |
| Close the complete active window | `Ctrl+a`, then `&` |
| Move to next/previous window | `Ctrl+a`, then `n` / `p` |
| Detach and keep everything running | `Ctrl+a`, then `d` |

The words “horizontal” and “vertical” can be ambiguous. In this project,
`split-window -h` creates panes side by side and is bound to `|`; `split-window
-v` creates panes above and below and is bound to `-`.

## Copy Mode

Enter copy mode with the standard `Ctrl+a`, then `[` binding. The project adds
these Vi-style controls:

| Key | Action |
| --- | --- |
| `v` | Begin selecting text. |
| Vi movement keys | Extend the selection. |
| `y` | Copy the selection and leave copy mode. |
| `Esc` | Cancel copy mode. |

With mouse mode enabled, scrolling a pane also enters tmux history when the
application inside the pane is not handling the mouse itself.

## Status Bar

The bottom bar is inspired by the Macchiato flavor from
[catppuccin/tmux](https://github.com/catppuccin/tmux), but this setup does not
load the full plugin. The config only customizes tmux's built-in status bar so
the rest of the terminal colors stay unchanged.

| Area | Style |
| --- | --- |
| Background | Catppuccin Macchiato base `#24273a` |
| Left segment | Lavender `tmux` label and current session name |
| Window list | Muted inactive windows and lavender active window |
| Right segment | Prompt icon, shell, CPU load, tmux sessions, uptime, and battery |
| Borders | Blue active pane border and muted inactive border |

The dynamic right segment is generated by:

```text
tmux/.local/bin/tmux-status
```

It shows:

| Icon | Segment | Meaning | Source | Fallback |
| --- | --- | --- | --- | --- |
| `👼` | Prompt icon | Personal workspace marker. | Static symbol in `tmux-status`. | None |
| Text | Shell | Current login shell, such as `zsh` or `fish`. | `basename "$SHELL"` | `sh` |
| `⚙` | CPU load | CPU usage averaged across cores. | macOS: `iostat`; Linux: `/proc/stat`; fallback: normalized process CPU | `0.0%` |
| `▣` | tmux sessions | Number of active tmux sessions. | `tmux list-sessions` plus `wc -l` | `0` |
| `󰔟` | Uptime | Time since the machine last booted. | macOS: `sysctl`; Linux: `/proc/uptime` | `n/a` |
| `󰁹` | Battery | Current battery percentage. | macOS: `pmset`; Linux: `/sys/class/power_supply` | `n/a` |

The CPU, tmux sessions, uptime, and battery segments are clickable. Clicking a
segment shows a short explanation in tmux's message area.

| Click target | Message |
| --- | --- |
| `⚙` / CPU value | `CPU usage` |
| `▣` / session count | `tmux sessions` |
| `󰔟` / uptime value | `system uptime` |
| `󰁹` / battery value | `battery level` |

Example output before tmux renders colors:

```text
👼 zsh ⚙ 12.0% ▣ 2 󰔟 7d 22h 19m 󰁹 100%
```

::: info CPU calculation
The CPU segment follows the same idea used by Catppuccin's tmux CPU module.
Catppuccin/tmux delegates the CPU value to the `tmux-cpu` plugin, which exposes
`#{cpu_percentage}` as CPU usage averaged across cores.

This project does not install the full plugin for this small segment, but the
local `tmux-status` script mirrors the same calculation strategy:

1. On Linux, sample aggregate counters from `/proc/stat` and calculate the
   difference between total and idle CPU time.
2. On macOS, use `iostat` when available.
   This is the preferred source because it reads system CPU idle data and
   calculates usage as `100 - idle`.
3. Use `sar` when available.
   This is another system-level source that can calculate usage from the idle
   column.
4. Fall back to `ps aux`.
   If neither `iostat` nor `sar` is available, the script sums process CPU usage
   and divides it by the number of CPU cores.

The fallback normalization is important on multi-core machines. Without it,
process CPU totals can show values higher than `100%`, such as `160%`, because
macOS can report CPU usage accumulated across multiple cores.
:::

References:

| Resource | What to check |
| --- | --- |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Theme and status module structure. |
| [catppuccin/tmux CPU module](https://github.com/catppuccin/tmux/blob/main/status/cpu.conf) | The Catppuccin CPU segment that uses `#{cpu_percentage}`. |
| [tmux-plugins/tmux-cpu](https://github.com/tmux-plugins/tmux-cpu) | Plugin that provides `#{cpu_percentage}`. |
| [tmux-cpu CPU script](https://github.com/tmux-plugins/tmux-cpu/blob/master/scripts/cpu_percentage.sh) | Original `iostat`, `sar`, and `ps aux` calculation flow. |

## Status Bar Commands

Check that the dynamic status command exists:

```sh
ls -la ~/.local/bin/tmux-status
```

Preview the raw tmux status output:

```sh
~/.local/bin/tmux-status
```

Reload the tmux config:

```sh
tmux source-file ~/.tmux.conf
```

Check what tmux is using for the right side of the status bar:

```sh
tmux show-options -g status-right
```

Expected value:

```text
status-right "#(~/.local/bin/tmux-status)"
```

If the command does not exist, reinstall the `tmux` package:

```sh
cd ~/.config/dotfiles
bin/dotfiles-install tmux
tmux source-file ~/.tmux.conf
```

The bar refreshes every five seconds:

```text
set -g status-interval 5
```

Click messages stay visible for five seconds:

```text
set -g display-time 5000
```

The click handlers are defined with tmux `control` ranges:

```text
MouseUp1Control0 -> CPU usage help
MouseUp1Control1 -> tmux sessions help
MouseUp1Control2 -> uptime help
MouseUp1Control3 -> battery help
```

::: info Why not load the full plugin?
The Catppuccin tmux plugin is useful when you want a complete tmux theme. This
setup only needs the bottom status bar, so the config keeps the same palette and
avoids extra plugin behavior.
:::

::: warning Font icons
The status bar uses a few icon glyphs. If they do not render correctly, install
or select a Nerd Font in WezTerm. The current terminal config uses JetBrains
Mono, so a patched JetBrainsMono Nerd Font is a good fit.
:::

## Layout Commands

| Command | Layout |
| --- | --- |
| `tmux-dev` | Opens or attaches to a `dev` session with 2 panes side by side. |
| `tmux-agent` | Opens or attaches to an `agent` session with 4 panes in a tiled layout. |

Both commands start in the current directory. You can pass a custom session name
as the first argument and a starting directory as the second:

```sh
tmux-dev project-api
tmux-agent content-workflow
tmux-dev project-api "$HOME/Projects/api"
tmux-agent agents "$HOME/Projects/automation"
```

Command behavior:

1. If the named session already exists, attach to it from a normal shell or
   switch to it when already inside tmux.
2. Otherwise create the session in the selected starting directory.
3. Build the requested layout and focus the first pane.
4. Attach or switch the current client to the new session.

| Command | Default session | Pane construction | Final layout |
| --- | --- | --- | --- |
| `tmux-dev [name] [directory]` | `dev` | One right-hand split | Two equal columns |
| `tmux-agent [name] [directory]` | `agent` | Left/right split, then split both columns | Four tiled panes |

::: tip Reusing layouts
Running `tmux-agent` twice does not create eight panes. The second invocation
finds the existing `agent` session and reconnects to it.
:::

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
| `Ctrl+a` then `h/j/k/l` | Move between panes left, down, up, or right. |

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

::: warning `kill-server`
`tmux kill-server` closes every tmux session. Use `tmux kill-session` when you
only want to close the current session.
:::

## Diagnose The Effective Configuration

| Command | What it confirms |
| --- | --- |
| `tmux show-options -g prefix` | The active prefix is `C-a`. |
| `tmux list-keys -T root M-1` | Direct pane 1 navigation is loaded. |
| `tmux list-keys -T prefix r` | The reload command is loaded. |
| `tmux show-options -g status-right` | The dynamic status script is configured. |
| `tmux display-message -p '#S:#I.#P'` | Current session, window, and pane numbers. |

Run `Ctrl+a`, then `r` after editing `.tmux.conf`. Existing sessions keep
running while tmux replaces the active options and bindings.
