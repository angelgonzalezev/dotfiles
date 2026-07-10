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
|-- wezterm/
|   `-- .config/wezterm/
|-- tmux/
|   |-- .tmux.conf
|   `-- .local/bin/
|       |-- tmux-agent
|       `-- tmux-dev
`-- zsh/
    `-- .zshrc
```

## Packages

Packages are top-level folders that Stow can link into `$HOME`.

| Package | Source | Target |
| --- | --- | --- |
| `nvim` | `nvim/.config/nvim` | `~/.config/nvim` |
| `wezterm` | `wezterm/.config/wezterm` | `~/.config/wezterm` |
| `tmux` | `tmux/.tmux.conf` | `~/.tmux.conf` |
| `tmux` | `tmux/.local/bin/tmux-dev` | `~/.local/bin/tmux-dev` |
| `tmux` | `tmux/.local/bin/tmux-agent` | `~/.local/bin/tmux-agent` |
| `zsh` | `zsh/.zshrc` | `~/.zshrc` |
