---
name: dotfiles-review
description: Review changes to this dotfiles repository for defects and risk. Use for code review of installer, restore, uninstall, CLI, Stow packages, shell configuration, documentation, tests, CI, or contribution readiness.
---

# Review Dotfiles Changes

Read `../../../contributing/playbooks/review.md` completely before reviewing.

1. Inspect the diff and all affected contracts before forming conclusions.
2. Prioritize data loss, unsafe command execution, privilege use, manifest path
   validation, broken rollback, non-idempotency, and macOS/Linux divergence.
3. Confirm registry, targets, config, help, docs, and tests agree.
4. Run focused checks and then the complete suite when practical.
5. Report findings first, ordered by severity with file and line references.
6. State residual risk and missing coverage when no defect is found.
