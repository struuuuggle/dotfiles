#!/bin/sh

# Usage: sh install.sh

for f in .??*
do
    # symlinkを貼りたくないファイルを以下に書いておく
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".emacs.d.bak" ]] && continue

    echo "$f"
done
