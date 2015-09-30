;;Finally, my own configuration again
(setq inhibit-startup-screen t)
(setq message-log-max 2000)
(setq undo-outer-limit 42649259)
(setq solarized-broken-srgb t)
(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(global-set-key (kbd "C-x C-b") 'ibuffer)
    (autoload 'ibuffer "ibuffer" "List buffers." t)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(transient-mark-mode -1)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose t)
(setq-default truncate-lines t)
(setq ido-enable-tramp-completion nil)

;;load up ido first, need it pretty much always
(require 'ido)
(setq ido-everywhere t)
(setq ido-default-buffer-method 'selected-window)
(ido-mode 1)
(setq scroll-bar-mode -1)

;;we want a bar cursor
(setq-default cursor-type '(bar . 5))

;;setup some initial load paths
(add-to-list 'load-path "~/.emacs.d/vendor")

;;our package sources
(require 'package)
(setq package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/")
                               ("elpa" . "http://tromey.com/elpa/")
                               ("marmalade" . "http://marmalade-repo.org/packages/")
                               ("melpa-stable" . "http://stable.melpa.org/packages/")
			       ))
      unstable-package-archives '(("melpa" . "http://melpa.org/packages/")))

;; required because of a package.el bug
(setq url-http-attempt-keepalives nil)

(package-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;(require 'powerline)

(require 'smex)
(global-set-key (kbd "M-x") 'smex)

(global-set-key (kbd "C-z") 'eshell)

(require 'windmove)
(windmove-default-keybindings)

(require 'winner)
(winner-mode t)


(setq ns-pop-up-frames nil)

(setq ns-command-modifier 'meta)
(setq ns-function-modifier 'hyper)
(setq ns-right-alternate-modifier 'control)


;;term stuff
;; (defvar my-term-shell "/bin/zsh")
;; (defadvice ansi-term (before force-bash)
;;   (interactive (list my-term-shell)))
;; (ad-activate 'ansi-term)
;; (defun my-term-use-utf8 ()
;;   (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
;; (add-hook 'term-exec-hook 'my-term-use-utf8)
;; (defun my-term-paste (&optional string)
;;  (interactive)
;;  (process-send-string
;;   (get-buffer-process (current-buffer))
;;   (if string string (current-kill 0))))
;; (defun my-term-hook ()
;;   (goto-address-mode)
;;   (define-key term-raw-map "\C-y" 'my-term-paste))
;; (add-hook 'term-mode-hook 'my-term-hook)
;; (defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
;;   (if (memq (process-status proc) '(signal exit))
;;       (let ((buffer (process-buffer proc)))
;;         ad-do-it
;;         (kill-buffer buffer))
;;     ad-do-it))
;; (ad-activate 'term-sentinel)

;;_. Cmd-` on mac should switch frames even if cmd is mapped to meta
(global-set-key (kbd "M-`") 'other-frame)

(require 'dired+)
;;(put 'dired-find-alternate-file 'disabled nil)  ;enable `a' command

;;load newer cedet
;; (load-file "~/.emacs.d/cedet/cedet-devel-load.el")
;; (require 'cedet)
;; ;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;; ;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;; (highlight-parentheses-mode t)

;; ;; Enable Semantic
;; (semantic-mode 1)

(setq semantic-inhibit-functions
      (list (lambda () (not (file-remote-p (buffer-file-name))))))

(setq stack-trace-on-error nil)
(add-to-list 'load-path "~/.emacs.d/ecb")
(setq
 ecb-methods-nodes-expand-spec (quote all)
 ecb-methods-show-node-info (quote (if-too-long . name))
 ecb-options-version "2.40"
 ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2)
 ecb-source-file-regexps (quote ((".*" ("\\(^\\(\\.\\|#\\)\\|\\(~$\\|\\.\\(elc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\|pyc\\)$\\)\\)") ("^\\.\\(emacs\\|gnus\\)$"))))
 ecb-source-path (quote (("/Users/aaditya/work/meghdoot" "meghdoot") ("/Users/aaditya/work/epsilon" "epsilon-rp") ("/Users/aaditya/work/epsilon/vaitarna/vaitarna" "vaitarna-rp") ("/" "/")))
 ecb-tree-indent 2
 ecb-truncate-long-names nil
 ecb-vc-enable-support 'nil
 ecb-auto-expand-tag-tree nil
 ecb-auto-expand-tag-tree-collapse-other (quote always)
 )
;;(require 'ecb)

;; (add-to-list 'load-path "~/.emacs.d/vendor/emacs-for-python")
;; (add-to-list 'load-path "~/.emacs.d/vendor/traad/elisp")
;; ;;(require 'traad)
;; (require 'epy-init)
;; (epy-setup-checker "pyflakes %f")
;;(global-hl-line-mode t)

(require 'auto-complete)
(global-auto-complete-mode t)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
;;(autoload 'jedi:setup "jedi" nil t)
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
;;(require 'jedi-direx)
;;(eval-after-load "python"
;;  '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))


(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook (lambda () (local-set-key (kbd "C-c C-c") 'hs-toggle-hiding)))

(require 'hideshowvis)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")

(autoload 'hideshowvis-minor-mode
  "hideshowvis"
  "Will indicate regions foldable with hideshow in the fringe."
  'interactive)

(dolist (hook (list 'python-mode-hook))
  (add-hook hook 'hideshowvis-enable))

(hideshowvis-symbols)


(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(require 'mmm-mako)
(mmm-mode t)

(add-to-list 'auto-mode-alist '("\\.mako\\'" . html-mode))
(mmm-add-mode-ext-class 'html-mode "\\.mako\\'" 'mako)

;;allow max on OS X
(defun get-frame-max-lines ()
  (-
   (/
    (* (- (display-pixel-height) 20) (frame-height))
    (frame-pixel-height)) 2))

(defun get-frame-max-cols ()
  (-
   (/
    (* (display-pixel-width) (frame-width))
    (frame-pixel-width))
   0  ))

(defun maximize-frame ()
  (interactive)
  (set-frame-position (selected-frame) 0 20)
  (set-frame-size (selected-frame) (get-frame-max-cols) (get-frame-max-lines)))

(defun halve-frame-h ()
  (interactive)
  (set-frame-position (selected-frame) 0 20)
  (set-frame-size (selected-frame) (/ (frame-width) 2) (frame-height)))

(defun halve-frame-v ()
  (interactive)
  (set-frame-position (selected-frame) 0 20)
  (set-frame-size (selected-frame) (frame-width) (/ (frame-height) 2)))

(global-set-key (kbd "C-|") 'maximize-frame)
(global-set-key (kbd "C->") 'halve-frame-h)
(global-set-key (kbd "C-<") 'halve-frame-v)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq tramp-backup-directory-alist backup-directory-alist)

;;(require 'remote-e)

(setq tramp-completion-reread-directory-timeout 120)
;; We load tramp to define the variable.
(require 'tramp)
;;(update-tramp-emacs-server-ssh-port-forward) ;; from remote-e
;; We our workenv for bhp in one place
;;(add-to-list 'tramp-remote-path "/home/aaditya/.virtualenvs/bhp/bin")
(setq vc-ignore-dir-regexp
                (format "\\(%s\\)\\|\\(%s\\)"
                        vc-ignore-dir-regexp
                        tramp-file-name-regexp))
;;delete trailing whitespaces
(require 'whitespace)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;magit stuff
(require 'magit)

(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

(define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(global-set-key (kbd "C-x g") 'magit-status)

;;recentf
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)

(setq
 set-mark-command-repeat-pop t
 auto-save-directory-fallback "~/.saves"
 backup-directory-alist '(("." . "~/.saves")) ; don't litter my fs tree
 frame-title-format '((:eval (if (buffer-file-name)
                                 (abbreviate-file-name (buffer-file-name))
                               "%b")) " [%*] %@")
 size-indication-mode t
 mark-even-if-inactive t
)

;; (setq
;;  sql-product 'postgres
;;  sql-input-ring-file-name "~/.psql_history"
;;  sql-password "meghd00t"
;;  sql-pop-to-buffer-after-send-region t
;;  sql-user "meghdoot"
;; )

(transient-mark-mode 0)
(delete-selection-mode 0)

(setq vc-handled-backends 'nil)
(global-reveal-mode t)

(setq visible-bell t)

(require 'visible-mark)
(visible-mark-mode t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq-default indent-tabs-mode nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.6)
 '(ac-auto-start 3)
 '(ac-delay 0.9)
 '(ac-quick-help-delay 0.2)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#002b36" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(ansi-term-color-vector
   [unspecific "#586e75" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#002b36"] t)
 '(background-color "#ffffff")
 '(background-mode light)
 '(cursor-color "#ffff00")
 '(custom-enabled-themes (quote (ample)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "08efabe5a8f3827508634a3ceed33fa06b9daeef9c70a24218b70494acdf7855" "8d6fb24169d94df45422617a1dfabf15ca42a97d594d28b3584dc6db711e0e0b" "49eea2857afb24808915643b1b5bd093eefb35424c758f502e98a03d0d3df4b1" "d24e10524bb50385f7631400950ba488fa45560afcadd21e6e03c2f5d0fad194" "5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" "fca8ce385e5424064320d2790297f735ecfde494674193b061b9ac371526d059" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "71efabb175ea1cf5c9768f10dad62bb2606f41d110152f4ace675325d28df8bd" "3f1540a9b55ba2db89ff9247e69c4aa533651bbef165fb80ef7c1ee2f1b3f4f7" "723d8e038750a51aa9d6f1000a6f5047f343a10291a07dfb30c8f35fa9bfe8ec" "9d0abcc1835bfb11ba0700f4a40378bab559523ad17cfa0765fde7b810a762bb" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(debug-on-quit nil)
 '(display-time-mode t)
 '(ecb-layout-name "left9")
 '(ecb-layout-window-sizes
   (quote
    (("left9"
      (ecb-methods-buffer-name 0.0856353591160221 . 0.9891304347826086)))))
 '(ecb-options-version "2.40" t)
 '(eshell-cmpl-autolist t)
 '(eshell-cmpl-ignore-case t)
 '(eshell-modules-list
   (quote
    (eshell-alias eshell-banner eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-rebind eshell-script eshell-smart eshell-term eshell-unix eshell-xtra)))
 '(eshell-scroll-to-bottom-on-input nil)
 '(eshell-scroll-to-bottom-on-output (quote all))
 '(eshell-visual-commands
   (quote
    ("vi" "screen" "top" "less" "more" "lynx" "ncftp" "pine" "tin" "trn" "elm" "vim" "tmux" "eshell.py" "eshell-test.py" "ipython")))
 '(fci-rule-character-color "#d9d9d9")
 '(fci-rule-color "#073642")
 '(flymake-gui-warnings-enabled nil)
 '(flymake-log-level 0)
 '(flymake-no-changes-timeout 0.5)
 '(flymake-start-syntax-check-on-find-file t)
 '(flymake-start-syntax-check-on-newline nil)
 '(font-use-system-font t)
 '(foreground-color "#ffff00")
 '(global-semanticdb-minor-mode t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(js2-cleanup-whitespace t)
 '(js2-highlight-level 3)
 '(js2-mirror-mode t)
 '(mac-command-modifier (quote meta))
 '(mac-option-modifier (quote meta))
 '(mmm-submode-decoration-level 1)
 '(pytest-global-name "py.test")
 '(python-indent-offset 4)
 '(rcirc-default-nick "aadis")
 '(safe-local-variable-values
   (quote
    ((virtualenv-default-directory . "~/work/epsilon")
     (virtualenv-workon . "bhp"))))
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(solarized-contrast (quote high))
 '(solarized-termcolors 256)
 '(sql-electric-stuff (quote semicolon))
 '(tabbar-mode nil nil (tabbar))
 '(tabbar-separator (quote (" ‡ ")))
 '(tool-bar-mode nil)
 '(tramp-auto-save-directory "~/.emacs.d/auto-save-list")
 '(tramp-default-method "scp")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
 ;;'(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Lekton"))))
 ;; '(error ((t (:inherit default :foreground "White" :underline (:color "#cb4b16" :style wave) :weight bold))))
 ;; '(flymake-errline ((t (:inherit default :background "#002b36" :underline (:color "FireBrick" :style wave) :weight bold))))
 ;; '(flymake-infoline ((t (:background "#002b36" :foreground "White" :underline (:color "#546E00" :style wave)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Menlo" :foundry "bitstream" :slant normal :weight normal :height 98 :width normal))))
 '(cursor ((t (:background "#F92672" :foreground "#F92672"))))
 '(diredp-exec-priv ((t nil)))
 '(diredp-file-name ((t nil)))
 '(diredp-flag-mark ((t nil)))
 '(diredp-no-priv ((t nil)))
 '(diredp-read-priv ((t nil)))
 '(diredp-write-priv ((t nil)))
 '(ecb-default-highlight-face ((t (:background "secondarySelectedControlColor" :weight bold))) t)
 '(error ((t (:inherit default :foreground "Black" :underline (:color "#cb4b16" :style wave) :weight bold))))
 '(flymake-errline ((t (:inherit default :background "LightPink" :underline (:color "FireBrick" :style wave) :weight bold))) t)
 '(flymake-infoline ((t (:underline (:color "#546E00" :style wave)))) t)
 '(flymake-warnline ((t (:background "LightBlue2" :underline (:color foreground-color :style wave)))) t)
 '(header-line ((t (:inherit mode-line :background "thistle3" :foreground "#fff" :inverse-video nil :box nil :underline "#999999" :slant normal :weight bold :height 1.0))))
 '(hl-line ((t (:background "gray50" :inverse-video nil))) t)
 '(hl-paren-face ((t (:weight bold))) t)
 '(mmm-default-submode-face ((t (:inherit default))))
 '(my-html-face ((t (:inherit default :background "gray92"))) t)
 '(semantic-decoration-on-unknown-includes ((t nil)) t)
 '(semantic-tag-boundary-face ((t (:box nil :overline "gray80"))) t)
 '(senator-momentary-highlight-face ((t (:background "gray70"))) t)
 '(tabbar-button ((t (:inherit tabbar-default :box nil))))
 '(tabbar-default ((t (:background "gray75" :foreground "gray25" :underline nil :weight normal :height 1.0 :family "Lucida Grande"))))
 '(tabbar-selected ((t (:inherit tabbar-default :foreground "dodger blue" :box nil :underline "slate blue"))))
 '(tabbar-separator ((t (:inherit tabbar-default :height 120))))
 '(tabbar-unselected ((t (:inherit tabbar-default :box nil))))
 '(variable-pitch ((t (:height 130 :family "Cambria"))))
 '(visible-mark-face ((t (:inverse-video t :underline "yellow"))) t))

(setq debug-on-quit nil)
(server-start)

;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;org-mode configuration
;; Enable org-mode
(require 'org)
;; Make org-mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-hide-leading-stars t)
;; The above is the default in recent emacsen

(dolist (hook '(text-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
    (dolist (hook '(change-log-mode-hook log-edit-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))

(put 'erase-buffer 'disabled nil)

(add-to-list 'load-path "/path/to/auto-package-update")
(require 'auto-package-update)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
;;(require 'smooth-scroll)
;;(smooth-scroll-mode 0)

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(2 ((shift) . 2))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 2) ;; keyboard scroll one line at a time

(setq inhibit-splash-screen nil)

;;cider stuff
(require 'cider)
(setq cider-repl-pop-to-buffer-on-connect t)
(add-hook 'cider-mode-hook #'eldoc-mode)

(load-file "~/.emacs.d/cypher-mode.el")
(require 'cypher-mode)

(require 'golden-ratio)
(golden-ratio-mode 1)

(put 'downcase-region 'disabled nil)
(display-time-mode 1)
(setq tab-width 2)
(scroll-bar-mode -1)
(require 'dired-k)
(define-key dired-mode-map (kbd "K") 'dired-k)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-file "~/.emacs.d/cider-history")

(global-company-mode)

(setq company-idle-delay nil)
(global-set-key (kbd "M-TAB") #'company-complete)


(defun org-convert-csv-table (beg end)
  (interactive (list (mark) (point)))
  (org-table-convert-region beg end ",")
  )

(add-hook 'org-mode-hook
      (lambda ()
    (define-key org-mode-map (kbd "<f6>") 'org-convert-csv-table)))
