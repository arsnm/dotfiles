;; -*- no-byte-compile: t; -*-
;;; lang/typst/packages.el

(package! typst-ts-mode
  :recipe (:host codeberg
           :repo "meow_king/typst-ts-mode"
           :files (:defaults "*.el")
           :pre-build (require 'compile)))
