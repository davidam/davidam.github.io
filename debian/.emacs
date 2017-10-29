
;;; ---------------------------------
;;; --- CONFIGURACIONES GENERALES ---
;;; ---------------------------------


;;;---   Poner colorines   ----

(global-font-lock-mode)

;;;-------- Pagina de caracteres ---------

(set-language-environment "Latin-1")

;;;-------- Personalizando el ispell a castellano ----------

(setq ispell-dictionary '("castellano" "[A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[^A-ZÁÉÍÑÓÚÜa-záéíñóúü]" "[---]" nil
  ("-B" "-d" "castellano")
  "~tex" iso-8859-1))

;;;------- Establecer algunas teclas ------

(global-unset-key "\e\e")


;; --- esto es un skin mas verde para el emacs (en modo shell se ve peor)

;;(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
;; '(default ((t (:stipple nil :background "DarkSlateGray" :foreground "Wheat" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 112 :width normal :family "misc-fixed"))))
;; '(region ((((class color) (background dark)) (:background "DarkGoldenrod"))));;)



;;; ----------------------------------
;;; --- CONFIGURACIONES DESARROLLO ---
;;; ----------------------------------



;;;------ Para utilizar el openacs mode -----

;;;---(add-to-list 'load-path "/usr/share/emacs/site-lisp/oacs")
;;;---(require 'oacs)
;;;(require 'color-occur)

;;;---- En modo sgml no quiero que me auto-inserte ayudas en cada etiqueta ---

(setq sgml-auto-insert-required-elements nil)

;;;---- Quiero que me indente los datos ------

(setq sgml-indent-data t)

;;;---- Quiero ver los colorines -----

(setq sgml-set-face t)

;; --- Quiero meter las dtd en su catalog ----

;;(add-to-list 'sgml-catalog-files "/usr/share/sgml/ad/ad.cat")


;;;---- Reemplaza los caracteres especiales por su correspondiente entidad"---
 

(defun ma-repl-acute ()
 "Reemplaza los caracteres castellanos por sus entidades externas"
    (interactive)
      (let ((case-fold-search nil)
        (iso-charent-alist '(("¡" . "&iexcl;")  ("¿" . "&iquest;")
                             ("\301" . "&Aacute;") ("\341" . "&aacute;")
                             ("\311" . "&Eacute;") ("\351" . "&eacute;")
                             ("\315" . "&Iacute;") ("\355" . "&iacute;")
                             ("\321" . "&Ntilde;") ("\361" . "&ntilde;")
                             ("\323" . "&Oacute;") ("\363" . "&oacute;")
                             ("\332" . "&Uacute;") ("\372" . "&uacute;"))))
        (save-excursion (loop for pair in iso-charent-alist
            do (goto-char (point-min))
            (while (search-forward (car pair) nil t)
              (replace-match (cdr pair) t t))))))



;;--------- para que al hacer run-lisp vaya a Common Lisp -----------

(setq inferior-lisp-program "lisp")
;;(setq inferior-lisp-program "/home/darroyo/bin/acl62_trial/alisp")
(define-key global-map "\C-xl" 'run-lisp)

;; ;;------- para el theo ------------------------

;; (defun run-theo ()
;;   (interactive)
;;   (fi:common-lisp fi:common-lisp-buffer-name
;; 		  fi:common-lisp-directory
;; 		  fi:common-lisp-image-name ;" -H /usr/local/swfelix/theo" 
;; 		  '("-L /usr/local/swfelix/theo/aloadfile.lisp")
;; 		  fi:common-lisp-host))




;; ---- esto es para el prolog --------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(prolog-program-name "gprolog"))

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
