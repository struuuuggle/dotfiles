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
export LESS='-M -R'
export LESSHISTFILE='/dev/null'
export PAGER=less

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

########################################
#PATH

# Disable Loading Global Profiles
setopt no_global_rcs

export PYENV_ROOT="$HOME/.pyenv"

path=(
    # 雑用スクリプト
    $HOME/bin(N-/)
    # /etc/paths に書いてあるもの
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
)

# 重複パスを登録しない
typeset -U path cdpath fpath manpath
