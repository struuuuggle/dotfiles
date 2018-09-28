;;; 004-theme.el --- theme settings
;;; Commentary:
;;; Code:

;; テーマの読み込み
;;-nwオプションをつけて起動した時としていない時でテーマを切り替える
(load-theme 'dracula t)

;; その他細かい色の設定
(set-face-background 'linum nil)
(set-face-foreground 'linum "#999999")
;; comment & doc (see also 'font-lock-string-face)
;; (set-face-foreground 'font-lock-comment-face "#8292c4")
(set-face-foreground 'font-lock-doc-face "#8292c4")
(provide '004-theme)
;;; 004-theme.el ends here
