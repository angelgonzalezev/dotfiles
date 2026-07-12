# Troubleshooting

Start with the project doctor:

```sh
~/.local/bin/bbldr dotfiles doctor
```

Doctor checks detected installed packages. Use a package name to narrow the
output or `--all` to diagnose configuration that has not been installed yet:

```sh
~/.local/bin/bbldr dotfiles doctor tmux
~/.local/bin/bbldr dotfiles doctor --all
```

It checks required commands, optional applications, managed paths, Git status,
and suspicious tracked filenames.

## Command Not Found

If `tmux-dev`, `tmux-agent`, `tmux-status`, or a user-installed Neovim cannot be
found, confirm that `~/.local/bin` is in `PATH`:

```sh
printf '%s\n' "$PATH" | tr ':' '\n'
source ~/.zshrc
command -v tmux-dev
```

## Neovim Search Does Not Work

`Space f g` uses ripgrep:

```sh
command -v rg
rg --version
```

Install it with `brew install ripgrep` on macOS or `sudo apt install ripgrep`
on Ubuntu/Debian.

Also verify the editor version and plugin state:

```sh
nvim --version | head -n 1
nvim --headless -i NONE -u ~/.config/nvim/init.lua +qa
```

Inside Neovim, run `:Lazy restore` and `:checkhealth`.

## Icons Are Empty Squares

Check that WezTerm can find the configured font:

```sh
wezterm ls-fonts | rg 'JetBrainsMono Nerd Font'
```

Reload WezTerm after installing the font. The configuration falls back to
JetBrains Mono for normal text, but tmux and Neovim icons need the patched Nerd
Font glyphs.

## tmux Status Is Missing

```sh
ls -la ~/.local/bin/tmux-status
~/.local/bin/tmux-status
tmux show-options -g status-right
tmux source-file ~/.tmux.conf
```

Reinstall all tmux links if the command is absent:

```sh
cd ~/.config/dotfiles
bbldr dotfiles install --config-only tmux
```

## A Custom Shortcut Does Not Work

Identify which layer owns the shortcut:

| Shortcut | Owner | Diagnostic |
| --- | --- | --- |
| `Cmd+Option+Left/Right` | WezTerm | `wezterm show-keys` |
| `Ctrl+a`, then a key | tmux | `tmux list-keys -T prefix` |
| `Option+1/2/3/4` | tmux plus terminal key encoding | `tmux list-keys -T root M-1` |
| `Space f f/g/b` | Neovim | `:map <leader>f` inside Neovim |

For tmux changes, reload with `Ctrl+a`, then `r`. For WezTerm changes, press
`Cmd+R`. For Neovim changes, restart the editor.

## Config Is Present But Not Linked

```sh
~/.local/bin/bbldr dotfiles doctor
cd ~/.config/dotfiles
stow --simulate --verbose --no-folding --target="$HOME" nvim wezterm tmux zsh
```

Use `bbldr dotfiles install` rather than direct Stow if the simulation reports
conflicts.

## Repository Cannot Update

`bbldr dotfiles update` uses `git pull --ff-only`. Local changes or diverging
history can stop the update to avoid overwriting your work:

```sh
cd ~/.config/dotfiles
git status --short
git diff
```

Commit or stash intentional changes before running update again.

If the installer reports an unexpected origin, inspect it before changing
anything:

```sh
git -C ~/.config/dotfiles remote -v
```

The installer refuses to pull or execute a repository whose origin differs
from `BBLDR_DOTFILES_REPO_URL`.

## Update Reports A Partial Target

`partial` means some files from an installed package are linked and newer files
are not yet linked. Run:

```sh
bbldr dotfiles update
```

The update reconciles only installed packages. A `backup required` state means
an exact destination contains a different file; preview the installation before
accepting the backup:

```sh
bbldr dotfiles install --dry-run --config-only <package>
```

## Restore The Previous Setup

Follow [Backups and Restore](/guides/backups-and-restore). The usual command is:

```sh
~/.local/bin/bbldr dotfiles restore --backup latest
```

For complete project removal, use `bbldr dotfiles purge` rather than deleting
`~/.config/dotfiles` directly. The recovery guide explains how to proceed if
the repository has already been deleted.
