;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; creation-date: 28-10-2004
;; author: Felix Hernández del Olmo (http://www.ia.uned.es/~felixh/)
;; author: David Arroyo Menéndez (http://www.davidam.com)
;; cvs-id: $Id$
;; description: this file describe some class required to use agents, queues 
;;              by now.
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



;;; QUEUES ;;;

(defclass lock-list nil
  ((elements :accessor elements-of :initform nil)
   (llock :accessor llock-of :initform (port:make-lock))))

(defclass queue (lock-list) ())

;;;; Operations on Queues

(defmethod empty-queue-p ((q queue))
  "Are there no elements in the queue?"
  (port:with-lock ((llock-of q)) 
		  (= (length (elements-of q)) 0)))

(defmethod not-empty-queue-p ((q queue))
  "Are there no elements in the queue?"
  (port:with-lock ((llock-of q)) 
		  (> (length (elements-of q)) 0)))


(defmethod queue-front ((q queue))
  "Return the element at the front of the queue."
  (port:with-lock ((llock-of q))
   (if (empty-queue-p q)
      nil
    (elt (elements-of q) 0))))

(defmethod remove-front ((q queue))
  "Remove the element from the front of the queue and return it."
  (port:with-lock ((llock-of q))
   (if (empty-queue-p q)
       nil
     (prog1
	 (first (elements-of q))
       (setf (elements-of q) (rest (elements-of q)))))))

(defmethod enqueue-at-end (l (q queue))
  "Add a list of items to the end of the queue."
  (port:with-lock ((llock-of q))
   (cond 
    ((null l) nil)
    ((and (atom l) (null (elements-of q))) (setf (elements-of q) (list l)))
    ((and (not (atom l)) (null (elements-of q)) (setf (elements-of q) l)))
    ((atom l) (nconc (elements-of q) (list l)))
    (t (nconc (elements-of q) l)))))

(defmethod print-queue ((q queue))
  "Print all queue elements"
  (port:with-lock ((llock-of q))
   (print (elements-of q))))

