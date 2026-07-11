# Add An Application

1. Inspect `config/packages.tsv`, `config/targets.tsv`, a similar Stow package,
   its application page, and lifecycle tests.
2. Run `bbldr dotfiles scaffold app <name>`.
3. Replace the empty source directory with portable application config.
4. Complete registry title, description, dependency group, and default flag.
5. Add platform-aware dependency logic only when automatic installation is
   safe on both supported platform families.
6. Document purpose, official sources, exact config, commands, shortcuts,
   integration, verification, and recovery.
7. Add clean, conflict, idempotent, restore, and uninstall test cases.
8. Run `bin/bbldr-dotfiles check` and inspect all generated links in a temporary
   home before proposing the change.
