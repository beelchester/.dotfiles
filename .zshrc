clear # stupid macos

# AS backend build flags
# export RUSTFLAGS="-L/opt/homebrew/opt/libomp/lib -lomp"
# export LIBRARY_PATH="/opt/homebrew/opt/libomp/lib:$LIBRARY_PATH"
# export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"

export CMAKE="$HOME/dev/backend/.vendor/tools/cmake/cmake-3.31.5-macos10.10-universal/CMake.app/Contents/bin/cmake"
export PATH="$HOME/dev/backend/.vendor/tools/cmake/cmake-3.31.5-macos10.10-universal/CMake.app/Contents/bin:$PATH"
export PKG_CONFIG_PATH="/Users/beel/dev/backend/vcpkg_installed/arm64-osx-release/lib/pkgconfig"

export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/sahil/.local/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
# export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"
# export PATH=$PATH:~/.android-sdk-macosx/platform-tools/
export PATH="$PATH:${HOME}/flutter/bin"
export PATH="$PATH:${HOME}/go/bin"
export PATH="$PATH:${HOME}/.config/tmux/plugins/tmuxifier/bin"
export PATH=$PATH:~/.cargo/bin/
export PATH="$PATH:/Applications/Zen Browser.app/Contents/MacOS"
# export VCPKG_ROOT=$HOME/vcpkg
# export PATH=$VCPKG_ROOT:$PATH
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"

# stops brew auto update
export HOMEBREW_NO_AUTO_UPDATE=1
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"

# export FFMPEG_INCLUDE_DIR="/Users/sahil/Developer/ffmpeg_builds/ffmpeg/include/"
# export FFMPEG_LIB_DIR="/Users/sahil/Developer/ffmpeg_builds/ffmpeg/lib/"

bindkey '^R' history-incremental-search-backward

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"
alias n='nvim'
alias cl='cargo literoom'
alias nrd='npm run dev'
alias ts='~/tmux-sessionizer'
alias tfs='~/tmux-fuzzy-sessions'
alias t='tmux'
alias ta='tmux a'
alias tk='tmux kill-session -t'
alias tn='tmuxifier new-session'
alias te='tmuxifier edit-session'
alias tks='tmux kill-server'
alias :q='clear'
alias :qa='exit'
alias la='ls -la'
alias lg='lazygit'

alias to="~/tmux-obsidian"
alias no="n /Volumes/VERACRYPT/Obsidian/saaa/"

# git aliases
alias gst='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gcsm='git commit -s -m'
alias glog='git log'
alias gcl="git clone"
alias gs='git stash'
alias gsa='git stash apply'

alias td="~/.config/aerospace/toggle_dvorak.sh"

eval "$(tmuxifier init -)"

export EDITOR="nvim"

ZSH_THEME="robbyrussell"

# source $HOME/notify_tmux.zsh

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
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


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

#source ~/fzf-git.sh/fzf-git.sh
export BAT_THEME="gruvbox-dark"

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

. "$HOME/.atuin/bin/env"

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"

bindkey '^f' atuin-search

bindkey -s '^O' 'ts^M'
bindkey -s '^A' 'tfs^M'
bindkey -s '^w' 'ls^M'
bindkey -s '^p' 'open .^M'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/beel/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/Users/beel/.bun/_bun" ] && source "/Users/beel/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by Antigravity
export PATH="/Users/beel/.antigravity/antigravity/bin:$PATH"
