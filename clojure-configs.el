(use-package paredit
  :ensure t)


(use-package clojure-mode
  :ensure t
  :hook (clojure-mode . (lambda ()
			  (print "hey there")
			  (lsp)
			  (subword-mode)
			  (paredit-mode)
			  )))

(use-package cider
  :ensure t)




