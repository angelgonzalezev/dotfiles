# Zsh And Oh My Zsh

Zsh is the interactive shell used by the terminal. Oh My Zsh manages the prompt,
plugins, and theme conventions used by this setup.

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

## Install Oh My Zsh

Install Oh My Zsh before installing the `zsh` package from this repo:

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

Before installing this package on a machine that already has a large `.zshrc`,
move machine-specific exports and generated tool paths to `~/.zshrc.local`.
The installer backs up the existing `.zshrc`, but the tracked config should stay
portable.

## Prompt Icon

The prompt icon is controlled by this line in `zsh/.zshrc`:

```sh
PROMPT="${PROMPT//➜/👼}"
```

To use a different icon, replace `👼` with another symbol:

```sh
PROMPT="${PROMPT//➜/❯}"
```

After changing it, reload the shell:

```sh
source ~/.zshrc
```

## Local Configuration

Keep machine-specific configuration in `~/.zshrc.local`:

```sh
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
```

That file is intentionally not managed by this repo.
