---
name: dotfiles-document
description: Document verified behavior in this dotfiles repository. Use when adding or updating application pages, commands, shortcuts, installer behavior, recovery steps, troubleshooting, diagrams, screenshots, or VitePress navigation.
---

# Document Dotfiles Behavior

Read `../../../contributing/playbooks/document.md` completely before editing.

1. Inspect the effective config, command help, tests, and current docs.
2. Verify upstream facts with official sources when they may have changed.
3. Separate custom project behavior from application defaults.
4. Document exact paths, commands, shortcuts, compatibility, safety boundaries, and recovery.
5. Keep English concise, scannable, and consistent with nearby pages.
6. Update third-party notices for external assets, then run `node tests/docs-links.mjs` and `npm run docs:build`.
