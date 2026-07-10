# Neovim

Neovim is a Vim-based text editor focused on extensibility, modern terminal
features, Lua configuration, built-in LSP support, and plugin-driven workflows.
In this setup it is the main terminal editor for editing code and dotfiles.

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

## Leader Key

| Key | Meaning |
| --- | --- |
| `Space` | Leader key |

## Uso Diario

| Comando | Accion |
| --- | --- |
| `i` | Entrar en modo insertar antes del cursor |
| `Esc` | Volver a modo normal |
| `Space f f` | Buscar archivos |
| `Space f g` | Buscar texto en el proyecto |
| `Space f b` | Buscar buffers abiertos |
| `:w` | Guardar |
| `:q` | Salir de la ventana actual |
| `:q!` | Salir sin guardar |
| `:wq` | Guardar y salir |
| `/texto` | Buscar `texto` hacia delante |
| `n` | Ir al siguiente resultado de busqueda |
| `N` | Ir al resultado anterior de busqueda |
| `u` | Deshacer |
| `Ctrl r` | Rehacer |
| `dd` | Cortar/eliminar linea actual |
| `yy` | Copiar linea actual |
| `p` | Pegar despues del cursor |
| `:bd` | Cerrar buffer actual |

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
