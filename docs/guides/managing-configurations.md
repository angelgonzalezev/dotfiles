# Managing Configuration Packages

Each application is a GNU Stow package whose source paths mirror their final
location below `$HOME`.

```text
nvim/.config/nvim/init.lua -> ~/.config/nvim/init.lua
tmux/.tmux.conf            -> ~/.tmux.conf
```

## Package Registry

Two tab-separated files are the source of truth:

| File | Content |
| --- | --- |
| `config/packages.tsv` | Name, default selection, dependency group, docs, title, and description. |
| `config/targets.tsv` | Package, target relative to `$HOME`, and source relative to the repo. |

Install, restore, uninstall, doctor, tests, and the documentation sidebar read
these files. Adding a package should not require editing command-specific lists.

```sh
bbldr dotfiles packages
```

This lists registry metadata and whether each package is currently linked.

## Scaffold An Application

```sh
bbldr dotfiles scaffold app myapp
```

This creates a default mapping:

```text
myapp/.config/myapp -> ~/.config/myapp
```

It also adds registry entries and `docs/apps/myapp.md`. The source directory is
intentionally empty: add the application's real configuration before testing.
Scaffold validates both registries and refuses to overwrite an existing package
directory or documentation page.

Then complete these areas:

| Area | Requirement |
| --- | --- |
| Configuration | Add only portable, useful source files. |
| Dependencies | Add platform-aware installation only when automatic support is safe. |
| Documentation | Explain purpose, official resources, exact behavior, shortcuts, and recovery. |
| Tests | Cover a clean target, an existing target, reinstall, restore, and uninstall. |
| UI | Add a real logo or screenshot when it helps users identify the application. |

Run:

```sh
bbldr dotfiles check
```

## Install And Remove A Package

```sh
bbldr dotfiles install --config-only nvim
bbldr dotfiles uninstall nvim
```

Use install rather than raw `stow` because it creates a restore manifest and
backs up exact conflicting files while preserving neighboring local files. Use
uninstall rather than `stow --delete` because it knows how to recover the
previous configuration and remove links introduced by later updates.

## Keep Local Values Private

Machine-specific Zsh configuration belongs in:

```text
~/.zshrc.local
```

Examples include private aliases, SDK paths, work credentials, tokens, and
tool-generated environment variables. The tracked `.zshrc` loads this file at
the end but the repository never manages it.

## Inspect Ownership

```sh
bbldr dotfiles status
readlink ~/.zshrc
readlink ~/.tmux.conf
readlink ~/.config/nvim/init.lua
```

When a path points inside `~/.config/dotfiles`, editing the live path edits the
Git working tree. A regular local file is not managed by Stow.
