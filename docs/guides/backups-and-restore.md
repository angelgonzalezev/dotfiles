# Backups, Restore, And Uninstall

The installer records each target before GNU Stow creates links. Restore uses
that record to recover the pre-install state without deleting unrelated files.

## List Restore Points

```sh
bbldr dotfiles backups
```

Example:

```text
ID                     STATUS        LATEST   PACKAGES
20260711-154500        complete      yes      nvim,wezterm,tmux,zsh
20260711-160200        rolled-back            zsh
```

Each record contains:

```text
~/.config/bbldr/backups/dotfiles/<id>/manifest.tsv
~/.config/bbldr/backups/dotfiles/<id>/status
```

`latest` identifies the most recent successful run that actually changed a
configuration target. An idempotent reinstall does not replace it.

## Manifest States

| State | State before install | Restore action |
| --- | --- | --- |
| `absent` | The target did not exist. | Remove only links created by this project. |
| `moved` | A user file or directory existed. | Remove managed links and copy the backup back. |
| `managed` | The target already pointed to this repo. | Keep it unchanged. |

## Restore

Restore every package from the latest useful record:

```sh
bbldr dotfiles restore --backup latest
```

Restore selected packages or an exact record:

```sh
bbldr dotfiles restore --backup latest tmux
bbldr dotfiles restore --backup 20260711-154500 nvim zsh
```

For automation:

```sh
bbldr dotfiles restore --backup latest --yes
```

## Uninstall Configuration

Return all registered packages to their original state:

```sh
bbldr dotfiles uninstall
```

Or uninstall selected packages:

```sh
bbldr dotfiles uninstall tmux zsh
```

Uninstall searches backwards for each package's original `absent` or `moved`
record. It deliberately retains:

```text
installed applications and package managers
~/.config/dotfiles
~/.local/bin/bbldr
backup records
Oh My Zsh, plugins, and fonts
```

This makes it possible to inspect the result, recover manually, or reinstall.

## Protection Against Data Loss

Before restoring, the command checks that each path is absent or still points
to the recorded repository source. If a link was replaced by a local file,
restore stops:

```text
Refusing to overwrite a modified path: /home/user/.zshrc
```

Move the new file aside and retry:

```sh
mv ~/.zshrc ~/.zshrc.after-dotfiles
bbldr dotfiles restore --backup latest zsh
```

The backup remains available after a successful restore.

## Recover A Broken Shell

Start Zsh without loading configuration:

```sh
/bin/zsh -f
```

Then restore only Zsh:

```sh
~/.local/bin/bbldr dotfiles restore --backup latest --yes zsh
exec /bin/zsh
```

Using the absolute `bbldr` path works even when the normal shell `PATH` failed
to load.

## Failed Installation

When Stow fails after configuration has been moved, installation performs an
automatic rollback and writes `rolled-back` to the record. Inspect it with:

```sh
bbldr dotfiles backups
```

Resolve the reported dependency or conflict and run the installer again. Do
not delete the timestamped backup while diagnosing the failure.
