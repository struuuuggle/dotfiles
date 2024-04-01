;;; init.el --- My init.el

;;; Commentary:
;; http://blog.lambda-consulting.jp/2015/11/20/article/

;;; Code:

;; https://zenn.dev/zk_phi/books/cba129aacd4c1418ade4/viewer/a53ba0ad0d729886a1dc
(require 'profiler)
(profiler-start 'cpu)

(require 'org)
(defvar my-config-dir (concat user-emacs-directory "mine/"))
(org-babel-load-file (expand-file-name "init.org" my-config-dir))

(profiler-report)
(profiler-stop)

;;; init.el ends here
