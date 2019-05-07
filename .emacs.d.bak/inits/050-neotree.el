;;; 050-neotree.el --- theme settings
;;; Commentary:
;;; Code:

(use-package neotree
    :after
    projectice
    :commands
    (neotree-show neotree-hide neotree-dir neotree-find)
    :custom
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    (setq neo-smart-open t)
    (setq neo-show-hidden-files t))

(if window-system (use-package all-the-icons))

;;; 050-neotree.el ends here
