;;; init.el --- for general
;;; Commentary:
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(init-loader-load)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ))

(require 'package)

;; Load path
(setq load-path
  (append
  (list
  (expand-file-name "~/.emacs.d/elpa/")
  (expand-file-name "~/.emacs.d/lisp/")
  (expand-file-name "~/.emacs.d/inits/")
  )
  load-path))

;; Preference
(require '000-face)
(require '001-bars)
(require '002-tab)
(require '003-linum)
(require '004-theme)
(require '005-keybind)
(require '006-flycheck)
(require '007-powerline)
(require '008-window)
(require '009-markdown)
(require '010-font)
(require '011-sound)
(require '030-whitespace)

;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;; 自動セーブの中止
(setq auto-save-default nil)


;;; init.el ends here
