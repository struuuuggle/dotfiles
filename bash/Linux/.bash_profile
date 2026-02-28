export LANG=ja_JP.UTF-8

if [[ -n "${SSH_CONNECTION}${SSH_CLIENT}${SSH_TTY}" ]]; then
  export PS1="\[\e[33m\][\h@\w]\\$\[\e[0m\] "
else
  export PS1="[\h@\w]\\$ "
fi

[[ -e ~/.bashrc ]] && . ~/.bashrc

[[ -e ~/.bash_profile.local ]] && . ~/.bash_profile.local
