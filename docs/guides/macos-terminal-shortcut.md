# macOS Terminal Shortcut

This setup uses WezTerm as the terminal app.

## Open WezTerm From A Command

Open WezTerm:

```sh
open -a WezTerm
```

Open WezTerm in the Desktop folder:

```sh
open -a WezTerm ~/Desktop
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

## Optional Shell Alias

Add this to `~/.zshrc.local` if you want a short shell command:

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
