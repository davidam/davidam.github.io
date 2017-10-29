;; define several class of keywords
(defvar mylsl-keywords
  '("break" "default" "do" "else" "for" "if" "return" "state" "while")
  "LSL keywords.")

(defvar mylsl-types
  '("float" "integer" "key" "list" "rotation" "string" "vector")
  "LSL types.")

(defvar mylsl-constants
  '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK")
  "LSL constants.")

(defvar mylsl-events
  '("at_rot_target" "at_target" "attach")
  "LSL events.")

(defvar mylsl-functions
  '("llAbs" "llAcos" "llAddToLandBanList" "llAddToLandPassList")
  "LSL functions.")

;; create the regex string for each class of keywords
(defvar mylsl-keywords-regexp (regexp-opt mylsl-keywords 'words))
(defvar mylsl-type-regexp (regexp-opt mylsl-types 'words))
(defvar mylsl-constant-regexp (regexp-opt mylsl-constants 'words))
(defvar mylsl-event-regexp (regexp-opt mylsl-events 'words))
(defvar mylsl-functions-regexp (regexp-opt mylsl-functions 'words))

;; clear memory
(setq mylsl-keywords nil)
(setq mylsl-types nil)
(setq mylsl-constants nil)
(setq mylsl-events nil)
(setq mylsl-functions nil)

;; create the list for font-lock.
;; each class of keyword is given a particular face
(setq mylsl-font-lock-keywords
  `(
    (,mylsl-type-regexp . font-lock-type-face)
    (,mylsl-constant-regexp . font-lock-constant-face)
    (,mylsl-event-regexp . font-lock-builtin-face)
    (,mylsl-functions-regexp . font-lock-function-name-face)
    (,mylsl-keywords-regexp . font-lock-keyword-face)
    ;; note: order above matters. “mylsl-keywords-regexp” goes last because
    ;; otherwise the keyword “state” in the function “state_entry”
    ;; would be highlighted.
))

;; define the mode
(define-derived-mode mylsl-mode fundamental-mode
  "lsl mode"
  "Major mode for editing LSL (Linden Scripting Language)…"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((mylsl-font-lock-keywords)))

  ;; clear memory
  (setq mylsl-keywords-regexp nil)
  (setq mylsl-types-regexp nil)
  (setq mylsl-constants-regexp nil)
  (setq mylsl-events-regexp nil)
  (setq mylsl-functions-regexp nil)
)

(provide 'mylsl-mode)
