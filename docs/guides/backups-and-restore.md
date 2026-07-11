# Backups And Restore

The project can return your configuration to its pre-install state without
uninstalling applications. Bootstrap records every target before Stow creates
links, and the restore command uses that record to avoid deleting unrelated
files.

## Quick Restore

Restore all packages from the latest completed installation:

```sh
~/.config/dotfiles/bin/dotfiles-restore --backup latest
```

Review the summary and confirm with `y`. For a non-interactive terminal:

```sh
~/.config/dotfiles/bin/dotfiles-restore --backup latest --yes
```

::: warning What is not removed
Restore does not uninstall Homebrew, APT packages, Neovim, WezTerm, fonts, Oh
My Zsh, or plugins. It only restores configuration targets managed by Stow.
:::

## Restore Selected Packages

```sh
~/.config/dotfiles/bin/dotfiles-restore --backup latest tmux
~/.config/dotfiles/bin/dotfiles-restore --backup latest nvim wezterm
```

Restore a specific installation rather than the latest one:

```sh
~/.config/dotfiles/bin/dotfiles-restore --backup 20260711-154500 --yes
```

## Find Installation Records

```sh
ls -la ~/.config/dotfiles-backups
cat ~/.config/dotfiles-backups/latest
cat ~/.config/dotfiles-backups/<timestamp>/status
column -t -s $'\t' ~/.config/dotfiles-backups/<timestamp>/manifest.tsv
```

Manifest states mean:

| State | Before installation | Restore behavior |
| --- | --- | --- |
| `absent` | No target existed. | Remove only the link installed by dotfiles. |
| `moved` | User config was moved into the backup. | Remove the managed link and copy the old config back. |
| `managed` | Target already pointed to this repo. | Keep it unchanged. |

## Protection Against Data Loss

Before changing anything, restore verifies every selected target. It proceeds
only when a path is absent or is still a symlink owned by the recorded repo.

If you replaced a symlink with a new file after installation, restore stops:

```text
refusing to overwrite a modified path: /home/user/.zshrc
Move it elsewhere, then run the restore command again.
```

Preserve that file and retry:

```sh
mv ~/.zshrc ~/.zshrc.after-dotfiles
~/.config/dotfiles/bin/dotfiles-restore --backup latest zsh
```

The original backup remains in the timestamped folder after restoration.

## Recover A Broken Shell

If Zsh reports an error before showing a prompt, start it without loading
configuration:

```sh
/bin/zsh -f
```

Then restore only Zsh:

```sh
~/.config/dotfiles/bin/dotfiles-restore --backup latest --yes zsh
exec /bin/zsh
```

If the dotfiles repo uses a custom path, replace `~/.config/dotfiles` with that
path.

## Failed Installation

If Stow simulation or linking fails after files were moved, bootstrap runs an
automatic rollback and writes:

```text
rolled-back
```

to the installation record's `status` file. Check it with:

```sh
find ~/.config/dotfiles-backups -name status -maxdepth 2 -print -exec cat {} \;
```

Do not manually delete the backup. Run the doctor, resolve the reported
dependency or conflict, and start the installer again.

## Legacy Backups

Backups made by older versions may not contain `manifest.tsv`. Inspect those
folders manually:

```sh
find ~/.config/dotfiles-backups/<timestamp> -maxdepth 6 -print
```

First unlink the relevant package with Stow:

```sh
cd ~/.config/dotfiles
stow --no-folding --target="$HOME" --delete nvim
```

Only then move the old configuration back. Do not use `rm -rf` on
`~/.config/nvim` or `~/.config/wezterm`; they may contain files created after
installation.

## Reinstall Later

```sh
cd ~/.config/dotfiles
bin/dotfiles-install nvim
```

This relinks configuration only. It does not install dependencies or create a
new backup manifest; use bootstrap when you need the complete safe workflow.
