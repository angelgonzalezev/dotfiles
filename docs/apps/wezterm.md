# WezTerm

WezTerm is a cross-platform terminal emulator and multiplexer. It supports tabs,
panes, GPU-accelerated rendering, rich font features, Lua configuration, and
searchable documentation. In this setup it is the main terminal UI around tools
like Neovim, Git, and shell sessions.

::: tip Why it matters
WezTerm is the visual shell for the workflow. It gives a consistent terminal
experience with readable font settings, tabs, custom colors, and fast keyboard
navigation.
:::

![WezTerm terminal preview](/images/apps/wezterm-overview.svg)

Configuration file:

```text
wezterm/.config/wezterm/wezterm.lua
```

## Official Resources

| Resource | URL |
| --- | --- |
| Website | [wezterm.org](https://wezterm.org/) |
| Configuration docs | [wezterm.org/config](https://wezterm.org/config/files.html) |
| GitHub | [github.com/wez/wezterm](https://github.com/wez/wezterm) |

## What It Is Used For Here

| Use | Notes |
| --- | --- |
| Terminal sessions | Main shell and command-line workspace. |
| Tabs and panes | Quickly switch between multiple terminal contexts. |
| Neovim host | Runs Neovim with custom colors, tabs, and font settings. |
| Lua configuration | Appearance and shortcuts live in `wezterm.lua`. |

## Problems It Solves

| Problem | Solution in this setup |
| --- | --- |
| Terminal UI changes between machines. | The theme, font, padding, opacity, and tab bar are versioned. |
| Switching tabs is slow. | `Cmd Option Left/Right` moves between tabs. |
| Terminal config is hard to audit. | The setup is a single Lua file in the repo. |
| macOS window controls can feel inconsistent. | Integrated native buttons are configured. |

## First Steps

Open WezTerm from macOS:

```sh
open -a WezTerm
```

Open WezTerm in the Desktop folder:

```sh
open -a WezTerm ~/Desktop
```

Reload config after editing:

```text
Cmd R
```

## Custom Shortcuts

| Shortcut | Action |
| --- | --- |
| `Cmd Option Left` | Move to previous tab |
| `Cmd Option Right` | Move to next tab |

## Common Shortcuts

### Tabs and Windows

| Shortcut | Action |
| --- | --- |
| `Cmd T` | Open new tab |
| `Cmd W` | Close current tab, with confirmation |
| `Cmd N` | Open new window |
| `Cmd Q` | Quit WezTerm |
| `Cmd 1` ... `Cmd 8` | Go to tab 1 ... 8 |
| `Cmd 9` | Go to last tab |
| `Cmd Shift [` | Move to previous tab |
| `Cmd Shift ]` | Move to next tab |
| `Cmd Option Left` | Move to previous tab, custom shortcut |
| `Cmd Option Right` | Move to next tab, custom shortcut |

### Panes

| Shortcut | Action |
| --- | --- |
| `Ctrl Alt "` | Split pane vertically |
| `Ctrl Alt %` | Split pane horizontally |
| `Ctrl Shift Left` | Focus pane on the left |
| `Ctrl Shift Right` | Focus pane on the right |
| `Ctrl Shift Up` | Focus pane above |
| `Ctrl Shift Down` | Focus pane below |
| `Ctrl Shift Z` | Toggle pane zoom |

### Copy, Paste, and Search

| Shortcut | Action |
| --- | --- |
| `Cmd C` | Copy to clipboard |
| `Cmd V` | Paste from clipboard |
| `Cmd F` | Search |
| `Ctrl Shift X` | Enter copy mode |
| `Ctrl Shift Space` | Quick select |

### Display

| Shortcut | Action |
| --- | --- |
| `Cmd =` | Increase font size |
| `Cmd -` | Decrease font size |
| `Cmd 0` | Reset font size |
| `Alt Enter` | Toggle fullscreen |
| `Cmd R` | Reload configuration |

## UI

| Area | Configuration |
| --- | --- |
| Font | JetBrains Mono |
| Font size | 14 |
| Theme | Catppuccin Mocha |
| Window opacity | 84% |
| macOS blur | 35 |
| Line height | 1.05 |
| Window decorations | Integrated macOS buttons with resize |
| Tab bar | Always visible, custom formatted |
| New tab button | Hidden |

## Tab Bar

Tabs show:

| Element | Behavior |
| --- | --- |
| Index | One-based tab number |
| Title | Explicit tab title, or active pane title |
| Active tab | Lavender background |
| Inactive tab | Dark background |
| Hovered tab | Brighter dark background |

Long tab titles are truncated to fit the tab width.

::: info WezTerm vs tmux
WezTerm tabs are terminal-app tabs. tmux windows and panes live inside a shell
session and can stay alive even when the terminal window closes.
:::
