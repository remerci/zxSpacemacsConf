;;; packages.el --- zxw3m Layer packages File for Spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq zxw3m-packages
      '(
        (w3m :location local)
        ;; helm-w3m
        ))

;; (defun zxw3m/init-helm-w3m ()
;;   "Initializes helm-w3m and adds keybindings for its exposed functionalities."
;;   (use-package helm-w3m
;;     :commands (helm-w3m-bookmarks)
;;     :init
;;     (progn
;;       (evil-leader/set-key
;;         "awb" 'helm-w3m-bookmarks))))

(defun v/w3m-open-site (site)
  "Opens site in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address (default: baidu.com):" nil nil "baidu.com" nil )))
  (w3m-goto-url
   (concat "http://" site)))

(defun zxw3m/init-w3m ()
  (use-package w3m
    :defer t
    :init
    (progn
      ;;启动和初始化w3m.el
      (autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
      (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
      (autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
      ;;使用工具包
      (setq w3m-use-toolbar t)
      ;;启用cookie
      (setq w3m-use-cookies t)
      ;;设定w3m运行的参数，分别为使用cookie和使用框架
      (setq w3m-command-arguments '("-cookie" "-F"))
      ;;用w3m浏览网页时也显示图片
      (setq w3m-display-inline-image t)
      ;; W3M Home Page
      (setq w3m-home-page "https://www.baidu.com")
      (setq-default w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.")

      ;;设定w3m的语言设置，以便方便使用和阅读中文
      ;;书签解码设置
                                        ;(setq w3m-bookmark-file-coding-system 'chinese-iso-8bit)
      ;;w3m的解码设置，后面最好都有，我也不详解了。
                                        ;(setq w3m-coding-system 'chinese-iso-8bit)
                                        ;(setq w3m-default-coding-system 'chinese-iso-8bit)
                                        ;(setq w3m-file-coding-system 'chinese-iso-8bit)
                                        ;(setq w3m-file-name-coding-system 'chinese-iso-8bit)
                                        ;(setq w3m-terminal-coding-system 'chinese-iso-8bit)
                                        ;(setq w3m-input-coding-system 'chinese-iso-8bit)
                                        ;(setq w3m-output-coding-system 'chinese-iso-8bit)

      ;;w3m是使用tab的，设定tab的宽度
      (setq w3m-tab-width 15)
      ;;设定w3m的主页，同mozilla firefox的默认主页一样。
                                        ;(setq w3m-home-page "http://www.google.com")
      ;;忘了。。。
                                        ;(setq w3m-view-this-url-new-session-in-background t)
                                        ;(add-hook 'w3m-fontify-after-hook 'remove-w3m-output-garbages)
      ;;好像是有利于中文搜索的。
                                        ;(defun remove-w3m-output-garbages ()
                                        ;  (interactive)
                                        ;  (let ((buffer-read-only))
                                        ;    (setf (point) (point-min))
                                        ;    (while (re-search-forward "[\200-\240]" nil t)
                                        ;      (replace-match " "))
                                        ;    (set-buffer-multibyte t))
      (eval-after-load "w3m-search"
        '(progn
           (add-to-list 'w3m-search-engine-alist
                        '("bing"
                          "http://cn.bing.com/search?q=%s"
                          nil))
           (add-to-list 'w3m-uri-replace-alist
                        '("\\`bi:" w3m-search-uri-replace "bing"))
           (add-to-list 'w3m-search-engine-alist
                        '("baidu"
                          "https://www.baidu.com/s?wd=%s"
                          nil))
           (add-to-list 'w3m-uri-replace-alist
                        '("\\`ba:" w3m-search-uri-replace "baidu"))
           (setq w3m-search-default-engine "bing")))

      (evil-leader/set-key
        "awo" 'v/w3m-open-site
        "awg" 'w3m-goto-url
        "awG" 'w3m-goto-url-new-session
        "aws" 'w3m-search
        "awS" 'w3m-search-new-session
        )                              ;  (set-buffer-modified-p nil))
      (with-eval-after-load 'w3m
        (define-key w3m-mode-map (kbd "C-f") 'evil-scroll-page-down)
        (define-key w3m-mode-map (kbd "C-b") 'evil-scroll-page-up)
        (define-key w3m-mode-map (kbd "SPC") 'evil-evilified-state))
      ))
  )

