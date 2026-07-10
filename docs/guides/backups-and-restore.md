# Backups And Restore

## Backup Location

The bootstrap moves existing config folders to:

```text
~/.config/dotfiles-backups/<timestamp>/.config/
```

Example:

```text
~/.config/dotfiles-backups/20260710-154500/.config/nvim
```

## Restore A Backup

Remove the symlink and move the backup back:

```sh
rm ~/.config/nvim
mv ~/.config/dotfiles-backups/<timestamp>/.config/nvim ~/.config/nvim
```

Use the same pattern for `wezterm`.

## Reinstall After Restore

```sh
cd ~/.config/dotfiles
bin/dotfiles-install nvim
```
