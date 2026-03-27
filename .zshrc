[[ -n $ZSH_PROF ]] && zmodload zsh/zprof

export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3

if [[ -d /opt/homebrew ]]; then
  HB=/opt/homebrew
elif [[ -d /usr/local ]]; then
  HB=/usr/local
else
  HB=/opt/homebrew
fi

set -o vi

typeset -U path fpath
export GOBIN="${GOBIN:-$HOME/go/bin}"
BUN_INSTALL="$HOME/.bun"

path=(
  $HB/bin
  /opt/orbstack/bin
  $HB/opt/postgresql@16/bin
  $HB/opt/openjdk@21/bin
  $HB/opt/llvm/bin
  $HOME/.warpstream
  $HOME/.codeium/windsurf/bin
  $BUN_INSTALL/bin
  $GOBIN
  $path
)

# 編譯選項（合併而非覆蓋）
export CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }-I$HB/opt/openjdk@21/include -I$HB/opt/llvm/include"
export LDFLAGS="${LDFLAGS:+$LDFLAGS }-L$HB/opt/llvm/lib"

# Bun 補充（存在才載）
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

##### Completions（存在才加入）
[[ -d $HOME/.docker/completions ]] && fpath=($HOME/.docker/completions $fpath)
[[ -d $HB/share/zsh/site-functions ]] && fpath=($HB/share/zsh/site-functions $fpath)

##### 常用 alias
alias w=wireman
alias vim=nvim
alias vi=nvim
alias oldvim=vim
alias cat=bat
alias b=btop
alias f=fastfetch
alias k=kubectl
alias m=minikube
alias ls=lla   # 你原本的 lla 習慣保留
alias p8="ping 8.8.8.8"

##### fzf / 外掛（存在才載）
[[ -r ~/.fzf.zsh ]] && source ~/.fzf.zsh

# autosuggestions 先於 syntax-highlighting 載入；使用非同步降低互動延遲
export ZSH_AUTOSUGGEST_USE_ASYNC=1
[[ -r $HB/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $HB/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax-highlighting **最後** 載入
[[ -r $HB/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source $HB/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

##### TheFuck：懶載入（避免啟動時 eval 外部程式）
if command -v thefuck >/dev/null; then
  fuck() { unset -f fuck; eval "$(thefuck --alias fuck)"; fuck "$@"; }
  alias fk='fuck'
fi

##### LuaRocks（保留你的既有設定）
export LUA_PATH='/opt/homebrew/Cellar/luarocks/3.11.1/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?/init.lua;/opt/homebrew/lib/lua/5.4/?.lua;/opt/homebrew/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/Users/peter/.luarocks/share/lua/5.4/?.lua;/Users/peter/.luarocks/share/lua/5.4/?/init.lua'
export LUA_CPATH='/opt/homebrew/lib/lua/5.4/?.so;/opt/homebrew/lib/lua/5.4/loadall.so;./?.so;/Users/peter/.luarocks/lib/lua/5.4/?.so'

zmodload zsh/complist
autoload -Uz compinit
compinit -C -d "${ZDOTDIR:-$HOME}/.zcompdump-$ZSH_VERSION" 2>/dev/null
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${ZDOTDIR:-$HOME}/.zsh/cache"

setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY EXTENDED_GLOB INTERACTIVE_COMMENTS

RCFILE="${ZDOTDIR:-$HOME}/.zshrc"
if [[ -r "$RCFILE" && ( ! -s "${RCFILE}.zwc" || "$RCFILE" -nt "${RCFILE}.zwc" ) ]]; then
  zcompile -U "$RCFILE" 2>/dev/null
fi

[[ -n $ZSH_PROF ]] && zprof

plugins=(zsh-history-substring-search)
export PATH="$PATH:/Users/peter/.local/bin"

eval "$(zoxide init zsh)"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"
fpath=(/Users/peter/.docker/completions $fpath)
autoload -Uz compinit
compinit

export PNPM_HOME="/Users/peter/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="/Users/peter/.antigravity/antigravity/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
 export PATH="$PATH":"$HOME/.pub-cache/bin"
eval "$(uv generate-shell-completion zsh)"

