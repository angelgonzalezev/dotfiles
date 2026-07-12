# Frequently Asked Questions

## Is this a framework or Angel's setup?

It is Angel Gonzalez's opinionated terminal workspace. Other users can install
it unchanged, select packages, or fork it and adapt the registry and config.

## Does installation overwrite my existing configuration?

Only exact destination files that conflict are moved into a timestamped backup
before Stow runs. Other files in the same directory stay in place. Use dry-run
to see conflicts and restore or uninstall to recover the previous state.

## Does uninstall remove applications?

No. It restores configuration only. Homebrew, APT packages, fonts, Oh My Zsh,
plugins, the repository, `bbldr`, and backups remain installed.

## How do I remove the repository too?

Run `bbldr dotfiles purge`. It restores configuration and removes managed CLI
commands plus the clean repository. Applications and backups remain available.

## Why use `bbldr dotfiles` instead of `dotfiles`?

`dotfiles` is already used by unrelated command-line tools. `bbldr` is the
Become Builder dispatcher and `dotfiles` is one module in that ecosystem.

## Can I install only tmux or Neovim?

Yes:

```sh
bbldr dotfiles install tmux
bbldr dotfiles install nvim
```

`bbldr dotfiles doctor` and `update` automatically respect that partial
selection. Use `doctor --all` only when you want to check every package.

## Where should private values go?

Put shell-specific private values in `~/.zshrc.local`. Do not add tokens,
credentials, work paths, or histories to a tracked package.

## Why is `bbldr` not found immediately after installation?

Open a new Zsh session or run:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

The Zsh package adds this path automatically for future shells.

## How do I report a security problem?

Follow the private reporting instructions in the repository `SECURITY.md` and
avoid publishing credentials or exploit details in a public issue.
