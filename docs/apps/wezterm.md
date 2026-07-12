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

![WezTerm logo](/images/logos/wezterm-logo.svg)

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

These are the only shortcuts overridden by `wezterm.lua`. The commands below
are WezTerm defaults that remain available. You can inspect the effective key
table for your installed version with:

```sh
wezterm --config-file ~/.config/wezterm/wezterm.lua show-keys
```

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
| Font | JetBrainsMono Nerd Font, with JetBrains Mono fallback |
| Font size | 14 |
| Theme | Catppuccin Mocha |
| Window opacity | 84% |
| macOS blur | 35 on macOS only |
| Line height | 1.05 |
| Window decorations | Integrated macOS buttons with resize |
| Tab bar | Always visible, custom formatted |
| New tab button | Hidden |

## Complete Appearance Configuration

| Setting | Value | Purpose |
| --- | --- | --- |
| Font fallback | Nerd Font, then JetBrains Mono | Preserve icons while retaining readable text if the patched font is unavailable. |
| Font size | `14` | Comfortable code and terminal text size. |
| Line height | `1.05` | Adds a small amount of vertical breathing room. |
| Color scheme | Catppuccin Mocha | Shared dark palette with Neovim. |
| Background opacity | `0.84` | Keeps the terminal slightly transparent. |
| macOS background blur | `35` | Makes content behind the transparent window less distracting. |
| Left/right padding | `16` | Prevents text touching the window edges. |
| Top padding | `14` | Separates terminal content from the title and tab area. |
| Bottom padding | `12` | Separates the final terminal row from the window edge. |
| Tab maximum width | `36` | Prevents one long title consuming the complete bar. |

On macOS, the close, hide, and maximize controls are integrated on the left of
the terminal title area. Linux receives normal resizable window decorations
because native macOS controls and blur do not exist there.

On Linux, the configuration skips native macOS title buttons and blur. The
remaining theme, tab bar, font, padding, and navigation behavior is shared.

WezTerm calls the macOS Command key `SUPER` internally. The custom `CMD|OPT`
bindings therefore appear as `SUPER|ALT` in `wezterm show-keys`.

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

The tab title is selected in this order:

1. A title explicitly assigned to the tab.
2. The active pane title, usually supplied by the shell or current program.
3. Whitespace is trimmed and the result is shortened to fit the configured
   width.

The rounded edges use Powerline glyphs from JetBrainsMono Nerd Font. The tab
bar remains visible with a single tab so its position does not change as tabs
are opened and closed. The `+` button is intentionally hidden; use `Cmd T`.

## Relationship With The Other Tools

```text
WezTerm window
  -> WezTerm tabs
     -> Zsh shell
        -> optional tmux session
           -> tmux windows and panes
              -> Neovim or other terminal commands
```

Closing a WezTerm tab closes the shell process in that tab. A detached tmux
session continues running because it is managed by the tmux server rather than
the terminal window.

## Reload And Diagnose

| Command | Purpose |
| --- | --- |
| `Cmd R` | Reload `wezterm.lua` in the running application. |
| `wezterm show-keys` | Show effective default and custom shortcuts. |
| `wezterm ls-fonts` | List fonts WezTerm can discover. |
| `wezterm ls-fonts \| rg 'JetBrainsMono Nerd Font'` | Verify the configured Nerd Font. |

When the Lua file contains an error, WezTerm displays a configuration error
instead of applying the broken reload. Run `bbldr dotfiles check` from the repo
to parse the same file before publishing it.

::: info WezTerm vs tmux
WezTerm tabs are terminal-app tabs. tmux windows and panes live inside a shell
session and can stay alive even when the terminal window closes.
:::
