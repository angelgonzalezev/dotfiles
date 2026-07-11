# Daily Workflow

After installation, your live config files are symlinks into this repository.
That means you can edit your normal config paths and still keep everything
versioned in Git.

## Start A Development Session

Open WezTerm, move to a project, and choose a layout:

```sh
cd "$HOME/Projects/example"
tmux-dev example
```

Use the first pane for Neovim and the second for tests or a development server:

```sh
nvim .
```

For four simultaneous commands:

```sh
tmux-agent example-agents "$HOME/Projects/example"
```

Detach with `Ctrl+a`, then `d`. Return later with:

```sh
tmux attach -t example
```

The [application pages](/apps/wezterm) explain how terminal tabs, tmux windows,
tmux panes, and Neovim buffers differ.

## Update Local Configs

Pull the latest changes:

```sh
cd ~/.config/dotfiles
git pull --ff-only
```

If local files have uncommitted changes, commit or stash them before pulling.

## Edit Configs

These paths are managed by the repo:

```text
~/.config/nvim
~/.config/wezterm
~/.tmux.conf
~/.local/bin/tmux-dev
~/.local/bin/tmux-agent
~/.local/bin/tmux-status
~/.zshrc
```

You can edit either the live path or the repo path. Both point to the same
tracked files.

::: tip Example
Editing `~/.tmux.conf` changes `~/.config/dotfiles/tmux/.tmux.conf`.
:::

## Reload Changes

Some tools need to reload their config after editing.

| Tool | Reload command |
| --- | --- |
| Zsh | `source ~/.zshrc` |
| tmux | `tmux source-file ~/.tmux.conf` |
| WezTerm | `Cmd+R` inside WezTerm |
| Neovim | Restart Neovim, or source the relevant Lua file manually. |

## Save Changes

Review, commit, and push:

```sh
cd ~/.config/dotfiles
git status --short
git diff
git add -- <files>
git commit -m "Update dotfiles"
git push
```

## Check Before Publishing

Run:

```sh
bin/dotfiles-doctor
bin/dotfiles-check
git status --short
```

Before pushing, review every staged file:

```sh
git diff --cached
```

::: warning Do not publish secrets
Never commit API keys, tokens, SSH keys, local databases, credentials, or
machine-specific private paths.
:::

## Typical Change Flow

1. Edit a config file.
2. Reload the app.
3. Test the behavior.
4. Review the Git diff.
5. Commit the change.
6. Push it to GitHub.

```sh
nvim ~/.tmux.conf
tmux source-file ~/.tmux.conf
cd ~/.config/dotfiles
git diff
git add -- tmux/.tmux.conf
git commit -m "Update tmux config"
git push
```
