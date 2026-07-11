# Contributing

This project is open source and maintained by Angel Gonzalez. Contributions are
welcome through pull requests when they improve the setup, documentation, safety,
or maintainability of the project.

## What Good Contributions Look Like

| Contribution | Good fit |
| --- | --- |
| Documentation improvements | Better explanations, clearer install steps, missing shortcuts. |
| Safer install logic | Better validation, clearer prompts, improved backups. |
| App configuration | Focused improvements to existing packages. |
| New package support | A well-scoped config package with docs and install support. |

::: info Project style
This repo is intentionally conservative. It should contain curated config that
is safe to publish and useful across machines.
:::

## Before Committing

Run:

```sh
bin/dotfiles-doctor
bin/dotfiles-check
git status --short
```

The equivalent npm entry point is `npm run check`.

Review every file before staging it:

```sh
git diff
```

Do not commit:

```text
credentials
tokens
SSH keys
local state
caches
logs
generated dependency folders
machine-specific private paths
```

## Commit Flow

```sh
git add -- <files>
git diff --cached
git commit -m "Update dotfiles"
git push
```

## Pull Request Flow

1. Fork the repository.
2. Create a branch.
3. Make a focused change.
4. Update docs when behavior changes.
5. Run checks.
6. Open a pull request explaining what changed and why.

Recommended branch naming:

```text
docs/improve-install-guide
config/update-tmux-layouts
fix/bootstrap-backups
```

## Useful Checks

```sh
git diff
git diff --cached
git ls-files
npm run docs:build
bash -n bin/bootstrap
bash -n bin/dotfiles-install
bash -n bin/dotfiles-restore
zsh -n zsh/.zshrc
```

## Documentation Changes

When adding or changing behavior, update the relevant docs:

| Change | Update |
| --- | --- |
| New app package | `docs/apps/<app>.md`, install docs, repository layout. |
| New command | `docs/reference/commands.md`. |
| New install behavior | `docs/getting-started/install.md`. |
| New safety behavior | `docs/guides/backups-and-restore.md`. |

## Continuous Integration

GitHub Actions runs the local check suite on macOS and Ubuntu. Pull requests
It also runs the isolated installer tests inside Debian 12. Pull requests must
preserve:

```text
shell syntax and ShellCheck
isolated install and restore behavior
Neovim configuration loading
VitePress production build
clean Git whitespace
```

When changing bootstrap or restore behavior, add a temporary-home regression
case to `tests/install-restore.sh`.

## License

This project uses the MIT License. You can use it, copy it, modify it, and
distribute your own version, as long as the license terms are preserved.
