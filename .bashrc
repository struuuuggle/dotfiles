alias e='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias ee='/Applications/Emacs.app/Contents/MacOS/Emacs &'
alias ssh_s15ti032='ssh s15ti032@zenith.edu.ics.saitama-u.ac.jp'
alias gimp='open -a GIMP.app'

#lsコマンドをglsコマンドに置き換え
alias ls='gls --color=auto'

#gidrcolorsコマンドでdircolors-solorizedを読み込む設定にする
eval $(gdircolors ~/.dircolors-solarized)

#シンボリックリンクの付け替えでsolarizedの各テーマを変更できるようにする
ln -fs ~/dircolors-solarized/dircolors.ansi-universal ~/.dircolors-solarized

#for bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi


### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/bash_autocomplete
