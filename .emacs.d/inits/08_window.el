;;; 08_window.el --- for window
;;; Commentary:
;;; Code:

;; ウィンドウサイズ
(setq default-frame-alist
      (append (list
               '(width . 100)
               '(height . 80)
               )
              default-frame-alist))

;;; 08_window.el ends here
