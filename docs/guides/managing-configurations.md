# Managing Configurations

This project is organized as packages. A package is a top-level folder that
mirrors where files should live from `$HOME`.

::: info Example
`nvim/.config/nvim/init.lua` becomes `~/.config/nvim/init.lua` when installed.
:::

## Add A New Package

Create a package that mirrors the final path from `$HOME`.

Example for a fictional app:

```text
myapp/
  .config/
    myapp/
      config.toml
```

Then update:

```text
bin/dotfiles-install
bin/bootstrap
bin/dotfiles-restore
docs/index.md
docs/getting-started/overview.md
docs/getting-started/install.md
docs/reference/repository-layout.md
README.md
```

If the app needs documentation, add:

```text
docs/apps/myapp.md
```

A complete package contribution should define:

| Area | Requirement |
| --- | --- |
| Repository layout | Source paths mirror their final location below `$HOME`. |
| Bootstrap | Package name, conflict targets, source paths, and backup behavior. |
| Installation | Default selection when appropriate and Stow compatibility. |
| Restore | Every target appears in the installation manifest. |
| Documentation | Purpose, official resources, configured behavior, commands, and troubleshooting. |
| Tests | Clean install, existing target, reinstall, and restore scenarios. |

Do not add application caches, session state, generated indexes, histories,
credentials, or machine-specific paths to a package.

## Install A Package

From the repo root:

```sh
bin/dotfiles-install nvim
bin/dotfiles-install wezterm
bin/dotfiles-install tmux
bin/dotfiles-install zsh
```

Install multiple packages:

```sh
bin/dotfiles-install nvim tmux zsh
```

## Remove A Package

Unlink it with Stow:

```sh
stow --no-folding --target="$HOME" --delete <package>
```

Then remove the package from the repo and update the docs.

For an end user returning to a pre-install configuration, prefer the
manifest-aware restore command instead:

```sh
bin/dotfiles-restore --backup latest <package>
```

## Keep Local Config Out Of Git

Some config is personal to one machine. Keep it out of tracked packages.

Use:

```text
~/.zshrc.local
```

Good candidates:

```text
private aliases
local SDK paths
work-only environment variables
tokens
credentials
machine-specific paths
```

::: warning Before publishing
Run `bin/dotfiles-doctor` and review `git diff --cached` before pushing.
:::

## Understand Ownership Before Editing

Check whether a live path belongs to this repository:

```sh
readlink ~/.zshrc
readlink ~/.tmux.conf
readlink ~/.config/nvim/init.lua
```

If `readlink` prints a path inside `~/.config/dotfiles`, editing the live path
changes the Git working tree. If it prints nothing, the path is a regular local
file and is not currently managed by Stow.
