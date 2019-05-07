;;; 004-theme.el --- theme settings
;;; Commentary:
;;; Code:

;; テーマの読み込み
(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)       ; if nil, bold is universally disabled
  (doom-themes-enable-bold t)         ; if nil, italics is universally disabled
  :custom-face
  (doom-modeline-bar ((t (:background "#636463"))))
  :config
  (when window-system
    (load-theme 'doom-dracula t))
  (when (not window-system)
    (load-theme 'doom-one t))
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; その他細かい色の設定
(set-face-background 'linum nil)
(set-face-foreground 'linum "#999999")

;; comment & doc (see also 'font-lock-string-face)
(set-face-foreground 'font-lock-comment-face "#8292c4")
(set-face-foreground 'font-lock-doc-face "#8292c4")

;;; 004-theme.el ends here
