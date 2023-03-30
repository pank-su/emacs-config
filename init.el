
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")


(scroll-bar-mode -1)
(tool-bar-mode -1)          ; Disable the toolbar



(require 'package)

(setq package-archives '(("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("gnu-devel" . "https://elpa.gnu.org/devel/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)


(use-package use-package-ensure-system-package :ensure t)

(setq use-package-always-ensure t)


(use-package org-modern)
;; Option 1: Per buffer
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;; (use-package dracula-theme)
(set-face-attribute 'default nil :font "JetBrains Mono" :height 100)
;; (load-theme 'dracula t)

(use-package material-theme)
(load-theme 'material-light t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sql . t)
   (java . t)
   (kotlin . t)
   (shell . t)
   (plantuml . t)
  )
 )

(setq org-plantuml-jar-path "~/.emacs.d/plantuml.jar")

(setq org-latex-classes
   '(("extarticle" "\\documentclass[14pt]{extarticle}"
	  ("\\section{%s}" . "\\section*{%s}")
	  ("\\subsection{%s}" . "\\subsection*{%s}")
	  ("\\subsubsection{%s}" . "\\subsubsection{%s}")
	  ("\\paragraph{%s}" . "\\paragraph*{%s}")
	  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
	 ("article" "\\documentclass[11pt]{article}"
	  ("\\section{%s}" . "\\section*{%s}")
	  ("\\subsection{%s}" . "\\subsection*{%s}")
	  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	  ("\\paragraph{%s}" . "\\paragraph*{%s}")
	  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
	 ("report" "\\documentclass[11pt]{report}"
	  ("\\part{%s}" . "\\part*{%s}")
	  ("\\chapter{%s}" . "\\chapter*{%s}")
	  ("\\section{%s}" . "\\section*{%s}")
	  ("\\subsection{%s}" . "\\subsection*{%s}")
	  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
	 ("book" "\\documentclass[11pt]{book}"
	  ("\\part{%s}" . "\\part*{%s}")
	  ("\\chapter{%s}" . "\\chapter*{%s}")
	  ("\\section{%s}" . "\\section*{%s}")
	  ("\\subsection{%s}" . "\\subsection*{%s}")
	  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(setq
   org-export-in-background t
   org-latex-minted-options '(("breaklines" "true")
	 ("float" "t")
	 ("breakanywhere" "true")
	 ("fontsize" "\\footnotesize"))
    org-latex-default-table-environment "longtable")

(use-package ox-reveal
  :config (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))



(setq org-latex-title-command (concat
			       "\\begin{titlepage}\n\n"
			       "\\centering{ГУАП}\n\n"
			       "\\vspace{32pt}\n\n"
			       "\\centering{ФАКУЛЬТЕТ СРЕДНЕГО ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ}\n\n"
			       "\\vspace{60pt}\n\n"
			       "\\raggedright{ОТЧЕТ \\\\
ЗАЩИЩЕН С ОЦЕНКОЙ}\n"
			       "\\vspace{14pt}\n\n"
			       "\\raggedright{ПРЕПОДАВАТЕЛЬ}\n\n"
			       "\\vspace{12pt}\n\n"
			       "\\begin{tabularx}{\\textwidth}{ >{\\centering\\arraybackslash}X >{\\centering\\arraybackslash}X >{\\centering\\arraybackslash}X }\n"
			       "\t преподаватель & & %d \\\\ \n"
			       "\t \\hrulefill & \\hrulefill & \\hrulefill \\\\ \n"
			       "\\footnotesize{должность, уч. степень, звание} & \\footnotesize{подпись, дата} & \\footnotesize{инициалы, фамилия} \\\\ \n"
			       "\\end{tabularx} \n \n"
			       "\\vspace{48pt} \n\n"
			       "\\centering{ОТЧЕТЫ О ЛАБОРАТОРНЫХ РАБОТАХ} \n\n"
			       "\\vspace{76pt} \n\n"
			       "\\centering{По дисциплине: %t} \n\n"
			       "\\vspace*{\\fill} \n\n"
			       "\\raggedright{РАБОТУ ВЫПОЛНИЛ} \n\n"
			       "\\vspace{10pt} \n\n"
			       "\\begin{tabularx}{\\textwidth}{>{\\raggedright\\arraybackslash}X  >{\\centering\\arraybackslash}X >{\\centering\\arraybackslash}X >{\\centering\\arraybackslash}X }\n"
			       "\t СТУДЕНТ ГР. № & 021к & & %a \\\\ \n"
			       "\t & \\hrulefill & \\hrulefill & \\hrulefill \\\\ \n"
			       "\t &  & \\footnotesize{подпись, дата} & \\footnotesize{инициалы, фамилия} \\\\ \n"
			       "\\end{tabularx} \n \n"
			       "\\vspace*{\\fill} \n\n"
			       "\\centering{Санкт-Петербург \\the\\year} \n\n"
			       "\\end{titlepage}\n"
			       ))

(setq org-latex-toc-command "\n\\tableofcontents \\clearpage\n")


(use-package f)

(defun my-latex-filter-continue-string (text backend info)
  "Ensure \"_\" are properly handled in LaTeX export."
  (when (org-export-derived-backend-p backend 'latex)
    (string-replace "\\\\" "\\\\ \n \\hline" (replace-regexp-in-string "Continued on next page"
								       "Продолжение на следующей странице"
								       (replace-regexp-in-string "Continued from previous page"
												 "Продолжение с предыдущей страницы" text))))
  )


(add-to-list 'org-export-filter-table-functions
             'my-latex-filter-continue-string)



(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))





(use-package org-download
    :after org
    :defer nil
    :custom
    (org-download-method 'directory)
    (org-download-image-dir "images")
    (org-download-heading-lvl nil)
    ;; (org-download-timestamp "%Y%m%d-%H%M%S_")
    (org-image-actual-width 300)
    (org-download-screenshot-method "magick clipboard: \"%s\"")
    :bind
    ("C-M-y" . org-download-screenshot)
    :config
    (require 'org-download)
    (add-hook 'dired-mode-hook 'org-download-enable)
    )

;; My library
;; (use-package notion-org
  ;; :load-path "C:/Users/user/Desktop/notion-org/")

(use-package company
  :config (global-company-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))


(setq dashboard-startup-banner "~/.emacs.d/me/god.png")

(use-package magit)

(setq org-publish-project-alist '(("org"
				   :base-directory "c:/Users/user/Desktop/sem_6"
				   :base-extension "org"
				   :recursive t
				   :publishing-function org-html-publish-to-html
				   :publishing-directory "C:/Users/user/Desktop/sem_6/publ")))

(defun my-org-confirm-babel-evaluate (lang body)
  (not (string= lang "sql")))  ;don't ask for ditaa
(setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

(setq org-babel-default-header-args:sql '(
					  (:dbuser . "org-mode")
					  (:dbpassword . "org-mode")
					  ))


(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package google-translate)


(require 'google-translate)
(require 'google-translate-smooth-ui)
(global-set-key "\C-ct" 'google-translate-smooth-translate)
(setq google-translate-default-target-language "ru") 

;; (setq org-latex-image-default-option '(("float" "wrap")))

(use-package org-ai
  :load-path "./org-ai"
  :commands (org-ai-mode)
  :custom
  (org-ai-openai-api-token "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")
  :init
  (add-hook 'org-mode-hook #'org-ai-mode)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(gradle-mode csv-mode htmlize csharp-mode magit dashboard company activity-watch-mode org-download ox-reveal dracula-theme org-modern use-package-ensure-system-package system-packages gcmh use-package))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
