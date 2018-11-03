; 
; (defun prepend-path ( my-path )
; (setq load-path (cons (expand-file-name my-path) load-path)))
; 	  
; (defun append-path ( my-path )
; (setq load-path (append load-path (list (expand-file-name my-path)))))
; 
; ;; Look first in the directory ~/elisp for elisp files
; (prepend-path "~/.emacs.d/lisp")
; 
; ;; Load verilog mode only when needed
; (autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
; 
; ;; Any files that end in .v, .dv or .sv should be in verilog mode
; (add-to-list 'auto-mode-alist '("\\.[ds]?v\\'" . verilog-mode))
; 
; ;; Any files in verilog mode should have their keywords colorized
; (add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))

(add-hook 'verilog-mode-hook '(lambda ()
    (add-hook 'local-write-file-hooks (lambda()
       (untabify (point-min) (point-max))))))

; ;; Enable syntax highlighting of **all** languages
; (global-font-lock-mode t)

;; User customization for Verilog mode
(setq verilog-indent-level             2
      verilog-indent-level-module      2
      verilog-indent-level-declaration 2
      verilog-indent-level-behavioral  2
      verilog-indent-level-directive   1
      verilog-case-indent              2
      verilog-auto-newline             t
      verilog-auto-indent-on-newline   t
      verilog-tab-always-indent        t
      verilog-auto-endcomments         t
      verilog-minimum-comment-distance 40
      verilog-indent-begin-after-if    t
      verilog-auto-lineup              'declarations
      verilog-highlight-p1800-keywords nil
      verilog-linter                   "my_lint_shell_command"
      verilog-typedef-regexp	       "_t$" 
      )

(custom-set-variables
 '(verilog-align-ifelse t)
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-inst-param-value t)
 '(verilog-auto-inst-vector nil)
 '(verilog-auto-lineup (quote all))
 '(verilog-auto-newline nil)
 '(verilog-auto-save-policy nil)
 '(verilog-auto-template-warn-unused t)
 '(verilog-case-indent 2)
 '(verilog-cexp-indent 2)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-highlight-modules t)
 '(verilog-indent-level 2)
 '(verilog-indent-level-behavioral 2)
 '(verilog-indent-level-declaration 2)
 '(verilog-indent-level-module 2)
 '(verilog-tab-to-comment t))
