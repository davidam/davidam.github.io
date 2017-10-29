;;; avanzado.lsp --- Ejercicios resueltos avanzados de  lisp

;; Copyright (C) 2005  David Arroyo Menéndez

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


;;EJERCICIO PRIMERO


(defun movilp (l)
  (cond ((not (and (= (length l) 3) (atom (first l)))) NIL)
	((or (null (movilp-aux (second l))) (null (movilp-aux (third l)))) NIL)
	((= (movilp-aux (second l)) (movilp-aux (third l))) (sumalista l))
	(t NIL)))
    
(defun movilp-aux (arg)
  (cond ((atom arg) arg)
	((not (and (= (length arg) 3) (atom (first arg)))) NIL)
	((or (null (movilp-aux (second arg))) (null (movilp-aux (third arg)))) NIL)
	((= (movilp-aux (second arg)) (movilp-aux (third arg))) (sumalista arg))
	(t NIL)))

;;La necesidad de tener dos funciones movilp y movilp-aux es que si en la primera llamada utilizáramos movilp-aux y metiéramos un número nos devolvería dicho número, lo cual es incorrecto. Pero para operaciones de suma y comprobación nos interesa que la llamada recursiva nos devuelva un número, si se encuentra dentro de la lista, claro.

(defun sumalista (l)
  (sumalista-aux l 0))

(defun sumalista-aux (l resultado)
  (cond ((endp l) resultado)
	((listp (first l)) (sumalista-aux (append (first l) (rest l)) resultado))
	(t (sumalista-aux (rest l) (+ resultado (first l))))))


;;Podemos comprobar que la movilp funciona con

(setf lista-ejemplo '(6 (4 (2 1 1) 4) (2 5 (1 2 2))))

(setf no-balanceado '(6 (4 (2 1 1) 4)))



;;EJERCICIO SEGUNDO

;; para hacer pruebas...

(setf tablero-ej (make-array '(4 4) :initial-contents '((1 1 0 1) (0 1 0 1) (0 0 0 0) (0 1 0 0))))
(setf tablero-peq (make-array '(3 3) :initial-contents '((1 0 1) (0 1 1) (1 0 0))))
(setf tablero-esr (make-array '(3 3) :initial-contents '((0 1 0) (0 0 1) (1 1 1))))

(setf tablero-otro (make-array '(6 6) :initial-contents '((1 1 0 1 1 0) (0 1 0 1 0 1) (0 0 0 1 1 0) (1 0 1 0 1 0) (0 1 0 1 0 1) (0 0 0 1 1 0))))

(defun vida (tablero max tam)
;; max es el número máximo de generaciones posibles y tam es el tamaño del tablero (supongo que habrá alguna primitiva para calcularlo pero la desconozco.
  (defvar *n* tam)
  (defvar *inicial* tablero)
  (defvar *max* max)
  (vida-aux (list (reglas tablero) tablero) 1))

(defun vida-aux (lista-tablero generacion) 
  (if (solucion lista-tablero generacion)
    nil
    (vida-aux (cons (reglas (first lista-tablero)) (list (first lista-tablero) (second lista-tablero))) (+ generacion 1))))
    
(defun solucion (lista-tablero gen)
  (or (eq (first lista-tablero) *inicial*) (eq (first lista-tablero) (first (last lista-tablero))) (= gen *max*))) 

(defun reglas (tablero)
  (let ((i 0) (j 0) (tablero-aux (make-array (list *n*  *n*) :initial-element '0))) 
    (dotimes (i *n*) 
      (dotimes (j *n*) 
	(if (= (aref tablero i j) 0)
	  (regla-uno i j tablero tablero-aux)
	  (progn (regla-dos i j tablero tablero-aux)
		 (regla-tres i j tablero tablero-aux)
		 (regla-cuatro i j tablero tablero-aux)))))
    (format t "~% ~%")
    (imprimir tablero-aux)
    (format t "~% ~%")
    (setf tablero tablero-aux)))


(defun regla-uno (i j tablero tablero-aux)
  (if (= 3 (vecinos i j tablero))
    (setf (aref tablero-aux i j) 1)))

(defun regla-dos (i j tablero tablero-aux)
  (if (or (= 0 (vecinos i j tablero)) (= 1 (vecinos i j tablero)))
    (setf (aref tablero-aux i j) 0)))

(defun regla-tres (i j tablero tablero-aux)
  (if (or (>= (vecinos i j tablero) 4))
    (setf (aref tablero-aux i j) 0)))

(defun regla-cuatro (i j tablero tablero-aux)
  (if (or (= 2 (vecinos i j tablero)) (= 3 (vecinos i j tablero)))
    (setf (aref tablero-aux i j) 1)))


(defun vecinos (i j tablero)
;;nos dice cuantos vecinos tiene la casilla i j de un tablero de nxn.
  (cond ((and (= i 0) (= j 0)) (+ 0 (aref tablero 0 1) (aref tablero 1 0) (aref tablero 1 1)))
	((and (= i 0) (= j (- *n* 1))) (+ 0 (aref tablero 0 (- *n* 2)) (aref tablero 1 (- *n* 2)) (aref tablero 1 (- *n* 1))))
	((and (= j 0) (= i (- *n* 1))) (+ 0 (aref tablero (- *n* 2) 0) (aref tablero (- *n* 2) 1) (aref tablero (- *n* 1) 1)))
	((and (= i (- *n* 1)) (= j (- *n* 1))) (+ 0 (aref tablero (- *n* 2) (- *n* 2)) (aref tablero (- *n* 2) (- *n* 1)) (aref tablero (- *n* 1) (- *n* 2))))
	 ((and (= i 0) (> j 0) (not (= j (- *n* 1)))) (+ 0 (aref tablero 0 (+ j 1)) (aref tablero 0 (- j 1)) (aref tablero 1 (+ j 1)) (aref tablero 1 j) (aref tablero 1 (- j 1))))
	 ((and (not (= i (- *n* 1))) (> i 0) (= j 0)) (+ 0 (aref tablero (+ i 1) 0) (aref tablero (- i 1) 0) (aref tablero (+ i 1) 1) (aref tablero i 1) (aref tablero (- i 1) 1)))
	((and (= i (- *n* 1)) (= j (- *n* 1))) (+ 0 (aref tablero (- *n* 2) (- *n* 2)) (aref tablero (- *n* 2) (- *n* 1)) (aref tablero (- *n* 1) (- *n* 2))))
	 ((and (= i (- *n* 1)) (not (= j (- *n* 1)))) (+ 0 (aref tablero (- *n* 1) (- j 1)) (aref tablero (- *n* 1) (+ j 1)) (aref tablero (- *n* 2) (- j 1)) (aref tablero (- *n* 1) (- j 1)) (aref tablero (- *n* 1) j) (aref tablero (- *n* 1) (+ j 1))))
	 ((and (not (= i (- *n* 1))) (= j (- *n* 1))) (+ 0 (aref tablero (- i 1) (- *n* 2)) (aref tablero (- i 1) (- *n* 1)) (aref tablero i (- *n* 2)) (aref tablero (+ i 1) (- *n* 2)) (aref tablero (+ i 1) (- *n* 1))))
	 ((or (> i (- *n* 1)) (> j (- *n* 1)))  (print '(ha introducido algun dato fuera de rango)))
         ((and (not (= i 0)) (not (= j 0)) (not (= i (- *n* 1))) (not (= j (- *n* 1)))) (+ 0 (aref tablero (- i 1) (- j 1)) (aref tablero (- i 1) j) (aref tablero (- i 1) (+ j 1)) (aref tablero i (- j 1)) (aref tablero i (+ j 1)) (aref tablero (+ i 1) (- j 1)) (aref tablero (+ i 1) j) (aref tablero (+ i 1) (+ j 1))))))



(defun imprimir (tablero)
  (let ((i 0) (j 0)) 
    (dotimes (i *n*) 
      (dotimes (j *n*)
	(format t "~a  " (aref tablero i j)))
      (format t "~% ~%"))))
        

;; (vida tablero-esr 10 3)

;; EJERCICIO TERCERO


(setf untablero '((0 1) (1 3) (2 0) (3 2))) ;;tablero para probar imprim-tablero

(defun imprime-tablero (list)
  (let ((a 0) (i 0) (j 0) (n (length list)))
    (format t " *-")
    (dotimes (a n) 
      (format t "--"))
    (format t "*")
    (format t "~%")
    (dotimes (i n)
      (format t " |")
      (dotimes (j n)
	(if (= j (second (elt list i)))
	  (format t " R")
	  (format t " .")))
      (format t " |~%"))
    (setf a 0)
    (format t " *-")
    (dotimes (a n) 
      (format t "--"))
    (format t "*")
    (format t "~%")))

(defun amenaza (i j a b)     ;; una reina en (i,j) y la otra en (a,b)
  (or (= i a)                ;; misma fila
      (= j b)                ;; misma columna
      (= (- i j) (- a b))    ;; si la diferencia entre columnas y filas
      (= (+ i j) (+ a b))))  ;; es 1, están en la misma diagonal.
    
(defun conflicto (n m tablero)
  (cond
    ((endp tablero) nil)
    ((amenaza n m (first (first tablero)) (second (first tablero))) t)
    (t (conflicto n m (rest tablero)))))

(defun reinas (tamano &optional (tablero nil) (n 0) (m 0))
  (unless (= m tamano)
    (unless (conflicto n m tablero)
      (if (= (+ 1 n) tamano)
	(imprime-tablero (reverse (cons (list n m) tablero)))
	(reinas tamano (cons (list n m) tablero) (+ 1 n) 0)))
    (reinas tamano tablero n (+ 1 m))))




