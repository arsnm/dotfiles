;;; lang/typst/config.el -*- lexical-binding: t; -*-

(use-package! typst-ts-mode
  :defer t
  :mode ("\\.typ\\'" . typst-ts-mode)
  :init
  ;; Register typst ts grammar upstream
  (when (boundp 'treesit-language-source-alist)
    (add-to-list 'treesit-language-source-alist
                 '(typst "https://github.com/uben0/tree-sitter-typst")))

  (setq typst-ts-enable-raw-blocks-highlight t)
  :config
  (set-docsets! 'typst-ts-mode "Typst")

  (map! :map typst-ts-mode-map
        :localleader
        "c" #'typst-ts-compile-and-preview
        "w" #'typst-ts-watch-mode))

(add-hook! 'typst-ts-mode-hook
           #'doom-mark-buffer-as-real-h
           #'display-fill-column-indicator-mode)

(when (modulep! :editor word-wrap)
  (add-hook 'typst-ts-mode-hook #'+word-wrap-mode))

(when (modulep! :editor format)
  (set-formatter! 'typstyle '("typstyle") :modes '(typst-ts-mode)))

(when (modulep! :tools lsp)
  (when (modulep! :tools lsp +eglot)
    (after! eglot
      (add-to-list 'eglot-server-programs
                   '(typst-ts-mode . ("tinymist")))))

  (unless (modulep! :tools lsp +eglot)
    (after! lsp-mode
      (add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "typst"))
      (lsp-register-client
       (make-lsp-client
        :new-connection (lsp-stdio-connection "tinymist")
        :major-modes '(typst-ts-mode)
        :server-id 'tinymist))))

  (add-hook 'typst-ts-mode-hook
            (if (modulep! :tools lsp +eglot)
                #'eglot-ensure
              #'lsp-deferred)))
