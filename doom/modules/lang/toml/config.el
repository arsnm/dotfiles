;;; lang/toml/config.el -*- lexical-binding: t; -*-
;;
;; Flags:
;;      +lsp            start a language server (taplo).
;;      +tree-sitter    use the built-in 'toml-ts-mode' when the grammar is
;;                      installed.

(defvar +toml-column-width 80
  "Line width for TOML buffers.
Used for `fill-column', the whitespace-mode highlight, and taplo's
`column-width' when the project has no taplo config file.")

(defvar +toml-taplo-default-options nil
  "Extra taplo formatter options, as \"key=value\" strings.
Only used when no .taplo.toml / taplo.toml is found above the file, so a
project's own config always wins. `column_width' is added automatically from
`+tolm-taplo-width'. Example:
    (setq +toml-taplo-default-options
        \\='(\"indent_string = \" \"reorder_keys=false\"))")


;;
;;; Major mode

(use-package! toml-mode
  :mode "\\.toml\\'"
  :mode "/Cargo\\.lock\\'"
  :mode "/uv\\.lock\\'")

(when (and (modulep! +tree-sitter)
           (fboundp 'treesit-language-available-p)
           (treesit-language-available-p 'toml))
  (add-to-list 'major-mode-remap-alist '(toml-mode . toml-ts-mode)))

(setq-hook! '(toml-mode-hook toml-ts-mode-hook)
  fill-column +toml-column-width
  whitespace-line-column +toml-column-width
  ;; Format with the taplo CLI through Apheleia, not through the language server.
  +format-with-lsp nil)

;; Never reformat lockfiles: they're generated, and rewriting them makes noise.
(add-hook! '(toml-mode-hook toml-ts-mode-hook)
  (defun +toml-inhibit-format-in-lockfiles-h()
    (when (and buffer-file-name
               (string-suffix-p ".lock" buffer-file-name))
      (setq-local apheleia-inhibit t))))


;;
;;; Formatter (:editor format / Apheleia)

(defun +toml--locate-config (names)
  "Return the nearest config file named one of NAMES above the current file."
  (when buffer-file-name
    (when-let ((dir (locate-dominating-file
                     buffer-file-name
                     (lambda (d)
                       (cl-some (lambda (n) (file-exists-p (expand-file-name n d)))
                                names)))))
      (cl-loop for n in names
               for f = (expand-file-name n dir)
               if (file-exists-p f) return f))))

(defun +toml-taplo-args ()
  "Extra taplo arguments for the current buffer.
Pass the project's config explicitly if there is one; otherwise apply the
module's defaults."
  (append
   (when buffer-file-name
     (list "--stdin-filepath" buffer-file-name))
   (if-let ((config (+toml--locate-config '(".taplo.toml" "taplo.toml"))))
       (list "--config" config)
     (cl-loop for opt in (cons (format "column_width=%d" +toml-column-width)
                               +toml-taplo-default-options)
              append (list "--option" opt)))))

(when (modulep! :editor format)
  (set-formatter! 'taplo '("taplo" "format" (+toml-taplo-args) "-")
    :modes '(toml-mode toml-ts-mode)))


;;
;;; LSP

(when (modulep! +lsp)
  (add-hook 'toml-mode-local-vars-hook #'lsp! 'append)
  (add-hook 'toml-ts-mode-local-vars-hook #'lsp! 'append)

  (if (modulep! :tools lsp +eglot)
      (after! eglot
        (add-to-list 'eglot-server-programs
                     '((toml-mode toml-ts-mode) . ("taplo" "lsp" "stdio"))))
    ;; lsp-mode ships a taplo client (lsp-toml); just make sure it also
    ;; recognises toml-ts-mode buffers.
    (after! lsp-mode
      (add-to-list 'lsp-language-id-configuration '(toml-ts-mode . "toml")))))
