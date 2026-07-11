# Security Model

Dotfiles installers operate on shell startup files and can install executable
software. Review the source and dry-run output before applying it.

## Trust Boundaries

| Input | Protection |
| --- | --- |
| Remote `install.sh` | Served over HTTPS from the repository; users should review it before execution. |
| Existing configuration | Moved into timestamped backups before links are created. |
| GNU Stow changes | Simulated before the real link operation. |
| `bbldr` command | Existing unrelated executables are never overwritten. |
| Repository updates | Require a clean worktree and fast-forward-only Git history. |
| Restore | Refuses to overwrite targets changed after installation. |
| Private machine values | Kept in untracked `~/.zshrc.local`. |

## Privileged Operations

`sudo` is used only on Ubuntu/Debian for APT packages, the WezTerm repository,
and its signing key. On macOS, Homebrew controls dependency installation. User
configuration, backups, fonts, Neovim's fallback release, and `bbldr` live under
the user's home directory.

## Remote Dependencies

Automatic mode can download Homebrew, current Neovim releases, WezTerm's APT
key and repository, JetBrainsMono Nerd Font, Oh My Zsh, and
zsh-autosuggestions. Dry-run reports the selected groups but does not download
or install them.

## Protect Local Data

- Run dry-run first.
- Review `bbldr dotfiles backups` after installation.
- Keep the backup directory until the setup has been used successfully.
- Never place secrets directly in shared config or command history.
- Review `git diff --cached` before every contribution.

## Command Collision Protection

The installer checks `PATH`, `~/.local/bin/bbldr`, and `bbldr-dotfiles`. It
updates only files carrying the Become Builder dispatcher marker or links
pointing to this repository. Any unrelated command causes installation to stop
before targets move.
