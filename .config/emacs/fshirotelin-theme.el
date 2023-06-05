;;;; fshirotelin.el - My version of the Intellij/Vim/Vscode Shirotelin theme
;;;; original src - https://github.com/yasukotelin/shirotelin
(require 'autothemer)

(autothemer-deftheme
 fshirotelin "Shirotelin color theme for Emacs"

 ;; Only for graphical Emacs
 ((((class color) (min-colors #xFFFFFF)))

  ;; Color palette
  (shiro-black "#000000")
  (shiro-white "#FFFFFF")
  (shiro-dark-purple "#87005f")
  (shiro-light-purple "#af00af")
  (shiro-blue "#0300b0")
  (shiro-turqoise "#005f5f")
  (shiro-dark-green "#005f00")
  (shiro-dark-blue "#01005f")
  (shiro-light-green "#afd7af")
  (shiro-light-red "#FFD0D0"))

 ;; customize faces
 ((default (:foreground shiro-black :background shiro-white))
  (cursor (:background shiro-dark-blue))
  (error (:foreground "red" :bold t))
  (link (:foreground shiro-light-purple :underline t))
  (link-visited (:foreground shiro-light-purple :underline t))
  (region (:background shiro-light-green))
  (mode-line (:background shiro-light-green :box (:line-width -1 :color shiro-dark-green :style 'released-button)))
  (font-lock-keyword-face (:foreground shiro-dark-purple :bold t))
  (font-lock-string-face (:foreground shiro-blue))
  (font-lock-comment-face (:foreground shiro-dark-green))
  (font-lock-builtin-face (:foreground shiro-dark-blue))
  (font-lock-constant-face (:foreground shiro-turqoise))
  (font-lock-variable-name-face (:foreground shiro-black))
  (font-lock-type-face (:foreground shiro-turqoise :bold t))
  (font-lock-function-name-face (:foreground shiro-dark-blue :bold t))
  (font-lock-doc-face (:foreground shiro-dark-green :italic t))
  (hl-todo-custom-face (:foreground shiro-dark-green :background shiro-light-green))
  (hl-error-custom-face (:foreground "red" :background shiro-light-red :bold t))))

(provide-theme 'fshirotelin)
