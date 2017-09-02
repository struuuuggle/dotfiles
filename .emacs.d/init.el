;;; Use init-loader.el
;; ref. https://github.com/emacs-jp/init-loader

;; Load downloaded init-loader.el
;; ref. http://tatsuyano.github.io/blog/2013/03/19/emacs-el-get-init-loader/

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(setq load-path
  (append
  (list
  (expand-file-name "~/.emacs.d/elpa/")
  (expand-file-name "~/.emacs.d/lisp/")
  (expand-file-name "~/.emacs.d/init-loader/")
  )
  load-path))

;; Define directory of init files.
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((top . 23) (left . 2))))
 '(package-selected-packages
   (quote
	(powerline ## atom-one-dark-theme package-utils atom-dark-theme rainbow-delimiters flycheck color-theme-sanityinc-solarized)))
 '(tab-always-indent t)
 '(tab-width 4))

;;行番号を常に表示する
(global-linum-mode t)
 
;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;;; スクロールを一行ずつにする
(setq scroll-step 1)

;;テーマの読み込み
(load-theme 'manoj-dark t)

;;行番号をあらかじめ3桁分確保
;;http://lisphack.blog137.fc2.com/blog-entry-14.html
(setq linum-format "%2d ")

;; カーソル行をハイライトする
(global-hl-line-mode t)

;; Macのoptionをメタキーにする
(setq mac-option-modifier 'meta)

;; スクロールバーを非表示
(scroll-bar-mode 0)

;;for Ricty
(add-to-list 'default-frame-alist '(font . "ricty-15"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;for flycheck
(global-flycheck-mode)

;;for atom-one-dark-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/atom-one-dark-theme-20170117.1905/atom-one-dark-theme")
;;(load-theme 'atom-one-dark t)

;;透明度
(set-frame-parameter nil 'alpha 75)

;; 自動セーブの中止
(setq auto-save-default nil)

;; 警告音を消す
;; http://ap-www.cf.ocha.ac.jp/hito/index.php?emacs.el%A4%CE%C0%DF%C4%EA
(setq visible-bell t)


;;ウィンドウサイズ
(setq default-frame-alist
      (append (list
	'(width . 52)
	'(height . 80)
	)
	default-frame-alist))

;;for Powerline
(require 'powerline)

(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
                          (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face1)
                                     (powerline-major-mode face1)
                                     (powerline-raw " " face1)
                                     ;;(funcall separator-left face1 face2)
                                     (powerline-buffer-id nil )
                                     (powerline-raw " [ ")
                                     (powerline-raw mode-line-mule-info nil)
                                     (powerline-raw "%*" nil)
                                     ;;(powerline-raw " |")
                                     ;;(powerline-process nil)
                                     ;;(powerline-vc)
                                     (powerline-raw " ]")
                                     ))
                          (rhs (list ;;(powerline-raw "%4l" 'l)
                                     ;;(powerline-raw ":" 'l)
                                     (powerline-raw "ch=%2c" 'l)
                                     (powerline-raw " | ")
                                     (powerline-raw "%6p" )
                                     (powerline-raw " ")
                                     )))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs)) 
                             (powerline-render rhs)))))))

(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
                      :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'bold)
(make/set-face 'mode-line-2-fg "#AAAAAA" "#2F343D" 'bold)
(make/set-face 'mode-line-1-arrow  "#AAAAAA" "#3E4451" 'bold)
(make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)

(powerline-my-theme)


;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")
