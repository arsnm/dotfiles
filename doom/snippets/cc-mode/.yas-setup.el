;;; doom/snippets/cc-mode/.yas-setup.el -*- lexical-binding: t; -*-

(defun my/c-header-guard()
  "Header guard name from the file name: MyCamelCaseFile.h -> MY_CAMEL_CASE_FILE_H"
  (let* ((case-fold-search nil)
         (name (file-name-base (or buffer-file-name (buffer-name))))
         (snake (replace-regexp-in-string
                 "\\([[:lower:]]\\)\\([[:upper]]\\)" "\\1_\\2" name t)))
    ;; Also turn char that can't appear in a macro name (my-file -> MY_FILE_H
    (concat (upcase (replace-regexp-in-string "[^[:alnum:]_]" "_" snake)) "_H")))
