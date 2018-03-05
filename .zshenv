########################################
#PATH

## 重複パスを登録しない
typeset -U path cdpath fpath manpath

#ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# nodebrew
export PATH="$PATH:$HOME/.nodebrew/current/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"

# Mecab
export PATH="$PATH:/usr/local/mecab/bin"

### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/zsh_autocomplete

# stack(Haskell)
export PATH="$PATH:$HOME/.local/bin"

########################################
