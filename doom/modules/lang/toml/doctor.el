;;; lang/toml/doctor.el -*- lexical-binding: t; -*-

(cond ((not (executable-find "taplo"))
       (warn! "Could not find taplo. Install it."))
      ((and (modulep! +lsp)
            (not (zerop (call-process "taplo" nil nil nil "lsp" "--help"))))
       (warn! "taplo was built without the 'lsp' feature. Reinstall correctly.")))

(when (and (modulep! +tree-sitter)
           (not (and (fboundp 'treesit-language-available-p)
                     (treesit-language-available-p 'toml))))
  (warn! "+tree-sitter is on but the TOML grammar isn't installed; falling back to toml-mode. Run M-x treesit-install-language-grammar RET toml"))

(unless (modulep! :editor format)
  (warn! ":editor format is disabled, so TOML buffers won't be formatted."))
