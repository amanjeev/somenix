;; package --- emacs
;;; Commentary:
;;; This is a personal Emacs settings package, large parts of this are copied from libkookie

;; -*- Mode: Emacs-Lisp -*-

;; Commands to remember
;; macro
;; C-x ( to start recording macro
;; C-x ) to end recording macro
;; C-x e to replay

;; M-x --- look for rectangle commands like kill-rectangle, string-rectangle etc.
;; M-y --- to see all killed stuff to be yanked.
;; M-TAB -- Autocomplete for org mode

;;; Code:
(setq inhibit-startup-message 1)
(setq initial-scratch-message nil)
(setq package-enable-at-startup nil)

(autoload 'notmuch "notmuch" "notmuch mail" t)
(setq notmuch-search-oldest-first nil)

;; More sane line-number behaviour
(setq display-line-numbers-grow-only 1)
(setq display-line-numbers-width-start 1)
(global-display-line-numbers-mode 1)

(setq tab-width 2)
(setq-default indent-tabs-mode nil)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(set-frame-font "Iosevka" nil t)
(setq default-frame-alist '((font . "Iosevka")))
(setq prettify-symbols-unprettify-at-point t)
(global-prettify-symbols-mode +1)
(set-face-attribute 'default nil :height 120)

(package-initialize)

;; Enable automatic shell.nix loading
(require 'direnv)
(direnv-mode)

;; Change the swap/autosave directory
(let ((backup-dir (concat user-emacs-directory "backups")))
  (make-directory backup-dir t)
  (setq backup-directory-alist (list (cons "." backup-dir)))
  (setq message-auto-save-directory backup-dir))

;; Some editing niceties
(delete-selection-mode 1)
(show-paren-mode 1)
(setq-default truncate-lines t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-visual-line-mode 1)
(column-number-mode 1)
(ido-mode 1)

(setq custom-safe-themes t)
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-eighties t)

(smartscan-mode 1)
(beacon-mode 1)

(setq markdown-command "pandoc")

(require 'sublimity)
(require 'sublimity-scroll)
(require 'sublimity-map)
(require 'sublimity-attractive)
(setq sublimity-map-size 10)
(setq sublimity-map-fraction 0.5)
(setq sublimity-map-text-scale -7)
;; Display minimap without delay
(sublimity-map-set-delay nil)

(require 'tramp)

(setq ring-bell-function 'ignore)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agent)
(global-set-key (kbd "\C-cc") 'org-capture)
(setq org-log-done t)

(global-set-key [remap other-window] 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)

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

;;; .emacs ends here
