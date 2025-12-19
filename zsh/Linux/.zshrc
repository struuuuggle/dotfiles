# .zshrc.linux

########################################
# General

[[ -e ~/.zshenv.local ]] && . ~/.zshenv.local

# Compile .zshrc automatically
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# プロンプト
# %B...%b     : %Bと%bの間を太字にする
# %F{color}%f : %Fと%fの間の文字ををcolorにする
# %K{color}%k : %Kと%kの間の背景色をcolorにする
# %C          : カレントディレクトリ
# %~          : カレントディクトリ(ホームディレクトリ以下全て表示)
# %n          : ユーザー名
# %m          : ホスト名
local p_dir="%F{cyan}[%n@%~]%f"
local p_mark="%B%(?,%F{green},%F{red})%(!,#,$)%f%b"
# 1行表示
#PROMPT="$p_dir $p_mark "
# 2行表示
PROMPT='$p_dir $vcs_info_msg_0_
$p_mark '

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# VCS

autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '(%b|%a)'

precmd () { vcs_info }

##############nn##########################
# 補完

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# オプション

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# Disable Loading Global Profiles
setopt no_global_rcs


########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward


########################################
# エイリアス

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias du='du -h'

# GNU commands
alias grep='grep --color=always'
alias ls='ls --color=always'

# Emacs
alias e='emacsclient -nw -a ""'
alias ee='emacs &'
alias ekill='emacsclient -e "(kill-emacs)"'
alias magit='emacs -e "(magit)"'

# git
alias gs='git status'
alias gl='git log'
alias glp='git log --pretty=fuller'
alias ga='git add'
alias gbrm='git branch --merged|egrep -v "\*|develop|master|main"|xargs git branch -d'
alias gc='git commit'
alias gcm='git commit -m'
alias gsw='git switch'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gdc='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gr='git restore'
alias grs='git restore --staged'
alias gp='git push origin $(git branch --contains=HEAD | cut -d" " -f2-)'
alias c='(){git switch -c $1}'
alias gdhead="git diff origin/$(git config init.defaultBranch)...HEAD"

# Rails
alias r='bin/rails'

########################################
# function

# cdの後にlsを実行
chpwd() { ls -a }

select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてfzfを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | fzf +m --reverse -e --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    # zle -R -c                   # refresh
    zsh -R
}
zle -N select-history
bindkey '^R' select-history

gb() {
  if [ ! -d ".git" ]; then
    echo "\nError: Directory .git/ not found" 1>&2
    BUFFER="$ZLE_LINE_ABORTED"
    exit 1
  fi

  git branch -a --sort=-authordate \
      | cut -c 3- \
      | grep -v origin \
      | fzf \
      | xargs git switch
}

ghq-list() {
  REPOSITORY_PATH="$(ghq list | fzf +m --reverse -e)"
  if [ -z $REPOSITORY_PATH ]; then
    zle send-break
  fi

  BUFFER="cd $(ghq root)/$REPOSITORY_PATH"
  zle accept-line
}
zle -N ghq-list
bindkey '^]' ghq-list

ghpr() {
    GH_FORCE_TTY=100% gh pr list \
        | fzf +m --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window up --header-lines 3 \
        | awk '{print $1}' \
        | xargs gh pr checkout
}

# emacs daemonが起動していなければ、ホームディレクトリで`emacs --daemon`を実行する
estart() {
  if ! emacsclient -e 0 > /dev/null 2>&1; then
    ({
      cd
      emacs --daemon
      cd -
    } > /dev/null 2>&1 & )
  fi
}
estart
