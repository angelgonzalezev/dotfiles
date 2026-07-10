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
```

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
bin/dotfiles-install zsh
source ~/.zshrc
```

The interactive bootstrap can also install Oh My Zsh and
`zsh-autosuggestions` for you:

```sh
~/.config/dotfiles/bin/bootstrap zsh
```

Before installing this package on a machine that already has a large `.zshrc`,
move machine-specific exports and generated tool paths to `~/.zshrc.local`.
The installer backs up the existing `.zshrc`, but the tracked config should stay
portable.

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
