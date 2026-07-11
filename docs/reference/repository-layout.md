# Repository Layout

The repository is structured for GNU Stow. Each top-level app folder is a
package. Inside each package, files are placed exactly where they should appear
relative to `$HOME`.

```text
.
|-- bin/
|   |-- bootstrap
|   |-- dotfiles-doctor
|   |-- dotfiles-install
|   |-- dotfiles-restore
|   |-- dotfiles-check
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
|       |-- tmux-dev
|       `-- tmux-status
|-- tests/
|   `-- install-restore.sh
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
| `tmux` | `tmux/.local/bin/tmux-status` | `~/.local/bin/tmux-status` |
| `zsh` | `zsh/.zshrc` | `~/.zshrc` |

## Scripts

| Script | Purpose |
| --- | --- |
| `bin/bootstrap` | Full installer: dependencies, backups, repo update, and Stow links. |
| `bin/dotfiles-install` | Links packages into `$HOME` with Stow. |
| `bin/dotfiles-restore` | Restores configuration from an installation manifest. |
| `bin/dotfiles-check` | Runs the local validation suite used by CI. |
| `bin/dotfiles-doctor` | Checks for common repo issues before publishing. |
| `bin/dotfiles-status` | Shows compact Git status. |
| `bin/dotfiles-sync` | Prints the manual sync flow. |

## Generated Or Local Files

These should not be committed:

```text
node_modules/
docs/.vitepress/cache/
docs/.vitepress/dist/
.DS_Store
logs
tokens
credentials
local databases
```

::: info Why generated docs are ignored
The VitePress source files live in `docs/`. The built output under
`docs/.vitepress/dist/` can be recreated with `npm run docs:build`.
:::

## Installation State

Installation records do not live in the repository. By default they are stored
under `~/.config/dotfiles-backups/<timestamp>/` with a manifest and status file.
This keeps machine-specific paths and previous private configuration out of Git.
