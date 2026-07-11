# Agent Instructions

This repository is Angel Gonzalez's open source terminal workspace for macOS
and Ubuntu/Debian.

## Architecture

- `bin/bbldr` is a generic dispatcher and must remain dotfiles-independent.
- `bin/bbldr-dotfiles` owns the dotfiles command surface.
- `config/packages.tsv` and `config/targets.tsv` are the package source of truth.
- Top-level app directories mirror `$HOME` for GNU Stow.
- `install.sh` is the small remote entry point.

## Rules

- Preserve backup, rollback, collision, dry-run, and restore safety.
- Never add credentials, histories, local caches, or private machine paths.
- Keep shared config portable; use `~/.zshrc.local` for local values.
- Update behavior, help, tests, and documentation together.
- Use `apply_patch` for manual edits and avoid unrelated refactors.

## Validation

```sh
npm ci
bin/bbldr-dotfiles check
git diff --check
```

Read the matching playbook in `contributing/playbooks/` before adding an app,
editing docs, preparing a contribution, or reviewing changes.
