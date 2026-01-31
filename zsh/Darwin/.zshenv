# .zshenv

########################################

# 環境変数
export LANG=ja_JP.UTF-8
export LC_ALL=$LANG
export TERM="xterm-256color"
export EDITOR='emacsclient -nw'

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

########################################
# PATH
export MINT_PATH="$HOME/.mint"
export MINT_LINK_PATH="$MINT_PATH/bin"

export GOPATH="$HOME/go"

path=(
    # X11
    /usr/X11/bin(N-/)
    # GNU
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    # pyenv
    # $HOME/.pyenv/shims(N-/)
    # stack(Haskell)
    $HOME/.local/bin(N-/)
    # Rust
    $HOME/.cargo/bin(N-/)
    # 雑用スクリプト
    $HOME/.local/bin(N-/)
    # Homebrew's sbin
    /usr/local/sbin(N-/)
    # Homebrew(M1)
    /opt/homebrew/bin(N-/)
    /opt/homebrew/sbin(N-/)
    # /etc/paths に書いてあるもの
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    # Java
    $JAVA_HOME/bin(N-/)
    # Go
    $GOPATH/bin/(N-/)
    # Mint
    $MINT_LINK_PATH(N-/)
)

# 重複パスを登録しない
typeset -U path cdpath fpath manpath

#############################################
