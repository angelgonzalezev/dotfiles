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
  dotfiles-doctor
  dotfiles-install
  dotfiles-status
  dotfiles-sync
```

## Common commands

```sh
bin/dotfiles-status
bin/dotfiles-doctor
```

When GNU Stow is installed, configs can be linked from the repo root with:

```sh
bin/dotfiles-install
```

Do not run `stow` blindly if real files already exist at the target paths.
Back them up or move them into this repo first.

## GitHub

Before publishing, run:

```sh
bin/dotfiles-doctor
git status --short
```

Keep the GitHub repo private unless every tracked file has been reviewed.
