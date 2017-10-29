;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; creation-date: 28-10-2004
;; author: Felix Hernández del Olmo (http://www.ia.uned.es/~felixh/)
;; author: David Arroyo Menéndez (http://www.davidam.com)
;; cvs-id: $Id$
;; description: this file describe some probes to verify the correct 
;;              functionality of mam in clax
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


(load "/home/darroyo/dev/acl2cmucl/agents/boot.lisp")

;; Primero probemos que mam funciona con normalidad

(setq mymam (make-instance 'mam))
(setq mymessage (make-instance 'message :content "Hello World"))

(dotimes (i 10)
  (send-message mymessage mymam))

(process-message mymam)

