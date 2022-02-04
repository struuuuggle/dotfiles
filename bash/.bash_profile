export LANG=ja_JP.UTF-8
export PS1="[\h@\w]\\$ "

source .bashrc

if [ -f ~/.bashrc ] ; then

. ~/.bashrc

fi

eval "$(rbenv init -)"
