(progn
    	(defvar bootstrap-version)
    	(let ((bootstrap-file
           (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory
                				(bootstrap-version 5))))
          		(unless (file-exists-p bootstrap-file)
            			(with-current-buffer
                          					(url-retrieve-synchronously)
                           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
                           'silent 'inhibit-cookies
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
                      				(dotimes (number 9 value))
                          					(set-face-attribute (intern (concat "rainbow-delimiters-depth-"
                                                                                                            																							(number-to-string (+ 1 number))
                                                                                                            																							"-face")) nil
                                                                            															:weight 'bold
                                                                            															:foreground (hsl-to-hex (/ (* (/ 100 8) number) 85.0
                                                                                                            																											1
                                                                                                            																											(+ 0.45 (/ (* number 4) 100.0)))))))))

(use-package cider-eval-sexp-fu)

(progn
    	(setq-default tab-width 2
                                  								indent-tabs-mode nil))

; (progn
;   (setq blue "#217dd9") (setq light-blue "#a6d2ff")
;   (setq cyan "cyan") (setq light-cyan "lightcyan")
;   (setq green "#24b353") (setq light-green "lightgreen")
;   (setq magenta "magenta") (setq light-magenta "lightmagenta")
;   (setq red "#b33024") (setq light-red "lightred")
;   (setq yellow "#d9b500") (setq light-yellow "lightyellow"))


; (progn
;   (setq inhibit-startup-screen t)

;   ;; show doc faster
;   (setq eldoc-idle-delay 0.2)

;   ;; (set-window-scroll-bars (minibuffer-window) nil nil)

;   (progn
;     (tool-bar-mode -1)
;     (menu-bar-mode -1))

;   ;; (progn
;   ;;   (set-window-scroll-bars (minibuffer-window) nil nil ))

;   (progn ;; don't blink cursor in normal mode
;     (add-hook 'evil-insert-state-entry-hook (lambda () (blink-cursor-mode +1)))
;     (add-hook 'evil-insert-state-exit-hook (lambda () (blink-cursor-mode -1))))

;   (setq-default mode-line-format '("%e "
;                                    mode-line-modified
;                                    " "
;                                    mode-line-buffer-identification))

;   (use-package paren
;       :config
;       (show-paren-mode +1))


;   ;; (progn
;   ;;   (defun add-side-padding-to-windows ()
;   ;;     (set-window-margins nil 1 1))
;   ;;   (add-hook 'window-configuration-change-hook 'add-side-padding-to-windows)
;   ;;   (add-hook 'writeroom-mode-hook
;   ;;             (lambda ())
;   ;;             (remove-hook 'window-configuration-change-hook 'add-side-padding-to-windows)))

;   ;; (progn
;   ;;   (defun add-top-padding-to-windows ()
;   ;;     (setq header-line-format " ")
;   ;;     (set-face-attribute 'header-line nil
;   ;;                         :background background
;   ;;                         :height 0.5
;   ;;                         :box nil))
;   ;;   (add-hook 'window-configuration-change-hook 'add-top-padding-to-windows))


;   (with-eval-after-load "evil"
;     (setq evil-normal-state-cursor `(,red (box . 3)))
;     (setq evil-visual-state-cursor `(,green (bar . 3)))
;     (setq evil-insert-state-cursor `(,blue (bar . 3))))

;   (use-package pretty-mode
;     :config
;     (global-pretty-mode t))

;   (use-package nav-flash
;     :config
;     (add-hook 'evil-jumps-post-jump-hook 'nav-flash-show)
;     (dolist (fn '(evil-window-top evil-window-middle evil-window-bottom))
;       (advice-add fn :after 'nav-flash-show)))

;   (fringe-mode 0)

;   ;; M-x
;   (use-package smex
;     :config
;     (smex-initialize)
;     (global-set-key (kbd "M-x") 'smex)))


; (progn
;   (use-package evil
;     :init
;     ;; evil-ex-search-vim-style-regexp t
;     ;; evil-ex-substitute-global t
;     ;; evil-respect-visual-line-mode t
;     ;; evil-symbol-word-search t
;     ;; evil-toggle-key ""
;     ;; evil-want-C-u-scroll t
;     ;; evil-want-Y-yank-to-eol t
;     (setq evil-want-keybinding nil)
;     (setq evil-symbol-word-search t)
;     (setq evil-ex-substitute-global t)
;     :config
;     (evil-mode t)

;     (evil-define-key nil evil-normal-state-map
;       "\C-h" 'evil-window-left
;       "\C-j" 'evil-window-down
;       "\C-k" 'evil-window-up
;       "\C-l" 'evil-window-right)

;     (global-set-key (kbd "C-x C-g") 'evil-show-file-info))

;   (use-package evil-surround
;     :config (global-evil-surround-mode 1))

;   (use-package evil-collection
;     :after evil
;     :config
;     (evil-collection-init))

;   (use-package evil-commentary
;     :config
;     (evil-commentary-mode 1))

;   (use-package evil-leader
;     :init (global-evil-leader-mode)
;     :config
;     (evil-leader/set-leader "<SPC>")

;     (evil-leader/set-key-for-mode 'clojure-mode
;       "e" 'cider-eval-sexp-at-point)
;     (evil-leader/set-key-for-mode 'emacs-lisp-mode
;       "e" 'eval-last-sexp)

;     (evil-ex-define-cmd "retab"
;                         '(lambda (&optional beg end)
;                            (interactive "r")
;                            (unless (and beg end)
;                              (setq beg (point-min)
;                                    end (point-max)))
;                            (if indent-tabs-mode
;                                (tabify beg end)
;                              (untabify beg end))))))

;     ;; (evil-define-command +evil:cd (&optional path)
;     ;;   "Change `default-directory' with `cd'."
;     ;;   (interactive "<f>")
;     ;;   (let ((path (or path "~")))
;     ;;     (cd path)
;     ;;     (message "Changed directory to '%s'" (abbreviate-file-name (expand-file-name path)))))

;     ;; (evil-ex-define-cmd "cd" '+evil:cd)))



; (progn
;   (use-package clojure-mode)

;   (use-package cider
;     ;; :hook (clojure-mode . cider-mode)
;     :init
;     (setq cider-allow-jack-in-without-project t)
;     (setq cider-repl-pop-to-buffer-on-connect nil)
;     (setq cljr-suppress-no-project-warning t)
;     (setq cider-repl-display-help-banner nil))

;   ;; sayid
;   ;; clj-refactor

;   (progn
;     ; TODO: delete char should delete entire word
;     (defun clojure/fancify-symbols (mode)
;       (font-lock-add-keywords
;         mode
;         `(("(\\(fn\\)[\[[:space:]]" (0 (progn (compose-region (match-beginning 1) (match-end 1) "λ"))))
;           ("(\\(partial\\)[\[[:space:]]" (0 (progn (compose-region (match-beginning 1) (match-end 1) "Ƥ"))))
;           ("(\\(comp\\)[\[[:space:]]" (0 (progn (compose-region (match-beginning 1) (match-end 1) "∘"))))
;           ("\\(#\\)(" (0 (progn (compose-region (match-beginning 1) (match-end 1) "ƒ"))))
;           ("\\(#\\){" (0 (progn (compose-region (match-beginning 1) (match-end 1) "∈")))))))
;     (clojure/fancify-symbols 'clojure-mode)))



; (progn
;   (use-package parinfer
;     :init
;     (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
;     (add-hook 'clojure-mode-hook #'parinfer-mode)))
;     ;; (setq parinfer-extensions '(defaults)
;     ;;                            pretty-parens
;     ;;                            ;; evil
;     ;;                            smart-tab
;     ;;                            smart-yank)))


; (progn
;   (dolist (face '(builtin
;                   constant
;                   doc
;                   function-name
;                   keyword
;                   type
;                   variable-name))
;           (set-face-attribute (intern (concat "font-lock-"
;                                               (symbol-name face)
;                                               "-face"))
;                               nil
;                               :inherit 'default
;                               :foreground "#bbb"))

;   (progn
;     (set-face-attribute 'default nil
;        :font "JetBrainsMono Nerd Font Mono"
;        :height 90
;        :weight 'thin
;        :foreground "#bbb" :background "black")

;     (progn
;       (set-face-attribute 'mode-line-inactive nil
;         :background "#161616" :foreground "white"
;         :box `(:line-width 3 :color "#111"))

;       (set-face-attribute 'mode-line nil
;         :background "#3c3c3c" :foreground "white"
;         :box `(:line-width 3 :color "#222")))))


; (defalias 'yes-or-no-p 'y-or-n-p)
; ;; (fset #'yes-or-no-p #'y-or-n-p)


; (add-hook 'clojure-mode-hook #'subword-mode)





; (progn
;   (require 'color)
;   (defun hsl-to-hex (&rest args)
;     (apply 'color-rgb-to-hex (apply 'color-hsl-to-rgb args))))


; (progn
;   (use-package rainbow-delimiters
;     :init
;     ; TODO: not working
;     (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;     :config
;     (progn
;       (let (value)
;         (dotimes (number 9 value)
;           (set-face-attribute (intern (concat "rainbow-delimiters-depth-"
;                                               (number-to-string (+ 1 number))
;                                               "-face")) nil
;                               :weight 'bold
;                               :foreground (hsl-to-hex (/ (* (/ 100 8) number) 85.0)
;                                                       1
;                                                       (+ 0.45 (/ (* number 4) 100.0)))))))))

; (use-package cider-eval-sexp-fu)


; (use-package eval-sexp-fu
;   :config
;   (face-spec-set 'eval-sexp-fu-flash
;                  `((t :background "green" :foreground "white"))))



; (use-package writeroom-mode)


; (progn
;   (setq-default tab-width 2
;                 indent-tabs-mode nil))



; (progn
;   ;; put backups in temp dir
;   (setq backup-directory-alist `((".*" . ,temporary-file-directory)))
;   (setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))))



; ;; auto-close delimiters
; (use-package smartparens
;   :config
;   (require 'smartparens-config)
;   (smartparens-global-mode +1))


; (use-package sort-words)


; (use-package nix-mode
;   :mode ("\\.nix\\'"))



; (use-package projectile
;   :config
;   (progn
;     (setq projectile-require-project-root nil
;           projectile-completion-system 'ivy)
;     (projectile-mode +1))

;   (evil-leader/set-key "f" 'projectile-find-file)

;   (defun avo/minibuffer-kill-word ()
;     "Kill a word, backwards, but only if the cursor is after `minibuffer-prompt-end', to prevent the 'Text is read-only' warning from monopolizing the minibuffer."
;     (interactive)
;     (when (> (point) (minibuffer-prompt-end))
;       (call-interactively 'backward-kill-word)))

;   (defun avo/minibuffer-kill-line ()
;     "Kill the entire line, but only if the cursor is after `minibuffer-prompt-end', to prevent the 'Text is read-only' warning from monopolizing the minibuffer."
;     (interactive)
;     (when (> (point) (minibuffer-prompt-end))
;       (call-interactively 'backward-kill-sentence)))

;   (define-key minibuffer-local-map "C-w" 'avo/minibuffer-kill-word)
;   ;; Restore common editing keys (and ESC) in minibuffer
;   (dolist (map '(minibuffer-local-map
;                  minibuffer-local-ns-map
;                  minibuffer-local-completion-map
;                  minibuffer-local-must-match-map
;                  minibuffer-local-isearch-map
;                  evil-ex-completion-map
;                  evil-ex-search-keymap
;                  read-expression-map))

;     `(define-key ,map [escape] #'abort-recursive-edit)
;     `(define-key ,map (kbd "C-r") 'evil-paste-from-register)
;     `(define-key ,map (kbd "C-a") 'move-beginning-of-line)
;     `(define-key ,map (kbd "C-w") 'avo/minibuffer-kill-word)
;     `(define-key ,map (kbd "C-u") 'avo/minibuffer-kill-line)
;     `(define-key ,map (kbd "C-b") 'backward-word)
;     `(define-key ,map (kbd "C-f") 'forward-word)))


; (use-package ivy
;   :config
;   (setq ivy-height 20
;         ivy-fixed-height-minibuffer t)
;   (ivy-mode +1)
;   (progn
;     (define-key ivy-minibuffer-map (kbd "C-SPC") #'ivy-call-and-recenter)
;     (define-key ivy-minibuffer-map (kbd "M-v") #'yank)
;     (define-key ivy-minibuffer-map (kbd "M-z") #'undo)
;     (define-key ivy-minibuffer-map (kbd "C-r") #'evil-paste-from-register)
;     (define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line)
;     (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line)
;     (define-key ivy-minibuffer-map (kbd "C-l") #'ivy-alt-done)
;     (define-key ivy-minibuffer-map (kbd "C-w") #'ivy-backward-kill-word)
;     (define-key ivy-minibuffer-map (kbd "C-u") #'ivy-kill-line)
;     (define-key ivy-minibuffer-map (kbd "C-b") #'backward-word)
;     (define-key ivy-minibuffer-map (kbd "C-f") #'forward-word)))





; (progn
;   (use-package magit
;     :config
;     (add-hook 'git-commit-mode-hook 'evil-insert-state)
;     (use-package evil-magit))

;   (use-package git-timemachine))

;   ;; (use-package magit-blame :after git-timemachine))





; ;; (use-package srefactor
; ;;   :init
; ;;   (setq srecode-map-save-file (expand-file-name ".local/etc/srecode-map.el" user-emacs-directory))
; ;;   :config
; ;;   (require 'srefactor-lisp))


; ;; (setq initial-buffer-choice '(lambda ()
; ;;                                (if (get-buffer "*scratch*")
; ;;                                    (kill-buffer "*scratch*"))
; ;;                                (get-buffer "*Messages*")))


; ;; (if (display-graphic-p)
; ;;     (progn
; ;;       (use-package git-gutter-fringe
; ;;         :config
; ;;         (setq-default fringes-outside-margins t)
; ;;         (progn)
; ;;         (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
; ;;         (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
; ;;         (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))
; ;;       (use-package git-gutter
; ;;         :init
; ;;         (setq git-gutter:update-interval 2))))


; ;; (progn
; ;;   (use-package dired
; ;;     :after evil
; ;;     :config
; ;;     (setq dired-no-confirm t)
; ;;     (setq dired-listing-switches)
; ;;     (setq "-lha --indicator-style slash --no-group --group-directories-first")
; ;;     (setq dired-recursive-copies 'always dired-recursive-deletes)
; ;;     (setq 'top global-auto-revert-non-file-buffers t)
; ;;     (defadvice dired-delete-entry
; ;;         (before force-clean-up-buffers
; ;;                 (file)
; ;;                 activate)
; ;;       (kill-buffer (get-file-buffer file)))
; ;;     (define-key dired-mode-map [remap quit-window]
; ;;       (lambda ()
; ;;         (interactive)
; ;;         (quit-window t)))(push (lambda ()))
; ;;         (let ((parent-directory (file-name-directory buffer-file-name)))
; ;;           (when (and (not (file-exists-p parent-directory))
; ;;                    (y-or-n-p (format "directory `%s' does not exist! create it?"
; ;;                                      parent-directory)))
; ;;             (make-directory parent-directory t)))
; ;;       find-file-not-found-functions))




; ;; (progn
; ;;   (use-package neotree
; ;;     :init
; ;;     (setq neo-create-file-auto-open t
; ;;           neo-force-change-root t
; ;;           neo-mode-line-type 'none
; ;;           neo-show-updir-line nil
; ;;           neo-confirm-create-file #'off-p
; ;;           neo-confirm-create-directory #'off-p
; ;;           neo-window-width 30
; ;;           neo-show-hidden-files t
; ;;           neo-theme 'ascii
; ;;           neo-autorefresh t)
; ;;     :config
; ;;     (with-eval-after-load "evil"
; ;;       (with-eval-after-load "evil-leader"
; ;;         (evil-leader/set-key "e" 'neotree-toggle))
; ;;       (evil-define-key 'normal neotree-mode-map (kbd "<tab>") 'neotree-enter))
; ;;     ;; TODO
; ;;     ;; collapse all
; ;;     (evil-define-key 'normal neotree-mode-map (kbd "gc")
; ;;       (lambda ()
; ;;         (interactive)
; ;;         (setq list-of-expanded-folders neo-buffer--expanded-node-list)
; ;;         (dolist (folder list-of-expanded-folders)
; ;;           (neo-buffer--toggle-expand folder))))
; ;;     ;; cursor always on the first non-blank character
; ;;     (progn
; ;;       (defun +neotree*indent-cursor (&rest _)
; ;;         (beginning-of-line)
; ;;         (skip-chars-forward " \t\r"))
; ;;       (defun +neotree*fix-cursor (&rest _)
; ;;         (with-current-buffer neo-global--buffer (+neotree*indent-cursor)))
; ;;       (add-hook 'neo-enter-hook #'+neotree*fix-cursor)
; ;;       (advice-add 'neotree-next-line :after '+neotree*indent-cursor)
; ;;       (advice-add 'neotree-previous-line :after '+neotree*indent-cursor))))


; (use-package ripgrep)


; ;; (use-package hl-todo
; ;;     :config
; ;;     (global-hl-todo-mode +1))


; ;; (setq custom-file "~/.emacs.d/custom.el")
; ;; (add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)
; ;; (setq-default vc-follow-symlinks t)
; ;; (setq sentence-end-double-space nil)
; ;; (setq-default uniquify-buffer-name-style 'forward)
; ;; (setq-default cursor-in-non-selected-windows nil)
; ;; (setq x-underline-at-descent-line t)
; ;; ;; display continuation lines
; ;; (setq truncate-partial-width-windows nil)
; ;; ;; window title
; ;; (setq frame-title-format '("%b"))
; ;; ;; use Perl regexes
; ;; (use-package pcre2el
; ;;   :config (global-set-key [(meta %)]
; ;;                           'pcre-query-replace-regexp))
; ;; ;; variable pitch font in text mode
; ;; (add-hook 'text-mode-hook
; ;;           (lambda ()
; ;;             (variable-pitch-mode 1)))
; ;; ;; show search position in mode line
; ;; (use-package anzu
; ;;   :config (defun my/anzu-update-func (here total)
; ;;             (when anzu--state
; ;;               (let ((status (cl-case anzu--state
; ;;                               (search (format " <%d/%d>" here total))
; ;;                               (replace-query (format " (%d Replaces)" total))
; ;;                               (replace (format " <%d/%d>" here total)))))
; ;;                 (propertize status 'face 'anzu-mode-line))))(custom-set-variables '(anzu-mode-line-update-function #'my/anzu-update-func))(global-anzu-mode +1))
; ;; ;; follow links using hints
; ;; (use-package link-hint
; ;;   :after evil
; ;;   :config (define-key evil-normal-state-map (kbd "SPC l") 'link-hint-open-link))
; ;; ;; highlight matching delimiters
; ;; ;; reload buffers when changed externally
; ;; (progn
; ;;   (setq revert-without-query '(".*"))
; ;;   (setq auto-revert-verbose nil)
; ;;   (global-auto-revert-mode +1))
; ;; ;; persist state
; ;; (progn
; ;;   ;; ;; autosave session
; ;;   ;; (progn
; ;;   ;;   (require 'desktop)
; ;;   ;;   (setq desktop-save t
; ;;   ;;         desktop-load-locked-desktop t)
; ;;   ;;   (desktop-save-mode 1)
; ;;   ;;   (add-hook 'auto-save-hook (lambda () (desktop-save desktop-dirname))))
; ;;   ;; persist variables
; ;;   (use-package savehist
; ;;     :config (setq savehist-save-minibuffer-history t
; ;;                   savehist-autosave-interval
; ;;                   nil ; save on kill only
; ;;                   savehist-additional-variables
; ;;                   '(kill-ring search-ring regexp-search-ring))(savehist-mode +1))
; ;;   ;; persist point location
; ;;   (use-package saveplace
; ;;     :after nav-flash
; ;;     :config (advice-add #'save-place-find-file-hook :after 'nav-flash-show)(advice-add #'save-place-find-file-hook
; ;;                                                                                        :after-while '(lambda ()
; ;;                                                                                                        (when buffer-file-name
; ;;                                                                                                          (ignore-errors (recenter)))))(save-place-mode +1)))
; ;; ;; spell checking
; ;; (use-package flyspell
; ;;   :config (add-hook 'flyspell-mode-hook #'flyspell-buffer))
; ;; ;; automatically clean up trailing whitespace on changed lines
; ;; ;; (use-package ws-butler :config (ws-butler-global-mode))
; ;; ;; completion
; ;; (progn
; ;;   (use-package company
; ;;     :after evil
; ;;     :init (setq company-transformers '(company-sort-by-occurrence)):config
; ;;     (global-company-mode +1))
; ;;   (use-package company-statistics
; ;;     :config (add-hook 'after-init-hook 'company-statistics-mode)))
; ;; ;; menu completion
; ;; (use-package ivy
; ;;   :config (setq
; ;;            ;; ivy-re-builders-alist `((t . ivy--regex-fuzzy))
; ;;            ivy-initial-inputs-alist nil ivy-height 20
; ;;            projectile-completion-system 'ivy)(ivy-mode +1))
; ;; ;; Evil
; ;; (progn
; ;;   (setq evil-toggle-key "")
; ;;   (use-package evil
; ;;     :init (setq evil-want-C-u-scroll t
; ;;                 evil-ex-search-vim-style-regexp t
; ;;                 evil-respect-visual-line-mode t
; ;;                 evil-want-Y-yank-to-eol t)
; ;;     :config
; ;;     (progn
; ;;       (with-eval-after-load "company"
; ;;         (global-set-key (kbd "TAB")
; ;;                         'company-indent-or-complete-common)
; ;;         (cl-loop for
; ;;                  (key . value)
; ;;                  in
; ;;                  '(("TAB" . company-select-next)
; ;;                    ("<backtab>" . company-select-previous)
; ;;                    ("RET" . nil))
; ;;                  do
; ;;                  (define-key company-active-map (kbd key) value)))
; ;;       (progn
; ;;         (use-package evil-numbers)
; ;;         (define-key evil-normal-state-map (kbd "C-c C-a") 'evil-numbers/inc-at-pt)
; ;;         (define-key evil-normal-state-map (kbd "C-c C-x") 'evil-numbers/dec-at-pt))
; ;;       (progn
; ;;         (define-key evil-visual-state-map (kbd "v") 'er/expand-region)
; ;;         (define-key evil-visual-state-map (kbd "V") 'er/contract-region))
; ;;       (progn
; ;;         (setq ivy-ignore-buffers '("\\` " "\\`\\*"))
; ;;         (define-key evil-normal-state-map (kbd "SPC b") 'ivy-switch-buffer))
; ;;       ;; reselect last pasted region
; ;;       (define-key evil-normal-state-map (kbd "gp") '(lambda ()
; ;;                                                       (cl-destructuring-bind (_ _ _ beg end &optional _)
; ;;                                                           evil-last-paste
; ;;                                                         (evil-visual-make-selection (save-excursion
; ;;                                                                                       (goto-char beg)
; ;;                                                                                       (point-marker))
; ;;                                                                                     end))))
; ;;       ;; move selected lines
; ;;       (progn
; ;;         (define-key evil-visual-state-map "J" (concat ":m '>+1"
; ;;                                                       (kbd "RET")
; ;;                                                       "gv=gv"))
; ;;         (define-key evil-visual-state-map "K" (concat ":m '<-2"
; ;;                                                       (kbd "RET")
; ;;                                                       "gv=gv"))))
; ;;     ;; keep visual selection visible while indenting
; ;;     (progn
; ;;       (define-key evil-visual-state-map (kbd "<") '(lambda ()
; ;;                                                      (interactive)
; ;;                                                      (evil-shift-left (region-beginning)
; ;;                                                                       (region-end))
; ;;                                                      (evil-normal-state)
; ;;                                                      (evil-visual-restore)))
; ;;       (define-key evil-visual-state-map (kbd ">") '(lambda ()
; ;;                                                      (interactive)
; ;;                                                      (evil-shift-right (region-beginning)
; ;;                                                                        (region-end))
; ;;                                                      (evil-normal-state)
; ;;                                                      (evil-visual-restore))))


; ;;   (use-package evil-expat :after evil)
; ;;   ;; search with selected region
; ;;   (use-package evil-visualstar
; ;;     :config (global-evil-visualstar-mode 1))
; ;;   (use-package evil-goggles
; ;;     :config (with-eval-after-load "diff-mode"
; ;;               (with-eval-after-load "evil-goggles"
; ;;                 (evil-goggles-use-diff-faces)))(setq evil-goggles-enable-change t)(evil-goggles-mode 1))
; ;;   (use-package evil-indent-plus
; ;;     :config (evil-indent-plus-default-bindings))
; ;;   (use-package evil-matchit
; ;;     :after evil
; ;;     :config (global-evil-matchit-mode 1))
; ;;   (use-package evil-snipe
; ;;     :config (evil-snipe-override-mode 1))
; ;; ;; file management

; ;;   ;; minimal UI
; ;;   (set-fringe-mode 0)
; ;;   ;; (fringe-mode '(8 . 8))
; ;;   ;; (defun mode-line-fill (face reserve)
; ;;   ;; "Return empty space using FACE and leaving RESERVE space on the right."
; ;;   ;; (unless reserve
; ;;   ;; (setq reserve 20))
; ;;   ;; (when (and window-system (eq 'right (get-scroll-bar-mode)))
; ;;   ;; (setq reserve (- reserve 3)))
; ;;   ;; (propertize " "
; ;;   ;; 'display `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))
; ;;   ;; 'face face))
; ;;   ;; (setq-default header-line-format (list
; ;;   ;; " "
; ;;   ;; 'mode-line-modified
; ;;   ;; " "
; ;;   ;; 'mode-line-buffer-identification
; ;;   ;; 'mode-line-modes
; ;;   ;; " -- "
; ;;   ;; `(vc-mode vc-mode)
; ;;   ;; ;; File modified
; ;;   ;; '(:eval (if (buffer-modified-p)
; ;;   ;; (list (mode-line-fill 'nil 12)
; ;;   ;; (propertize " [modified] " 'face 'header-line-red))
; ;;   ;; (list (mode-line-fill 'nil 9)
; ;;   ;; (propertize "%4l:%3c " 'face 'header-line))))
; ;;   ;; ))
; ;;   ;; (setq-default mode-line-format "")
; ;;   ;; (make-face 'header-line-grey)
; ;;   ;; (set-face-attribute 'header-line-grey nil
; ;;   ;; :weight 'medium
; ;;   ;; :foreground "#ffffff"
; ;;   ;; :background "#999999"
; ;;   ;; :box '(:line-width 1 :color "#999999"))
; ;;   ;; (make-face 'header-line-red)
; ;;   ;; (set-face-attribute 'header-line-red nil
; ;;   ;; :weight 'medium
; ;;   ;; :foreground "white"
; ;;   ;; :background "#dd7777"
; ;;   ;; :box '(:line-width 1 :color "#dd7777"))
; ;;   ;; (set-face-attribute 'mode-line nil
; ;;   ;; :height 10
; ;;   ;; :background "#999"
; ;;   ;; :box nil)
; ;;   ;; (set-face-attribute 'mode-line-inactive nil
; ;;   ;; :height 10
; ;;   ;; :background "#999"
; ;;   ;; :box nil)
; ;;   ;; (set-face-attribute 'header-line nil
; ;;   ;; :inherit nil
; ;;   ;; :foreground "white"
; ;;   ;; :background "#000000"
; ;;   ;; :box '(:line-width 3 :color "#000000"))
; ;;   (progn
; ;;   ;; git-link
; ;;   (use-package git-link :config
; ;;                                         ;open the website for the current version controlled file, fallback to repository root
; ;;     (evil-ex-define-cmd "gbrowse"
; ;;                         '(lambda ()
; ;;                            (interactive)
; ;;                            (require 'git-link)
; ;;                            (cl-destructuring-bind (beg end)
; ;;                                (if buffer-file-name (git-link--get-region))
; ;;                              (let ((git-link-open-in-browser t))
; ;;                                (git-link (git-link--select-remote) beg end))))))
; ;;   (use-package notmuch :config
; ;;     (setq send-mail-function 'sendmail-send-it
; ;;           mm-text-html-renderer 'w3m)
; ;;     (dolist (hook '(notmuch-show-mode-hook
; ;;                     notmuch-message-mode-hook))
; ;;       (add-hook hook 'variable-pitch-mode)))
; ;;   ;; fix sexp macro indenting
; ;;   (eval-after-load "lisp-mode"
; ;;     '(defun lisp-indent-function (indent-point state)
; ;;        "This function is the normal value of the variable `lisp-indent-function'.
; ;; The function `calculate-lisp-indent' calls this to determine
; ;; if the arguments of a Lisp function call should be indented specially.
; ;; INDENT-POINT is the position at which the line being indented begins.
; ;; Point is located at the point to indent under (for default indentation);
; ;; STATE is the `parse-partial-sexp' state for that position.
; ;; If the current line is in a call to a Lisp function that has a non-nil
; ;; property `lisp-indent-function' (or the deprecated `lisp-indent-hook'),
; ;; it specifies how to indent.  The property value can be:
; ;; * `defun', meaning indent `defun'-style
; ;;   \(this is also the case if there is no property and the function
; ;;   has a name that begins with \"def\", and three or more arguments);
; ;; * an integer N, meaning indent the first N arguments specially
; ;;   (like ordinary function arguments), and then indent any further
; ;;   arguments like a body;
; ;; * a function to call that returns the indentation (or nil).
; ;;   `lisp-indent-function' calls this function with the same two arguments
; ;;   that it itself received.
; ;; This function returns either the indentation to use, or nil if the
; ;; Lisp function does not specify a special indentation."
; ;;        (let ((normal-indent (current-column))
; ;;              (orig-point (point)))
; ;;          (goto-char (1+ (elt state 1)))
; ;;          (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
; ;;          (cond
; ;;           ;; car of form doesn't seem to be a symbol, or is a keyword
; ;;           ((and (elt state 2)
; ;;               (or (not (looking-at "\\sw\\|\\s_"))
; ;;                  (looking-at ":")))
; ;;            (if (not (> (save-excursion (forward-line 1) (point))
; ;;                      calculate-lisp-indent-last-sexp))
; ;;                (progn (goto-char calculate-lisp-indent-last-sexp)
; ;;                       (beginning-of-line)
; ;;                       (parse-partial-sexp (point)
; ;;                                           calculate-lisp-indent-last-sexp 0 t)))
; ;;            ;; Indent under the list or under the first sexp on the same
; ;;            ;; line as calculate-lisp-indent-last-sexp.  Note that first
; ;;            ;; thing on that line has to be complete sexp since we are
; ;;            ;; inside the innermost containing sexp.
; ;;            (backward-prefix-chars)
; ;;            (current-column))
; ;;           ((and (save-excursion
; ;;                 (goto-char indent-point)
; ;;                 (skip-syntax-forward " ")
; ;;                 (not (looking-at ":")))
; ;;               (save-excursion
; ;;                 (goto-char orig-point)
; ;;                 (looking-at ":")))
; ;;            (save-excursion
; ;;              (goto-char (+ 2 (elt state 1)))
; ;;              (current-column)))
; ;;           (t
; ;;            (let ((function (buffer-substring (point)
; ;;                                              (progn (forward-sexp 1) (point))))
; ;;                  method)
; ;;              (setq method (or (function-get (intern-soft function)
; ;;                                            'lisp-indent-function)
; ;;                              (get (intern-soft function) 'lisp-indent-hook)))
; ;;              (cond ((or (eq method 'defun)
; ;;                        (and (null method)
; ;;                           (> (length function) 3)
; ;;                           (string-match "\\`def" function)))
; ;;                     (lisp-indent-defform state indent-point))
; ;;                    ((integerp method)
; ;;                     (lisp-indent-specform method state
; ;;                                           indent-point normal-indent))
; ;;                    (method
; ;;                     (funcall method indent-point state)))))))))
; ;;   ;; highlight eval'd sexps
; ;;   (add-hook 'lisp-mode-hook
; ;;             (lambda ()
; ;;               (push '(";;" .  ">") prettify-symbols-alist)
; ;;               (prettify-symbols-mode)))
; ;;   (use-package org :ensure org-plus-contrib :config
; ;;     (setq org-startup-indented t
; ;;           org-hide-leading-stars t)
; ;;     (setq org-confirm-elisp-link-function nil)
; ;;     ;; make auto indent work in code blocks
; ;;     (setq org-src-tab-acts-natively t)
; ;;     (progn
; ;;       (defun org-wrap-source ()
; ;;         (interactive)
; ;;         (let ((start (min (point) (mark)))
; ;;               (end (max (point) (mark))))
; ;;           (goto-char end)
; ;;           (unless (bolp)
; ;;             (newline))
; ;;           (insert "#+END_SRC\n")
; ;;           (goto-char start)
; ;;           (unless (bolp)
; ;;             (newline))
; ;;           (insert "#+BEGIN_SRC\n")))
; ;;       (define-key evil-visual-state-map (kbd "gs") 'org-wrap-source)))
; ;;   (use-package org-bullets :config
; ;;     (require 'org-bullets)
; ;;     (setq org-bullets-bullet-list '("·"))
; ;;     (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
; ;;   (use-package evil-org
; ;;     :after org
; ;;     :config
; ;;     (add-hook 'org-mode-hook 'evil-org-mode)
; ;;     (add-hook 'evil-org-mode-hook
; ;;               (lambda ()
; ;;                 (evil-org-set-key-theme '(textobjects
; ;;                                           insert
; ;;                                           navigation
; ;;                                           additional
; ;;                                           shift
; ;;                                           todo
; ;;                                           heading)))))
; ;;   (with-eval-after-load 'org
; ;;     (defvar-local rasmus/org-at-src-begin -1
; ;;       "Variable that holds whether last position was a ")
; ;;     (defvar rasmus/ob-header-symbol ?☰
; ;;       "Symbol used for babel headers")
; ;;     (defun rasmus/org-prettify-src--update ()
; ;;       (let ((case-fold-search t)
; ;;             (re "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*")
; ;;             found)
; ;;         (save-excursion
; ;;           (goto-char (point-min))
; ;;           (while (re-search-forward re nil t)
; ;;             (goto-char (match-end 0))
; ;;             (let ((args (org-trim
; ;;                          (buffer-substring-no-properties (point)
; ;;                                                          (line-end-position)))))
; ;;               (when (org-string-nw-p args)
; ;;                 (let ((new-cell (cons args rasmus/ob-header-symbol)))
; ;;                   (cl-pushnew new-cell prettify-symbols-alist :test #'equal)
; ;;                   (cl-pushnew new-cell found :test #'equal)))))
; ;;           (setq prettify-symbols-alist
; ;;                 (cl-set-difference prettify-symbols-alist
; ;;                                    (cl-set-difference
; ;;                                     (cl-remove-if-not
; ;;                                      (lambda (elm)
; ;;                                        (eq (cdr elm) rasmus/ob-header-symbol))
; ;;                                      prettify-symbols-alist)
; ;;                                     found :test #'equal)))
; ;;           ;; Clean up old font-lock-keywords.
; ;;           (font-lock-remove-keywords nil prettify-symbols--keywords)
; ;;           (setq prettify-symbols--keywords (prettify-symbols--make-keywords))
; ;;           (font-lock-add-keywords nil prettify-symbols--keywords)
; ;;           (while (re-search-forward re nil t)
; ;;             (font-lock-flush (line-beginning-position) (line-end-position))))))
; ;;     (defun rasmus/org-prettify-src ()
; ;;       "Hide src options via `prettify-symbols-mode'.
; ;;   `prettify-symbols-mode' is used because it has uncollpasing. It's
; ;;   may not be efficient."
; ;;       (let* ((case-fold-search t)
; ;;              (at-src-block (save-excursion
; ;;                              (beginning-of-line)
; ;;                              (looking-at "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*"))))
; ;;         ;; Test if we moved out of a block.
; ;;         (when (or (and rasmus/org-at-src-begin
; ;;                     (not at-src-block))
; ;;                  ;; File was just opened.
; ;;                  (eq rasmus/org-at-src-begin -1))
; ;;           (rasmus/org-prettify-src--update))
; ;;         ;; Remove composition if at line; doesn't work properly.
; ;;         ;; (when at-src-block
; ;;         ;;   (with-silent-modifications
; ;;         ;;     (remove-text-properties (match-end 0)
; ;;         ;;                             (1+ (line-end-position))
; ;;         ;;                             '(composition))))
; ;;         (setq rasmus/org-at-src-begin at-src-block)))
; ;;     (defun rasmus/org-prettify-symbols ()
; ;;       (mapc (apply-partially 'add-to-list 'prettify-symbols-alist)
; ;;             (cl-reduce 'append
; ;;                        (mapcar (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
; ;;                                `(("#+begin_src" . ?✎) ;; ➤ 🖝 ➟ ➤ ✎
; ;;                                  ("#+end_src"   . ?□) ;; ⏹
; ;;                                  ("#+header:" . ,rasmus/ob-header-symbol)
; ;;                                  ("#+begin_quote" . ?»)
; ;;                                  ("#+end_quote" . ?«)))))
; ;;       (turn-on-prettify-symbols-mode)
; ;;       (add-hook 'post-command-hook 'rasmus/org-prettify-src t t))
; ;;     (add-hook 'org-mode-hook #'rasmus/org-prettify-symbols))
; ;;   (use-package clojure-mode :config
; ;;     (dolist (mode '(eldoc-mode
; ;;                     ;; lispy-mode
; ;;                     parinfer-mode))
; ;;       (add-hook 'clojure-mode-hook mode))
; ;;     (add-hook 'clojure-mode-hook (lambda ()
; ;;                                    (bind-key "<tab>" 'company-indent-or-complete-common clojure-mode-map)
; ;;                                    (bind-key "TAB" 'company-indent-or-complete-common clojure-mode-map))))
; ;;   ;; (add-hook 'clojure-mode-hook (lambda ()
; ;;   ;;                                (define-key lispy-mode-map-lispy "[" nil)
; ;;   ;;                                (define-key lispy-mode-map-lispy "]" nil)))
; ;;   (progn
; ;;     (progn
; ;;       (progn
; ;;         (progn
; ;;           (setq background "#fffdf5") (setq background-light "#e6e3d3")
; ;;           (setq foreground (hsl-to-hex 0 0 .15)) (setq foreground-light (hsl-to-hex 0 0 .6)))
; ;;         (let ((font-height 90))
; ;;           (progn
; ;;             (set-face-attribute 'default nil
; ;;                                 :font fixed-pitch-font
; ;;                                 :height font-height
; ;;                                 :foreground foreground :background background)
; ;;             (set-face-attribute 'variable-pitch nil
; ;;                                 :font variable-pitch-font
; ;;                                 :height 1.07))
; ;;           (progn
; ;;             (set-face-foreground 'error red)
; ;;             (set-face-foreground 'warning yellow)
; ;;             (set-face-foreground 'success green))
; ;;           ;; window dividers
; ;;           (add-hook 'prog-mode-hook
; ;;                     (lambda ()
; ;;                       (set-face-attribute 'window-divider nil
; ;;                                           :foreground background-light)
; ;;                       (set-face-attribute 'fringe nil
; ;;                                           :background background)
; ;;                       (setq-default window-divider-default-places t
; ;;                                     window-divider-default-bottom-width 2 window-divider-default-right-width 2)
; ;;                       (window-divider-mode)))
; ;;           (with-eval-after-load "nav-flash"
; ;;             (set-face-attribute 'nav-flash-face nil
; ;;                                 :background light-blue))
; ;;           (with-eval-after-load "hl-todo"
; ;;             (setq hl-todo-keyword-faces `(("TODO" . ,green)
; ;;                                           ("FIXME" . ,red)
; ;;                                           ("NOTE" . ,foreground)))
; ;;             (set-face-bold 'hl-todo t))
; ;;           (with-eval-after-load "neotree"
; ;;             (add-hook 'neotree-mode-hook
; ;;                       (lambda ()
; ;;                         (face-remap-add-relative 'default
; ;;                                                  `(:foreground ,foreground :background ,background-light))))
; ;;             (advice-add #'neo-global--select-window :after
; ;;                         '(lambda ()
; ;;                            (set-window-fringes neo-global--window 0 0)))
; ;;             (set-face-bold 'neo-dir-link-face t)
; ;;             (set-face-foreground 'neo-expand-btn-face background)
; ;;             (dolist (face '(neo-button-face
; ;;                             neo-dir-link-face
; ;;                             neo-expand-btn-face
; ;;                             neo-file-link-face
; ;;                             neo-header-face
; ;;                             neo-root-dir-face))
; ;;               (set-face-attribute face nil
; ;;                                   :foreground foreground
; ;;                                   :height 100))
; ;;             (set-face-attribute 'neo-root-dir-face nil
; ;;                                 :weight 'bold
; ;;                                 :foreground foreground)
; ;;             (add-hook 'neotree-mode-hook
; ;;                       '(lambda ()
; ;;                          (dolist (face '(neo-dir-link-face
; ;;                                          neo-root-dir-face
; ;;                                          neo-file-link-face))
; ;;                            (set-face-attribute face nil :font variable-pitch-font)))))
; ;;           (with-eval-after-load "git-gutter"
; ;;             (cl-loop for (key . value)
; ;;                      in '(("modified" . yellow)
; ;;                           ("deleted" . red)
; ;;                           ("added" . green))
; ;;                      do `(set-face-attribute (intern (concat "git-gutter:" key)) nil
; ;;                                              :foreground ,value :background ,value)))
; ;;           (set-face-attribute 'show-paren-match nil
; ;;                               :weight 'extrabold
; ;;                               :background (face-background 'default) :foreground blue)
; ;;           ;; ;; Company
; ;;           ;; (with-eval-after-load "company"
; ;;           ;;   (set-face-attribute 'company-scrollbar-bg nil
; ;;           ;;                       :background foreground)
; ;;           ;;   (set-face-attribute 'company-scrollbar-fg nil
; ;;           ;;                       :background (color 'bg))
; ;;           ;;   (set-face-attribute 'company-tooltip nil
; ;;           ;;                       :background foreground-darker :foreground (color 'bg -20))
; ;;           ;;   (set-face-attribute 'company-tooltip-common nil
; ;;           ;;                       :background foreground-darker :foreground (color 'bg -10))
; ;;           ;;   (set-face-attribute 'company-tooltip-common-selection nil
; ;;           ;;                       :background (color 'highlight) :foreground (color 'bg 20))
; ;;           ;;   (set-face-attribute 'company-tooltip-selection nil
; ;;           ;;                       :background (color 'highlight) :foreground (color 'fg 40)))
; ;;           (with-eval-after-load "evil-snipe"
; ;;             (set-face-attribute 'evil-snipe-matches-face nil
; ;;                                 :background background :foreground blue
; ;;                                 :underline t
; ;;                                 :weight 'bold))
; ;;           (with-eval-after-load "anzu"
; ;;             (set-face-attribute 'anzu-mode-line nil
; ;;                                 :font variable-pitch-font :weight 'bold
; ;;                                 :foreground "white"))
; ;;           ;; cursor
; ;;           (with-eval-after-load "diff-mode"
; ;;             (cl-loop for (key . value)
; ;;                      in '(("added" . green) ("changed" . yellow) ("removed" . red))
; ;;                      do `(set-face-attribute (intern (concat "diff-" key)) nil
; ;;                                              :background ,value)))
; ;;           (progn
; ;;             (set-face-attribute 'highlight nil
; ;;                                 :background yellow)
; ;;             (set-face-attribute 'lazy-highlight nil
; ;;                                 :background background :foreground yellow
; ;;                                 :weight 'bold :underline t)
; ;;             (set-face-attribute 'isearch nil
; ;;                                 :background yellow :foreground foreground
; ;;                                 :underline t)
; ;;             (set-face-attribute 'region nil
; ;;                                 :background background-light))
; ;;           (progn
; ;;             (set-face-attribute 'font-lock-comment-face nil
; ;;                                 :slant 'italic
; ;;                                 :foreground blue)
; ;;             (set-face-attribute 'font-lock-string-face nil
; ;;                                 :foreground foreground-light)
; ;;             (dolist (face '(builtin constant doc function-name keyword type variable-name))
; ;;               (set-face-attribute (intern (concat "font-lock-" (symbol-name face) "-face")) nil
; ;;                                   :inherit 'default
; ;;                                   :foreground "#bbb"))))
; ;;         ;; minibuffer
; ;;         (progn (set-face-attribute 'minibuffer-prompt nil
; ;;                                    :font variable-pitch-font :weight 'bold
; ;;                                    :foreground blue)
; ;;                (add-hook 'minibuffer-setup-hook
; ;;                          (lambda ()
; ;;                            (set-window-scroll-bars (minibuffer-window) nil nil)
; ;;                            (set-window-fringes (minibuffer-window) 0 0 nil)
; ;;                            (set (make-local-variable 'face-remapping-alist)
; ;;                                 `((default :foreground ,background :background ,foreground))))))
; ;;         (add-hook 'evil-command-window-mode-hook
; ;;                   (lambda ()
; ;;                     (face-remap-add-relative 'default
; ;;                                              `(:foreground ,background :background ,foreground))))))
; ;;     (setq-default scroll-bar-adjust-thumb-portion t)
; ;;     (use-package smartparens
; ;;       :init
; ;;       (use-package smartparens-config)
; ;;       :config
; ;;       (sp-with-modes sp--lisp-modes
; ;;         (sp-local-pair "'" nil :actions nil)
; ;;         (sp-local-pair "`" nil :actions nil))
; ;;       (smartparens-global-mode +1))
; ;;     (use-package anzu
; ;;       :config
; ;;       (progn
; ;;         (defun my/anzu-update-func (here total)
; ;;           (when anzu--state
; ;;             (let ((status (cl-case anzu--state
; ;;                             (search (format " <%d/%d>" here total))
; ;;                             (replace-query (format " (%d Replaces)" total))
; ;;                             (replace (format " <%d/%d>" here total)))))
; ;;               (propertize status 'face 'anzu-mode-line))))
; ;;         (custom-set-variables '(anzu-mode-line-update-function #'my/anzu-update-func)))
; ;;       (global-anzu-mode +1))
; ;;     (use-package link-hint :after evil
; ;;       :config
; ;;       (define-key evil-normal-state-map (kbd "SPC l") 'link-hint-open-link))
; ;;     (progn
; ;;       (setq revert-without-query '(".*"))
; ;;       (setq auto-revert-verbose nil)
; ;;       (global-auto-revert-mode +1))
; ;;     (fset #'yes-or-no-p #'y-or-n-p)
; ;;     (use-package sort-words)
; ;;     (progn
; ;;       (use-package savehist
; ;;         :config
; ;;         (setq savehist-save-minibuffer-history t
; ;;               savehist-autosave-interval nil ; save on kill only
; ;;               savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
; ;;         (savehist-mode +1))
; ;;       (use-package saveplace :after nav-flash
; ;;         :config
; ;;         (advice-add #'save-place-find-file-hook :after 'nav-flash-show)
; ;;         (advice-add #'save-place-find-file-hook :after-while '(lambda () (when buffer-file-name (ignore-errors (recenter)))))
; ;;         (save-place-mode +1)))
; ;;     (use-package flyspell
; ;;       :init
; ;;       (setq ispell-program-name "hunspell"
; ;;             ispell-local-dictionary "en_US"
; ;;             ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
; ;;                                             ("fr_FR" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "fr-moderne") nil utf-8)
; ;;                                             ("ro_RO" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "ro_RO") nil utf-8)))
; ;;       :config
; ;;       (add-hook 'flyspell-mode-hook #'flyspell-buffer))
; ;;     (progn
; ;;       (use-package company :after evil
; ;;         :init
; ;;         (setq company-transformers '(company-sort-by-occurrence))
; ;;         :config
; ;;         (global-company-mode +1))
; ;;       (use-package company-statistics
; ;;         :config
; ;;         (add-hook 'after-init-hook 'company-statistics-mode)))
; ;;     (progn
; ;;       (progn
; ;;         (add-hook 'text-mode-hook (lambda () (variable-pitch-mode +1)))
; ;;         (add-hook 'text-mode-hook (lambda () (visual-line-mode +1))))
; ;;       (use-package typo
; ;;         :config
; ;;         (typo-global-mode 1)
; ;;         (add-hook 'text-mode-hook 'typo-mode)))
; ;;       (use-package evil-expat :after evil)
; ;;       (use-package evil-visualstar
; ;;         :config
; ;;         (global-evil-visualstar-mode 1))
; ;;       (use-package evil-collection :after evil
; ;;         :config
; ;;         (evil-collection-init))
; ;;       (use-package evil-goggles
; ;;         :config
; ;;         (evil-goggles-use-diff-faces)
; ;;         (setq evil-goggles-enable-change t)
; ;;         (evil-goggles-mode 1))
; ;;       (use-package evil-indent-plus
; ;;         :config
; ;;         (evil-indent-plus-default-bindings))
; ;;       (use-package evil-matchit :after evil
; ;;         :config
; ;;         (global-evil-matchit-mode 1))
; ;;       (use-package evil-snipe
; ;;         :config
; ;;         (evil-snipe-override-mode 1))
; ;;       (use-package evil-surround
; ;;         :config
; ;;         (global-evil-surround-mode 1))
; ;;       :config
; ;;       (evil-mode +1)
; ;;       (evil-define-key nil evil-normal-state-map
; ;;         "\C-h"'evil-window-left
; ;;         "\C-j" 'evil-window-down
; ;;         "\C-k" 'evil-window-up
; ;;         "\C-l" 'evil-window-right)
; ;;       (global-set-key (kbd "C-x C-g") 'evil-show-file-info)
; ;;       (with-eval-after-load "company"
; ;;         (cl-loop for (key . value)
; ;;                  in '(("TAB" . company-select-next)
; ;;                       ("<backtab>" . company-select-previous)
; ;;                       ("RET" . nil))
; ;;                  do (define-key company-active-map (kbd key) value)))
; ;;       (progn
; ;;         (use-package evil-numbers)
; ;;         (define-key evil-normal-state-map (kbd "C-c C-a") 'evil-numbers/inc-at-pt)
; ;;         (define-key evil-normal-state-map (kbd "C-c C-x") 'evil-numbers/dec-at-pt))
; ;;       (progn
; ;;         (define-key evil-visual-state-map (kbd "v") 'er/expand-region)
; ;;         (define-key evil-visual-state-map (kbd "V") 'er/contract-region))
; ;;       (progn
; ;;         (setq ivy-ignore-buffers '("\\` " "\\`\\*"))
; ;;         (define-key evil-normal-state-map (kbd "SPC b") 'ivy-switch-buffer))
; ;;       (define-key evil-normal-state-map (kbd "gp")
; ;;         '(lambda ()
; ;;            (cl-destructuring-bind (_ _ _ beg end &optional _) evil-last-paste
; ;;              (evil-visual-make-selection (save-excursion (goto-char beg) (point-marker)) end))))
; ;;       (progn
; ;;         (define-key evil-visual-state-map "J" (concat ":m '>+1" (kbd "RET") "gv=gv"))
; ;;         (define-key evil-visual-state-map "K" (concat ":m '<-2" (kbd "RET") "gv=gv")))
; ;;       (progn
; ;;         (define-key evil-visual-state-map (kbd "<")
; ;;           '(lambda ()
; ;;              (interactive)
; ;;              (evil-shift-left (region-beginning) (region-end))
; ;;              (evil-normal-state) (evil-visual-restore)))
; ;;         (define-key evil-visual-state-map (kbd ">")
; ;;           '(lambda ()
; ;;              (interactive)
; ;;              (evil-shift-right (region-beginning) (region-end))
; ;;              (evil-normal-state) (evil-visual-restore))))
; ;;       (evil-ex-define-cmd "retab"
; ;;                           '(lambda (&optional beg end)
; ;;                              (interactive "r")
; ;;                              (unless (and beg end) (setq beg (point-min) end (point-max)))
; ;;                              (if indent-tabs-mode (tabify beg end) (untabify beg end))))
; ;;       (evil-ex-define-cmd "cd"
; ;;                           '(lambda (path)
; ;;                              (interactive "D")
; ;;                              (cd path))))

; ;;     (use-package counsel
; ;;       :config
; ;;       (define-key ivy-mode-map [remap execute-extended-command] 'counsel-M-x))


; ;;     ;; fix sexp macro indenting
; ;;     (eval-after-load "lisp-mode"
; ;;       '(defun lisp-indent-function (indent-point state)
; ;;          "This function is the normal value of the variable `lisp-indent-function'.
; ;; The function `calculate-lisp-indent' calls this to determine
; ;; if the arguments of a Lisp function call should be indented specially.
; ;; INDENT-POINT is the position at which the line being indented begins.
; ;; Point is located at the point to indent under (for default indentation);
; ;; STATE is the `parse-partial-sexp' state for that position.
; ;; If the current line is in a call to a Lisp function that has a non-nil
; ;; property `lisp-indent-function' (or the deprecated `lisp-indent-hook'),
; ;; it specifies how to indent.  The property value can be:
; ;; * `defun', meaning indent `defun'-style
; ;;   \(this is also the case if there is no property and the function
; ;;   has a name that begins with \"def\", and three or more arguments);
; ;; * an integer N, meaning indent the first N arguments specially
; ;;   (like ordinary function arguments), and then indent any further
; ;;   arguments like a body;
; ;; * a function to call that returns the indentation (or nil).
; ;;   `lisp-indent-function' calls this function with the same two arguments
; ;;   that it itself received.
; ;; This function returns either the indentation to use, or nil if the
; ;; Lisp function does not specify a special indentation."
; ;;          (let ((normal-indent (current-column))
; ;;                (orig-point (point)))
; ;;            (goto-char (1+ (elt state 1)))
; ;;            (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
; ;;            (cond
; ;;             ;; car of form doesn't seem to be a symbol, or is a keyword
; ;;             ((and (elt state 2)
; ;;                 (or (not (looking-at "\\sw\\|\\s_"))
; ;;                    (looking-at ":")))
; ;;              (if (not (> (save-excursion (forward-line 1) (point))
; ;;                        calculate-lisp-indent-last-sexp))
; ;;                  (progn (goto-char calculate-lisp-indent-last-sexp)
; ;;                         (beginning-of-line)
; ;;                         (parse-partial-sexp (point)
; ;;                                             calculate-lisp-indent-last-sexp 0 t)))
; ;;              ;; Indent under the list or under the first sexp on the same
; ;;              ;; line as calculate-lisp-indent-last-sexp.  Note that first
; ;;              ;; thing on that line has to be complete sexp since we are
; ;;              ;; inside the innermost containing sexp.
; ;;              (backward-prefix-chars)
; ;;              (current-column))
; ;;             ((and (save-excursion
; ;;                   (goto-char indent-point)
; ;;                   (skip-syntax-forward " ")
; ;;                   (not (looking-at ":")))
; ;;                 (save-excursion
; ;;                   (goto-char orig-point)
; ;;                   (looking-at ":")))
; ;;              (save-excursion
; ;;                (goto-char (+ 2 (elt state 1)))
; ;;                (current-column)))
; ;;             (t
; ;;              (let ((function (buffer-substring (point)
; ;;                                                (progn (forward-sexp 1) (point))))
; ;;                    method)
; ;;                (setq method (or (function-get (intern-soft function)
; ;;                                              'lisp-indent-function)
; ;;                                (get (intern-soft function) 'lisp-indent-hook)))
; ;;                (cond ((or (eq method 'defun)
; ;;                          (and (null method)
; ;;                             (> (length function) 3)
; ;;                             (string-match "\\`def" function)))
; ;;                       (lisp-indent-defform state indent-point))
; ;;                      ((integerp method)
; ;;                       (lisp-indent-specform method state
; ;;                                             indent-point normal-indent))
; ;;                      (method
; ;;                       (funcall method indent-point state)))))))))
