
;;; Commentary:
;;; Code:

;; optionをメタキーにする
(setq mac-option-modifier 'meta)

;; C-hにbackspaceと同じ処理を割り当てる
;; ref. http://akisute3.hatenablog.com/entry/20120318/1332059326
(global-set-key "\C-h" 'delete-backward-char)

(provide '05-keybind)
;;; 05-keybind.el ends here
