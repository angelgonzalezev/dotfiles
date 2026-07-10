# Repository Layout

```text
.
|-- bin/
|   |-- bootstrap
|   |-- dotfiles-doctor
|   |-- dotfiles-install
|   |-- dotfiles-status
|   `-- dotfiles-sync
|-- docs/
|   |-- apps/
|   |-- getting-started/
|   |-- guides/
|   `-- reference/
|-- nvim/
|   `-- .config/nvim/
`-- wezterm/
    `-- .config/wezterm/
```

## Packages

Packages are top-level folders that Stow can link into `$HOME`.

| Package | Source | Target |
| --- | --- | --- |
| `nvim` | `nvim/.config/nvim` | `~/.config/nvim` |
| `wezterm` | `wezterm/.config/wezterm` | `~/.config/wezterm` |
