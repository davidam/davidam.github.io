;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; creation-date: 28-10-2004
;; author: Felix Hernández del Olmo (http://www.ia.uned.es/~felixh/)
;; author: David Arroyo Menéndez (http://davidam.no-ip.info)
;; cvs-id: $Id$
;; description: this file describe some probes to verify the correct 
;;              functionality of utilities in clax
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
(setq *clocc-root* "/opt/clocc/port/extra/")
(compile-file (concatenate 'string *clocc-root* "clocc"))
(load *)
(load "/opt/clocc/port/ext.lisp")
(load "/opt/clocc/port/proc.lisp")
(load "/home/darroyo/dev/acl2cmucl/agents/utilities.lisp")

;; Primero probamos que la cola funciona con normalidad

(setf myqueue (make-instance 'queue))
(empty-queue-p myqueue)
(queue-front myqueue)
(enqueue-at-end nil myqueue)
(enqueue-at-end '(2 3 4) myqueue)
(enqueue-at-end '(2 3 4) myqueue)
(enqueue-at-end nil myqueue)
(print-queue myqueue)
(queue-front myqueue)
(remove-front myqueue)

;; Ahora probamos que se respetan los bloqueos

(defun use-when-request (q)
  (loop 
   (port:process-wait "llega peticion" #'not-empty-queue-p q)
   (print (queue-front q))
   (remove-front q)))

(use-when-request myqueue)

(port:make-process "sleep in the background" #'enqueue-at-end 1 myqueue)

(dotimes (i 10)
  (port:make-process "sleep in the background" #'enqueue-at-end i myqueue))

(print-queue myqueue)

;; Desde varios procesos se intenta mandar un símbolo, por ejemplo 'a y otro lo recibe y lo imprime correctamente

