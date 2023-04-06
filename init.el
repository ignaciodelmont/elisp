;; Package management
(require 'package)

(setq package-archives
	     '(("melpa" . "http://melpa.org/packages/")
	       ("elpa" . "https://elpa.gnu.org/packages/")))

(print package-archives)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

; quelpa
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

; quelpa use-package
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)


;; UI
(scroll-bar-mode -1)  ; Disable visible scrollbar
(tool-bar-mode -1)    ; Disable the toolbar
(tooltip-mode -1)     ; Disable tooltips
(set-fringe-mode 2)   ; Some breathing room
(global-display-line-numbers-mode t) ; Line numbers

;; Default Behavior
(setq make-backup-files nil) ; don't store backup files anywhere
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t))) ; don't clutter up the filesystem with autosave files


(setq custom-file "~/elisp/emacs-custom.el")
(load custom-file)

;; Syntax
(use-package flycheck)


(use-package markdown-mode
  :mode "\\.md\\'"
  )

;; Modeline
(use-package all-the-icons)
(use-package doom-themes)
(use-package doom-modeline
  :init (doom-modeline-mode 1))


;; lsp
(setq lsp-diagnostic-package :none) ; disables lsp as default checker for flycheck (alongside other stuff)
(use-package lsp-ui :commands lsp-ui-mode)

;; Languages
(load "~/elisp/python-configs")

;; Org
(load "~/elisp/org-configs")

;; Copilot

; ref:  https://github.com/zerolfx/copilot.el
; in order to enable it run M-x copilot-login
    
(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :branch "main"
                   :files ("dist" "*.el"))
  :hook (prog-mode . copilot-mode))

(defun my/copilot-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (indent-for-tab-command)))

(with-eval-after-load 'copilot
  (define-key copilot-mode-map (kbd "<tab>") #'my/copilot-tab))

;; Shell
(use-package vterm
  :ensure t
  :config
  (setq vterm-shell "/bin/zsh")
  (setq vterm-max-scrollback 10000))


;; Company
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))


;; Magit
(use-package magit)
