# Backups And Restore

## Backup Location

The bootstrap moves existing config files and folders to:

```text
~/.config/dotfiles-backups/<timestamp>/
```

Example:

```text
~/.config/dotfiles-backups/20260710-154500/.config/nvim
~/.config/dotfiles-backups/20260710-154500/.tmux.conf
~/.config/dotfiles-backups/20260710-154500/.local/bin/tmux-dev
~/.config/dotfiles-backups/20260710-154500/.zshrc
```

## Restore A Backup

Remove the symlink and move the backup back:

```sh
rm ~/.config/nvim
mv ~/.config/dotfiles-backups/<timestamp>/.config/nvim ~/.config/nvim
```

Use the same pattern for `wezterm`.

For `tmux`, restore the config file directly:

```sh
rm ~/.tmux.conf
mv ~/.config/dotfiles-backups/<timestamp>/.tmux.conf ~/.tmux.conf
```

If a tmux layout command was backed up, restore it the same way:

```sh
rm ~/.local/bin/tmux-dev
mv ~/.config/dotfiles-backups/<timestamp>/.local/bin/tmux-dev ~/.local/bin/tmux-dev
```

For `zsh`, restore the shell config directly:

```sh
rm ~/.zshrc
mv ~/.config/dotfiles-backups/<timestamp>/.zshrc ~/.zshrc
```

## Reinstall After Restore

```sh
cd ~/.config/dotfiles
bin/dotfiles-install nvim
```
