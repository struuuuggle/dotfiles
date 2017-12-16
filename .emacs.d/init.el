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
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(setq load-path
  (append
  (list
  (expand-file-name "~/.emacs.d/elpa/")
  (expand-file-name "~/.emacs.d/lisp/")
  (expand-file-name "~/.emacs.d/inits/")
  )
  load-path))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((top . 23) (left . 2))))
 '(package-selected-packages
   (quote
    (markdown-preview-mode markdown-mode dashboard init-loader powerline ## atom-one-dark-theme package-utils atom-dark-theme rainbow-delimiters flycheck color-theme-sanityinc-solarized)))
 '(tab-always-indent t)
 '(tab-width 4))

;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;; スクロールを一行ずつにする
(setq scroll-step 1)

;; カーソル行をハイライトする
(global-hl-line-mode t)

;;透明度
(set-frame-parameter nil 'alpha 95)

;; 自動セーブの中止
(setq auto-save-default nil)

;; 警告音を消す
(setq visible-bell t)

;; 改行コードを表示する
;;(setq eol-mnemonic-dos "(CRLF)")
;;(setq eol-mnemonic-mac "(CR)")
;;(setq eol-mnemonic-unix "(LF)")

;;; init.el ends here
