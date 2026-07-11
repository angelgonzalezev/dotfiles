# Path to your Oh My Zsh installation.
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"

# Homebrew is installed outside the default PATH on Apple Silicon Macs.
if ! command -v brew >/dev/null 2>&1; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

ZSH_THEME="robbyrussell"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

plugins=(git)

if [ -d "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions" ]; then
  plugins+=(zsh-autosuggestions)
fi

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  autoload -Uz colors && colors
  PROMPT='%F{green}👼%f %F{cyan}%~%f '
fi

export PATH="$HOME/.local/bin:$PATH"

# Keep local machine-specific exports, SDKs, tokens, and generated paths out of Git.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# Replace the robbyrussell arrow with the personal prompt icon.
PROMPT="${PROMPT//➜/👼}"
