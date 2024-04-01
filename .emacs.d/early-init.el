;;; early-init.el --- This file is loaded before the package system and GUI is initialized

;;; Commentary:
;; https://emacs-jp.github.io/tips/startup-optimization

;;; Code:

;; 起動処理中にGCを走らせない
;; init.elの最後でもとに戻す必要がある
(setq gc-cons-threshold most-positive-fixnum)

;; Emacsの起動時にパッケージを自動的に読み込まない
(setq package-enable-at-startup nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(ns-transparent-titlebar . t) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; 直接編集画面へ遷移する
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(provide 'early-init)
;;; early-init.el ends here
