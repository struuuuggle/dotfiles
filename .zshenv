# .zshenv

# 環境変数
export LANG=ja_JP.UTF-8
export LC_ALL=$LANG
export TERM="xterm-256color"

export LESS='-M -R'
export LESSOPEN='| src-hilite-lesspipe.sh %s'
export LESSHISTFILE='/dev/null/'

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

########################################
#PATH

# GNU
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
# nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"
# stack(Haskell)
export PATH="$HOME/.local/bin:$PATH"
#Rust
export PATH="$HOME/.cargo/bin:$PATH"
# 雑用スクリプト
export PATH="$HOME/bin:$PATH"
# 重複パスを登録しない
typeset -U path cdpath fpath manpath
