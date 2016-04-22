;;; readline-complete-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (company-readline ac-rlc-prefix-shell-dispatcher
;;;;;;  ac-rlc-setup-sources) "readline-complete" "readline-complete.el"
;;;;;;  (22296 16882 438200 315000))
;;; Generated autoloads from readline-complete.el

(autoload 'ac-rlc-setup-sources "readline-complete" "\
Add me to shell-mode-hook!

\(fn)" nil nil)

(autoload 'ac-rlc-prefix-shell-dispatcher "readline-complete" "\


\(fn)" nil nil)

(eval-after-load 'auto-complete '(eval '(ac-define-source shell '((candidates . rlc-candidates) (prefix . ac-rlc-prefix-shell-dispatcher) (requires . 0)))))

(autoload 'company-readline "readline-complete" "\
`company-mode' back-end using `readline-complete'.

\(fn COMMAND &optional ARG &rest IGNORE)" t nil)

;;;***

;;;### (autoloads nil nil ("readline-complete-pkg.el") (22296 16882
;;;;;;  731261 290000))

;;;***

(provide 'readline-complete-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; readline-complete-autoloads.el ends here
