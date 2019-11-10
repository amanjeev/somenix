;; package --- emacs
;;; Commentary:
;;; This is a personal Emacs settings package

;; -*- Mode: Emacs-Lisp -*-

;;; Code:
(setq inhibit-startup-message t)

;; stable package archive
(setq package-enable-at-startup nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

(add-to-list 'auto-mode-alist '("\\.tf\\'" . hcl-mode))

;; Make the sequence "C-xw" execute the `what-line' command,
;; which prints the current line number in the echo area.
(global-set-key "\C-xw" 'what-line)

(menu-bar-mode -1)
(tool-bar-mode -1)
(global-visual-line-mode 1)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;(when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" "3629b62a41f2e5f84006ff14a2247e679745896b5eaa1d5bcfbc904a3441b0cd" "9492cf1ac00c8a1f7130a867a97404dfeb6727801c6b2b40b853b91543f7af67" default)))
 '(package-selected-packages
   (quote
    (markdown-preview-mode kapacitor docker dockerfile-mode hcl-mode solarized-theme color-theme-solarized auto-complete puppet-mode yaml-mode iedit beacon exec-path-from-shell flycheck counsel swiper ace-window org-bullets which-key try org org-ac use-package-chords python-django use-package highlight-symbol monokai-theme powerline-evil powerline symon multi-term magithub scala-mode rust-mode json-mode web-beautify emmet-mode web-mode clojure-mode slime elpy jedi company-go company-web company-cmake evil-nerd-commenter multiple-cursors rainbow-identifiers rainbow-delimiters rainbow-mode undo-tree visual-regexp ace-jump-mode minimap sublimity god-mode magit diffview python xpm ## js2-mode company)))
 '(save-place t)
 '(show-paren-mode t))

;; for ssh
(require 'tramp)
(setq tramp-default-method "ssh")
(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")
(setq tramp-chunksize 500)

;; https://www.emacswiki.org/emacs/AlarmBell
;;(setq visible-bell 1)
;; turn off alarm completely
(setq ring-bell-function 'ignore)


;; global company mode
(add-hook 'after-init-hook 'global-company-mode)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agent)
(setq org-log-done t)

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;;(setq exec-path-from-shell-variables '("PATH" "MANPATH" "GOROOT"))

;; set auto mode for .tf files
(add-to-list 'auto-mode-alist '("\\.tf\\'" . hcl-mode))

;; to try other packages
(use-package try
  :ensure t)

;; find your cursor
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  )

;; refactor text simultaneously
(use-package iedit
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Org-mode stuff
;;(use-package org-bullets
;;  :ensure t
;;  :config
;;  (add-hook 'org-mode-hook (lambda () (org-bullet-mode 1))))

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; open buffer in another window
(defalias 'list-buffers 'ibuffer-other-window)

;; change C-x o to show numbers if more than 2 windows
(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    ))

;; move around the text
;; Better M-y via counsel
(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y". ivy-next-line)))

;; better search
(use-package swiper
  :ensure try
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))


(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))


(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    ;;(global-auto-complete-mode t)
    ))

(use-package exec-path-from-shell
  :ensure t
  )


;; programming languages
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; python
(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

;; Commands to remember

;; macro
;; C-x ( to start recording macro
;; C-x ) to end recording macro
;; C-x e to replay

;; M-x --- look for rectangle commands like kill-rectangle, string-rectangle etc.

;; M-y --- to see all killed stuff to be yanked.

;; Install extensions if they're missing
(defun packages-install (my-packages)
  (dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p))))

(defun init--install-packages ()
  (packages-install
   '(
     iedit
     beacon
     exec-path-from-shell
     flycheck
     counsel
     swiper
     ace-window
     org-bullets
     which-key
     try
     org
     org-ac
     use-package-chords
     python-django
     use-package
     highlight-symbol
     monokai-theme
     powerline-evil
     powerline symon
     multi-term
     magithub
     scala-mode
     rust-mode
     json-mode
     web-beautify
     emmet-mode
     web-mode
     clojure-mode
     slime
     elpy
     jedi
     company-go
     company-web
     company-cmake
     evil-nerd-commenter
     multiple-cursors
     rainbow-identifiers
     rainbow-delimiters
     rainbow-mode
     undo-tree
     visual-regexp
     ace-jump-mode
     minimap
     sublimity
     god-mode
     magit
     diffview
     python
     xpm
     js2-mode
     company)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit variable-pitch :foreground "#cb4b16" :height 1.0))))
 '(org-level-2 ((t (:inherit variable-pitch :foreground "#859900" :height 0.9))))
 '(org-level-3 ((t (:inherit variable-pitch :foreground "#268bd2" :height 0.8)))))
(set-face-attribute 'default nil :height 140)
(provide '.emacs)
;;; .emacs ends here
(put 'upcase-region 'disabled nil)