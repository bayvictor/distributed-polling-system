;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

(setq display-time-24hr-format t)

(setq-default tab-width 2)
;; Turn off use of tabs for indentation in many modes
(setq indent-tabs-mode nil)
;; LaTeX mode


(global-set-key [f1]  'replace-string)
(global-set-key [f2]  'goto-line)
(global-set-key [f3]  'set-mark-command)
(global-set-key [f4]  'buffer-menu-other-window)
(global-set-key [f5] 'other-window)
(global-set-key [f6] 'delete-other-windows)
(global-set-key [f7] 'delete-window)
(global-set-key [f8] 'split-window)
(global-set-key [f9] 'scroll-other-window)
(global-set-key [f10] 'compile)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end]  'end-of-line)
(global-set-key [(control ?])] 'flip-window)
(global-set-key [f11]  'tags-search)
(global-set-key [f12]  'flip-window)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

(global-set-key [(C-home)] 'beginning-of-buffer)
(global-set-key [(C-end)]  'end-of-buffer)
(global-set-key [(control home)] 'beginning-of-buffer)
(global-set-key [(control end)] 'end-of-buffer)

(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-end] 'end-of-buffer)



(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 2)))

;; Python Hook
(add-hook 'python-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))
(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 2)))


(custom-set-variables
 '(python-guess-indent nil)
 '(python-indent 2))

;;See also `M-x python-guess-indent'
