;; Copyright (C) 2013  David Arroyo Menéndez

;; Author: David Arroyo Menéndez <davidam@es.gnu.org>
;; Maintainer: David Arroyo Menéndez <davidam@es.gnu.org>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, 
;; Boston, MA 02110-1301 USA,


;; To collapse functions
(outline-minor-mode) ;; You can use it with: M-x hide-sublevels, M-x hide-others, M-x show-subtree, M-x hide-subtree, M-x show-all

(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.module$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.inc$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.info$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.test$" . php-mode) auto-mode-alist))

;; CSS and Rainbow modes 
(defun all-css-modes() (css-mode) (rainbow-mode))

;; Load both major and minor modes in one call based on file type 
(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes))

(define-skeleton drupal-info
  "A skeleton to .info"
  ""
  > "name = \"" (skeleton-read "Name of module: ") "\"" \n
  > "description = \"" (skeleton-read "Description: ") "\"" \n 
  > "package = \"" (skeleton-read "Package: ") "\"" \n 
  > "core = \"7.x\"")

(define-skeleton drupal-form-textfield
  "A skeleton to textfield form"
  ""
  > "$form['" (skeleton-read "Form name: ") "'] = array( " \n 
  > "'#type' => 'textfield', " \n
  > "'#title' => t('" (skeleton-read "Title: ") "'), " \n
  > "'#required' => " (skeleton-read "Required: TRUE | FALSE "), \n
  > "'#default_value' => \"" (skeleton-read "Default Value: ") "\"," \n
  > "'#description' => \"" (skeleton-read "Description: ") "\"," \n
  > "'#size' => 20, " \n
  > "'#maxlength' => 20, " \n 
  > ");" \n
)

(define-skeleton drupal-form-select 
  "A skeleton to select form"
  ""
  > "$form['" (skeleton-read "Form name: ") "'] = array( " \n 
  > "'#type' => 'select', " \n
  > "'#title' => t('" (skeleton-read "Title: ")  "'), " \n
  > "'#options' => drupal_map_assoc($arr), " \n
  > "'#description' => t('" (skeleton-read "Description: ") "'), " \n
  > "'#required' => TRUE, " \n
  > ");" \n
  )

(define-skeleton drupal-form-submit
  "A skeleton to submit form"
  ""
  > "$form['" (skeleton-read "Form name: ") "'] = array( " \n 
  > "'#type' => 'select', " \n
  > "'#title' => t('" (skeleton-read "Title: ")  "'), " \n
  > "'#options' => drupal_map_assoc($arr), " \n
  > "'#description' => t('" (skeleton-read "Description: ") "'), " \n
  > "'#required' => TRUE, " \n
  > ");" \n
  )

(define-skeleton drupal-form-item
  "A skeleton to item form"
  ""
  > "$form['" (skeleton-read "Form name: ") "'] = array( " \n
  > "'#type' => 'item', " \n
  > "'#title' => t('" (skeleton-read "Title: ") "'), " \n
  > ");" \n
)

(define-skeleton drupal-form-fieldset
  "A skeleton to fieldset form"
  ""
  > "$form['" (skeleton-read "Form name: ") "'] = array( " \n
  > "'#type' => 'fieldset', " \n
  > "'#title' => t('" (skeleton-read "Title: ") "'), " \n
  > "'#collapsible' => " (skeleton-read "Collapsible (TRUE | FALSE): ") "," \n
  > "'#collapsed' => " (skeleton-read "Collapsed (TRUE | FALSE): ") "," \n
  > ");" \n
)

(define-skeleton drupal-set-message-two-vars
  "A skeleton to drupal-set-message"
  ""
  > "drupal_set_message(t('The form @form has been submitted and the image has been saved, filename: @filename.', array('@form' => 'my form', '@filename' => $file->filename)))" \n
)


(define-skeleton drupal-l
  "Fill a drupal link function."
  ""
  '(setq text (skeleton-read "Text? ")) \n
  '(setq url (skeleton-read "Url? ")) \n
  '(setq class (skeleton-read "Class? ")) \n
  > "l(t('" text "'), '" url "', array('attributes' => array('class' =>
array('" class "'))))" \n)

