;;; basicos.lisp --- Ejercicios resueltos basicos de lisp

;; Copyright (C) 2005  David Arroyo Menendez

;; Author: David Arroyo Menendez (http://www.davidam.com)
;; Maintainer: David Arroyo Menendez (http://www.davidam.com)
;; Keywords: extensions

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.


;; PRIMERO
;; Habría que obligar a que además la lista sea numérica

(defun H (lista)
   (if (endp lista)
       0
       (+ (* (first lista) (log (first lista)))
	  (H (rest lista))))) 

;; SEGUNDO


(defun ordena1 (a b c)
   (cond ((and (< a b) (< b c)) (list a b c))
	 ((and (< a c) (< c b)) (list a c b))
	 ((and (< b a) (< a c)) (list b a c))
	 ((and (< b c) (< c a)) (list b c a))
	 ((and (< c a) (< a b)) (list c a b))
	 ((and (< c b) (< b a)) (list a b c))))
       
(defun ordena2 (x y z)
  (setf lista (list (max x y z)))
  (case (max x y z)
	     ((= x) (cons (max y z) lista))
	     ((= y) (cons (max x z) lista))
	     ((= y) (cons (max x z) lista)))
  (cons (min x y z) lista))

;; TERCERO

;; primero enunciamos el ejercicio con 2 argumentos

(defun par(x)
  (if (= (mod x 2) 1)
      NIL
    T))

(defun par-min-dos (x y)
  (par (min x y)))

;; ahora para un número n de argumentos, con n>=1

(defun par-min-n (x &rest n)
  (par-min-n-aux x (rest n)))

(defun par-min-n-aux (x lista)
  (if (endp lista)
      (par x)
    (par-min-n-aux (min x (first lista)) (rest lista))))


;; CUARTO EJERCICIO

(defun concatena-listas (&rest listas-y-atomos)
  (if (atom (first listas-y-atomos))
      (concatena-listas-aux (list (first listas-y-atomos)) (rest listas-y-atomos))
    (concatena-listas-aux (first listas-y-atomos) (rest listas-y-atomos))))

(defun concatena-listas-aux (l lista-de-listas)
  (cond ((endp lista-de-listas)
	 l)
	((null (first lista-de-listas))
	 (concatena-listas-aux l (rest lista-de-listas)))
	((atom (first lista-de-listas))
	 (concatena-listas-aux (append l (list (first lista-de-listas))) (rest lista-de-listas)))
	(t
	 (concatena-listas-aux (append l (first lista-de-listas)) (rest lista-de-listas)))))
	
;; si no usamos rest...

(defun concatena (listadelistas)
  (cond ((endp listadelistas) nil)
	((atom (first listadelistas)) (append (list (first listadelistas)) (concatena (rest listadelistas))))
	(t (append (first listadelistas) (concatena (rest listadelistas))))))


;; QUINTO EJERCICIO

(defun sust2 (lista-asoc2 L2)
  (cond ((endp L2)    nil)
	((eq (assoc (first L2) lista-asoc2) nil) (append (list (first L2)) (sust2 lista-asoc2 (rest L2))))
	(t (append (rest (assoc (first L2) lista-asoc2)) (sust2 lista-asoc2 (rest L2))))))

;;(SUST2 `( (A B) (C D) (E F) (B K) (D L) )    `(A C E B D M))

(defun sust1 (lista-asoc1 L1)
   (cond ((endp L1)    nil)

;;si la lista L1 es vacía nos indica el fin de la recursión

	 ((eq (assoc (first L1) lista-asoc1) nil) (append (list (first L1)) (sust1 lista-asoc1 (rest L1))))

;;comprueba que el elemento a intercambiar no tiene correspondencia en la lista de asociación y lo incluye en la lista final sin modificarlo

	 ((assoc (first (rest (assoc (first L1) lista-asoc1))) lista-asoc1) (sust1 lista-asoc1 (append (rest (assoc (first (rest (assoc (first L1) lista-asoc1))) lista-asoc1)) (rest L1))))

;;comprueba que el elemento intercambiado vuelve a tener una correspondencia en la lista de asociación, por lo que llama de nuevo a la función con el elemento intercambiado, por si esto se repitiera más veces.

	 (t (append (rest (assoc (first L1) lista-asoc1)) (sust1 lista-asoc1 (rest L1))))))

;;en el resto de los casos intercambia de una manera normal

;; (SUST1 `( (A B) (C D) (E F) (B K) (D L) )    `(A C E B D M))


;; SEXTO EJERCICIO

(defun agrupar (uno dos)
  (cond ((atom uno) (agrupar-aux uno dos))
	((atom dos) (agrupar-aux dos uno))))

(defun agrupar-aux (atomo lista)
  (cond ((endp lista) atomo)
	((eq atomo (first lista)) (cons atomo lista))
	(t (cons (first lista) (agrupar-aux atomo (rest lista))))))

;; otra manera de hacer lo mismo tal vez más sencilla

(defun agrupar (lista atomo)
  (cond 
   ((endp lista) (list atomo))
;; si hemos llegado al final de la lista mete el atomo
   ((eq (first lista) atomo) (cons atomo lista))
;; si el atomo coincide con el elemento devuelve el resto de la lista con el atomo
   (t (append (list (first lista)) (agrupar (rest lista) atomo)))))
;; en cualquier otro caso sigue avanzando en la lista sin añadir nada

;; (AGRUPAR `(A A A B B B C C C) `B)
;; (AGRUPAR `(A A A B B B C C C) `D)



;; SÉPTIMO EJERCICIO

(defun aplanar (l)
  (aplanar-aux (aplana l)))

(defun aplana (lista)
  (cond ((null lista) NIL)
	((atom lista) (list lista))
	(t (append (aplana (first lista)) (aplana (rest lista))))))

(defun aplanar-aux (l)
  (if (endp l)
      NIL
    (append (list (min-lista l)) (aplanar-aux (delete (min-lista l) l)))))

(defun min-lista (l)
  (apply #'min l))



;; OCTAVO EJERCICIO

(defmacro mi-if (condicion accion &rest sino) ;Nombre y parametros 
  `(if ,condicion ,accion ,@sino))

;; NOVENO EJERCICIO

;;(do ((<parametro1> <valorinic1> <forma-actualiz1>)
;;     (<parametro2> <valorinic2> <forma-actualiz2>)
;;     ...
;;     (<parametron> <valorinicn> <forma-actualizn>))
;;    (<prueba-para-fin> <formas-intermedias>
;;		       <forma-resultado>))

;;(defmacro mi-do (

;;  (list 'when (list 'not x) (list 'or z nil)))
  
;; DÉCIMO EJERCICIO


(defun inicializa (matriz i j)
  (cond ((= i 10) (inicializa matriz 0 (+ j 1)))
	((= j 20) NIL)
	(t (progn (setf (aref matriz i j) (+ i j))
		  (inicializa matriz (+ i 1) j)))))

(defun imprime (matriz x)
  (if (= x 10) NIL
      (cons (aref matriz x (* x 2)) (imprime matriz (+ x 1)))))
    
(progn (setf matriz (make-array '(10 20)))
       (inicializa matriz 0 0)
       (imprime matriz 0))

