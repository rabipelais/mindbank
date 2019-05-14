;;; mindbank.el --- Major mode for keeping, taking, and orginising notes about books.

;; Copyright (C) Sebastian Mendez

;; Author: Sebastian Mendez
;; Maintainer: Sebastian Mendez
;; Created: 10 May 2019
;; Version: 0.01
;; Keywords:
;; Homepage:

(require 'sql)
(require 'ht)
(require 'dash)
(require 'calibre-mode)

;;; COMMENTARY:


;;; CODE:
(setq mindbank-buffer-name "*Mindbank*")

(defvar mindbank-mode-map
  "Keymap for Mindbank mode")

(if mindbank-mode-map
    nil
  (setq mindbank-mode-map (make-keymap)))


(setq mindmap--docs-table (ht-create))
(setq mindmap--docs-alist nil)

(defun mindbank-mode ()
  "Major mode for keeping, taking, and orginising notes about books.
Special commands:
\\{mindbank-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'mindbank-mode)
  (setq mode-name "Mindbank")
  (use-local-map mindbank-mode-map)
  (make-local-variable calibre-items)

  (run-hooks 'mindbank-mode-hook))

(defun mindbank-show ()
  "Show the dashboard for the mindbank."
  (interactive)
  (pop-to-buffer mindbank-buffer-name)
  (let ((books-alist (mindbank--read-docs)))
    (mindbank--display-docs books-alist)))

(defun mindbank--read-docs ()
  (let ((books-list-lines (split-string
			   (calibre-chomp
			    (calibre-query
			     (calibre-build-default-query ""))) "\n")))
    (--map (calibre-query-to-alist it) books-list-lines)))


(defun mindbank--display-docs (books-alist)
  (let ((books-strings (--map (calibre--make-item-selectable-string it) books-alist)))
    (insert (--reduce (concat acc "\n" it) books-strings))))

;;; UTILITY

(defun list-to-alist (l &optional acc)
  (if (>= (length l) 2)
      (let ((k (car l))
	    (v (cadr l))
	    (rest (cddr l)))
	(if rest
	    (list-to-alist rest (cons `(,k ,v) acc))
	  (cons `(,k ,v) acc)))
    acc))

(provide 'mindbank)
;;; mindbank.el ends here

