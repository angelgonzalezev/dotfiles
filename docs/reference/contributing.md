# Contributing

This project is maintained by Angel Gonzalez and accepts focused pull requests
that improve configuration, safety, documentation, tests, or portability.

The canonical workflow lives in the repository
[CONTRIBUTING.md](https://github.com/angelgonzalezev/dotfiles/blob/main/CONTRIBUTING.md).

## Local Validation

```sh
npm ci
bbldr dotfiles check
```

From a fresh clone where `bbldr` is not registered yet:

```sh
bin/bbldr-dotfiles check
```

The suite validates shell scripts, isolated homes, dry-run, command collisions,
install, restore, uninstall, docs links, application configs, VitePress, and
Git whitespace.

## Change Contract

| Change | Required companion work |
| --- | --- |
| New public command | Update command reference, help, and CLI tests. |
| Installer behavior | Update install, security, recovery docs, and isolated tests. |
| Application behavior | Update its app page with exact commands and shortcuts. |
| New package | Use scaffold, complete registry metadata, docs, assets, and lifecycle tests. |
| Agent workflow | Update the neutral playbook and both skill entry points. |

Never commit secrets, credentials, histories, caches, generated application
state, or machine-specific private paths.
