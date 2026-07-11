# Zsh And Oh My Zsh

Zsh is the interactive shell used by the terminal. Oh My Zsh manages the prompt,
plugins, and theme conventions used by this setup.

::: tip Why it matters
The shell is where every command starts. A clean prompt, shared history,
suggestions, and a stable `PATH` make the terminal faster and easier to use.
:::

## Official Resources

| Resource | URL |
| --- | --- |
| Zsh | [zsh.org](https://www.zsh.org/) |
| Oh My Zsh | [ohmyz.sh](https://ohmyz.sh/) |
| zsh-autosuggestions | [github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) |

## What It Is Used For Here

| Use | Notes |
| --- | --- |
| Prompt | Uses Oh My Zsh `robbyrussell` with the prompt arrow replaced by `👼`. |
| History | Shares shell history across tabs and sessions. |
| Suggestions | Enables `zsh-autosuggestions` when the plugin is installed. |
| Local commands | Adds `~/.local/bin` to `PATH` so commands like `tmux-dev` work anywhere. |
| Local overrides | Loads `~/.zshrc.local` for machine-specific config that should not be committed. |
| Homebrew | Activates `/opt/homebrew` or `/usr/local` automatically when needed. |

## Problems It Solves

| Problem | Solution in this setup |
| --- | --- |
| Prompt differs between machines. | The prompt is tracked and uses the `👼` icon. |
| Shell history is fragmented. | History is shared across tabs and sessions. |
| Local commands are hard to run globally. | `~/.local/bin` is added to `PATH`. |
| Private machine config leaks into Git. | `~/.zshrc.local` is loaded but not tracked. |

## First Steps

Reload the shell after installing:

```sh
source ~/.zshrc
```

Check that the config is linked:

```sh
ls -la ~/.zshrc
```

Check that local commands work:

```sh
command -v tmux-dev
command -v tmux-agent
command -v tmux-status
```

## Startup Order

When a new Zsh shell starts, this configuration performs the following steps:

1. Defines the Oh My Zsh directory.
2. Adds Homebrew to `PATH` on Intel or Apple Silicon macOS when necessary.
3. Selects the `robbyrussell` theme.
4. Configures persistent and shared command history.
5. Enables the Git plugin and conditionally enables autosuggestions.
6. Loads Oh My Zsh, or a small fallback prompt when it is not installed.
7. Adds `~/.local/bin` to `PATH`.
8. Loads private machine-specific configuration from `~/.zshrc.local`.
9. Replaces the theme arrow with the `👼` prompt symbol.

This order matters: local overrides load after the shared framework, while the
prompt replacement runs last so it can modify the theme-generated prompt.

## History Configuration

| Setting | Value | Effect |
| --- | --- | --- |
| History file | `~/.zsh_history` | Persists commands between terminal sessions. |
| In-memory entries | `50000` | Keeps a large searchable history in the active shell. |
| Saved entries | `50000` | Keeps the same maximum on disk. |
| `APPEND_HISTORY` | Enabled | Appends history instead of replacing the file. |
| `INC_APPEND_HISTORY` | Enabled | Writes commands incrementally rather than only on shell exit. |
| `SHARE_HISTORY` | Enabled | Makes commands available across tabs and tmux panes. |
| `HIST_IGNORE_DUPS` | Enabled | Avoids storing an immediate duplicate command. |
| `HIST_IGNORE_SPACE` | Enabled | Commands starting with a space are not saved. |
| `HIST_VERIFY` | Enabled | Places expanded history in the prompt for review before execution. |

::: warning History is not a secret store
`HIST_IGNORE_SPACE` helps with intentionally private commands, but it is not a
security boundary. Avoid entering tokens directly on the command line and use
environment files or secret managers when possible.
:::

## Plugins And Suggestions

| Plugin | Behavior |
| --- | --- |
| `git` | Adds Oh My Zsh Git aliases and helper functions. |
| `zsh-autosuggestions` | Shows suggestions from history and completion when its directory exists. |

Suggestions use a muted `#6c7086` color. The strategy first checks history and
then shell completion. Press the right arrow to accept a visible suggestion.

The Git plugin aliases belong to Oh My Zsh and may change with that project;
use `alias | rg git` or the
[official plugin reference](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
to inspect the installed version.

## Install Oh My Zsh

The tracked `zsh/.zshrc` is portable. It contains only shell behavior that
should be shared between machines.

Install Oh My Zsh manually:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install `zsh-autosuggestions`:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Then install the zsh config:

```sh
cd ~/.config/dotfiles
bbldr dotfiles install --config-only zsh
source ~/.zshrc
```

The interactive installer can also install Oh My Zsh and
`zsh-autosuggestions` for you:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)" -- zsh
```

Before installing this package on a machine that already has a large `.zshrc`,
move machine-specific exports and generated tool paths to `~/.zshrc.local`.
The installer backs up the existing `.zshrc`, but the tracked config should stay
portable.

On Ubuntu/Debian, the installer can install Zsh but does not change the login
shell. After testing the configuration, change it explicitly if desired:

```sh
chsh -s "$(command -v zsh)"
```

## Prompt Icon

The prompt icon is controlled by this line in `zsh/.zshrc`:

```sh
PROMPT="${PROMPT//➜/👼}"
```

The `robbyrussell` theme normally renders `➜`. This line keeps the rest of the
theme unchanged and only replaces that symbol.

To use a different icon, replace `👼` with another symbol:

```sh
PROMPT="${PROMPT//➜/❯}"
```

After changing it, reload the shell:

```sh
source ~/.zshrc
```

If the prompt does not change, open a new terminal tab or check that
`~/.zshrc` points to the repo:

```sh
ls -la ~/.zshrc
```

## Local Configuration

Keep machine-specific configuration in `~/.zshrc.local`:

```sh
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
```

That file is intentionally not managed by this repo.

Examples of values that belong in `~/.zshrc.local`:

```text
SDK paths
work credentials
machine-specific aliases
tool-generated PATH entries
private tokens
```

The local file can also contain aliases that should not be shared:

```sh
alias work-api='cd "$HOME/Projects/work-api"'
export EDITOR=nvim
```

Validate and reload after editing:

```sh
zsh -n ~/.zshrc.local
source ~/.zshrc
```

## Without Oh My Zsh

The tracked configuration still works when Oh My Zsh is absent. It enables
Zsh colors and shows a minimal `👼 <current-directory>` prompt. The Git plugin,
theme, and autosuggestions are skipped until their dependencies are installed.
