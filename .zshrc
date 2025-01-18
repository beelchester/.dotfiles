clear # stupid macos

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/sahil/.local/bin:$PATH
# export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"
export PATH="$PATH:${HOME}/flutter/bin"
export PATH="$PATH:${HOME}/go/bin"
export PATH="$PATH:${HOME}/.tmux/plugins/tmuxifier/bin"
export PATH=$PATH:~/.cargo/bin/
# export VCPKG_ROOT=$HOME/vcpkg
# export PATH=$VCPKG_ROOT:$PATH
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"

# stops brew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# export FFMPEG_INCLUDE_DIR="/Users/sahil/Developer/ffmpeg_builds/ffmpeg/include/"
# export FFMPEG_LIB_DIR="/Users/sahil/Developer/ffmpeg_builds/ffmpeg/lib/"

bindkey '^R' history-incremental-search-backward

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
alias n='nvim'
alias nrd='npm run dev'
alias ts='~/tmux-sessionizer'
alias t='tmux'
alias ta='tmux a'
alias tk='tmux kill-session -t'
alias tn='tmuxifier new-session'
alias te='tmuxifier edit-session'
alias tks='tmux kill-server'
alias :q='clear'
alias :qa='exit'
alias la='ls -la'

alias to="~/tmux-obsidian"
alias no="n /Volumes/VERACRYPT/Obsidian/saaa/"

# git aliases
alias gst='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gcsm='git commit -s -m'
alias glog='git log'
alias gcl="git clone"

alias td="todoist"

eval "$(tmuxifier init -)"

export EDITOR="nvim"

ZSH_THEME="robbyrussell"

# source $ZSH/oh-my-zsh.sh # don't need this, unnecessary bloatware causing startup slowdown

# plugins=(git zsh-autosuggestions)
# using brew version instead of oh-my-zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh completion
# Using oh-my-zsh's function without loading oh-my-zsh.. with some color modification
autoload compinit
compinit
source $HOME/zsh-completions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#FAB387"
FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"


# https://github.com/starship/starship/issues/3418#issuecomment-2477375663
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

bindkey -v # vi mode
bindkey -M viins jk vi-cmd-mode # jk to exit insert mode
bindkey -v '^?' backward-delete-char # https://unix.stackexchange.com/questions/290392/backspace-in-zsh-stuck
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh
export BAT_THEME="Catppuccin Mocha"

alias ls='eza --color=always --icons=always'

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --icons=always --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.atuin/bin/env"

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^f' atuin-search

bindkey -s '^O' 'ts^M'
bindkey -s '^w' 'ls^M'
bindkey -s '^p' 'open .^M'
