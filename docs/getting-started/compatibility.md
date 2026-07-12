# Compatibility

This page defines the environment the installer supports and the boundaries a
user should understand before applying the configuration.

## Supported Platforms

| Platform | Dependency automation | Configuration | CI coverage |
| --- | --- | --- | --- |
| Current macOS, Intel or Apple Silicon | Homebrew | Full | Current GitHub macOS runner |
| Ubuntu 22.04 and 24.04 | APT and official releases | Full | Lifecycle container |
| Debian 12 and 13 | APT and official releases | Full | Lifecycle container |
| Other Linux | Manual dependencies | Stow packages | Not guaranteed |
| Windows | None | Unsupported | None |

The shell scripts require Bash. The installed interactive shell configuration
is Zsh. GNU Stow performs configuration linking.

## Required Before The Remote Installer

The one-command installer needs these commands before it can start:

```sh
git --version
curl --version
bash --version
```

The installer can install the remaining selected dependencies. A stable HTTPS
connection is required for GitHub, Homebrew or APT, application releases,
fonts, Oh My Zsh, and plugins.

## Privileges

| Platform | Possible elevated action |
| --- | --- |
| macOS | Homebrew may request administrator approval during its own installation. |
| Ubuntu/Debian | `sudo` is used for APT packages, repositories, keys, and system package metadata. |

Configuration links, backups, the repository, `bbldr`, per-user fonts, and the
Linux Neovim fallback stay inside the user's home directory.

## Application Requirements

| Package | Runtime requirements |
| --- | --- |
| `nvim` | Neovim 0.10+, Git, ripgrep, internet access on first plugin install, and a Nerd Font for icons. |
| `wezterm` | WezTerm and a Nerd Font. Blur and integrated title buttons apply only on macOS. |
| `tmux` | tmux plus common system commands used by the status script. Battery data is optional. |
| `zsh` | Zsh. Oh My Zsh and autosuggestions are optional enhancements. |

## Unsupported Assumptions

- The installer does not change the login shell.
- It does not manage work credentials, SDK paths, SSH keys, or shell history.
- It does not remove package-manager dependencies during uninstall or purge.
- Moving the repository manually breaks symlinks; use purge and reinstall at
  the new `BBLDR_DOTFILES_DIR` instead.
- A custom backup directory must be writable and must not overlap a managed
  configuration target.
- Parent directories for managed targets must resolve inside `$HOME`; symlinks
  that redirect configuration directories outside the home directory are
  rejected.

Use [Install](/getting-started/install) for the supported workflow and
[Backups, Restore, And Uninstall](/guides/backups-and-restore) for recovery.
