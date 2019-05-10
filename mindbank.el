;;; mindbank.el --- Major mode for keeping, taking, and orginising notes about books.

;; Copyright (C) Sebastian Mendez

;; Author: Sebastian Mendez
;; Maintainer: Sebastian Mendez
;; Created: 10 May 2019
;; Version: 0.01
;; Keywords:
;; Homepage:

(require 'sql)
(require 'dash)

;;; COMMENTARY:


;;; CODE:
(defvar mindbank-mode-map
  "Keymap for Mindbank mode")

(if mindbank-mode-map
    nil
  (setq mindbank-mode-map (make-keymap)))


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
  )


(provide 'mindbank)
;;; mindbank.el ends here

