
;; quito la barra de navegacion
(tool-bar-mode nil)

;; para poder usar el scroll del raton en modo grafico
(mwheel-install)

;; navegador por defecto
(setq browse-url-default-browser 'lynx)

;; colorines
(global-font-lock-mode)

;; metemos auto-fill en modo text
(setq text-mode-hook (cons 'auto-fill-mode text-mode-hook))

;;; activo las abreviaturas
(setq abbrev-mode 't)

;;; relativo a la codificación de caracteres
;(setq current-language-environment "Latin-1")
;(setq default-input-method "latin-1-prefix")

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "Spanish")



;; para publicar de manera remota

(defun remote-publish (orig dest)
  "Use rsync to transfer published files to a remote destination."
  (interactive "Morigen: \nMdestino: ")
  (start-process
   "remote-publish" "*remote-publish*" "rsync" "--archive" "--delete"
   "--rsh=ssh"
   (file-name-as-directory
    (expand-file-name orig))
   dest))


(defun localhost2wainu ()
  (interactive)
  (message "Sincronizo mi emacs en wainu")
  (start-process
   "syncronizing..." "*syncronizing*" "rsync" "--archive" "--delete" "--rsh=ssh" "--recursive" "--verbose" "--exclude=*~" (expand-file-name "~/emacs") (expand-file-name "~/mail") "lendir@wainu.ii.uned.es:"))

(add-hook 'kill-emacs-query-functions 'localhost2wainu)

;; rsync --archive --delete --rsh=ssh --recursive --verbose --exclude *~ lendir@wainu.ii.uned.es:emacs $HOME