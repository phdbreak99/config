
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (verilog-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

;; Enable syntax highlighting of **all** languages
(global-font-lock-mode t)

;; User customization for Verilog mode
(setq verilog-indent-level           4
    verilog-indent-level-module      4
    verilog-indent-level-declaration 4
    verilog-indent-level-behavioral  4
    verilog-indent-level-directive   1
    verilog-case-indent              4
    verilog-auto-newline             t
    verilog-auto-indent-on-newline   t
    verilog-tab-always-indent        t
    verilog-auto-endcomments         t
    verilog-minimum-comment-distance 40
    verilog-indent-begin-after-if    t
    verilog-auto-lineup              'declarations
    verilog-linter                   "my_lint_shell_command"
    )
