;;; 005-keybind.el --- keys
;;; Commentary:
;;; Code:

;; optionをメタキーにする
(setq mac-option-modifier 'meta)

;; C-hにbackspaceと同じ処理を割り当てる
(global-set-key "\C-h" 'delete-backward-char)

(provide '005-keybind)
;;; 005-keybind.el ends here
