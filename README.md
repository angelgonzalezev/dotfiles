# dotfiles

Personal configuration repository.

This repo is intentionally conservative: only curated configuration files should
be tracked. Credentials, local state, caches, logs, generated dependency trees,
and machine-specific files must stay out of Git.

## Layout

Packages are arranged for GNU Stow. Each package mirrors the target path from
`$HOME`.

```text
nvim/
  .config/
    nvim/
wezterm/
  .config/
    wezterm/
bin/
  bootstrap
  dotfiles-doctor
  dotfiles-install
  dotfiles-status
  dotfiles-sync
```

## Documentation

- [Docs index](docs/index.md)
- [Install](docs/getting-started/install.md)
- [Neovim](docs/apps/nvim.md)
- [WezTerm](docs/apps/wezterm.md)

## Install

Install everything from any terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

To install only one package:

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- nvim
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash -s -- wezterm
```

Existing config folders are backed up automatically to:

```text
~/.config/dotfiles-backups/
```

If the repository already exists locally, the bootstrap updates it with
`git pull --ff-only`. Commit, stash, or discard local changes before running it.

### Manual Install

Install the required tool:

```sh
brew install stow
```

Clone the repository:

```sh
git clone https://github.com/angelgonzalezev/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
```

Check the repository before linking anything:

```sh
bin/dotfiles-doctor
```

Link the default packages into `$HOME`:

```sh
bin/dotfiles-install
```

This links:

```text
~/.config/nvim    -> ~/.config/dotfiles/nvim/.config/nvim
~/.config/wezterm -> ~/.config/dotfiles/wezterm/.config/wezterm
```

If config folders already exist, back them up before installing:

```sh
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.config/wezterm ~/.config/wezterm.backup
bin/dotfiles-install
```

To install only one package:

```sh
bin/dotfiles-install nvim
bin/dotfiles-install wezterm
```

## Contributing

These commands are for maintaining this repository, not for normal
installation.

Show the repository status:

```sh
bin/dotfiles-status
```

Before publishing, run:

```sh
bin/dotfiles-doctor
git status --short
```

Keep the GitHub repo private unless every tracked file has been reviewed.
