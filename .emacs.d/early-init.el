;;; early-init.el --- The Early Init File -*- lexical-binding: t -*-

;;; Commentary:
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Early-Init-File.html
;; https://emacs-jp.github.io/tips/startup-optimization

;;; Code:

;; workaround:
;; https://github.com/d12frosted/homebrew-emacs-plus/issues/733
(let* ((cache-file (locate-user-emacs-file ".cache/exec-path"))
       (cached-path (when (file-exists-p cache-file)
                      (with-temp-buffer
                        (insert-file-contents cache-file)
                        (buffer-string))))
       (shell-path (if (and cached-path (> (length cached-path) 0))
                       cached-path
                     (replace-regexp-in-string
                      "[ \t\n\r]+\\'" ""
                      (shell-command-to-string "echo $PATH")))))
  (when (and (not (file-exists-p cache-file))
             (> (length shell-path) 0))
    (make-directory (file-name-directory cache-file) t)
    (with-temp-file cache-file
      (insert shell-path)))
  (when (> (length shell-path) 0)
    (setenv "PATH" shell-path)
    (setq exec-path (split-string shell-path path-separator))))

;; 起動処理中にGCを走らせない
;; init.elの最後でもとに戻す必要がある
(setq gc-cons-threshold most-positive-fixnum)

;; Emacsの起動時にパッケージを自動的に読み込まない
(setq package-enable-at-startup nil)
;; Prefer quickstart cache when available.
(defvar package-quickstart)
(setq package-quickstart t)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(ns-transparent-titlebar . t) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(setq-default mode-line-format nil)
(setq-default header-line-format nil)

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
