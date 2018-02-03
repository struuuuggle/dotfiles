;;; 08-window.el --- for window
;;; Commentary:
;;; Code:

;; ウィンドウサイズ
(setq default-frame-alist
      (append (list
               '(width . 100)
               '(height . 80)
               )
              default-frame-alist))

(provide '08-window)
;;; 08-window.el ends here
