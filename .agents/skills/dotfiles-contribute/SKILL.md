---
name: dotfiles-contribute
description: Implement and prepare a focused contribution to this dotfiles repository. Use when changing installer logic, CLI behavior, package configuration, tests, documentation, CI, or preparing a pull request.
---

# Contribute To Dotfiles

Read `../../../AGENTS.md`, `../../../CONTRIBUTING.md`, and
`../../../contributing/playbooks/contribute.md` completely before editing.

1. Inspect surrounding implementation and preserve unrelated changes.
2. Protect dry-run, backups, rollback, restore, and command collision behavior.
3. Update tests, help, and documentation with public behavior.
4. Run focused tests followed by `bin/bbldr-dotfiles check`.
5. Review the diff for secrets, private paths, and unrelated churn.
6. Summarize the problem, changes, safety impact, and verification for the PR.
