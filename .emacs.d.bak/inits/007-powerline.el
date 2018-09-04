;;; 007-powerline.el --- for powerline
;;; Commentary:
;;; Code:

;;for Powerline
(require 'powerline)

(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
                          (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face1)
                                     (powerline-major-mode face1)
                                     (powerline-raw " " face1)
                                     (if window-system (progn
                                                         (funcall separator-left face1 face2)
                                                         ))
                                     (powerline-buffer-id nil )
                                     ;;(powerline-raw " [")
                                     ;;(powerline-raw mode-line-mule-info nil)
                                     ;;(powerline-raw "%*" nil)
                                     ;;(powerline-raw " |")
                                     ;;(powerline-process nil)
                                     ;;(powerline-vc)
                                     ;;(powerline-raw "]")
                                     ))
                          (rhs (list (powerline-raw "[%2l:%2c]" 'l)
                                     (powerline-raw "%i" 'l)
                                     )))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs))
                             (powerline-render rhs)))))))

(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
                      :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'light)
(make/set-face 'mode-line-2-fg "#CCCCCC" "#2F343D" 'light)
(make/set-face 'mode-line-1-arrow  "#AAAAA" "#3E4451" 'bold)
(make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)


;; 上に定義したpowerline-my-themeを呼び出す
(powerline-my-theme)

;; There are five builtin themes:
;;(powerline-default-thme)
;;(powerline-center-theme)
;;(powerline-center-evil-theme)
;;(powerline-vim-theme)
;;(powerline-nano-theme)


(provide '007-powerline)
;;; 007-powerline.el ends here
