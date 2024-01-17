(progn
  (defvar bootstrap-version)
  (let ((bootstrap-file
         (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
        (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)))

(progn
  (straight-use-package 'use-package)
  (setq straight-use-package-by-default t))

(progn
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (setq-default mode-line-format '("%e "
                                   mode-line-modified
                                   " "
                                   mode-line-buffer-identification)))

(progn
  (use-package evil
    :init
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1))

  (use-package evil-collection
    :after evil
    :config
    (evil-collection-init))

  (use-package evil-commentary
    :config
    (evil-commentary-mode 1))

  (use-package evil-leader
    :init (global-evil-leader-mode)
    :config
    (evil-leader/set-leader "<SPC>")

    (evil-leader/set-key-for-mode 'clojure-mode
      "e" 'cider-eval-sexp-at-point)
    (evil-leader/set-key-for-mode 'emacs-lisp-mode
      "e" 'eval-last-sexp)))


(progn
  (use-package clojure-mode)

  (use-package cider
    :init
    (setq cider-allow-jack-in-without-project t)
    (setq cider-repl-pop-to-buffer-on-connect nil)
    (setq cljr-suppress-no-project-warning t)))

(progn
  (use-package parinfer
    :init
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'clojure-mode-hook #'parinfer-mode)))

(set-face-attribute 'default nil
   :font "JetBrainsMono Nerd Font Mono"
   :height 62
   :weight 'thin
   :foreground "white" :background "black")

(defalias 'yes-or-no-p 'y-or-n-p)

(add-hook 'clojure-mode-hook #'subword-mode)

(progn
  ; TODO: delete char should delete entire word
  (defun clojure/fancify-symbols (mode)
    (font-lock-add-keywords mode `(("(\\(fn\\)[\[[:space:]]"      (0 (progn (compose-region (match-beginning 1) (match-end 1) "λ"))))
                                   ("(\\(partial\\)[\[[:space:]]" (0 (progn (compose-region (match-beginning 1) (match-end 1) "Ƥ"))))
                                   ("(\\(comp\\)[\[[:space:]]"    (0 (progn (compose-region (match-beginning 1) (match-end 1) "∘"))))
                                   ("\\(#\\)("                    (0 (progn (compose-region (match-beginning 1) (match-end 1) "ƒ"))))
                                   ("\\(#\\){"                    (0 (progn (compose-region (match-beginning 1) (match-end 1) "∈")))))))
  (clojure/fancify-symbols 'clojure-mode))



(progn
  (require 'color)
  (defun hsl-to-hex (&rest args)
    (apply 'color-rgb-to-hex (apply 'color-hsl-to-rgb args))))


(progn
  (use-package rainbow-delimiters
    :init
    ; TODO: not working
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
    :config
    (progn
      (let (value)
        (dotimes (number 9 value)
          (set-face-attribute (intern (concat "rainbow-delimiters-depth-"
                                              (number-to-string (+ 1 number))
                                              "-face")) nil
                              :weight 'bold
                              :foreground (hsl-to-hex (/ (* (/ 100 8) number) 85.0)
                                                      1
                                                      (+ 0.45 (/ (* number 4) 100.0)))))))))



(use-package cider-eval-sexp-fu)



(progn
  (setq-default tab-width 2
                indent-tabs-mode nil))
