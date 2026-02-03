;;; init.el --- The Init File -*- lexical-binding: t; -*-

;;; Commentary:

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Init-File.html

;;; Code:

;; https://emacs-jp.github.io/tips/startup-optimization
; (require 'profiler)
; (profiler-start 'cpu)

(defvar my-config-dir (expand-file-name "mine/" user-emacs-directory))
(defvar my-config-org (expand-file-name "init.org" my-config-dir))
(defvar my-config-el (expand-file-name "init.el" my-config-dir))
(defvar my-config-elc (expand-file-name "init.elc" my-config-dir))

(declare-function org-babel-tangle-file "ob-tangle")

(defun my/tangle-init-org ()
  "Tangle init.org into init.el."
  (interactive)
  (require 'org)
  (org-babel-tangle-file my-config-org my-config-el))

(defun my/load-init-config ()
  "Load pre-tangled init.el/init.elc, or fall back to init.org."
  (cond
   ((or (file-exists-p my-config-el) (file-exists-p my-config-elc))
    (when (and (file-exists-p my-config-org)
               (file-exists-p my-config-el)
               (file-newer-than-file-p my-config-org my-config-el))
      (if noninteractive
          (my/tangle-init-org)
        (message "init.org is newer than init.el; run M-x my/tangle-init-org to update.")))
    (let ((config-to-load (if (and (file-exists-p my-config-elc)
                                   (or (not (file-exists-p my-config-el))
                                       (file-newer-than-file-p my-config-elc my-config-el)))
                              my-config-elc
                            my-config-el)))
      (load config-to-load nil 'nomessage)))
   ((file-exists-p my-config-org)
    (require 'org)
    (org-babel-load-file my-config-org))
   (t
    (message "No init.org/init.el found in %s" my-config-dir))))

(my/load-init-config)

; (profiler-report)
; (profiler-stop)

;;; init.el ends here
