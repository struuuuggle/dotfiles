
;;; Commentary:
;;; Code:

;; optionをメタキーにする
(setq mac-option-modifier 'meta)

;; C-hにbackspaceと同じ処理を割り当てる
(global-set-key "\C-h" 'delete-backward-char)

(provide '05-keybind)
;;; 05-keybind.el ends here
