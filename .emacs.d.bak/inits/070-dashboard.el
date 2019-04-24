;;; 070-dashboard.el --- for dashboard
;;; Commentary:
;;; Code:

(require 'dashboard)
(dashboard-setup-startup-hook)
;; Set the title
;; (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
(setq dashboard-startup-banner "~/.emacs.d/banner/000-emacs.txt")
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))


(provide '070-dashboard)
;;; 070-dashboard.el ends here
