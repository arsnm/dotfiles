;;; lang/typst/doctor.el -*- lexical-binding: t; -*-

(unless (treesit-language-available-p 'typst)
  (warn! "Typst tree-sitter grammar is missing. Run `M-x treesit-install-language-grammar RET typst` inside Emacs."))

(unless (executable-find "typst")
  (warn! "Couldn't find `typst` in your PATH. Compilation will fail."))

(when (modulep! :tools lsp)
  (unless (executable-find "tinymist")
    (warn! "Couldn't find `tinymist` in your PATH. LSP support will fail to initialize.")))

(when (modulep! :editor format)
  (unless (executable-find "typstyle")
    (warn! "Couldn't find `typstyle` in your PATH. Code formatting will not work.")))
