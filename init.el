(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(doom-modeline org)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)))
 
 (scroll-bar-mode -1)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))


(require 'use-package)
(setq use-package-always-ensure t)

(set-face-attribute 'default nil :font "JetBrains Mono" :height 100)
(load-theme 'dracula t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
  
(use-package elpy
  :ensure t
  :init
  (elpy-enable))


(setq org-odt-preferred-output-format "docx")

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))


(setq dashboard-startup-banner "~/me/god.png")
