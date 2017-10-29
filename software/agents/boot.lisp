;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; creation-date: 28-10-2004
;; author: Felix Hern�ndez del Olmo (http://www.ia.uned.es/~felixh/)
;; author: David Arroyo Men�ndez (http://www.davidam.com)
;; cvs-id: $Id$
;; description: this file let boot clax
;; copyright note:
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(in-package :cl-user)
(defvar *clocc-root* "/opt/clocc/port/extra/")
(compile-file (concatenate 'string *clocc-root* "clocc"))
(load *)
(load "/opt/clocc/port/ext.lisp")
(load "/opt/clocc/port/proc.lisp")

(defvar *agents-path* "/home/darroyo/dev/acl2cmucl/agents/")

(load (concatenate 'string *agents-path* "utilities"))
(load (concatenate 'string *agents-path* "mam"))
