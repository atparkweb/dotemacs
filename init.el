;;; package --- Summary
;;; Commentary:
;;; Code:

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa.milkbox.net/packages/") t)

(require 'cask "/home/atpark333/.cask/cask.el")
(cask-initialize)

(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(package-selected-packages
   '(rust-mode flycheck-rust tide company diminish evil flycheck-ledger company-ghc ghc yaml-mode puppet-mode lua-mode markdown-mode stylus-mode fish-mode helm-flycheck helm-swoop helm-dash helm-ag helm-projectile helm git-gutter persp-projectile perspective neotree autopair rainbow-mode smart-mode-line yasnippet web-mode use-package typescript-mode smex smartparens scss-mode rainbow-delimiters projectile prodigy popwin php-mode pallet nyan-mode multiple-cursors magit linum-relative less-css-mode ledger-mode js2-mode idle-highlight-mode htmlize flycheck-elm flycheck-cask expand-region exec-path-from-shell evil-surround evil-snipe evil-search-highlight-persist evil-matchit evil-leader evil-commentary ess emmet-mode elm-mode editorconfig drag-stuff dockerfile-mode alchemist, vue-mode))
 '(safe-local-variable-values
   '((haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4))))

;; Use UTF-8 encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq current-language-environment "UTF-8")
(setenv "LC_CTYPE" "UTF-8")

;; Other stuff
(setq inhibit-startup-screen t)
(menu-bar-mode -1) ;; Disable menu bar
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))
(setq highlight-trailing-whitespace t)
(setq standard-indent 2)
(setq js-indent-level 2)
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq
  backup-by-copying t ; don't clobber symlinks
  backup-directory-alist
    '(("." . "~/.saves/"))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)  ; use versioned backups
(setq auto-save-default nil)
(auto-save-mode nil) ;; Disable autosaving
(show-paren-mode t) ;; Show matching parens
(setq scroll-margin 5 scroll-conservatively 9999 scroll-step 1) ;; Smooth scrolling
(setq gc-cons-threshold 20000000) ;; Increase garbage collection limit
(setq visible-bell 1)
(setq ring-bell-function 'ignore)
(setq blink-matching-paren nil)
(setq require-final-newline t)
(setq initial-scratch-message ";; Hello, Andy")
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 80)
(setq large-file-warning-threshold 100000000)

(column-number-mode 1)
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
    (set-face-background 'default "unspecified-bg" frame)
    (set-face-background 'mode-line "unspecified-bg" frame)
    (set-face-background 'fringe "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))
    (set-face-background 'mode-line "unspecified-bg" (selected-frame))
    (set-face-background 'fringe "unspecified-bg" frame)))
(add-hook 'window-setup-hook 'on-after-init)

(global-undo-tree-mode)

;; Theme.
;; ================================================================================
(use-package hc-zenburn-theme
  :load-path "vendor/hc-zenburn-emacs"
  :init (progn
          (require 'hc-zenburn-theme)
            (load-theme 'hc-zenburn t)))

(use-package smart-mode-line
  :ensure t
  :init (progn
          (setq sml/shorten-directory t)
          (setq sml/shorten-modes t)
          (setq sml/name-width 30)
          (setq sml/numbers-separator "")
          (setq sml/show-trailing-N nil)
          (setq sml/show-frame-identification nil)
          (setq sml/mule-info nil)
          (setq sml/show-client nil)
          (setq sml/show-remote nil)
          (setq sml/position-percentage-format nil)
          (sml/setup))
  :config (sml/apply-theme 'respectful))


;; Misc.
;; ================================================================================
(use-package undo-tree
  :diminish undo-tree-mode
  :init (progn
    (setq undo-tree-auto-save-history t)))

(use-package php-mode
  :ensure t
  :config (progn
            (setq indent-tabs-mode t)
            (setq tab-width 4)))

(use-package scss-mode
  :ensure t)

(use-package editorconfig
  :ensure t)

(use-package smex
  :ensure t
  :commands smex
  :bind (("M-x" . smex)
         ("≈" . smex)))

;; EVIL
;; ================================================================================
(use-package evil
  :ensure t
  :init (progn
          (setq evil-want-C-u-scroll t
                evil-overriding-maps nil
                evil-intercept-maps nil
                evil-shift-width 2
    evil-undo-system 'undo-tree
                evil-esc-delay 0 ; Prevent esc from translating to meta key in terminal mode
                ; Cursor
                evil-emacs-state-cursor  '("red" box)
                evil-normal-state-cursor '("gray" box)
                evil-visual-state-cursor '("gray" box)
                evil-insert-state-cursor '("gray" bar)
                evil-motion-state-cursor '("gray" box))
          (evil-mode 1))
  :bind ("C-q" . delete-window)
  :config (progn

            (use-package evil-leader
              :ensure t
              :init (global-evil-leader-mode)
              :config (progn
                        (evil-leader/set-leader ",")
                        (evil-leader/set-key "t" 'transpose-words)
                        (evil-leader/set-key "w" 'save-buffer)
                        (evil-leader/set-key "i" 'evil-window-move-far-left)
                        (evil-leader/set-key "a" 'align-regexp)
                        (evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all)))

            (use-package evil-search-highlight-persist
               :ensure t
               :init (global-evil-search-highlight-persist))

            (use-package evil-commentary
              :ensure t
              :init (evil-commentary-mode))

            (use-package evil-snipe
              :ensure t
              :diminish evil-snipe-mode
              :init     (progn
                          (evil-snipe-mode 1)
                          (evil-snipe-override-mode 1)))

            (use-package evil-surround
              :ensure t
              :init (global-evil-surround-mode 1))

            (use-package evil-matchit
              :ensure t
              :init (global-evil-matchit-mode 1))

            ; Window management
            (global-set-key (kbd "C-q") 'delete-window)
            (global-set-key (kbd "C-j") 'evil-window-next)
            (global-set-key (kbd "C-k") 'evil-window-prev)
            (define-key evil-normal-state-map (kbd "C-q") 'delete-window)
            (define-key evil-normal-state-map (kbd "C-j") 'evil-window-next)
            (define-key evil-normal-state-map (kbd "C-k") 'evil-window-prev)
            (define-key evil-normal-state-map (kbd "C-l") 'evil-window-increase-width)
            (define-key evil-normal-state-map (kbd "C-h") 'evil-window-decrease-width)
            (define-key evil-insert-state-map (kbd "C-j") 'comment-indent-new-line)

            (define-key evil-normal-state-map (kbd "-")
              (lambda ()
                (interactive)
                (split-window-vertically)
                (other-window 1)))

            (define-key evil-normal-state-map (kbd "|")
              (lambda ()
                (interactive)
                (split-window-horizontally)
                    (other-window 1)))

            ; Buffer Management
            (define-key evil-visual-state-map (kbd "SPC") 'evil-search-forward)
            (define-key evil-normal-state-map (kbd "SPC") 'evil-search-forward)
            (evil-add-hjkl-bindings package-menu-mode-map 'emacs)
            (evil-add-hjkl-bindings outline-mode-map 'emacs)
            (evil-add-hjkl-bindings occur-mode-map 'emacs)
            (define-key evil-visual-state-map (kbd "C-i") 'indent-region)))


;; Visual utilities
;; ================================================================================
(use-package diminish
  :ensure t
  :config (progn
            (diminish 'isearch-mode " ?")))

(use-package rainbow-mode
  :ensure t
  :diminish rainbow-mode
  :commands (rainbow-mode)
  :init (progn
          (add-hook 'css-mode-hook 'rainbow-mode)
          (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)))

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode
  :init (progn
          (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)))

;;(use-package linum-relative
;; :ensure t
;;  :config (progn
;;           (setq linum-relative-format "%3s   ")
;;            (linum-on)
;;            (linum-relative-global-mode)))

(use-package popwin
  :ensure t
  :commands (popwin-mode)
  :init (popwin-mode 1)
  :config (progn
            (evil-define-key 'normal popwin:keymap (kbd "q") 'popwin:close-popup-window)
            ;; Let's override the popwin defaults
            (setq popwin:special-display-config  '(("^\\*magit:.*\\*$" :regexp t :position top :height 20 :dedicated t)
                                                   ("^\\*helm.*\\*$" :regexp t :position bottom :dedicated t)
                                                   (help-mode :position bottom :noselect t :stick t)
                                                   (completion-list-mode :noselect t)
                                                   (grep-mode :noselect t)
                                                   (occur-mode :noselect t)
                                                   ("*Warnings*" :noselect t)
                                                   ("*Miniedit Help*" :noselect t)
                                                   ("*undo-tree*" :width 60 :position right)))))

(use-package autopair
  :ensure t
  :diminish autopair-mode
  :init (autopair-global-mode))


;; File and buffer management
;; ================================================================================
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init (progn
          (setq projectile-enable-caching t)
          (setq projectile-completion-system 'ido)
          (setq projectile-indexing-method 'alien)
          (projectile-global-mode +1))
  :config (progn
            (add-to-list 'projectile-globally-ignored-directories ".cache")
            (add-to-list 'projectile-globally-ignored-directories ".tmp")
            (add-to-list 'projectile-globally-ignored-directories "tmp")
            (add-to-list 'projectile-globally-ignored-directories "node_modules")
            (add-to-list 'projectile-globally-ignored-directories "bower_components")))

(use-package neotree
  :ensure t
  :commands (neotree-dir neo-global--window-exists-p)
  :preface (progn
             (defun projectile-neotree-project-root ()
                (interactive)
                (if (neo-global--window-exists-p)
                  (neotree-hide)
                  (if (projectile-project-p)
                    (neotree-dir (projectile-project-root))
                    (neotree)))))
  :init (progn
          (setq neo-window-fixed-size nil)
          (evil-leader/set-key "k b" 'projectile-neotree-project-root)
          (evil-leader/set-key "k r" 'neotree-find))
  :config (progn
            (evil-add-hjkl-bindings neotree-mode-map 'normal)
            (evil-define-key 'normal neotree-mode-map
              "a" 'neotree-stretch-toggle
              "q" 'neotree-hide
              "o" 'neotree-enter
              "v" 'neotree-enter-vertical-split
              "i" 'neotree-enter-horizontal-split
              "r" 'neotree-refresh
              "h" 'neotree-hidden-file-toggle
              (kbd "m d") 'neotree-delete-node
              (kbd "m a") 'neotree-create-node
              (kbd "m m") 'neotree-rename-node)))

(use-package perspective
  :ensure t
  :init (progn
            (define-key evil-normal-state-map (kbd "C-@") 'persp-switch)
            (define-key evil-normal-state-map (kbd ")") 'persp-next)
            (define-key evil-normal-state-map (kbd "(") 'persp-prev)
            (evil-leader/set-key "p k" 'persp-kill)
            (persp-mode))
  :config (progn
            (use-package persp-projectile :ensure t)))


;; Git Utilities
;; ================================================================================
(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :init (global-git-gutter-mode +1)
  :config (progn
            (git-gutter:linum-setup)
            (define-key evil-normal-state-map (kbd "] c") 'git-gutter:next-hunk)
            (define-key evil-normal-state-map (kbd "[ c") 'git-gutter:previous-hunk)
            (evil-leader/set-key "g a" 'git-gutter:stage-hunk)
            (evil-leader/set-key "g r" 'git-gutter:revert-hunk)))

(use-package magit
  :ensure t
  :init (progn
          (evil-set-initial-state 'git-commit-mode 'insert)
          (evil-set-initial-state 'git-commit-major-mode 'insert)
          (evil-set-initial-state 'text-mode 'insert) ;; Git-commit is text-mode major
          (evil-leader/set-key
            "g l" 'magit-log
            "g c" 'magit-commit
            "g C" 'magit-commit-amend
            "g s" 'magit-status
            "g d" 'magit-diff-unstaged
            "g D" 'magit-diff-staged
            "g b" 'magit-blame
            "g w" 'magit-stage-file))
  :config (progn
            (setq magit-keymaps
              '(magit-mode-map magit-log-mode-map magit-refs-mode-map
                 magit-diff-mode-map magit-stash-mode-map magit-blame-mode-map
                 magit-reflog-mode-map magit-status-mode-map magit-tag-section-map
                 magit-cherry-mode-map magit-hunk-section-map magit-file-section-map
                 magit-process-mode-map magit-stashes-mode-map magit-revision-mode-map
                 magit-log-read-revs-map magit-stash-section-map magit-staged-section-map
                 magit-remote-section-map magit-commit-section-map magit-branch-section-map
                 magit-stashes-section-map magit-log-select-mode-map magit-unpulled-section-map
                 magit-unstaged-section-map magit-unpushed-section-map magit-untracked-section-map
                 magit-module-commit-section-map))
            (dolist (map-name magit-keymaps)
              (let* ((map (symbol-value map-name)))
                (-when-let (def (lookup-key map "v"))
                  (define-key map "V" def)
                  (define-key map "v" nil))
                (-when-let (def (lookup-key map "k"))
                  (define-key map "K" def)
                  (define-key map "k" nil))
                (evil-add-hjkl-bindings map 'emacs
                  "v" 'evil-visual-char)))))


;; Flycheck
;; ================================================================================
(use-package flycheck
  :ensure t
  :diminish (flycheck-mode . " f")
  :init (progn
          (setq flycheck-check-syntax-automatically '(mode-enabled save))
          (global-flycheck-mode))
  :config (progn
            (define-key evil-normal-state-map (kbd "] e") 'next-error)
            (define-key evil-normal-state-map (kbd "[ e") 'previous-error)))

;;;----------------------------------------
;;; jsx web-mode flycheck config
;;;----------------------------------------

;; Disable jshint since I want to use eslint as my checker
(setq-default flycheck-disable-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; Custom flycheck temp files prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; Use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;;;----------------------------------------
;;; flymake
;;;----------------------------------------

(use-package flymake
  :ensure t
  :init (progn
          (defun flymake-compile-script-path (path)
            (let* ((temp-file (flymake-init-create-temp-buffer-copy
                              'flymake-create-temp-inplace))
                  (local-file (file-relative-name
                                temp-file
                                (file-name-directory buffer-file-name))))
              (list path (list local-file))))

          (defun flymake-syntaxerl ()
            (flymake-compile-script-path "/usr/local/bin/syntaxerl"))

          ; see /usr/local/lib/erlang/lib/tools-<Ver>/emacs/erlang-flymake.erl
          (defun erlang-flymake-only-on-save ()
              "Trigger flymake only when the buffer is saved (disables syntax check on newline and when there are no changes)."
              (interactive)
              ;; There doesn't seem to be a way of disabling this; set to the
              ;; largest int available as a workaround (most-positive-fixnum
              ;; equates to 8.5 years on my machine, so it ought to be enough ;-) )
              (setq flymake-no-changes-timeout most-positive-fixnum))

          (setq flymake-log-level 3)
          (add-hook 'erlang-mode-hook
                    '(lambda()
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'"     flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.hrl\\'"     flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.xrl\\'"     flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.yrl\\'"     flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.app\\'"     flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.app.src\\'" flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.config\\'"  flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.rel\\'"     flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.script\\'"  flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.escript\\'" flymake-syntaxerl))
                      (add-to-list 'flymake-allowed-file-name-masks '("\\.es\\'"      flymake-syntaxerl))

                      ;; should be the last.
                      (flymake-mode 1)))
          (erlang-flymake-only-on-save)))

; http://www.emacswiki.org/emacs/FlymakeCursor
;(require 'flymake-cursor) 


;; Helm
;; ================================================================================
(use-package helm
  :ensure t
  :init (progn
          (require 'helm-config))
  :config (progn
            (helm-autoresize-mode 1)
            (define-key evil-normal-state-map (kbd "C-b") 'helm-buffers-list)
            (define-key evil-normal-state-map (kbd "g o") 'helm-google-suggest)

            (define-key helm-map (kbd "C-l") 'projectile-invalidate-cache)
            (define-key helm-map (kbd "C-b") 'helm-keyboard-quit)
            (define-key helm-map (kbd "C-p") 'helm-keyboard-quit)
            (define-key helm-map (kbd "C-j") 'helm-next-line)
            (define-key helm-map (kbd "C-k") 'helm-previous-line)
            (define-key helm-map (kbd "C-d") 'helm-buffer-run-kill-persistent)))

(use-package helm-projectile
  :ensure t
  :bind ("C-p" . helm-projectile)
  :init (progn
          (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile)))

(use-package helm-ag
  :ensure t
  :commands (helm-projectile-ag)
  :init (progn
          (define-key evil-normal-state-map (kbd "C-s") 'helm-projectile-ag)))

(use-package helm-dash
  :ensure t
  :init (progn
          (setq dash-docs-docsets-path "~/.docset")
          (setq dash-docs-common-docsets '("Lo-Dash" "HTML" "CSS"))
          (evil-leader/set-key "f" 'helm-dash-at-point)
          (define-key evil-normal-state-map (kbd "C-f") 'helm-dash))
  :config (progn
            (add-hook 'prog-mode-hook
              (lambda ()
                (interactive)
                (setq helm-current-buffer (current-buffer))))))

(use-package helm-swoop
  :ensure t
  :commands (helm-swoop)
  :init (progn
          (evil-leader/set-key "sb" 'helm-swoop)
          (evil-leader/set-key "sa" 'helm-multi-swoop)))

(use-package helm-flycheck
  :ensure t
  :commands helm-flycheck
  :init (evil-leader/set-key "e l" 'helm-flycheck))


;; Company moed
;; ================================================================================
(use-package company
  :ensure t
  :diminish " c"
  :defines company-dabbrev-downcase
  :init (progn
          (setq company-dabbrev-downcase nil)
          (global-company-mode))
  :config (progn
                                        ; Swap some keybindings
            (define-key company-active-map (kbd "C-j") 'company-select-next)
            (define-key company-active-map (kbd "C-k") 'company-select-previous)
            (define-key company-active-map (kbd "C-i") 'company-select-next)
            (define-key company-active-map (kbd "C-o") 'company-select-previous)
                                        ; Okay lets setup company backends the way we want it, in a single place.
            (setq company-backends
              '( company-css
                 company-elisp
                 company-clang
                 company-ghc
                 ( company-capf
                   company-dabbrev-code
                   ;; company-etags
                   ;; company-gtags
                   company-keywords
                   company-files
                   company-dabbrev
                   :with company-yasnippet)))))


;; LANGUAGE PACKS
;; ================================================================================

(use-package js2-mode
  :ensure t
  :diminish js2-minor-mode
  :commands (js2-mode js-mode js2-minor-mode)
  :defines helm-dash-docsets
  :init (progn
          (setq indent-tabs-mode t)
          (setq tab-width 2)
          (use-package tern
            :diminish " T"
            :commands (tern-mode)
            :ensure t
            :init (progn
                    (add-hook 'js-mode-hook 'tern-mode)
                    (add-hook 'js-mode-hook (lambda()
                                                   ;; Scan the file for nested codeblocks
                                                   (imenu-add-menubar-index)
                                                   ;; Activate the folding mode
                                                   (hs-minor-mode t)))))
          (setq js2-highlight-level 3)
          (setq js2-mode-show-parse-errors nil)
          (setq js2-mode-show-strict-warnings nil)
                                        ; Use js2-mode as a minor mode (preferred way)
          (add-hook 'js-mode-hook 'js2-minor-mode)
          (add-to-list 'interpreter-mode-alist '("node" . js-mode)))
  :config (progn
            (add-hook 'js2-minor-mode-hook
              (lambda ()
                (interactive)
                (setq-local helm-dash-docsets
                  '("Javascript"
                     "NodeJS"
                     "Vue"
                     "React"
                     "Chai"))))))


;; ================================================================================
;; Web Mode
;; ================================================================================

(use-package web-mode
  :ensure t
  :preface (progn
             (defun jsxhint-predicate ()
               (and (executable-find "jsxhint")
                 (buffer-file-name)
                 (string-match ".*\.jsx?$" (buffer-file-name)))))
  :commands web-mode
  :init (progn
          (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.liquid\\'" . liquid-mode))
          (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.html.twig\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.html.jsx\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.tag\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
          (add-to-list 'magic-mode-alist '("\/\*\*.*@jsx" . web-mode))

          (flycheck-define-checker jsxhint
            "A JSX syntax and style checker based on JSXHint."
            :command ("jsxhint" source)
            :error-patterns ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
            :predicate jsxhint-predicate
            :modes (web-mode))

          (add-to-list 'flycheck-checkers 'jsxhint)

          (use-package emmet-mode
            ;; Can't diminish this, because the logic relies on
            ;; reading the mode-line.
            ;; :diminish " e"
            :ensure t
            :commands emmet-mode
            :init (progn
                    (add-hook 'sgml-mode-hook 'emmet-mode)
                    (add-hook 'css-mode-hook  'emmet-mode)
                    (add-hook 'web-mode-hook 'emmet-mode))))
  :config (progn
            (add-hook 'web-mode-hook
              (lambda ()
                (interactive)
                (setq-local helm-dash-docsets '("Javascript" "HTML" "CSS" "Lo-Dash" "jQuery" "Bootstrap_3"))))
            (add-hook 'web-mode-hook (lambda () (yas-activate-extra-mode 'js-mode)))
            (add-hook 'web-mode-hook 'rainbow-mode)
      (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
      (setq web-mode-markup-indent-offset 4)
            (define-key prog-mode-map (kbd "C-x /") 'web-mode-element-close)))

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it)) 


(use-package fish-mode
  :ensure t
  :commands fish-mode)

(use-package less-css-mode
  :ensure t
  :commands less-css-mode
  :init (progn
          (add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))))

(use-package php-mode
  :ensure t
  :commands php-mode)

(use-package markdown-mode
  :ensure t
  :commands markdown-mode)

(use-package lua-mode
  :ensure t
  :commands lua-mode)

(use-package typescript-mode
  :init (progn
          (setq indent-tabs-mode t)
          (setq tab-width 2)
    (setq typescript-indent-level 2)
          (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode)))
  :commands typescript-mode)

(use-package vue-mode
  :init (progn
    (setq indent-tabs-mode 0)
    (setq tab-width 2)
          (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode)))
  :commands vue-mode)

(use-package puppet-mode
  :ensure t
  :commands puppet-mode)

(use-package yaml-mode
  :ensure t
  :commands yaml-mode)

(defvar my-ghc-initialized nil)
(use-package ghc
  :ensure t
  :init (progn
          (add-hook 'haskell-mode-hook (lambda ()
                                         (ghc-abbrev-init)
                                         (ghc-type-init)
                                         (unless my-ghc-initialized
                                           (ghc-comp-init)
                                           (setq my-ghc-initialized t))
                                         (ghc-import-module))))
  :config (progn
            (use-package company-ghc
              :ensure t)))

(use-package haskell-mode
  :ensure t
  :commands (haskell-mode haskell-interactive-mode)
  :init (progn
          (evil-set-initial-state 'haskell-interactive-mode 'emacs)

          (setq haskell-process-auto-import-loaded-modules t)
          (setq haskell-process-log t)
          (setq haskell-process-suggest-remove-import-lines t)
          (setq haskell-process-type (quote cabal-repl))
          (setq haskell-interactive-popup-errors nil)
          (setq haskell-stylish-on-save t)

          (evil-define-key 'normal haskell-mode-map
            (kbd "?") 'hoogle)

          (evil-leader/set-key-for-mode 'haskell-mode
            "t" 'ghc-show-type
            "h t" 'haskell-process-do-type
            "h i" 'haskell-interactive-bring
            "`" 'haskell-interactive-bring
            "h r" 'haskell-process-load-or-reload
            "h k" 'haskell-session-kill
            "h m" 'haskell-menu
            "h b" 'haskell-process-cabal-build
            "h g i" 'haskell-navigate-imports
            "h f i" 'haskell-mode-format-imports)

          (add-hook 'haskell-interactive-mode-hook
            (lambda ()
              (local-set-key (kbd "<up>") 'haskell-interactive-mode-history-previous)
              (local-set-key (kbd "<down>") 'haskell-interactive-mode-history-next)
              (local-set-key (kbd "C-j") 'evil-window-next)))

          (add-hook 'haskell-mode-hook (lambda ()
                                         (interactive-haskell-mode)
                                         (turn-on-haskell-indentation)))))

;; Ledger-mode
;; ================================================================================
(use-package ledger-mode
  :ensure t
  :commands ledger-mode
  :init (progn
          (add-to-list 'auto-mode-alist '("\\.ledger\\'" . ledger-mode)))
  :config (progn
            (evil-define-key 'normal ledger-mode-map
              (kbd "Y") 'ledger-copy-transaction-at-point
              (kbd "C") 'ledger-post-edit-amount
              (kbd "!") 'ledger-post-align-postings)

            (evil-leader/set-key-for-mode 'ledger-mode
              "n" 'ledger-add-transaction
              "r" 'ledger-reconcile
              "d" 'ledger-delete-current-transaction
              "?" 'ledger-display-balance-at-point)))

(use-package flycheck-ledger :ensure t)

(use-package elixir-mode
  :ensure t
  :init (progn
          (setq highlight-tabs t)
          (setq indent-tabs-mode nil)))
          ;; (setq tab-width 2)))

;; Alchemist -- Elixir tooling
;; ================================================================================
(use-package alchemist
  :ensure t
  :config(progn
           (evil-leader/set-key-for-mode 'elixir-mode
             "c c" 'alchemist-compile-this-buffer
             "c f" 'alchemist-compile--file
             "e b" 'alchemist-execute-this-buffer
             "e f" 'alchemist-execute--file
             "h h" 'alchemist-help
             "h i" 'alchemist-help-history
             "h e" 'alchemist-help--seach-at-point
             "h r" 'alchemist-refcard
             "i i" 'alchemist-iex-run
             "t"   'alchemist-mix-test
             "v l" 'alchemist-eval-current-line
             "v k" 'alchemist-eval-print-current-line
             "v o" 'alchemist-eval-region
             "v i" 'alchemist-eval-print-region
             "v u" 'alchemist-eval-quoted-region
             "v y" 'alchemist-eval-print-quoted-region
             "v q" 'alchemist-eval-buffer
             "v w" 'alchemist-eval-print-buffer
             )))

;; Elm
;; ================================================================================
(use-package elm-mode
  :ensure t)

(with-eval-after-load 'elm-mode
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

;; Rust
;; ================================================================================
(use-package rust-mode
  :ensure t
  :init (progn
          (add-hook 'rust-mode-hook
            (lambda ()
        (setq rust-format-on-save t)
              (setq indent-tabs-mode nil)))))
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


;; Load any local configuration if it exists
(if (file-exists-p (expand-file-name ".emacs.el"))
  (progn
    (load (expand-file-name ".emacs.el"))))

(if (file-exists-p (expand-file-name "README.org"))
  (progn
    (add-to-list 'org-agenda-files (expand-file-name "README.org"))))

(if (file-exists-p (expand-file-name "project.org"))
  (progn
    (add-to-list 'org-agenda-files (expand-file-name "project.org"))))

(provide 'init)
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
