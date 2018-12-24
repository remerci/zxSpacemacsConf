(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))


;; (setq octopress-workdir (expand-file-name "/windata/notes/publish/github/octopress/"))

;; (defun zilongshanren/octopress-rake (command)
;;   "run rake commands"
;;   (let ((command-str (format "/bin/bash -l -c 'source $HOME/.rvm/scripts/rvm && rvm use ruby 2.0.0  && cd %s && rake %s'" octopress-workdir command)))
;;     (shell-command-to-string command-str)))

;; (defun zilongshanren/octopress-qrsync (command)
;;   (let ((command-str (format "/usr/local/bin/qrsync %s" command )))
;;     (shell-command-to-string command-str)))

;; (defun zilongshanren/octopress-generate ()
;;   "generate jekyll site"
;;   (interactive)
;;   (zilongshanren/octopress-rake "generate")
;;   (message "Generate site OK"))

;; (defun zilongshanren/octopress-deploy ()
;;   "default deploy task"
;;   (interactive)
;;   (zilongshanren/octopress-rake "deploy")
;;   (zilongshanren/octopress-qrsync "/Users/guanghui/4gamers.cn/guanghui.json")
;;   (message "Deploy site OK"))

;; (defun zilongshanren/octopress-gen-deploy ()
;;   "generate website and deploy"
;;   (interactive)
;;   (zilongshanren/octopress-rake "gen_deploy")
;;   (zilongshanren/octopress-qrsync "/Users/guanghui/4gamers.cn/guanghui.json")
;;   (message "Generate and Deploy OK"))

;; (defun zilongshanren/octopress-upimg ()
;;   (interactive)
;;   (zilongshanren/octopress-qrsync "/Users/guanghui/4gamers.cn/guanghui.json")
;;   (message "Up Img to Qiniu"))

;; (defun zilongshanren/org-save-and-export ()
;;   (interactive)
;;   (org-octopress-setup-publish-project)
;;   (org-publish-project "octopress" t))
