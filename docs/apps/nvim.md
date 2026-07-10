# Neovim

Neovim is a Vim-based text editor focused on extensibility, modern terminal
features, Lua configuration, built-in LSP support, and plugin-driven workflows.
In this setup it is the main terminal editor for editing code and dotfiles.

::: tip Why it matters
Neovim makes editing fast without leaving the terminal. This reduces context
switching between terminal, editor, search tools, and Git workflows.
:::

![Neovim showing the Snacks picker and WezTerm configuration](/images/apps/nvim-screenshot.png)

Configuration file:

```text
nvim/.config/nvim/init.lua
```

## Official Resources

| Resource | URL |
| --- | --- |
| Website | [neovim.io](https://neovim.io/) |
| Documentation | [neovim.io/doc](https://neovim.io/doc/) |
| GitHub | [github.com/neovim/neovim](https://github.com/neovim/neovim) |

## What It Is Used For Here

| Use | Notes |
| --- | --- |
| Editing code | Fast keyboard-first editor inside the terminal. |
| Editing dotfiles | Main editor for this repository's config and docs. |
| Project search | Uses Snacks picker for files, text, and buffers. |
| Lua configuration | The setup lives in `init.lua` and is managed with `lazy.nvim`. |

## Problems It Solves

| Problem | Solution in this setup |
| --- | --- |
| Finding files manually is slow. | `Space f f` opens a file picker. |
| Searching text from the shell breaks flow. | `Space f g` searches inside the project. |
| Open buffers are hard to track. | Custom tabline plus `Space f b` make buffers visible and searchable. |
| Editor setup is hard to reproduce. | The config is versioned in `nvim/.config/nvim/init.lua`. |

## First Steps

Open Neovim:

```sh
nvim
```

Open the dotfiles project:

```sh
cd ~/.config/dotfiles
nvim .
```

Use these first:

```text
Space f f   find files
Space f g   search text
i           insert text
Esc         return to normal mode
:w          save
:q          quit
```

## Leader Key

| Key | Meaning |
| --- | --- |
| `Space` | Leader key |

## Daily Usage

| Command | Action |
| --- | --- |
| `i` | Enter insert mode before the cursor |
| `Esc` | Return to normal mode |
| `Space f f` | Search files |
| `Space f g` | Search text in the project |
| `Space f b` | Search open buffers |
| `:w` | Save |
| `:q` | Quit the current window |
| `:q!` | Quit without saving |
| `:wq` | Save and quit |
| `/text` | Search forward for `text` |
| `n` | Go to the next search result |
| `N` | Go to the previous search result |
| `u` | Undo |
| `Ctrl r` | Redo |
| `dd` | Delete current line |
| `yy` | Copy current line |
| `p` | Paste after the cursor |
| `:bd` | Close current buffer |

## Custom Shortcuts

| Shortcut | Mode | Action |
| --- | --- | --- |
| `Space f f` | Normal | Search files with Snacks picker |
| `Space f g` | Normal | Search text with Snacks grep |
| `Space f b` | Normal | Search open buffers with Snacks picker |

## Common Shortcuts

### Modes

| Shortcut | Action |
| --- | --- |
| `Esc` | Return to normal mode |
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | Open a new line below and enter insert mode |
| `v` | Enter visual mode |
| `V` | Enter visual line mode |

### Files

| Command | Action |
| --- | --- |
| `:w` | Save file |
| `:q` | Quit current window |
| `:q!` | Quit without saving |
| `:wq` | Save and quit |
| `:e path/to/file` | Open file |

### Editing

| Shortcut | Action |
| --- | --- |
| `u` | Undo |
| `Ctrl r` | Redo |
| `yy` | Copy current line |
| `p` | Paste after cursor |
| `dd` | Delete current line |
| `/text` | Search forward |
| `n` | Next search result |
| `N` | Previous search result |

### Buffers

| Command | Action |
| --- | --- |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Close current buffer |
| `Space f b` | Search buffers with Snacks picker |

## UI

| Area | Configuration |
| --- | --- |
| Theme | Catppuccin Mocha |
| Background | Transparent |
| Line numbers | Absolute and relative numbers enabled |
| Mouse | Enabled |
| Search | Ignore case unless uppercase is used |
| Statusline | Lualine |
| Tabline | Custom WezTerm-style buffer tabline |

## Plugins

| Plugin | Purpose |
| --- | --- |
| `folke/lazy.nvim` | Plugin manager |
| `catppuccin/nvim` | Theme |
| `echasnovski/mini.icons` | Icons |
| `folke/snacks.nvim` | Picker and search UI |
| `nvim-lualine/lualine.nvim` | Statusline |

## Notes

The tabline shows listed buffers, not Vim tabs. Modified buffers get a `+`
marker in the tab title.

::: info Vim modes
Neovim is modal. Most commands run from normal mode. If a shortcut does not
work, press `Esc` first and try again.
:::
