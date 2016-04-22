;; startup
(setq inhibit-startup-screen t)

;; path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-rails")
(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")


;; color-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/color-theme-20080305.34/themes")
(require 'color-theme)
;(require 'color-theme-desert)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (load-theme 'desert t)))


;; japanese
(set-language-environment "Japanese")
(set-default-coding-systems 'euc-japan)
(set-terminal-coding-system 'euc-japan)
(set-buffer-file-coding-system 'euc-japan)
;(set-default-font "-*-fixed-medium-r-normal-*-16-*-*-*-*-*-fontset-standard")
;(progn (load-library "canna") (canna))
(global-set-key [zenkaku-hankaku] 'anthy-mode)


;; require
(require 'auto-complete)
(require 'auto-complete-config)
(require 'smart-compile)
(require 'linum)
(require 'magit)
(require 'slime)
(require 'ac-slime)
(require 'popwin)
(require 'ruby-mode)
(require 'inf-ruby)
(require 'rcodetools)
(require 'ruby-electric)
(require 'ruby-block)
(require 'rails)
(require 'python)
(require 'python-mode)
(require 'jedi)
(require 'w3m)


;; auto-mode
(setq auto-mode-alist 
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.rhtml$" . html-mode) auto-mode-alist))

;; interpreter mode
(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode)) interpreter-mode-alist))

;; Other Setup
;; auto-complete
(global-auto-complete-mode t)

;; compilation-filter
(add-hook 'compilation-filter-hook
	  '(lambda  ()
	     (inf-ruby-auto-enter)
))

;; Common Lisp
;;(setq inferior-lisp-program "ccl")
(setq inferior-lisp-program "clisp")

(slime-setup '(slime-repl slime-fancy slime-banner))
(add-hook 'lisp-mode-hook
	  (lambda ()
	    (slime-mode t)
	    (define-key lisp-mode-map (kbd "C-c C-s") 'slime)
	    (define-key lisp-mode-map "\C-m" 'newline-and-indent)
	    (add-to-list 'ac-sources 'ac-source-slime)
	    ))
(add-hook 'comint-mode-hook
	  (lambda ()
	    (slime-mode t)
	    (auto-complete-mode t)
	    ))
;; for slime
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; for popwin
(push '("*slime-apropos*") popwin:special-display-config)
(push '("*slime-macroexpansion*") popwin:special-display-config)
(push '("*slime-description*") popwin:special-display-config)
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
(push '("*slime-xref*") popwin:special-display-config)
(push '(sldb-mode :stick t) popwin:special-display-config)
(push '(slime-repl-mode) popwin:special-display-config)
(push '(slime-connection-list-mode) popwin:special-display-config)

;; ruby
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process" t)
(autoload 'inf-ruby-setup-keybindings "inf-ruby"
  "Set local key defs for inf-ruby in ruby mode" t)
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-eval-binding "Pry.toplevel_binding")

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (robe-mode)
	     (ac-robe-setup)
;	     (inf-ruby-minor-mode)
;	     (run-ruby)
;	     (robe-start)
	     (ruby-electric-mode t)
	     (define-key ruby-mode-map "\C-m" 'newline-and-indent)
	     (define-key ruby-mode-map "\C-c\C-p" 'xmp)
	     (turn-on-font-lock)
	     (set-face-foreground font-lock-comment-face "pink")
	     (set-face-foreground font-lock-string-face "yellow")
	     (set-face-foreground font-lock-function-name-face "grey")
	     (set-face-foreground font-lock-variable-name-face "orange")
	     (set-face-foreground font-lock-keyword-face "LightSeaGreen")
	     (set-face-foreground font-lock-type-face "LightSeaGreen")
	     )
)
;(global-font-lock-mode 1)

(add-hook 'inf-ruby-mode-hook
	  '(lambda ()
	     (inf-ruby-minor-mode)
	     (ansi-color-for-comint-mode-on)
	     ))
;(eval-after-load 'ruby-mode
;  '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))
(defadvice robe-start (before setup-ruby-runner) (run-ruby))

(setq ruby-deep-indent-paren-style nil)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; rails
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))
(setq hippie-expand-try-functions-list
      '(try-compelte-abbrev
	try-complete-file-name
	try-expand-dabbrev))
(setq rails-use-mongrel t)
;;;(require 'rails)
(add-hook 'rails-minar-mode
	  '(lambda ()
	     (define-key rails-minor-mode-map "\C-c\C-p" 'rails-lib:run-primary-switch)
	     (define-key rails-minor-mode-map "\C-c\C-n" 'rails-lib:run-secondary-switch)
	     (setf rails-api-root "/home/shuta/rails/doc/api")))

;; python-mode
(add-hook 'python-mode-hook
	  '(lambda () 
	     (jedi:setup)
	     (define-key python-mode-map "\C-m" 'newline-and-indent)
	     (define-key python-mode-map "\C-cS" 'run-python)
))

(setq jedi:complete-on-dot t)


;; w3m
(setq w3m-use-cookies t)

;; font and face
;(setq default-frame-alist (append '(
;				    (foreground-color . "gray") ;
;				    (background-color . "black") ;
;				    (cursor-color . "blue") ;
;				    ) default-frame-alist))


;; Keyboard
;; smart-compile
(global-set-key (kbd "C-x c") 'smart-compile)
(global-set-key (kbd "C-x C-x") (kbd "C-x c C-m"))
(global-set-key [f9] 'linum-mode)
(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-c C-x C-e")
		'(lambda nil
		   (interactive)
		   (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c C-x C-g") 'magit-status)
