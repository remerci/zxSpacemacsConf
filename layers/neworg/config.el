                                        ;====================
                                        ; keybinding & global conf
                                        ;====================
;; Custom Key Bindings
(global-set-key (kbd "<f9> a") 'org-agenda)
;; (global-set-key (kbd "<f9> I") 'bh/punch-in)
;; (global-set-key (kbd "<f9> O") 'bh/punch-out)
(global-set-key (kbd "<f9> i") 'org-clock-in)
(global-set-key (kbd "<f9> o") 'org-clock-out)
(global-set-key (kbd "<f9> g") 'org-clock-goto)
(global-set-key (kbd "<f9> SPC") 'org-clock-in-last)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> s") 'org-ido-switchb)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> l") 'org-toggle-link-display)
(global-set-key (kbd "<f9> t") 'org-toggle-inline-images)

;; global conf
;; (add-hook 'org-mode-hook 'smartparens-mode)

                                        ;====================
                                        ; capture, agenda, tag variables
                                        ;====================

(setq org-tag-persistent-alist '(("#pMyth" . ?m) ("#pJys" . ?j) ("#gWiz" . ?w) ("#gRIL" . ?r) ("#aNotes" . ?n)))

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (
              ("c" "New Task in Now Work" entry (clock)
               "* TODO %?\n%U" :clock-resume t)
              ("t" "todo" entry (file+headline "/windata/notes/org/GTD/Inbox.org" "Petty")
               "* NEXT %?\n%U\n" :clock-resume t)
              ("m" "work myth" entry (file+headline "/windata/notes/org/GTD/Inbox.org" "mythStudy")
               "* TODO %? \t:#pMyth:\n%U" :clock-resume t)
              ("w" "work jys" entry (file+headline "/windata/notes/org/GTD/Inbox.org" "workStudy")
               "* TODO %? \t:#pJys:\n%U" :clock-resume t)
              ("n" "note" entry (file+headline "/windata/notes/org/GTD/mythStudy.org" "QuickNotes")
               "* %f%? \n%i\n" :clock-resume t)
              ("l" "links" entry (file+headline "/windata/notes/org/GTD/mythStudy.org" "QuickNotes")
               "* %?\n%i\n%a\n%U" :clock-resume t)
              ("j" "Journal" entry (file+datetree "/windata/notes/org/GTD/diary.org")
               "* %?" :clock-resume t)
              ("a" "account" table-line (file+headline "/windata/notes/org/memo.org" "accounts")
               "| %? |  |  |" :clock-resume t)
              ;; ("h" "Habit" entry (file+headline "/windata/notes/org/GTD/mythStudy.org" "periodical")
              ;;  "* TODO %?\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:END:\n")
              ;; "* NEXT %?\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
              ;; ("H" "HouseWork" entry (file+headline "/windata/notes/org/GTD/TODO.org" "house work")
              ;;  "* TODO %? :house:\n%U\n" :clock-resume t)
              ;; ("x" "HeXuan" entry (file+headline "/windata/notes/org/GTD/mythStudy.org" "zhx")
              ;;  "* TODO %? :zhx:\n%U\n" :clock-resume t)
              ;; ("q" "work qyk" entry (file+headline "/windata/notes/org/GTD/TODO.org" "Work")
              ;;  "* TODO %? :qyk:\n%U" :clock-resume t)
              ;; ("z" "work zzy" entry (file+headline "/windata/notes/org/GTD/TODO.org" "Work")
              ;;  "* TODO %? :zzy:\n%U" :clock-resume t)
              )))
               ;; "* NEXT %? :habit:\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1w/10d>>\")\n:PROPERTIES:\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Custom agenda command definitions
(setq customStr "-STYLE=\"habit\"-SCHEDULED<>\"<now>\"-DEADLINE<>\"<now>\"")
(setq mythStr (concat customStr "-SOMEDAY-TODO-REFILE"))
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
                (tags-todo "REFILE")
                (tags-todo (concat "+#pMyth" mythStr)
                           ((org-agenda-sorting-strategy '(priority-down todo-state-down))))
                (tags-todo (concat "+#pJys" mythStr "|+#pZzy" mythStr "|+#pQyk" mythStr))
                (tags-todo "WAITING")
                ;; (tags-todo (concat "+qyk" pString))
                ;; (tags-todo (concat "+{jys\|zzy}" pString))
                ;; (tags-todo (concat "+zhx" pString "|+house" pString))
                ;; (tags-todo "+jys-SOMEDAY-WAITING-habit")
                ))
              ("w" "任务安排"
               (
                (tags-todo (concat "-#pMyth-#pQyk-#pZzy-#pJys-zhx-house" mythStr))
                (tags-todo (concat "SOMEDAY" customStr))
                (tags-todo (concat "TODO" customStr))
                ))
              )))

                                        ;====================
                                        ; capture
                                        ;====================
(setq org-directory "/windata/notes/org/GTD")
(setq org-default-notes-file "/windata/notes/org/GTD/mythStudy.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

                                        ;====================
                                        ; agenda
                                        ;====================
  (setq org-agenda-files (quote ("/windata/notes/org/GTD"
                                 "/windata/notes/org/notes"
                                 )))
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
(setq org-agenda-span 'day)
;; set show items in agenda with l(log) cmd
(setq org-agenda-log-mode-items '(closed clock))

  ;========== eval-after ==========

(with-eval-after-load 'org

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

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
                           (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "Start Date/Time:"))
                           (org-time-today)))
               (tend (or tend
                         (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "End Date/Time:"))
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
;; ;;
;; ;; Resume clocking task when emacs is restarted
;; (org-clock-persistence-insinuate)
;; ;;
;; ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
;; (setq org-clock-history-length 23)
;; ;; Resume clocking task on clock-in if the clock is open
;; (setq org-clock-in-resume t)
;; ;; Separate drawers for clocking and logs
;; (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; ;; Save clock data and state changes and notes in the LOGBOOK drawer
;; (setq org-clock-into-drawer t)
;; ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
;; (setq org-clock-out-remove-zero-time-clocks t)
;; ;; Clock out when moving task to a done state
;; (setq org-clock-out-when-done t)
;; ;; Save the running clock and all clock history when exiting Emacs, load it on startup
;; (setq org-clock-persist t)
;; ;; Do not prompt to resume an active clock
;; (setq org-clock-persist-query-resume nil)
;; ;; Enable auto clock resolution for finding open clocks
;; (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; ;; Include current clocking task in clock reports
;; (setq org-clock-report-include-clocking-task t)

;; (setq bh/keep-clock-running nil)

;; (defun bh/find-project-task ()
;;   "Move point to the parent (project) task if any"
;;   (save-restriction
;;     (widen)
;;     (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
;;       (while (org-up-heading-safe)
;;         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;           (setq parent-task (point))))
;;       (goto-char parent-task)
;;       parent-task)))

;; (defun bh/punch-in (arg)
;;   "Start continuous clocking and set the default task to the
;; selected task.  If no task is selected set the Organization task
;; as the default task."
;;   (interactive "p")
;;   (setq bh/keep-clock-running t)
;;   (if (equal major-mode 'org-agenda-mode)
;;       ;;
;;       ;; We're in the agenda
;;       ;;
;;       (let* ((marker (org-get-at-bol 'org-hd-marker))
;;              (tags (org-with-point-at marker (org-get-tags-at))))
;;         (if (and (eq arg 4) tags)
;;             (org-agenda-clock-in '(16))
;;           (bh/clock-in-organization-task-as-default)))
;;     ;;
;;     ;; We are not in the agenda
;;     ;;
;;     (save-restriction
;;       (widen)
;;       ; Find the tags on the current task
;;       (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
;;           (org-clock-in '(16))
;;         (bh/clock-in-organization-task-as-default)))))

;; (defun bh/punch-out ()
;;   (interactive)
;;   (setq bh/keep-clock-running nil)
;;   (when (org-clock-is-active)
;;     (org-clock-out))
;;   (org-agenda-remove-restriction-lock))

;; (defun bh/clock-in-default-task ()
;;   (save-excursion
;;     (org-with-point-at org-clock-default-task
;;       (org-clock-in))))

;; (defun bh/clock-in-parent-task ()
;;   "Move point to the parent (project) task if any and clock in"
;;   (let ((parent-task))
;;     (save-excursion
;;       (save-restriction
;;         (widen)
;;         (while (and (not parent-task) (org-up-heading-safe))
;;           (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;             (setq parent-task (point))))
;;         (if parent-task
;;             (org-with-point-at parent-task
;;               (org-clock-in))
;;           (when bh/keep-clock-running
;;             (bh/clock-in-default-task)))))))

;; (defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

;; (defun bh/clock-in-organization-task-as-default ()
;;   (interactive)
;;   (org-with-point-at (org-id-find bh/organization-task-id 'marker)
;;     (org-clock-in '(16))))

;; (defun bh/clock-out-maybe ()
;;   (when (and bh/keep-clock-running
;;              (not org-clock-clocking-in)
;;              (marker-buffer org-clock-default-task)
;;              (not org-clock-resolving-clocks-due-to-idleness))
;;     (bh/clock-in-parent-task)))

;; (add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

;;                                         ;==================================================

;; (require 'org-id)
;; (defun bh/clock-in-task-by-id (id)
;;   "Clock in a task by id"
;;   (org-with-point-at (org-id-find id 'marker)
;;     (org-clock-in nil)))

;; (defun bh/clock-in-last-task (arg)
;;   "Clock in the interrupted task if there is one
;; Skip the default task and get the next one.
;; A prefix arg forces clock in of the default task."
;;   (interactive "p")
;;   (let ((clock-in-to-task
;;          (cond
;;           ((eq arg 4) org-clock-default-task)
;;           ((and (org-clock-is-active)
;;                 (equal org-clock-default-task (cadr org-clock-history)))
;;            (caddr org-clock-history))
;;           ((org-clock-is-active) (cadr org-clock-history))
;;           ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
;;           (t (car org-clock-history)))))
;;     (widen)
;;     (org-with-point-at clock-in-to-task
;;       (org-clock-in nil))))


;;                                         ;==================================================

;; (setq org-time-stamp-rounding-minutes (quote (1 1)))

;; (setq org-agenda-clock-consistency-checks
;;       (quote (:max-duration "4:00"
;;                             :min-duration 0
;;                             :max-gap 0
;;                             :gap-ok-around ("4:00"))))

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
 'org-babel-load-languages '((emacs-lisp . t)))

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
                                        ; reminder
                                        ;====================

;; ; Erase all reminders and rebuilt reminders for today from the agenda
;;       (defun bh/org-agenda-to-appt ()
;;         (interactive)
;;         (setq appt-time-msg-list nil)
;;         (org-agenda-to-appt))

;; ; Rebuild the reminders everytime the agenda is displayed
;;       (add-hook 'org-finalize-agenda-hook 'bh/org-agenda-to-appt 'append)

;; ; This is at the end of my .emacs - so appointments are set up when Emacs starts
;;       (bh/org-agenda-to-appt)

;; ; Activate appointments so we get notifications
;;       (appt-activate t)

;; ; If we leave Emacs running overnight - reset the appointments one minute after midnight
;;       (run-at-time "24:01" nil 'bh/org-agenda-to-appt)

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
;; (setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5) (("/windata/notes/org/tool.org" "/windata/notes/org/env.org" "/windata/notes/org/dev.org" "/windata/notes/org/research.org" "/windata/notes/org/life.org" "/windata/notes/org/res.org" "/windata/notes/org/life.org") :maxlevel . 5))))
;(directory-files "/windata/notes/org/notes/" t "\\..*")
(setq org-refile-files (directory-files "/windata/notes/org/notes/" t ".org"))
(setq org-refile-targets (quote ((nil :maxlevel . 3) (org-agenda-files :maxlevel . 2) (org-refile-files :maxlevel . 3))))

                                        ;====================
                                        ; archive
                                        ;====================
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")
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
                                        ; GTD
                                        ;====================

                                        ;====================
                                        ; publish
                                        ;====================

;((setq org-publish-project-alist
;      '(
;        ("org-notes"
;         :base-directory "/windata/notes/org/" ;; Change this to your local dir
;         :base-extension "org"
;         :publishing-directory "/windata/notes/publish/org_notes/html/"
;         :recursive t
;         :publishing-function org-publish-org-to-html
;         :headline-levels 4             ; Just the default for this project.
;         :auto-preamble nil
;         ;:auto-sitemap t
;         ;:sitemap-filename "sitemap.org"
;         ;:sitemap-title "sitemap"
;         :section-numbers nil
;         :table-of-contents t
;         :author "ZHAO Xin"
;         :email "zhaoxin.remerci@gmail.com"
;         :style "<link rel='stylesheet' type='text/css' href='../res/org-manual.css' />"
;         :style-include-default nil
;         )
;
;        ;; These are static files (images, pdf, etc)
;        ("org-images"
;         :base-directory "/windata/notes/org/images/" ;; Change this to your local dir
;         :base-extension "png\\|jpg\\|gif\\|pdf"
;         :publishing-directory "/windata/notes/publish/org_notes/images/"
;         :recursive t
;         :publishing-function org-publish-attachment
;         )
;
;        ("org-other"
;         :base-directory "/windata/notes/org/other" ;; Change this to your local dir
;         :base-extension "mp3\\|ogg\\|swf\\|txt\\|asc"
;         :publishing-directory "/windata/notes/publish/org_notes/other/"
;         :recursive t
;         :publishing-function org-publish-attachment
;         )
;
;        ("org-res"
;         :base-directory "/windata/notes/org/res/" ;; Change this to your local dir
;         :base-extension "css\\|js"
;         :publishing-directory "/windata/notes/publish/org_notes/res/"
;         :recursive t
;         :publishing-function org-publish-attachment
;         )
;
;        ("org-web" :components ("org-notes" "org-images" "org-other" "org-res"))
;        ("slide"
;         :base-directory "/windata/notes/org/slides/"
;         :base-extension "org"
;         :publishing-directory "/windata/notes/publish/org_notes/slides/"
;         :publishing-function org-export-as-s5
;         )
;        ;;
;        ))setq org-tag-persistent-alist '(("钱叶魁" . ?q) ("张振友" . ?z) ("me" . ?m) ("教研室" . ?j) ("readKindle" . ?r)))

)
