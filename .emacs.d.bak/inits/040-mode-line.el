;;; 040-mode-line.el --- Set mode-line-format
;;; Commentary:
;;; Code:

(setq mode-line-format
      (list
       '(:eval (list (nyan-create)))
       ))

(provide '040-mode-line)
;;; 040-mode-line.el ends here
