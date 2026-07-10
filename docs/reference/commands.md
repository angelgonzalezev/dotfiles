# Commands

## `bin/bootstrap`

One-command installer intended to run from any terminal.

```sh
curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/bin/bootstrap | bash
```

## `bin/dotfiles-install`

Links packages into `$HOME` with GNU Stow.

```sh
bin/dotfiles-install
bin/dotfiles-install nvim
bin/dotfiles-install wezterm
```

## `bin/dotfiles-doctor`

Checks the repo path, Stow availability, Git status, and tracked file names that
look sensitive.

```sh
bin/dotfiles-doctor
```

## `bin/dotfiles-status`

Shows compact Git status for the repo.

```sh
bin/dotfiles-status
```

## `bin/dotfiles-sync`

Shows status and prints the manual commit/push flow.

```sh
bin/dotfiles-sync
```
