

;;; Commentary:
;;; Code:

;; テーマの読み込み
;;-nwオプションをつけて起動した時としていない時でテーマを切り替える
(load-theme 'manoj-dark t)
(if window-system (progn
                    ;;for atom-one-dark-theme
                    (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/atom-one-dark-theme-20170117.1905/atom-one-dark-theme")
                    (load-theme 'atom-one-dark t)
                    ))

(provide '04_theme)
;;; 04_theme.el ends here
