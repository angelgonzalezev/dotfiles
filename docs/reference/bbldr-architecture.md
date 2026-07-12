# bbldr Architecture

`bbldr` is a dependency-free Bash dispatcher for Become Builder command-line
modules.

```text
~/.local/bin/
  bbldr                 dispatcher
  bbldr-dotfiles        dotfiles module
  bbldr-project         possible future module
```

When invoked as `bbldr dotfiles doctor`, the dispatcher resolves
`bbldr-dotfiles` through `PATH` and forwards `doctor` unchanged.

## Module Contract

A module must:

1. Be executable.
2. Use the name `bbldr-<module>`.
3. Support `help` and return non-zero for unknown commands.
4. Own its own versioning, state, and documentation.
5. Never overwrite a dispatcher or module it does not recognize.
6. Treat `--help` as read-only and reject unknown options.

The dispatcher owns only `help`, `version`, and module discovery. It does not
contain dotfiles-specific installation logic.

The dotfiles module reads its version from the repository `VERSION` file. The
dispatcher has an independent version so future modules can evolve separately.
