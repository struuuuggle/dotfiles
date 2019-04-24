;;; init.el --- for general
;;; Commentary:
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(init-loader-load)
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/" ))
(package-initialize)

;; Load path
(setq load-path
      (append '("~/.emacs.d/elpa/"
                "~/.emacs.d/lisp/"
                "~/.emacs.d/inits/")
              load-path))

;; Preference
;; (require '000-face)
;; (require '001-bars)
;; (require '002-tab)
;; (require '003-linum)
;; (require '004-theme)
;; (require '005-keybind)
;; (require '006-flycheck)
;; (require '007-powerline)
;; (require '008-window)
;; (require '009-markdown)
;; (require '010-font)
;; (require '011-sound)
;; (require '012-savefile)
;; (require '020-doom-themes)
;; (require '030-whitespace)
;; (require '040-mode-line)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile dashboard-project-status company-box company-lsp company ivy magit neotree doom-themes ac-helm websocket web-server uuidgen powerline package-utils nyan-mode init-loader flycheck dracula-theme dashboard))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "nil")))))
