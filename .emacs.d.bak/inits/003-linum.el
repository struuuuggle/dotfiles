;;; 003-linum.el --- custom settings for line number
;;; Commentary:
;;; Code:

;;行番号を常に表示する
(global-linum-mode t)

;;行番号をあらかじめ3桁分確保
(setq linum-format "%3d ")

;;; 003-linum.el ends here
