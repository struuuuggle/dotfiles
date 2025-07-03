# .zshenv

########################################

# Compile .zshrc automatically
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# 環境変数
export LANG=ja_JP.UTF-8
export LC_ALL=$LANG
export TERM="xterm-256color"

export LESS='-I -M -R -j.5'
export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"
export LESSHISTFILE='/dev/null'
# see `man terminfo`
export LESS_TERMCAP_mb=$(tput bold)
export LESS_TERMCAP_md=$(tput bold; tput setaf 4) # fg: blue
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setab 7; tput setaf 0) # bg: white, fg: black
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput setaf 2) # green
export PAGER=less
export EDITOR='emacsclient -nw'

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

########################################
#PATH

if [[ `uname -m` == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export MINT_PATH="$HOME/.mint"
export MINT_LINK_PATH="$MINT_PATH/bin"

export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-16.jdk/Contents/Home"

export GOPATH="$HOME/go"

export OPENSSL_ROOT=$(brew --prefix openssl)
export LDFLAGS="-L$OPENSSL_ROOT/lib"
export CPPFLAGS="-I$OPENSSL_ROOT/include"
export PKG_CONFIG_PATH="$OPENSSL_ROOT/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_ROOT"

path=(
    # $JAVA_HOME/bin(N-/)
    # X11
    /usr/X11/bin(N-/)
    # GNU
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    # openssl
    $OPENSSL_ROOT/bin(N-/)
    # rbenv
    $HOME/.rbenv/shims(N-/)
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
    # Mint
    $MINT_LINK_PATH(N-/)
    # Java
    $JAVA_HOME/bin(N-/)
    # Go
    $GOPATH/bin/(N-/)
)

if command -v rbenv 1>/dev/null 2>&1; then
   eval "$(rbenv init --no-rehash -)"
fi

# 重複パスを登録しない
typeset -U path cdpath fpath manpath

#############################################
# Additional settings

export BAT_THEME="Dracula"
export FZF_DEFAULT_OPTS="--inline-info"

if command -v gh 1>/dev/null 2>&1; then
   eval "$(gh copilot alias -- zsh)"
fi
