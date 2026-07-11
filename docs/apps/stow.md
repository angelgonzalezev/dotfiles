# GNU Stow

GNU Stow is a symlink manager. It takes files arranged inside a package and
creates links to them under a target directory. In this project the target is
`$HOME`, so every package mirrors the path the application expects.

::: tip Why it matters
Stow lets applications read their normal paths while the real files remain in
one Git repository. Editing the live configuration therefore edits the tracked
file without a manual copy or synchronization step.
:::

![GNU Stow logo](/images/logos/gnu-stow-logo.webp)

## Official Resources

| Resource | URL |
| --- | --- |
| Website | [gnu.org/software/stow](https://www.gnu.org/software/stow/) |
| Manual | [GNU Stow manual](https://www.gnu.org/software/stow/manual/stow.html) |
| Source | [savannah.gnu.org/projects/stow](https://savannah.gnu.org/projects/stow/) |

## How Packages Map To Your Home Directory

```text
Repository source                         Live target
nvim/.config/nvim/init.lua             -> ~/.config/nvim/init.lua
wezterm/.config/wezterm/wezterm.lua     -> ~/.config/wezterm/wezterm.lua
tmux/.tmux.conf                         -> ~/.tmux.conf
tmux/.local/bin/tmux-dev                -> ~/.local/bin/tmux-dev
zsh/.zshrc                              -> ~/.zshrc
```

The top-level directory is the Stow package name. Everything below it is a
path relative to `$HOME`.

## Why This Project Uses `--no-folding`

By default, Stow may link an entire directory when it can. This repository uses:

```sh
stow --no-folding --target="$HOME" <package>
```

With `--no-folding`, `~/.config/nvim` remains a real directory and its managed
files are individual symlinks. This makes ownership clearer and allows another
unmanaged file to coexist in the parent directory.

Check a link:

```sh
ls -la ~/.config/nvim/init.lua
readlink ~/.config/nvim/init.lua
```

## Project Commands

Use the wrapper for normal relinking:

```sh
cd ~/.config/dotfiles
bin/dotfiles-install
bin/dotfiles-install nvim
bin/dotfiles-install nvim tmux zsh
```

The wrapper selects `$HOME`, enables `--no-folding`, and defaults to every
project package when no package is supplied.

::: warning Relinking is not a safe first install
`bin/dotfiles-install` does not back up conflicts. On a new machine or after
creating unrelated config files, use `bin/bootstrap`; it records and moves
conflicting targets before calling Stow.
:::

## Simulate Before Linking

Preview what Stow would do without modifying the filesystem:

```sh
cd ~/.config/dotfiles
stow --simulate --verbose --no-folding --target="$HOME" nvim
```

The bootstrap runs a simulation automatically after creating its backup and
before performing the real install.

## Unlink A Package

Remove only links belonging to a package:

```sh
cd ~/.config/dotfiles
stow --no-folding --target="$HOME" --delete nvim
```

This does not delete the source files from the repository. For an end-user
rollback, use the project restore command instead because it also returns the
configuration saved before installation:

```sh
bin/dotfiles-restore --backup latest nvim
```

## Conflicts

Stow refuses to replace a regular file with a symlink. A direct install may
produce a message similar to:

```text
WARNING! stowing nvim would cause conflicts
```

Do not use `--adopt` unless you understand that it can move target content into
the repository. The supported solution is to run bootstrap so the original is
placed in a timestamped backup and can be restored later.

## Verify All Managed Links

```sh
~/.config/dotfiles/bin/dotfiles-doctor
```

The doctor reports whether each expected target is linked, missing, or present
as an unmanaged file.
