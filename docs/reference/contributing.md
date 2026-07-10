# Contributing

These steps are for maintaining the repository.

## Before Committing

```sh
bin/dotfiles-doctor
git status --short
```

Review every file before staging it. Do not commit credentials, tokens, local
state, caches, logs, or generated dependency folders.

## Commit Flow

```sh
git add -- <files>
git commit -m "Update dotfiles"
git push
```

## Useful Checks

```sh
git diff
git diff --cached
git ls-files
```
