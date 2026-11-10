;;; doom/lsp.el -*- lexical-binding: t; -*-

(with-eval-after-load 'eglot
  (setq eglot-code-action-indications 'nil))

;; Python lsp (ty)
(with-eval-after-load 'python
  (set-eglot-client! '(python-mode python-ts-mode) '("ty" "server")))
