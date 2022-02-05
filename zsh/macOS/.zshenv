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

export LESS='-I -M -R'
export LESSOPEN='| src-hilite-lesspipe.sh %s'
export LESSHISTFILE='/dev/null'
export PAGER=less
export EDITOR='emacsclient -nw'

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

########################################
#PATH

# Disable Loading Global Profiles
setopt no_global_rcs

if [[ `uname -m` == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export MINT_LINK_PATH=/opt/mint/bin
export MINT_PATH=/opt/mint/lib
export RBENV_ROOT=$(brew --prefix rbenv)
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-16.jdk/Contents/Home"

path=(
    # $JAVA_HOME/bin(N-/)
    # X11
    /usr/X11/bin(N-/)
    # GNU
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    # rbenv
    $RBENV_ROOT/bin(N-/)
    # pyenv
    $HOME/.pyenv/shims(N-/)
    # nodebrew
    $HOME/.nodebrew/current/bin(N-/)
    # stack(Haskell)
    $HOME/.local/bin(N-/)
    # Rust
    $HOME/.cargo/bin(N-/)
    # Go
    /usr/local/go/bin(N-/)
    # 雑用スクリプト
    $HOME/.local/bin(N-/)
    # /etc/paths に書いてあるもの
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    # Homebrew's sbin
    /usr/local/sbin(N-/)
    # Homebrew(M1)
    /opt/homebrew/bin(N-/)
    # Mint
    $MINT_LINK_PATH(N-/)
    # Java
    $JAVA_HOME/bin(N-/)
)

# rbenv
if command -v rbenv 1>/dev/null 2>&1; then
   eval "$(rbenv init -)"
fi

# pyenv
# if command -v pyenv 1>/dev/null 2>&1; then
#     eval "$(pyenv init -)"
# fi

export OPENSSL_ROOT=$(brew --prefix openssl)
export PATH="$OPENSSL_ROOT/bin:$PATH"
export LDFLAGS="-L$OPENSSL_ROOT/lib"
export CPPFLAGS="-I$OPENSSL_ROOT/include"
export PKG_CONFIG_PATH="$OPENSSL_ROOT/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_ROOT"
export BAT_THEME="Dracula"

# 重複パスを登録しない
typeset -U path cdpath fpath manpath
