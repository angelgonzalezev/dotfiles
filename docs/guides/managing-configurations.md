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
