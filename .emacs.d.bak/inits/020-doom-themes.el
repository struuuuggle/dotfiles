;;; 004-theme.el --- theme settings
;;; Commentary:
;;; Code:

(use-package doom-themes
    :custom
    (doom-themes-enable-italic t)       ; if nil, bold is universally disabled
    (doom-themes-enable-bold t)         ; if nil, italics is universally disabled
    :custom-face
    (doom-modeline-bar ((t (:background "#6272a4"))))
    :config
    (load-theme 'doom-dracula t)
    (doom-themes-neotree-config)
    (doom-themes-org-config))

(provide '020-doom-themes)
;;; 020-doom-themes.el ends here
