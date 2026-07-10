# Managing Configurations

## Add A New Package

Create a package that mirrors the final path from `$HOME`.

Example for a fictional app:

```text
myapp/
  .config/
    myapp/
      config.toml
```

Then update:

```text
bin/dotfiles-install
bin/bootstrap
docs/README.md
README.md
```

## Install A Package

From the repo root:

```sh
bin/dotfiles-install nvim
bin/dotfiles-install wezterm
```

## Remove A Package

Unlink it with Stow:

```sh
stow --target="$HOME" --delete <package>
```

Then remove the package from the repo and update the docs.
