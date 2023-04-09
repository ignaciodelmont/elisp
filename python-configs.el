(use-package poetry
  :ensure t)


(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 
			 (with-eval-after-load 'poetry
			   (poetry-venv-workon)) ; ensure poetry venv is activated before lsp is triggered
			 
			 (require 'lsp-pyright)			
			 (lsp)
			 (flycheck-mode 1)
			 (flycheck-select-checker 'python-flake8))))


(use-package python-black
  :hook (python-mode . python-black-on-save-mode-enable-dwim))
