;;; early-init.el --- This file is loaded before the package system and GUI is initialized

;;; Commentary:
;; https://emacs-jp.github.io/tips/startup-optimization

;;; Code:

;; workaround:
;; https://github.com/d12frosted/homebrew-emacs-plus/issues/733
(let ((shell-path (string-trim (shell-command-to-string "echo $PATH"))))
  (setenv "PATH" shell-path)
  (setq exec-path (split-string shell-path path-separator)))

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

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Implied-Frame-Resizing.html
(setq frame-inhibit-implied-resize t)

;; Use plists for deserialization
;; https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setenv "LSP_USE_PLISTS" "true")

(provide 'early-init)
;;; early-init.el ends here
