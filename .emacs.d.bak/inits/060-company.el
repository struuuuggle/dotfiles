;;; 060-company.el --- for company
;;; Commentary:
;;; Code:

(add-hook 'after-init-hook 'global-company-mode)

(require 'company-lsp)
(push 'company-lsp company-backends)

(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(provide '060-company)
;;; 060-company.el ends here
