;;; Emacs4CL 0.4.0 <https://github.com/susam/emacs4cl>

;; Customize user interface.
(menu-bar-mode 0)
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-startup-screen t)

;; Theme
;; M-x list-colors-display for builtin colors
;; light green: honeydew
;(set-background-color ivory1)
;; Use my custom theme fshirotelin-them.el
;(load-theme 'fshirotelin t)
(load-theme 'manoj-dark t)

;; Use spaces, not tabs, for indentation.
(setq-default indent-tabs-mode nil)

;; use CUA mode
;(cua-mode t)
;(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;; Highlight matching pairs of parentheses.
(setq show-paren-delay 0)
(show-paren-mode)

;; Workaround for https://debbugs.gnu.org/34341 in GNU Emacs <= 26.3.
(when (and (version< emacs-version "26.3") (>= libgnutls-version 30603))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Write customizations to a separate file instead of this file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

;; Enable installation of packages from MELPA.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install packages.
(dolist (package '(slime paredit markdown-mode google-this))
  (unless (package-installed-p package)
    (package-install package)))

;; Configure SBCL as the Lisp program for SLIME.
(add-to-list 'exec-path "/usr/local/bin")
(load (expand-file-name "~/.roswell/helper.el"))
(setq inferior-lisp-program "ros -Q run")

;; Enable Paredit.
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(defun override-slime-del-key ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-del-key)

;; Configure packages
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package dired
             :ensure nil
             :config
             (setq dired-listing-switches "-agho --group-directories-first"
                   delete-by-moving-to-trash t))

(use-package autothemer
  :ensure t)

;; google from emacs using C-x g RET
(google-this-mode 1)
(global-set-key (kbd "C-x g") 'google-this-mode-submap)

;; save/restore opened files and windows config
(desktop-save-mode 1)

;; highlight TODO and other keywords
(defface hl-todo-custom-face
  '((t :foreground "#005f00" :background "#afd7af" :inherit (hl-todo)))
  "Face for highlighting TODOs.")
(defface hl-error-custom-face
  '((t :foreground "#ff0000" :background "#FFD0D0" :inherit (hl-todo)))
  "Face for highlighting errors.")
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       hl-todo-custom-face bold)
          ("FIXME"      hl-error-custom-face bold)
          ("KLUDGE"     h1-todo-custom-face bold)
          ("HACK"       hl-todo-custom-face bold)
          ("TEMP"       h1-todo-custom-face bold)
          ("NOTE"       hl-todo-custom-face bold)
          ("DEPRECATED" font-lock-doc-face bold))))

;;; Org mode

;; Shortcuts for storing links, viewing the agenda, and starting a capture
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)
;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

;; Notes
(setq org-capture-templates
      '(    
        ("n" "Note"
         entry (file+headline "~/Documents/Poemata/notes.org" "Random Notes")
         "** %?"
         :empty-lines 0)
        ))

;;; eshell
;; Sync aliases from bash
(defun eshell-load-bash-aliases ()
  "Read Bash aliases and add them to the list of eshell aliases."
  ;; Bash needs to be run - temporarily - interactively
  ;; in order to get the list of aliases.
  (with-temp-buffer
    (call-process "bash" nil '(t nil) nil "-ci" "alias")
    (goto-char (point-min))
    (while (re-search-forward "alias \\(.+\\)='\\(.+\\)'$" nil t)
      (eshell/alias (match-string 1) (match-string 2)))))

;; We only want Bash aliases to be loaded when Eshell loads its own aliases,
;; rather than every time `eshell-mode' is enabled.
(add-hook 'eshell-alias-load-hook 'eshell-load-bash-aliases)
