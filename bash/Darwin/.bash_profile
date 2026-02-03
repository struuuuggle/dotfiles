export LANG=ja_JP.UTF-8
export PS1="[\h@\w]\\$ "

[[ -e ~/.bashrc ]] && . ~/.bashrc

[[ -e ~/.bash_profile.local ]] && . ~/.bash_profile.local

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
