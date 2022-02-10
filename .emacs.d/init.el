;;; init.el --- My init.el


;;; Commentary:

;;; See also [[https://emacs-jp.github.io/tips/emacs-in-2020]]
;;;
;;; Type `<f1> v` to see a description of variables
;;;
;;; :preface
;;; ↓
;;; :if, :when, :unless
;;; ↓
;;; :require
;;; ↓
;;; :config

;;; Code:

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;; Now you can use leaf!
(leaf leaf-tree :ensure t)
(leaf leaf-convert :ensure t)


;;; faces:

(leaf page-break-lines
  :emacs>= 24.4
  :ensure t
  :blackout t
  :global-minor-mode
  (global-page-break-lines-mode))

(leaf beacon
  :ensure t
  :if (window-system)
  :blackout t
  :custom
  (beacon-color . "#62f992")
  :config (beacon-mode 1))

(leaf dashboard
  :ensure t
  :require t
  :when (< (length command-line-args) 2)
  :custom
  (dashboard-banner-logo-title . "Welcome to Emacs!")
  ;; Value can be
  ;; 'official: which displays the official emacs logo
  ;; 'logo:     which displays an alternative emacs logo
  ;; 1, 2 or 3: which displays one of the text banners
  ;; "path/to/your/image.png" which displays whatever image you would prefer
  (dashboard-startup-banner . 'logo)
  (dashboard-center-content . t)
  (dashboard-items . '((recents . 10)
                       (projects . 5)
                       (agenda . 10)))
  (initial-buffer-choice . (lambda nil
                             (get-buffer "*dashboard*")))
  :config
  (dashboard-setup-startup-hook))

(add-to-list 'auto-mode-alist '("\\*dashboard*\\'" . dashboard-mode))

(leaf which-key
  :doc "Emacs package that displays available keybindings in popup"
  :ensure t
  :blackout t
  :hook (after-init-hook)
  :bind (which-key-mode-map
         ("C-x TAB" . which-key-C-h-dispatch))
  :custom
  ;; Set the time delay (in seconds) for the which-key popup to appear. A value of
  ;; zero might cause issues so a non-zero value is recommended.
  (which-key-idle-delay . 0.3)
  :config
  ;; 画面幅に応じて右端または下部に表示
  ;; (which-key-setup-side-window-right-bottom)
  :global-minor-mode t)

(leaf treemacs
  :ensure t
  :config
  :bind ([f8] . 'treemacs)
  :config
  (leaf treemacs-icons-dired
    :ensure t
    :commands treemacs-icons-dired-enable-once
    :hook ((dired-mode-hook . treemacs-icons-dired-enable-once)))
  (leaf treemacs-all-the-icons
    :ensure t))


;;; config:

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :custom ((user-full-name . "Mikiya Abe")
           (user-mail-address . "struuuuggle@gmail.com")
           (user-login-name . "struuuuggle")
           (history-delete-duplicates . t)
           (history-length . 1000)
           (select-enable-cliboard . t)
           (indent-tabs-mode . nil)
           (menu-bar-mode . nil)
           (display-line-numbers . t)
           (scroll-conservatively . 1)
           (mouse-wheel-scroll-amount . '(1 ((control) . 5)))
           (scroll-bar-mode . nil)
           (scroll-preserve-screen-position . t)
           (tool-bar-mode . nil)
           (truncate-lines . nil)))

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 0.1))
  :global-minor-mode global-auto-revert-mode)

(leaf delsel
  :doc "delete selection if you insert"
  :tag "builtin"
  :global-minor-mode delete-selection-mode)

(leaf paren
  :doc "highlight matching paren"
  :tag "builtin"
  :global-minor-mode show-paren-mode)

(leaf elec-pair
  :tag "builtin"
  :config
  ;; When enabled, typing an open parenthesis automatically inserts the corresponding closing parenthesis, and vice versa.
  (electric-pair-mode)
  :custom
  (electric-pair-delete-adjacent-pairs . t))

(leaf simple
  :tag "builtin"
  :custom
  ;; do not show line numbers in the mode line
  (line-number-mode . nil)
  ;; do not show column numbers in the mode line
  (column-number-mode . nil))

(leaf eldoc
  :tag "builtin"
  :blackout t)

(leaf restart-emacs
  :if window-system
  :ensure t)


;;; theme:

(leaf doom-themes
  :ensure t
  :custom-face
  (doom-modeline-bar . '((t (:background "#6272a4"))))
  :config
  (load-theme 'doom-dracula t)
  (doom-themes-treemacs-config)
  (doom-themes-org-config)
  (set-face-foreground 'vertical-border (doom-color 'base3)))

(when (not window-system)
  ;; linum
  (set-face-attribute 'line-number nil
                      :foreground "#999999")
  ;; background
  (set-face-background 'region "#565A6D")
  ;; comment & doc (see also 'font-lock-string-face)
  (set-face-foreground 'font-lock-comment-face "#8292c4")
  (set-face-foreground 'font-lock-doc-face "#8292c4")
  ;; 背景色をターミナルのそれに合わせる
  ;; `printf "\x1b]11;?\x1b\\"`を実行することでターミナルの背景色を取得できる
  (set-face-background 'default "2F23318C3FD1"))

;; linum
(set-face-attribute 'line-number-current-line nil
                    :foreground (doom-color 'green))

;; cursol
(set-cursor-color (doom-color 'green))


;;; sound:

;; アラートを無効化
(setq ring-bell-function 'ignore)


;;; indent:

;; タブ幅をスペース2つ分にする
(setq-default tab-width 2)

;; タブ文字ではなくスペースを使う
(setq-default indent-tabs-mode nil)

(leaf highlight-indent-guides
  :if (window-system)
  :blackout
  :hook
  ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled . t)
  (highlight-indent-guides-responsive . t)
  ;; column
  (highlight-indent-guides-method . 'character))


;;; flycheck:

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :emacs>= 24.3
  :blackout t
  :ensure t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :custom ((flycheck-emacs-lisp-initialize-packages . t))
  :hook (emacs-lisp-mode-hook lisp-interaction-mode-hook)
  :config
  (leaf flycheck-package
    :doc "A Flycheck checker for elisp package authors"
    :ensure t
    :config
    (flycheck-package-setup))

  (leaf flycheck-elsa
    :doc "Flycheck for Elsa."
    :emacs>= 25
    :ensure t
    :config
    (flycheck-elsa-setup)))


;;; ivy:

(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :blackout t
  :leaf-defer nil
  :custom ((ivy-initial-inputs-alist . nil)
           (ivy-use-selectable-prompt . t)
           (ivy-display-style . t)
           (ivy-height-alist . '((t lambda (_caller) (/ (frame-height) 2)))))
  :global-minor-mode t
  :config
  (leaf swiper
    :doc "Isearch with an overview. Oh, man!"
    :req "emacs-24.5" "ivy-0.13.0"
    :tag "matching" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :bind (("C-s" . swiper)))

  (leaf counsel
    :doc "Various completion functions using Ivy"
    :req "emacs-24.5" "swiper-0.13.0"
    :tag "tools" "matching" "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :blackout t
    :bind (("C-S-s" . counsel-imenu)
           ("C-x C-r" . counsel-recentf))
    :custom `((counsel-yank-pop-separator . "\n----------\n")
              (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group)))
    :global-minor-mode t)

  (leaf ivy-prescient
    :doc "prescient.el + Ivy"
    :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
    :tag "extensions" "emacs>=25.1"
    :url "https://github.com/raxod502/prescient.el"
    :emacs>= 25.1
    :ensure t
    :after prescient ivy
    :custom ((ivy-prescient-retain-classic-highlighting . t))
    :global-minor-mode t)

  (leaf ivy-rich
    :ensure t
    :global-minor-mode t))

(leaf prescient
  :doc "Better sorting and filtering"
  :req "emacs-25.1"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :custom ((prescient-aggressive-file-save . t))
  :global-minor-mode prescient-persist-mode)



;;; company:

(leaf company
  :doc "Modular text completion framework"
  :req "emacs-24.3"
  :tag "matching" "convenience" "abbrev" "emacs>=24.3"
  :url "http://company-mode.github.io/"
  :emacs>= 24.3
  :ensure t
  :blackout t
  :leaf-defer nil
  :bind ((company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("<tab>" . company-complete-selection))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom ((company-idle-delay . 0)
           (company-minimum-prefix-length . 1)
           (company-transformers . '(company-sort-by-occurrence)))
  :global-minor-mode global-company-mode)


;;; git:

(leaf magit
  :ensure t
  :bind
  ("C-x g" . magit-status)
  ("C-x M-g" . magit-dispatch-popup))

(leaf git-gutter
  :ensure t
  :custom
  (git-gutter:modified-sign . " ")
  (git-gutter:added-sign    . " ")
  (git-gutter:deleted-sign  . " ")
  :custom-face
  (git-gutter:modified . '((t (:background "#ffb86c"))))
  (git-gutter:added    . '((t (:background "#50fa7b"))))
  (git-gutter:deleted  . '((t (:background "#ff79c6"))))
  :config
  (global-git-gutter-mode +1))

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)

;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
;; (setq auto-revert-check-vc-info t)


;;; font:

;; 表示確認用:
;; 0123456789
;; 一二三四五六

(leaf cus-fonte
  :config (set-frame-font "-*-Fira Code-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1"))

(leaf fira-code-mode
  :when window-system
  :blackout t
  :doc "Emacs minor mode for Fira Code ligatures using prettify-symbols"
  :ensure t
  :global-minor-mode t)

(leaf all-the-icons
  :doc "A utility package to collect various Icon Fonts and propertize them within Emacs."
  :if (display-graphic-p)
  :require t
  :ensure t
  :config
  (leaf all-the-icons-ivy-rich
    :ensure t
    :init
    (all-the-icons-ivy-rich-mode 1)
    :require t)
  
  (leaf all-the-icons-dired
    :doc "Adds dired support to all-the-icons"
    :ensure t
    :hook ((dired-mode-hook . all-the-icons-dired-mode))))


;;; lsp

(leaf lsp-mode
  :require t
  :ensure t
  :hook
  (swift-mode-hook . lsp)
  :config
  (leaf lsp-ui
    :require t
    :ensure t
    :bind
    (:lsp-mode-map
     ("C-c C-r" . lsp-ui-peek-find-references)
     ("C-j" . lsp-ui-doc-show)
     ("C-c i" . lsp-ui-peek-find-implementation)
     ("M-s-0" . lsp-ui-imenu)
     ("C-c s" . lsp-ui-sideline-mode))
    :custom
    ;; lsp-ui-doc
    (lsp-ui-doc-enable . t)
    (lsp-ui-doc-include-signature . t)
    (lsp-ui-doc-position . 'at-point) ;; top, bottom, or at-point
    (lsp-ui-doc-max-width . 200) ;; Original value is 150
    (lsp-ui-doc-max-height . 300) ;; Original value is 13
    (lsp-ui-doc-use-childframe . t)
    (lsp-ui-doc-use-webkit . t)
    ;; lsp-ui-flycheck
    (lsp-ui-flycheck-enable . nil)
    ;; lsp-ui-sideline
    (lsp-ui-sideline-enable . nil)
    (lsp-ui-sideline-ignore-duplicate . t)
    (lsp-ui-sideline-show-symbol . t)
    (lsp-ui-sideline-show-hover . t)
    (lsp-ui-sideline-show-diagnostics . nil)
    (lsp-ui-sideline-show-code-actions . nil)
    ;; lsp-ui-imenu
    (lsp-ui-imenu-enable . nil)
    (lsp-ui-imenu-kind-position . 'top)
    ;; lsp-ui-peek
    (lsp-ui-peek-enable . t)
    (lsp-ui-peek-peek-height . 30)
    (lsp-ui-peek-list-width . 8)
    ;; never, on-demand, or always
    (lsp-ui-peek-fontify . 'always))
  
  (leaf lsp-sourcekit
    :require t
    :ensure t
    :after lsp-mode
    :custom
    ;; configure the package to point to the sourcekit-lsp executable
    `(lsp-sourcekit-executable . ,(string-trim (shell-command-to-string "xcrun --find sourcekit-lsp")))
    (lsp-sourcekit-extra-args . '("-Xswiftc"
                                  "-sdk"
                                  "-Xswiftc"
                                  "/Applications/Xcode-13.2.1.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
                                  "-Xswiftc"
                                  "-target"
                                  "-Xswiftc"
                                  "x86_64-apple-ios15.2-simulator"))))

(leaf swift-mode
  :require t
  :ensure t
  :config
  (add-to-list 'company-backends 'company-sourcekit)
  (leaf company-sourcekit
    :ensure t
    :doc "Completion for Swift projects via SourceKit with the help of SourceKitten"))



(leaf smart-jump
  :ensure t
  :bind
  ("s-b" . smart-jump-go)
  ("M-," . smart-jump-back))


;;; languages:

(leaf json-mode
  :doc "Major mode for editing JSON files with emacs"
  :ensure t
  :config
  (leaf json-reformat
    :doc "Reformat tool for JSON"
    :emacs>= 23
    :ensure t
    :custom
    (json-reformat:indent-width . 2)))


;;; org-mode:

(leaf org-mode
  :config
  (leaf org-keys
    :custom ((org-speed-commands-user . '(("d" org-todo "DONE")))))
  (leaf org-bullets
    :doc "utf-8 bullets for org-mod"
    :hook (org-mode-hook))
  (leaf org-download
    :doc "Drag and drop images to Emacs org-mode"
    :ensure t
    :custom ((org-download-image-dir . "~/Documents/Org/pictures/")))
  (leaf org-journal
    :doc "A simple org-mode based journaling mode"
    :ensure t
    :custom
    (org-journal-date-format . "%A, %d %B %Y"))
  :custom
  ;; dでタスクをDONEにする
  (org-speed-commands-user . '(("d" org-todo "DONE")))
  ;; 行を折り返す
  (org-startup-truncated . nil)
  ;; 画像をインラインで表示
  (org-startup-with-inline-images . t)
  ;; 見出しの余分な*を消す
  (org-hide-leading-stars . t)
  (org-todo-keywords . '((sequence "TODO" "DOING" "|" "DONE")))
  ;; スピードコマンドを有効化
  (org-use-speed-commands . t)
  ;; ファイルの場所
  (org-directory . "~/Documents/Org/")
  ;; org-babelに使用できる言語を追加する
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((shell . t)
                                 (swift . t)
                                 (python . t)
                                 (kotlin . t)
                                 (ruby . t)
                                 (emacs-lisp . t)))
  ;; Org-captureのテンプレート
  ;;
  ;; Template expansion
  ;; https://orgmode.org/manual/Template-expansion.html#Template-expansion
  ;;
  ;; %t: タイムスタンプ(日付のみ)
  ;; %T: タイムスタンプ(日付と時刻)
  ;; %u: 非アクティブなタイムスタンプ(日付のみ) 非アクティブなタイムスタンプはagendaに影響しない
  ;; %U: 非アクティブなタイムスタンプ(日付と時刻)
  ;; %?: テンプレートを補完した後のカーソルの位置
  ;; %i: リージョンがアクティブな状態でcaptureが呼び出されたときに、挿入されるリージョン
  (org-capture-templates .
                         '(("t" "✅ Todo" entry (file+headline "~/Documents/Org/task.org" "Tasks")
                            "* TODO %?\n   %U\n  %i\n  ")
                           ("m" "💡 Memo" entry (file+datetree "~/Documents/Org/memo.org")
                            "* %?\nEntered on %U\n  %i\n  ")
                           ("j" "🗓  Journal entry" entry (function org-journal-find-location)
                            "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")))
  :bind
  ;; org-mode
  ;; (global-set-key (kbd "C-c p") 'org-preview-html-mode)
  ;; Org-captureを呼び出す
  ("C-c c" . 'org-capture)
  ;; Org-agendaを呼び出す
  ("C-c a" . 'org-agenda)
  ;; memo.orgを開く
  ("C-c m" . 'open-memo)
  ;; task.orgを開く
  ("C-c t" . 'open-task))

(defun org-journal-find-location ()
  "Quoted from `https://www.mhatta.org/wp/2019/02/25/org-mode-101-8/`."
  (org-journal-new-entry t)
  (goto-char (point-min)))

(defun show-org-buffer (file)
  "Show an org-file FILE on the current buffer."
  (interactive)
  (if (get-buffer file)
      (let ((buffer (get-buffer file)))
        (switch-to-buffer buffer)
        (message "%s" file))
    (find-file (concat "~/Documents/Org/" file))))

(defun open-memo ()
  "Show an memo.org."
  (interactive)
  (show-org-buffer "memo.org"))

(defun open-task ()
  "Show an task.org."
  (interactive)
  (show-org-buffer "task.org"))


;;; projectile:

(leaf projectile
  :ensure t
  :blackout t
  :custom
  (projectile-switch-project-action . 'projectile-dired)
  (projectile-project-search-path . '("~/Documents/" "~/sandbox/" ("~/ghq/" . 3)))
  :config
  (projectile-mode +1)
  :bind ((projectile-mode-map
          ("s-p" . projectile-command-map))))


;;; keybind:

;; C-hにbackspaceと同じ処理を割り当てる
(global-set-key "\C-h" 'delete-backward-char)

;; alias of "M-g M-g"
(global-set-key "\M-g" 'goto-line)

;; カーソルのある行をコメントアウトする
(global-set-key (kbd "s-/") 'comment-line)
(global-set-key "\M-;" 'comment-line)

(global-set-key "\C-c\C-x" 'eval-buffer)



(provide 'init)
;;; init.el ends here
