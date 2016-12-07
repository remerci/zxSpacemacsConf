
;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
  You should not put any user code in this function besides modifying the variable
  values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; (default nil)
   dotspacemacs-enable-lazy-installation nil
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     spacemacs-helm
     spacemacs-ivy
     auto-completion
     better-defaults
     emacs-lisp
     git
     markdown
     ;; (python :variables python-enable-yapf-format-on-save t)
     python
     ipython-notebook
     ;semantic
     gtags
     (c-c++ :variables c-c++-enable-clang-support t)
     org
     (spacemacs-layouts :variables layouts-enable-autosave t
                        layouts-autosave-delay 300)
     (shell :variables
            shell-default-position 'full
            shell-default-shell 'ansi-term
            shell-default-term-shell "/bin/zsh")
     ;(chinese :variables chinese-default-input-method 'wubi
      ;        chinese-enable-fcitx t)
              ;chinese-enable-youdao-dict t)
     ycmd
     racket
     ;; ----------------------------------------------------------------
     ;; zx private conf
     neworg
     zxcalendar
     ;; zilongshanren
     ;; ----------------------------------------------------------------
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages nil))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed.
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-dark
                         solarized-light
                         spacemacs-light
                         spacemacs-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("YaHei Consolas Hybrid";"Source Code Pro, WenQuanYi Micro Hei Mono";
                               :size 15
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; Default value is `cache'.
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f) is replaced.
   dotspacemacs-use-ido nil
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state nil
   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible value is `all',
   ;; `current' or `nil'. Default is `all'
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil
   configuration-layer-private-directory "~/.spacemacs.d/"
   comint-last-prompt-overlay nil
   )
  ;; User initialization goes here
  (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
  ;========== additional info search path ==========
  (setq Info-additional-directory-list '("/usr/share/info/"))
  ;========== frame maximized ==========
  ;; (add-hook 'after-init-hook '(lambda () (w32-send-sys-command #xf030)))
  ;; (when window-system (set-frame-size (selected-frame) 100 44))
  ;; (setq default-frame-alist '((width . 100) (height . 55)))
  ;; (setq initial-frame-alist '((top . 1) (left . 1) (width . 80) (height . 55)))
  ;; (toggle-frame-maximized)
  ;========== package archives list ==========
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  ;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
  ;; (add-to-list 'yas-snippet-dirs "/home/myth/MyBackup/confs/yasnippet-snippets-collection/")

  ;; yas current line
  ;; (defun yasnippet-current-line ();; C-c TAB
  ;;   (interactive)
  ;;   (let ((current-line (string-trim-right (thing-at-point 'line t))))
  ;;     (end-of-line)
  ;;     (newline-and-indent)
  ;;     (yas-expand-snippet (yasnippet-string-to-template (string-trim current-line)))))

  ;; (defun yasnippet-string-to-template (string)
  ;;   (let ((count 1))
  ;;     (labels ((rep (text)
  ;;                   (let ((replace (format "${%d:%s}" count text)))
  ;;                     (incf count)
  ;;                     replace)))
  ;;       (replace-regexp-in-string "[a-zA-Z0-9]+" #'rep string))))
  ;; (global-set-key (kbd "C-c TAB") 'yasnippet-current-line)
  )

(defun dotspacemacs/user-config ()
  "Configuration function.
 This function is called at the very end of Spacemacs initialization after
layers configuration."
  ;(spacemacs//set-monospaced-font   "Source Code Pro" "WenQuanYi Micro Hei Mono" 15 14)
  ;(spacemacs//set-monospaced-font   "YaHei Consolas Hybrid" "YaHei Consolas Hybrid" 16 16)
  (setq mouse-yank-at-point t);在光标位置而不是鼠标点击位置插入剪贴板内容。
  (mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。很好玩阿，这个功能
  (auto-image-file-mode t);打开图片显示功能
  (setq user-full-name "Zhao Xin");个人信息
  (setq user-mail-address "zhaoxin_remerci@gmail.com");个人信息
  (setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
  (setq sentence-end-double-space nil);设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空格。
  ;(setq face-font-rescale-alist '(("Source Code Pro" . 1.0) ("WenQuanYi Micro Hei" . 1.23)))
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (yapfify uuidgen py-isort org-projectile mwim hide-comnt evil-unimpaired dumb-jump column-enforce-mode racket-mode faceup ycmd request-deferred request anaconda-mode auto-complete avy packed smartparens yasnippet company projectile helm helm-core markdown-mode with-editor async hydra f s popup evil py-yapf ein python-mode smeargle orgit magit-gitflow magit helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-commit evil-magit youdao-dictionary xterm-color ws-butler wrap-region window-numbering which-key volatile-highlights visual-regexp-steroids vi-tilde-fringe use-package toc-org stickyfunc-enhance srefactor spacemacs-theme spaceline solarized-theme smooth-scrolling smex shell-pop restart-emacs rainbow-delimiters quelpa pyvenv python pytest pyenv-mode popwin pip-requirements persp-mode pcre2el paradox pangu-spacing page-break-lines org-repo-todo org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file nodejs-repl neotree multi-term move-text monokai-theme mmm-mode markdown-toc macrostep lorem-ipsum live-py-mode lispy linum-relative link-hint leuven-theme keyfreq info+ indent-guide impatient-mode ido-vertical-mode hy-mode hungry-delete hl-todo hl-anything highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-ls-git helm-gtags helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gh-md ggtags flx-ido find-file-in-project find-by-pinyin-dired fill-column-indicator fcitx fancy-battery expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-vimish-fold evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-jumper evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help elisp-slime-nav disaster define-word cython-mode ctags-update counsel company-ycmd company-statistics company-quickhelp company-c-headers company-anaconda cmake-font-lock clean-aindent-mode clang-format chinese-wbim buffer-move bracketed-paste beacon auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-pinyin ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
