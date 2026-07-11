# Repository Layout

```text
.
|-- .agents/skills/             Codex-compatible project skills
|-- .claude/skills/             Claude-compatible skill entry points
|-- .github/                    CI and contribution templates
|-- bin/
|   |-- bbldr                   Generic ecosystem dispatcher
|   `-- bbldr-dotfiles          Dotfiles module CLI
|-- config/
|   |-- packages.tsv            Package metadata
|   `-- targets.tsv             Managed path mappings
|-- docs/                       VitePress source and public assets
|-- nvim/                       Neovim Stow package
|-- tmux/                       tmux Stow package and layout commands
|-- wezterm/                    WezTerm Stow package
|-- zsh/                        Zsh Stow package
|-- tests/                      CLI and installation regression tests
|-- install.sh                  Remote installation entry point
|-- AGENTS.md                   Shared agent instructions
|-- CLAUDE.md                   Claude entry point
|-- CONTRIBUTING.md             Human contribution workflow
`-- SECURITY.md                 Security policy and reporting
```

## CLI Dispatch

`~/.local/bin/bbldr` converts the first argument into an executable name:

```text
bbldr dotfiles doctor
  -> locate bbldr-dotfiles in PATH
  -> execute bbldr-dotfiles doctor
```

The dispatcher is intentionally neutral. Another project can provide
`bbldr-project` without changing this repository.

## Package Sources

Stow packages mirror `$HOME`. The CLI reads `config/targets.tsv` rather than
hard-coding those paths in each operation. This keeps install, restore,
uninstall, status, doctor, docs, and tests aligned.

## Runtime State

Runtime files are outside the repository:

```text
~/.config/dotfiles                         Git checkout
~/.config/bbldr/backups/dotfiles           installation records
~/.local/bin/bbldr                         dispatcher
~/.local/bin/bbldr-dotfiles                module link
~/.zshrc.local                             private machine overrides
```

Dependencies, caches, histories, sessions, credentials, and local overrides
must not be added to a Stow package.
