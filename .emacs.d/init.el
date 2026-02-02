;;; init.el --- My init.el

;;; Commentary:
;; http://blog.lambda-consulting.jp/2015/11/20/article/

;;; Code:

;; https://zenn.dev/zk_phi/books/cba129aacd4c1418ade4/viewer/a53ba0ad0d729886a1dc
(require 'profiler)
; (profiler-start 'cpu)

(defvar my-config-dir (expand-file-name "mine/" user-emacs-directory))
(defvar my-config-org (expand-file-name "init.org" my-config-dir))
(defvar my-config-el (expand-file-name "init.el" my-config-dir))
(defvar my-config-elc (expand-file-name "init.elc" my-config-dir))

(defun my/tangle-init-org ()
  "Tangle init.org into init.el."
  (interactive)
  (require 'org)
  (org-babel-tangle-file my-config-org my-config-el))

(when (and (file-exists-p my-config-org)
           (file-exists-p my-config-el)
           (file-newer-than-file-p my-config-org my-config-el))
  (message "init.org is newer than init.el; run M-x my/tangle-init-org to update."))

(let ((config-to-load (if (and (file-exists-p my-config-elc)
                               (file-newer-than-file-p my-config-elc my-config-el))
                          my-config-elc
                        my-config-el)))
  (load config-to-load nil 'nomessage))

; (profiler-report)
; (profiler-stop)

;;; init.el ends here
