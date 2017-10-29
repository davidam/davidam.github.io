
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; creation-date: 28-10-2004
;; author: Felix Hernández del Olmo (http://www.ia.uned.es/~felixh/)
;; author: David Arroyo Menéndez (http://www.davidam.com)
;; cvs-id: $Id$
;; description: this file describe the class mam (minimal agente module) and 
;;              the class message and associated methods
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


(defclass message nil
  ((performative :accessor message-performative :initarg :performative)
   (sender :accessor message-sender :initarg :sender)
   (receiver :accessor message-receiver :initarg :receiver)
   (reply-to :accessor message-reply-to :initarg :reply-to)
   (content :accessor message-content :initarg :content)
   (language :accessor message-language :initarg :language)
   (encoding :accessor message-encoding :initarg :encoding)
   (ontology :accessor message-ontology :initarg :ontology)
   (protocol :accessor message-protocol :initarg :protocol)
   (conversation-id :accessor message-conversation-id :initarg :conversation-id)
   (reply-with :accessor message-reply-with :initarg :reply-with)
   (in-reply-to :accessor message-in-reply-to :initarg :in-reply-to)
   (reply-by :accessor message-reply-by :initarg :reply-by)))

(defclass mam nil 
  ((name :accessor name :initarg :name)
   (agent :accessor agent :initarg :agent)
   ;;privados
   (messages-queue :accessor messages-queue :initform (make-instance 'queue))
   (principal-process :accessor principal-process)
   (launched-processes :accessor launched-processes :initform (make-instance 'queue))
   (local-exit :accessor local-exit :initarg :salida-local) 
   (global-variable-process :accessor global-variable-process)
   (pack :accessor pack :initarg :pack)
   (parent-of-mam :accessor padre-de :initarg :control-padre) 
   (childrens-of-mam :accessor hijos-de :initform (make-instance 'queue))
   (permissions :accessor permissions :initarg permissions)
   (lock-permissions :accessor lock-permissions :initform (port:make-lock))
;;   (control-launcher :accessor control-launcher :initform *mi-control*)
))


(defmethod process-message ((control mam))
  "A process wait until to find some message in queue, then print it and remove it"
  (loop 
   (port:process-wait "I'm waiting until to find some message" #'not-empty-queue (messages-queue control))
   (print (message-content (queue-front control)))
   (remove-front control)))

(defun process-message (control)
  "A process wait until to find some message in queue, then print it and remove it"
  (loop 
   (port:process-wait "I'm waiting until to find some message" #'not-empty-queue (messages-queue control))
   (print (message-content (queue-front control)))
   (remove-front control)))

(defmethod process-message ((control mam))
  "A process wait until to find some message in messages queue, then print it and remove it"
  (loop 
   (port:process-wait "I'm waiting until to find some message" #'not (empty-queue-p (messages-queue control)))
   (print (message-content (queue-front (messages-queue control))))
   (remove-front (messages-queue control))))

(defmethod send-message ((m message) (control mam))
  "Send a message to a control"
  (port:make-process "I go to enqueue" #'enqueue-at-end m (messages-queue control)))


;; I need a method to create a process and run process-message