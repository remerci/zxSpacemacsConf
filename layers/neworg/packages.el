;;; packages.el --- neworg Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License GPLv3

(setq noteRootStr "e:/notes")
(setq gtdStr (concat noteRootStr "/org/GTD"))
(setq noteStr (concat noteRootStr "/org/notes"))

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq neworg-packages
    '(
      ;; package names go here
      (org :location built-in)
      ;; org-octopress
      ;; org-id
      ;; bbdb
      ;; bbdb-com
      ;; ox-html
      ;; ox-latex
      ;; ox-ascii
      ;; org-checklist
      ;; org-crypt
      ;; org-protocol
      ;; smex
      ;; org-mime
      ))

;; List of packages to exclude.
(setq neworg-excluded-packages '())

;; For each package, define a function neworg/init-<package-name>
;;
;; (defun neworg/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme
;; https://github.com/jwiegley/use-package

(defun neworg/init-org-octopress ()
  (use-package org-octopress
    :commands (org-octopress org-octopress-setup-publish-project)
    :init
    (progn
      (evilified-state-evilify org-octopress-summary-mode org-octopress-summary-mode-map)
      (add-hook 'org-octopress-summary-mode-hook
                #'(lambda () (local-set-key (kbd "q") 'bury-buffer)))
      (setq org-blog-dir (concat noteRootStr "/publish/github/octopress/source/"))
      (setq org-octopress-directory-top org-blog-dir)
      (setq org-octopress-directory-posts (concat org-blog-dir "_posts"))
      (setq org-octopress-directory-org-top org-blog-dir)
      (setq org-octopress-directory-org-posts (concat org-blog-dir "blog"))
      (setq org-octopress-setup-file (concat noteRootStr "/publish/github/setupfile.org"))

      )))

;;In order to export pdf to support Chinese, I should install Latex at here https://www.tug.org/mactex/
;; http:/ereizl.github.io/posts/2012-04-06-export-orgmode-file-in-Chinese.html
;;http://stackoverflow.com/questions/21005885/export-org-mode-code-block-and-result-with-different-styles
(defun neworg/post-init-org ()
  (with-eval-after-load 'org
    (progn
      ;; https://github.com/syl20bnr/spacemacs/issues/2994#issuecomment-139737911
      ;; (when (configuration-layer/package-usedp 'company)
      ;;   (spacemacs|add-company-hook org-mode))
      ;; (spacemacs|disable-company org-mode)

      (setq org-agenda-inhibit-startup t)   ;; ~50x speedup
      (setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
      (setq org-agenda-window-setup 'current-window)
      (setq org-log-done t)
      ;; (add-hook 'org-mode-hook )
      (define-key org-mode-map [(meta return)] 'org-meta-return)
      ;; ====================加密文章====================
      ;; "http://coldnew.github.io/blog/2013/07/13_5b094.html"
      ;; org-mode 設定
      (require 'org-crypt)

      ;; 當被加密的部份要存入硬碟時，自動加密回去
      (org-crypt-use-before-save-magic)

      ;; 設定要加密的 tag 標籤為 secret
      (setq org-crypt-tag-matcher "secret")

      ;; 避免 secret 這個 tag 被子項目繼承 造成重複加密
      ;; (但是子項目還是會被加密喔)
      (setq org-tags-exclude-from-inheritance (quote ("secret")))

      ;; 用於加密的 GPG 金鑰
      ;; 可以設定任何 ID 或是設成 nil 來使用對稱式加密 (symmetric encryption)
      (setq org-crypt-key nil)
      ;; --------------------加密文章--------------------

      (require 'ox-publish)
      (setq org-plantuml-jar-path
            (expand-file-name "~/.spacemacs.d/plantuml.jar"))
      (setq org-ditaa-jar-path "~/.spacemacs.d/ditaa.jar")

      ;; (require 'ox-md nil t)

      ;; (add-hook 'org-mode-hook 'smartparens-mode)
                                        ;====================
                                        ; capture, agenda, tag variables
                                        ;====================

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      `(("t" "todo" entry (file+headline ,(concat gtdStr "/Inbox.org") "Other")
               "* NEXT %?\n" :clock-resume t)
              ("r" "work RD" entry (file+headline ,(concat gtdStr "/Inbox.org") "RD")
               "* NEXT %?\n%U"
               :clock-resume t
               :empty-lines 1)
              ("j" "work jys" entry (file+headline ,(concat gtdStr "/Inbox.org") "Teach")
               "* NEXT %?\n%U" :clock-resume t)
              ("n" "note" entry (file+headline ,(concat gtdStr "/MythStudy.org") "QuickNotes")
               "* %f%? \n%i\n" :clock-resume t)
              ("l" "links" entry (file+headline ,(concat gtdStr "/MythStudy.org") "QuickNotes")
               "* %?\n%i\n%a\n%U" :clock-resume t)
              ("a" "account" table-line (file+headline ,(concat noteStr "/memo.org") "accounts")
               "| %? |  |  |" :clock-resume t)
              ("d" "Journal" entry (file+datetree ,(concat gtdStr "/diary.org"))
               "* %?" :clock-resume t)
              ("k" "quicknote" item (clock)
               "%i" :immediate-finish t)
              ("c" "New Task in Now Work" entry (clock)
               "* TODO %?\n%U"
               :clock-resume t
               :empty-lines 1)
              ;; ("h" "Habit" entry (file+headline (concat gtdStr /mythStudy.org") "periodical")
              ;;  "* TODO %?\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE habit\n:END:\n")
              ;; "* NEXT %?\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE habit\n:REPEAT_TO_STATE NEXT\n:END:\n")
              ;; ("H" "HouseWork" entry (file+headline (concat gtdStr /TODO.org") "house work")
              ;;  "* TODO %? :house\n%U\n" :clock-resume t)
              ;; ("x" "HeXuan" entry (file+headline (concat gtdStr /mythStudy.org") "zhx")
              ;;  "* TODO %? :zhx:\n%U\n" :clock-resume t)
              ;; ("q" "work qyk" entry (file+headline (concat gtdStr /TODO.org") "Work")
              ;;  "* TODO %? :qyk:\n%U" :clock-resume t)
              ;; ("z" "work zzy" entry (file+headline (concat gtdStr /TODO.org") "Work")
              ;;  "* TODO %? :zzy:\n%U" :clock-resume t)
              ;; "* NEXT %? :habit:\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1w/10d>>\")\n:PROPERTIES:\n:REPEAT_TO_STATE NEXT\n:END:\n"))))
              ))

(setq org-tag-persistent-alist '(("#myth" . ?m) ("#outWork" . ?o) ("#teach" . ?t) ("#rd" . ?r) ("#life" . ?l)
                                 ("%think" . ?k) ("%notes" . ?n)))

;; Custom agenda command definitions
(setq customStr "-STYLE=\"habit\"-SCHEDULED<>\"<now>\"-DEADLINE<>\"<now>\"")
(setq mythStr (concat customStr "-SOMEDAY-WAITING-TODO-REFILE"))
(setq org-agenda-custom-commands
      (quote (
              ;; ("n" "Notes" tags "notes"
              ;;  ((org-agenda-overriding-header "Notes")
              ;;   (org-tags-match-list-sublevels t)))
              ;; ("h" "Habits" tags-todo "STYLE=\"habit\""
              ;;  ((org-agenda-overriding-header "Habits")
              ;;   (org-agenda-sorting-strategy
              ;;    '(todo-state-down effort-up category-keep))))
              ;; ("r" "refile" tags-todo "REFILE")
              ("p" "项目安排"
               ((agenda "")
                (tags-todo (concat "REFILE" customStr))
                (tags-todo (concat "+#myth" mythStr "|+#life" mythStr)
                           ((org-agenda-sorting-strategy '(priority-down todo-state-down))))
                (tags-todo (concat "+#teach" mythStr "|+#rd" mythStr))
                (tags-todo (concat "+#outWork" mythStr))
                ;; (tags-todo "WAITING+WorkStudy | SOMEDAY+WorkStudy")
                (tags-todo "SOMEDAY-#myth-#life|WAITING|TODO-#myth-#life")
                ;; (tags-todo (concat "+qyk" pString))
                ;; (tags-todo (concat "+{jys\|zzy}" pString))
                ;; (tags-todo (concat "+zhx" pString "|+house" pString))
                ;; (tags-todo "+jys-SOMEDAY-WAITING-habit")
                ))
              ("w" "任务安排"
               (
                (tags-todo (concat "-#myth-#life-#teach-#rd-#outWork" mythStr))
                (tags-todo (concat "SOMEDAY-#teach-#rd-#outWork" customStr))
                (tags-todo (concat "TODO-#teach-#rd-#outWork" customStr))
                ))
              )))

                                        ;====================
                                        ; capture
                                        ;====================
(setq org-directory gtdStr)
(setq org-default-notes-file (concat gtdStr "/mythStudy.org"))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

                                        ;====================
                                        ; agenda
                                        ;====================
  (setq org-agenda-files (list gtdStr noteStr))

  (setq org-todo-keywords
        (quote (
                (sequence "DOING(i)" "NEXT(n)" "TODO(t)" "SOMEDAY(s@/!)" "WAITING(w@/!)" "|" "DONE(d)")
                (sequence "|" "CANCELLED(c@/!)")
                )))

  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("DOING" :foreground "cyan" :weight bold)
                ("NEXT" :foreground "yellow" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("SOMEDAY" :foreground "magenta" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold)
                ;; ("MEETING" :foreground "forest green" :weight bold)
                ;; ("PHONE" :foreground "forest green" :weight bold)
                )))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("NEXT") ("TODO") ("DOING") ("WAITING") ("SOMEDAY") ("CANCELLED" . t))
              ("WAITING" ("NEXT") ("TODO") ("DOING") ("CANCELLED") ("SOMEDAY") ("WAITING" . t))
              ("SOMEDAY" ("NEXT") ("TODO") ("DOING") ("WAITING") ("CANCELLED") ("SOMEDAY" . t))
              ("TODO" ("DOING") ("NEXT") ("WAITING") ("CANCELLED") ("SOMEDAY") ("TODO" . t))
              ("NEXT" ("DOING") ("TODO") ("WAITING") ("CANCELLED") ("SOMEDAY") ("NEXT" . t))
              ("DOING" ("NEXT") ("TODO") ("WAITING") ("CANCELLED") ("SOMEDAY") ("DOING" . t))
              ("DONE" ("NEXT") ("TODO") ("DOING") ("WAITING") ("CANCELLED") ("SOMEDAY")))))

                                        ;==================================================

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

(setq org-stuck-projects (quote ("+PROJECT+LEVEL<4/-DONE" ("TODO" "NEXT") nil "")))

;; only show today's agenda
(setq org-agenda-span 'week)
;; set show items in agenda with l(log) cmd
(setq org-agenda-log-mode-items '(closed clock))

                                        ;====================
                                        ; clock
                                        ;====================
      ;; used by org-clock-sum-today-by-tags
      (defun filter-by-tags ()
        (let ((head-tags (org-get-tags-at)))
          (member current-tag head-tags)))

      (defun org-clock-sum-today-by-tags (timerange &optional tstart tend noinsert)
        (interactive "P")
        (let* ((timerange-numeric-value (prefix-numeric-value timerange))
               (files (org-add-archive-files (org-agenda-files)))
               (include-tags '("myth" "zzy" "qyk" "jys" "MEETING"
                               "LIFE" "PROJECT" "OTHER"))
               (tags-time-alist (mapcar (lambda (tag) `(,tag . 0)) include-tags))
               (output-string "")
               (tstart (or tstart
                           (and timerange (equal timerange-numeric-value 4) (- (org-time-today) 86400))
                           (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "Start Date/Time"))
                           (org-time-today)))
               (tend (or tend
                         (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "End Date/Time"))
                         (+ tstart 86400)))
               h m file item prompt donesomething)
          (while (setq file (pop files))
            (setq org-agenda-buffer (if (file-exists-p file)
                                        (org-get-agenda-file-buffer file)
                                      (error "No such file %s" file)))
            (with-current-buffer org-agenda-buffer
              (dolist (current-tag include-tags)
                (org-clock-sum tstart tend 'filter-by-tags)
                (setcdr (assoc current-tag tags-time-alist)
                        (+ org-clock-file-total-minutes (cdr (assoc current-tag tags-time-alist)))))))
          (while (setq item (pop tags-time-alist))
            (unless (equal (cdr item) 0)
              (setq donesomething t)
              (setq h (/ (cdr item) 60)
                    m (- (cdr item) (* 60 h)))
              (setq output-string (concat output-string (format "[-%s-] %.2d:%.2d\n" (car item) h m)))))
          (unless donesomething
            (setq output-string (concat output-string "[-Nothing-] Done nothing!!!\n")))
          (unless noinsert
            (insert output-string))
          output-string))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-out-when-done t)

;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(eval-after-load 'org-clock
  '(progn
     (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
     (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))

                                        ;====================
                                        ; Report & Track
                                        ;====================
;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

; global Effort estimate values
; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                    ("STYLE_ALL" . "habit"))))

;; Agenda log mode items to display (closed and state changes by default)
(setq org-agenda-log-mode-items (quote (closed state)))

;; 为了计算各Tag的周时间统计
(org-babel-do-load-languages
 'org-babel-load-languages
 '((perl . t)
   (ruby . t)
   (sh . t)
   (dot . t)
   (js . t)
   (latex .t)
   (python . t)
   (emacs-lisp . t)
   (plantuml . t)
   (C . t)
   (ditaa . t)))


;; ========================= habit =========================
; Enable habit tracking (and a bunch of other modules)
(require 'org-install)
(add-to-list 'org-modules 'org-habit)

; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)
; (run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))
(run-at-time "07:40" 86400 '(lambda () (setq org-habit-show-habits nil)))
(run-at-time "20:00" 86400 '(lambda () (setq org-habit-show-habits t)))

                                        ;====================
                                        ; refile
                                        ;====================
; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
(setq org-refile-target-verify-function 'bh/verify-refile-target)

(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps nil)
;; (directory-files noteStr t "\\..*")
(setq org-refile-files (directory-files noteStr t ".org"))
(setq org-refile-targets (quote ((nil :maxlevel . 3) (org-agenda-files :maxlevel . 2) (org-refile-files :maxlevel . 3))))

                                        ;====================
                                        ; archive
                                        ;====================
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive:* Archived Tasks")
(defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    ;; Consider only tasks with done todo headings as archivable candidates
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
          (subtree-end (save-excursion (org-end-of-subtree t))))
      (if (member (org-get-todo-state) org-todo-keywords-1)
          (if (member (org-get-todo-state) org-done-keywords)
              (let* ((daynr (string-to-int (format-time-string "%d" (current-time))))
                     (a-month-ago (* 60 60 24 (+ daynr 1)))
                     (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                     (this-month (format-time-string "%Y-%m-" (current-time)))
                     (subtree-is-current (save-excursion
                                           (forward-line 1)
                                           (and (< (point) subtree-end)
                                                (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
                (if subtree-is-current
                    subtree-end ; Has a date in this month or last month, skip it
                  nil))  ; available to archive
            (or subtree-end (point-max)))
        next-headline))))

                                        ;====================
                                        ; publish
                                        ;====================

      ;; ==================== export latex chinese pdf ====================
      (add-to-list 'org-latex-classes '("ctexart" "\\documentclass[11pt]{ctexart}
                                        [NO-DEFAULT-PACKAGES]
                                        \\usepackage[utf8]{inputenc}
                                        \\usepackage[T1]{fontenc}
                                        \\usepackage{fixltx2e}
                                        \\usepackage{graphicx}
                                        \\usepackage{longtable}
                                        \\usepackage{float}
                                        \\usepackage{wrapfig}
                                        \\usepackage{rotating}
                                        \\usepackage[normalem]{ulem}
                                        \\usepackage{amsmath}
                                        \\usepackage{textcomp}
                                        \\usepackage{marvosym}
                                        \\usepackage{wasysym}
                                        \\usepackage{amssymb}
                                        \\usepackage{booktabs}
                                        \\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black]{hyperref}
                                        \\tolerance=1000
                                        \\usepackage{listings}
                                        \\usepackage{xcolor}
                                        \\lstset{
                                        %行号
                                        numbers=left,
                                        %背景框
                                        framexleftmargin=10mm,
                                        frame=none,
                                        %背景色
                                        %backgroundcolor=\\color[rgb]{1,1,0.76},
                                        backgroundcolor=\\color[RGB]{245,245,244},
                                        %样式
                                        keywordstyle=\\bf\\color{blue},
                                        identifierstyle=\\bf,
                                        numberstyle=\\color[RGB]{0,192,192},
                                        commentstyle=\\it\\color[RGB]{0,96,96},
                                        stringstyle=\\rmfamily\\slshape\\color[RGB]{128,0,0},
                                        %显示空格
                                        showstringspaces=false
                                        }
                                        "
                                        ("\\section{%s}" . "\\section*{%s}")
                                        ("\\subsection{%s}" . "\\subsection*{%s}")
                                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

      ;; {{ export org-mode in Chinese into PDF
      ;; @see http://reizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
      ;; and you need install texlive-xetex on different platforms
      ;; To install texlive-xetex:
      ;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux
      ;; }}
      (setq org-latex-default-class "ctexart")
      (setq org-latex-pdf-process
            '(
              "xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex -interaction nonstopmode -output-directory %o %f"
              "xelatex -interaction nonstopmode -output-directory %o %f"
              "rm -fr %b.out %b.log %b.tex auto"))

      (setq org-latex-listings t)
      ;; -------------------- export latex chinese pdf --------------------

      ;; ==================== export html ====================
      ;; copy from chinese layer
      (defadvice org-html-paragraph (before org-html-paragraph-advice
                                            (paragraph contents info) activate)
        "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
        (let* ((origin-contents (ad-get-arg 1))
               (fix-regexp "[[:multibyte]]")
               (fixed-contents
                (replace-regexp-in-string
                 (concat
                  "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
          (ad-set-arg 1 fixed-contents)))

      (defvar zilongshanren-website-html-preamble
        "<div class='nav'>
<ul>
<li><a href='http://remerci.github.io'>博客</a></li>
<li><a href='f:/notes/publish/org_notes/public_html/index.html'>Wiki目录</a></li>
</ul>
</div>")

      (defvar zilongshanren-website-html-blog-head
        " <link rel='stylesheet' href='f:/notes/publish/org_notes/public_html/Acss/worg.css' type='text/css'/> \n
    <link rel=\"stylesheet\" type=\"text/css\" href=\"f:/notes/publish/org_notes/public_html/Acss/autumn.css\"/> \n
    <link rel=\"stylesheet\" type=\"text/css\" href=\"f:/notes/publish/org_notes/public_html/Acss/prettify.css\"/>")

      (setq org-export-with-sub-superscripts '{})
      (setq org-publish-project-alist
            `(
              ("blog-notes"
               :base-directory noteStr
               :base-extension "org"
               :publishing-directory (concat noteRootStr "/publish/org_notes/public_html/")
               :preserve-breaks t
               :recursive t
               :html-head , zilongshanren-website-html-blog-head
               :publishing-function org-html-publish-to-html
               :headline-levels 4       ; Just the default for this project.
               :auto-preamble t
               :exclude "gtd.org"
               :exclude-tags ("ol" "noexport")
               :section-numbers t

               :sub-superscript {}
               :html-preamble ,zilongshanren-website-html-preamble
               :author "remerci"
               :email "zhaoxin.remerci@gmail.com"
               :auto-sitemap t          ; Generate sitemap.org automagically...
               :sitemap-filename "index.org" ; ... call it sitemap.org (it's the default)...
               :sitemap-title "我的wiki"     ; ... with title 'Sitemap'.
               :sitemap-sort-files anti-chronologically
               :sitemap-file-entry-format "%t" ; %d to output date, we don't need date here
               )
              ("blog-static"
               :base-directory noteStr
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
               :publishing-directory (concat noteRootStr "/publish/org_notes/public_html/")
               :recursive t
               :publishing-function org-publish-attachment
               )
              ("blog" :components ("blog-notes" "blog-static"))))
      ;; -------------------- export html --------------------

      ;; hack for org headline toc
      (defun org-html-headline (headline contents info)
        "Transcode a HEADLINE element from Org to HTML.
CONTENTS holds the contents of the headline.  INFO is a plist
holding contextual information."
        (unless (org-element-property :footnote-section-p headline)
          (let* ((numberedp (org-export-numbered-headline-p headline info))
                 (numbers (org-export-get-headline-number headline info))
                 (section-number (and numbers
                                      (mapconcat #'number-to-string numbers "-")))
                 (level (+ (org-export-get-relative-level headline info)
                           (1- (plist-get info :html-toplevel-hlevel))))
                 (todo (and (plist-get info :with-todo-keywords)
                            (let ((todo (org-element-property :todo-keyword headline)))
                              (and todo (org-export-data todo info)))))
                 (todo-type (and todo (org-element-property :todo-type headline)))
                 (priority (and (plist-get info :with-priority)
                                (org-element-property :priority headline)))
                 (text (org-export-data (org-element-property :title headline) info))
                 (tags (and (plist-get info :with-tags)
                            (org-export-get-tags headline info)))
                 (full-text (funcall (plist-get info :html-format-headline-function)
                                     todo todo-type priority text tags info))
                 (contents (or contents ""))
                 (ids (delq nil
                            (list (org-element-property :CUSTOM_ID headline)
                                  (org-export-get-reference headline info)
                                  (org-element-property :ID headline))))
                 (preferred-id (car ids))
                 (extra-ids
                  (mapconcat
                   (lambda (id)
                     (org-html--anchor
                      (if (org-uuidgen-p id) (concat "ID-" id) id)
                      nil nil info))
                   (cdr ids) "")))
            (if (org-export-low-level-p headline info)
                ;; This is a deep sub-tree export it as a list item.
                (let* ((type (if numberedp 'ordered 'unordered))
                       (itemized-body
                        (org-html-format-list-item
                         contents type nil info nil
                         (concat (org-html--anchor preferred-id nil nil info)
                                 extra-ids
                                 full-text))))
                  (concat (and (org-export-first-sibling-p headline info)
                               (org-html-begin-plain-list type))
                          itemized-body
                          (and (org-export-last-sibling-p headline info)
                               (org-html-end-plain-list type))))
              (let ((extra-class (org-element-property :HTML_CONTAINER_CLASS headline))
                    (first-content (car (org-element-contents headline))))
                ;; Standard headline.  Export it as a section.
                (format "<%s id=\"%s\" class=\"%s\">%s%s</%s>\n"
                        (org-html--container headline info)
                        (org-export-get-reference headline info)
                        (concat (format "outline-%d" level)
                                (and extra-class " ")
                                extra-class)
                        (format "\n<h%d id=\"%s\">%s%s</h%d>\n"
                                level
                                preferred-id
                                extra-ids
                                (concat
                                 (and numberedp
                                      (format
                                       "<span class=\"section-number-%d\">%s</span> "
                                       level
                                       (mapconcat #'number-to-string numbers ".")))
                                 full-text)
                                level)
                        ;; When there is no section, pretend there is an
                        ;; empty one to get the correct <div
                        ;; class="outline-...> which is needed by
                        ;; `org-info.js'.
                        (if (eq (org-element-type first-content) 'section) contents
                          (concat (org-html-section first-content "" info) contents))
                        (org-html--container headline info)))))))

      )))
