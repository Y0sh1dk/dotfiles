# Colors.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

ZSH_THEME="powerlevel10k/powerlevel10k"

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Enable plugins.
plugins=(
  history-substring-search
  per-directory-history
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Custom $PATH with extra locations.
export PATH=$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/go/bin:/usr/local/git/bin:$HOME/.composer/vendor/bin:$HOME/.krew/bin:$PATH

# Bash-style time output.
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
  share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
  share_path="/opt/homebrew/share"
else
  echo "Unknown architecture: ${arch_name}"
fi

# Allow history search via up/down keys.
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Completions.
autoload -Uz compinit && compinit
# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Once a week
export HOMEBREW_AUTO_UPDATE_SECS=604800

# K9s config
export K9SCONFIG=$HOME/.k9s

# Include alias file (if present)
[[ ! -f ~/.aliases ]] || source ~/.aliases

# Include funcion file (if present)
[[ ! -f ~/.functions ]] || source ~/.functions

# Include ANZ specific config
[[ ! -f ~/.anz ]] || source ~/.anz

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
