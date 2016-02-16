(setq emacs-lisp-dir "~/.emacs.d/"
      my-elmode-dir (concat emacs-lisp-dir "elmodes/"))
(setq load-path
      (append load-path (list my-elmode-dir)))

(add-to-list 'load-path "~/.emacs.d/lips/")

(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
(load-theme 'solarized t)

(windmove-default-keybindings)

(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)

(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

(load "std.el")
(load "std_comment.el")
(if (file-exists-p "~/.myemacs") 
    (load-file "~/.myemacs"))
