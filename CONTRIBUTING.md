# Contributing

Thank you for improving this open source workspace. Keep changes focused,
portable, documented, and safe for a user who already has terminal config.

## Setup

```sh
git clone https://github.com/<your-user>/dotfiles.git
cd dotfiles
npm ci
bin/bbldr-dotfiles check
```

## Workflow

1. Create a branch such as `fix/install-rollback` or `docs/tmux-shortcuts`.
2. Inspect the existing package, registry, tests, and app page before editing.
3. Keep private and machine-specific values outside tracked packages.
4. Update tests and documentation whenever behavior changes.
5. Run `npm run check` and review `git diff --check`.
6. Open a PR that explains the problem, behavior change, and verification.

## Add An Application

```sh
bbldr dotfiles scaffold app <name>
```

Then add real configuration, complete registry metadata, document exact
behavior and official resources, and test clean install, conflict backup,
reinstall, restore, and uninstall.

## Pull Request Checklist

- No credentials, tokens, histories, caches, or machine-specific paths.
- Public commands and help output agree.
- Registry, Stow sources, docs, and tests agree.
- macOS and Ubuntu/Debian behavior is explicit.
- Recovery behavior is documented for installer changes.
- New assets include verified upstream attribution and license notices.
- Every public subcommand handles `--help` and rejects unknown options.
- `npm run check` passes.

See `contributing/playbooks/` for task-specific workflows used by humans and
coding agents.
