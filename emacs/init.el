(setq package-enable-at-startup nil)
;; let's be really sure package.el isn't used
(setq use-package-ensure-function 'ignore)
(setq package-archives nil)

(use-package catppuccin-theme :hook after-init-hook)
(use-package counsel)
(use-package dashboard :ensure t :config (dashboard-setup-startup-hook))
(use-package doom-themes :hook after-init-hook)
(use-package eldoc-box :hook prog-mode-hook)
(use-package esup :defer t)
(use-package evil :defer 1)
(use-package ivy-rich)
(use-package linum-relative :hook prog-mode-hook)
(use-package markdown-mode :hook markdown-mode-hook)
(use-package mini-frame)
(use-package org-bullets :hook org-mode-hook)
(use-package rust-mode :hook rust-mode-hook)
(use-package treesit-auto)
(use-package yaml-mode :defer t)

(use-package all-the-icons)
(use-package all-the-icons-ivy-rich)

(setq background-color "#11111b")
(setq foreground-color "#cdd6f4")

(load-theme 'catppuccin t)
(doom-themes-visual-bell-config)

(defun org-mode-custom-faces ()
  (set-face-attribute 'org-level-1 nil :height 200)
  (set-face-attribute 'org-level-2 nil :height 180)
  (set-face-attribute 'org-level-3 nil :height 180)
  (set-face-attribute 'org-level-4 nil :height 180)
  (set-face-attribute 'org-level-5 nil :height 180)
  (set-face-attribute 'org-level-6 nil :height 180)
  (set-face-attribute 'org-document-title nil :height 240)
  (set-face-attribute 'org-code nil :family "Monospace")
  (set-face-attribute 'org-hide nil :background background-color :foreground background-color))

(add-hook 'org-mode-hook #'org-mode-custom-faces)

(defun set-font (font-name)
  (set-face-attribute 'default nil :font font-name :height 140))

(set-font "Iosevka Nerd Font")

(add-to-list 'default-frame-alist '(alpha-background . 90))

(set-background-color background-color)

(setq pixel-scroll-precision-large-scroll-height 40.0)
(setq pixel-scroll-precision-interpolation-factor 30)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
     '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(add-hook 'emacs-startup-hook (lambda () (menu-bar-mode -1)))
(add-hook 'emacs-startup-hook (lambda () (tool-bar-mode -1)))
(add-hook 'emacs-startup-hook (lambda () (scroll-bar-mode -1)))
(add-hook 'emacs-startup-hook (lambda () (tooltip-mode -1)))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "<mouse-1>") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "<ret>") 'dired-find-alternate-file)

(evil-mode 1)
(counsel-mode 1)
(ivy-rich-mode 1)
(all-the-icons-ivy-rich-mode 1)
(electric-pair-mode 1)

(setq max-mini-window-height 3)

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(add-hook 'conf-mode-hook (lambda ()
  (visual-line-mode 1)))
(add-hook 'text-mode-hook (lambda ()
  (visual-line-mode 1)))

(add-hook 'prog-mode-hook (lambda ()
  (toggle-truncate-lines 1)))

(setq linum-relative-backend 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'linum-relative-mode)

(add-hook 'prog-mode-hook 'eglot-ensure)

(add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))

(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook (lambda () (setq fill-column 90)))

(defun format-code ()
  (add-hook 'after-save-hook #'eglot-format nil t))

(add-hook 'prog-mode-hook #'format-code)

(add-hook 'prog-mode-hook 'eldoc-box-hover-mode)

(add-hook 'prog-mode-hook 'company-mode)
(add-hook 'prog-mode-hook 'company-box-mode)

(setq company-tooltip-maximum-width 60)
(setq company-candidates-length 3)

(setq treesit-font-lock-level 4)
(setq treesit-auto-install 'prompt)
(global-treesit-auto-mode)

(defun tangle ()
  (when (eq major-mode 'org-mode)
    (org-babel-tangle)))

(add-hook 'after-save-hook 'tangle)

(setq org-startup-folded t)

(define-key evil-normal-state-map (kbd "<tab>") 'org-cycle)

(setq org-bullets-bullet-list '("●" "◉" "○"))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-hide-emphasis-markers t)

(defun org-emphasis-toggle ()
  (interactive)
  (if org-hide-emphasis-markers
    (progn (setq org-hide-emphasis-markers nil) (message "Made org details show"))
    (progn (setq org-hide-emphasis-markers t) (message "Made org details hidden"))))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(define-key evil-normal-state-map (kbd "<SPC>.") 'find-file)
(define-key evil-normal-state-map (kbd "<SPC>oe") #'org-emphasis-toggle)
