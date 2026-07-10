# Backups And Restore

The installer is designed to avoid deleting existing configuration. When it
finds a file or folder that would conflict with a managed package, it moves the
existing item into a timestamped backup folder.

::: tip Safety model
The bootstrap moves old files before linking new ones. It does not merge config
files automatically because automatic merges can hide mistakes.
:::

## Backup Location

Backups are stored in:

```text
~/.config/dotfiles-backups/<timestamp>/
```

Example:

```text
~/.config/dotfiles-backups/20260710-154500/.config/nvim
~/.config/dotfiles-backups/20260710-154500/.config/wezterm
~/.config/dotfiles-backups/20260710-154500/.tmux.conf
~/.config/dotfiles-backups/20260710-154500/.local/bin/tmux-dev
~/.config/dotfiles-backups/20260710-154500/.local/bin/tmux-agent
~/.config/dotfiles-backups/20260710-154500/.zshrc
```

## Inspect Backups

List backup folders:

```sh
ls -la ~/.config/dotfiles-backups
```

Inspect a specific backup:

```sh
find ~/.config/dotfiles-backups/<timestamp> -maxdepth 4 -print
```

## Restore A Backup

Remove the symlink and move the backup back.

Restore Neovim:

```sh
rm ~/.config/nvim
mv ~/.config/dotfiles-backups/<timestamp>/.config/nvim ~/.config/nvim
```

Restore WezTerm:

```sh
rm ~/.config/wezterm
mv ~/.config/dotfiles-backups/<timestamp>/.config/wezterm ~/.config/wezterm
```

Restore tmux:

```sh
rm ~/.tmux.conf
mv ~/.config/dotfiles-backups/<timestamp>/.tmux.conf ~/.tmux.conf
```

Restore a tmux layout command:

```sh
rm ~/.local/bin/tmux-dev
mv ~/.config/dotfiles-backups/<timestamp>/.local/bin/tmux-dev ~/.local/bin/tmux-dev
```

Restore Zsh:

```sh
rm ~/.zshrc
mv ~/.config/dotfiles-backups/<timestamp>/.zshrc ~/.zshrc
```

::: warning Use the correct timestamp
Replace `<timestamp>` with the backup folder you want to restore. If there are
multiple backups, inspect them before moving files back.
:::

## Reinstall After Restore

After restoring a previous config, you can reinstall the dotfiles package later:

```sh
cd ~/.config/dotfiles
bin/dotfiles-install nvim
```

## Change Backup Location

Use `DOTFILES_BACKUP_DIR`:

```sh
DOTFILES_BACKUP_DIR="$HOME/dotfiles-backups" ~/.config/dotfiles/bin/bootstrap
```
