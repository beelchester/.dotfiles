# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/sahil/.local/bin:$PATH
export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"
export PATH="$PATH:${HOME}/flutter/bin"
export PATH="$PATH:${HOME}/go/bin"
export PATH="$PATH:${HOME}/.tmux/plugins/tmuxifier/bin"
export VCPKG_ROOT=$HOME/vcpkg
export PATH=$VCPKG_ROOT:$PATH
export ANDROID_NDK_HOME=/Users/sahil/Library/Android/sdk/ndk/26.1.10909125
export PATH=$HOME/gccrs-install/bin:$PATH

bindkey '^R' history-incremental-search-backward

# zsh autocomplete
# source /Users/sahil/zsh-autocomplete/zsh-autocomplete.plugin.zsh


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
alias n='nvim'
alias nrd='npm run dev'
alias jfr='just && flutter run -d macos'
alias ts='~/tmux-sessionizer'
alias t='tmux'
alias ta='tmux a'
alias tk='tmux kill-session -t'
alias tn='tmuxifier new-session'
alias te='tmuxifier edit-session'
alias tks='tmux kill-server'
alias cdf='source /Users/sahil/cdf.sh'

eval "$(tmuxifier init -)"

export EDITOR="nvim"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#FAB387"
FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

source $ZSH/oh-my-zsh.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# bun completions
[ -s "/Users/sahil/.bun/_bun" ] && source "/Users/sahil/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
bindkey -v # vi mode
bindkey -M viins jk vi-cmd-mode # jk to exit insert mode
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
