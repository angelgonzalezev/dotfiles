# Review A Change

1. Prioritize data loss, command execution, privilege escalation, broken
   restore, non-idempotent install, and cross-platform regressions.
2. Confirm package metadata, sources, targets, help, docs, and tests agree.
3. Check that dry-run writes nothing and collision checks happen before moves.
4. Check failure paths as carefully as successful installation.
5. Verify local/private values are excluded from tracked config.
6. Run focused tests, then `bin/bbldr-dotfiles check`.
7. Report findings by severity with file and line references; state remaining
   test gaps even when no defect is found.
