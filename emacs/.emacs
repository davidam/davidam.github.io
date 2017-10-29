;;(defun append-to-buffer (buffer start end)
;; Turn off menu bar (this bar has text)
;; (Use numeric argument to turn on)

(tool-bar-mode 0)
(menu-bar-mode 0)
(show-paren-mode)
(display-battery-mode)

;; DRUPAL

(load "~/public_html/emacs/drupal.el")  

;; ORG-MODE
	
;; (setq load-path (cons "~/git/org-mode/lisp" load-path))
;; (load "~/git/org-mode/lisp/ox-latex.el")
;; (load "~/git/worg/code/elisp/davidam.el")
;; (load "~/git/worg/code/elisp/org-license.el")
;; (load "~/git/worg/code/elisp/org-effectiveness.el")
;; (load "~/git/org-mode/contrib/lisp/org-learn.el")
;; (load "~/git/org-mode/contrib/lisp/org-drill.el")
;; (load "~/git/org-mode/lisp/ox-latex.el")

(setq user-full-name "David Arroyo Menéndez")
(setq user-mail-address "davidam@es.gnu.org")
(setq message-fcc-handler-function 'rmail-output)



;;; BBDB

(require 'bbdb)	       
	       
;; (load "~/git/bbdb-vcard/vcard.el")
;; (load "~/git/bbdb-vcard/bbdb-vcard.el")
(setq bbdb-file "~/.bbdb")
(setq bbdb-default-country "Spain")
(setq bbdb-north-american-phone-numbers nil)

(autoload 'bbdb         "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-name    "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-company "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-net     "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-notes   "bbdb-com" "Insidious Big Brother Database" t)
;;(bbdb-initialize 'rmail 'message 'sc) 
(autoload 'bbdb-insinuate-rmail    "bbdb-rmail" "Hook BBDB into RMAIL")
(setq rmail-mode-hook 'bbdb-insinuate-rmail)

;;(add-hook 'mail-mode 'bbdb-insinuate-rmail)
;;mail-citation-hook

;;;; PO-MODE ;;;;
(require 'po-mode)
(defun iacute()
  (interactive)
  (insert "@'{@dotless{i}}"))
;; El atajo C-i insertará i acentuada, a la manera nativa de texinfo
(define-key po-subedit-mode-map "\C-i" 'iacute)

;; Debe cortar las líneas automáticamente
(add-hook 'po-subedit-mode-hook 'auto-fill-mode)

;;;; ASPELL ;;;;
;; Para que avise
(setq ispell-program-name "aspell" ispell-extra-args '("--lang=es"))
(add-hook 'po-subedit-mode-hook
(lambda()
(flyspell-mode 1)))

;;;; Dictionary ;;;;
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
(setq dictionary-server "localhost")

;; ERC

(require 'erc)

(setq erc-autojoin-channels-alist
          '(("localhost" "&bitlbee")
	    ("freenode.net" "#emacs-es" "#org-mode" "#gimp-es" "#drupal-es" "#drupal.cat" "#hackcthulhu" "#lisp-es" "#emacs" "#mediawiki-es" "#wikimedia-es" "#hurd")))

(setq erc-user-full-name "David Arroyo Menéndez")
(setq erc-nick "davidam")
(setq erc-message-english-QUIT "%n (%u@%h) se fue: %r")
(setq erc-default-coding-system '(utf-8 . utf-8))
(setq erc-server-history-list '("irc.freenode.net" "irc.irc-hispano.org"
                                 "localhost"))
(setq erc-log-channels-directory "~/.erc/")
(setq erc-save-buffer-on-part t
      erc-save-queries-on-quit t
      erc-log-write-after-send t
      erc-log-write-after-insert t)

(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
  (save-some-buffers t (lambda () (when (eq major-mode 'erc-mode) t))))
(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-drill-optimal-factor-matrix nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "localhost")
 '(smtpmail-smtp-service 25))

;; Para que mi calendario sea mÃ¡s bello

(setq view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; Para que mi calendario este en mi idioma

(setq calendar-week-start-day 1
          calendar-day-name-array
          ["Domingo" "Lunes" "Martes" 
           "Miercoles" "Jueves" "Viernes" "Sábado"]
          calendar-month-name-array
          ["Enero" "Febrero" "Marzo" "Abril"
           "Mayo" "Junio" "Julio" "Agosto" "Septiembre"
           "Octubre" "Noviembre" "Diciembre"])

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit default :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
