(use-package python-mode
  :ensure t
  :hook (python-mode . (lambda()
			 (lsp)
			 (flycheck-mode 1)
			 (flycheck-select-checker 'python-flake8)			
			 )))

(use-package poetry
  :ensure t)

(use-package python-black
  :hook (python-mode . python-black-on-save-mode-enable-dwim))


