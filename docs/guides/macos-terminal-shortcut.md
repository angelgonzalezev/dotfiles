# macOS Terminal Shortcut

This setup uses WezTerm as the terminal app. You can open it from a shell
command, from macOS Shortcuts, or through a custom alias.

## Open WezTerm From A Command

Open WezTerm:

```sh
open -a WezTerm
```

Open WezTerm in the Desktop folder:

```sh
open -a WezTerm ~/Desktop
```

Open WezTerm from the current shell with an alias:

```sh
alias terminal='open -a WezTerm'
```

## Create A Keyboard Shortcut

Use the macOS Shortcuts app to open WezTerm from anywhere:

1. Open the Shortcuts app.
2. Create a new shortcut.
3. Add the `Open App` action.
4. Select `WezTerm`.
5. Name the shortcut `Open WezTerm`.
6. Open the shortcut details.
7. Assign a keyboard shortcut.

Recommended shortcut:

```text
Ctrl + Option + T
```

::: tip Why this shortcut
`Ctrl + Option + T` is memorable and usually avoids conflicts with common
macOS and app-level shortcuts.
:::

## Store The Alias Safely

Add aliases to `~/.zshrc.local`, not to the tracked `zsh/.zshrc`:

```sh
alias terminal='open -a WezTerm'
```

Reload the shell:

```sh
source ~/.zshrc
```

Then run:

```sh
terminal
```

## Troubleshooting

Check that WezTerm is installed:

```sh
open -a WezTerm
```

If macOS says the app cannot be found, install it:

```sh
brew install --cask wezterm
```
