---
name: dotfiles-add-app
description: Add a new application configuration package to this dotfiles repository. Use when creating a Stow package, registering managed targets, adding dependency handling, writing application documentation, or adding lifecycle tests for a new terminal tool.
---

# Add A Dotfiles Application

Read `../../../contributing/playbooks/add-app.md` completely before editing.

1. Inspect the package registry and the closest existing application package.
2. Run `bbldr dotfiles scaffold app <name>` when `bbldr` is installed, or
   `bin/bbldr-dotfiles scaffold app <name>` from a fresh clone.
3. Add portable configuration and keep generated state and secrets out.
4. Complete metadata, dependency behavior, documentation, assets, and tests.
5. Verify clean install, conflict backup, idempotency, restore, and uninstall.
6. Run `bin/bbldr-dotfiles check` and review the complete diff.
