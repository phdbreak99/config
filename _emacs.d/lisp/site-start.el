;; This is the global config file area for LINUX emacs.
;;

;;; VERILOG MODE
;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Add file extension here which is in verilog mode (.v is default)
(setq auto-mode-alist (append (list '("\\.sv\\'" . verilog-mode)
                    '("\\.svh\\'" . verilog-mode)
                    '("\\.vh\\'"  . verilog-mode)
                    '("\\.vb\\'"   . verilog-mode)
                    '("\\.vtb\\'"  . verilog-mode)
                    ) auto-mode-alist))
(add-hook 'verilog-mode-hook
      '(lambda ()
         (setq verilog-auto-endcomments nil
           verilog-auto-ignore-concat nil
           verilog-auto-output-ignore-regexp "^unused__"
           verilog-auto-delete-trailing-whitespace nil
           verilog-auto-inst-param-value t
           verilog-auto-reset-widths 'unbased
           verilog-auto-tieoff-declaration "assign" ;; SystemVerilog style
           verilog-case-fold nil
           verilog-typedef-regexp "_[sS]$"
           ;; Override users' .emacs settings
           indent-tabs-mode nil
           default-tab-width 4
           tab-width 4
           fill-column 80)
         ;; Any files in verilog mode should have their keywords colorized
         ;; (Really this is a user preference, but we'll leave it for compatibility.)
         (unless noninteractive (font-lock-mode 1))
         ))

;;;
;;; SPECMAN MODE
(autoload 'specman-mode "specman-mode" "Specman mode" t )
;; Any files that end in .e, .e3, et cetera should be in specman mode
(setq auto-mode-alist
   (append (list
       (cons "\\.e\\'" 'specman-mode)
       (cons "\\.e3\\'" 'specman-mode)
       (cons "\\.load\\'" 'specman-mode)
       (cons "\\.ecom\\'" 'specman-mode)
       (cons "\\.etst\\'" 'specman-mode))
      auto-mode-alist))
;; Any files in specman mode should have their keywords colorized
(add-hook 'specman-mode-hook '(lambda () (font-lock-mode 1)))

;;;
;;; TESTBUILDER
;; *.tw files are testbuilder wizard files that obey the c++ rules
(setq auto-mode-alist (append auto-mode-alist '(("\\.tw$" . c++-mode))))

;;;
;;; VC-SVN
;; This version of emacs needs to load a .el file to properly handle
;; SVN as a version control system.  But version 23 already has this,
;; and the version we keep in site-lisp is too old for Emacs 23.
(if (and (> emacs-major-version 20)
         (< emacs-major-version 23))
    (require 'vc-svn-200207))

;; load special vc-svn17 only when needed to support new svn WC format
;; if there are no issues with backward compatibility (with svn 1.6) 
;; this can be loaded unconditionally
(if (= emacs-major-version 23)
    (if (getenv "SUBVERSION_MODULE_PATH")
    (require 'vc-svn17)))

;;;
;;; CSR highlighting for yaml based .csr files
(autoload 'csr3-mode "csr3-mode" "Mode for editing site CSR files" t)
(autoload 'csr3-text-mode "csr3-mode" "Mode for highlighting site CSR text files" t)

;;;
;;; Color themes
(when (>= emacs-major-version 23)
  (autoload 'color-theme "color-theme" "Make the colors for emacs more pretty" t)
  (autoload 'color-theme-install "color-theme" "Make the colors for emacs more pretty" t)
  (autoload 'color-theme-initialize "color-theme" "Make the colors for emacs more pretty" t))

;;;
;;; Yaml mode
(when (>= emacs-major-version 23)
  (autoload 'yaml-mode "yaml-mode" "Mode for editing yaml files" t))

(defun yasnippet-enable ()
  "Enable verilog-mode yasnippet"
  (interactive)
  (autoload 'verilog-mode-map "verilog-mode" "Verilog mode" t )
  (when (>= emacs-major-version 23)
    (setq yas-verbosity 0))
  (require 'yasnippet)
  (setq yas/root-directory snippet-directory)
  (yas/load-directory yas/root-directory)
  ;; (setq yas/triggers-in-field t) ;; Most people find this more irritating than helpful.
  (add-hook 'find-file-hook 'sv-handler)
  (defun sv-handler ()
    (cond
     ((eval (string-match "\.sv$" (buffer-file-name)))
      (yas/minor-mode)))))

;;;
;;; MISC SETTINGS

;; Name multiple buffers intelligently
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Remove .log's from the Emacs default; want to complete them all the time
(delete ".log" completion-ignored-extensions)

;; Change next-line to not add CR's
(setq-default next-line-add-newlines nil)

;; Allow variables to be set (for .v file AUTOs)
(setq enable-local-eval t)

;; Don't ask about visiting tags tables
(setq tags-add-tables t)

;; Disable stupid warnings
(setq warning-suppress-types '((undo discard-info)))

;; Prevent errors caused by /nfs/.dir-locals.el
(defadvice dir-locals-find-file (after cavm-ignore-nfs-dir-local (file))
  "Ignore /nfs/.dir-locals.el which doesn't actually
exist, but always pops up giving errors."
  (if (and ad-return-value
       (string-match "^/[^/]+/.dir-locals.el" ad-return-value))  ; /nfs, /o70/ etc
      (setq ad-return-value nil)))
(ad-activate 'dir-locals-find-file)

;; Default is now too small, got this error:
;;      File ccu_tbl.vh is large (9MB), really open? (y or n) __END__
(setq large-file-warning-threshold (truncate 100e6))

;;;
;;; END

