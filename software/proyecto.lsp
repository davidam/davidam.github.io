;--Proyecto de Programación en LISP


;; Funciones necesarias para crear la función corresponde a la que dado un patrón y un hecho devuelve una lista de asociación, en la que se instancia el patrón con el hecho, si este se ha correspondido.

(defun agrega-ligadura (expresion-variable-patron dato ligaduras)
  (if (eq '_ (extrae-variable expresion-variable-patron))
      ligaduras
    (cons (haz-ligaduras
	   (extrae-variable expresion-variable-patron)
	   dato)
	  ligaduras)))

(defun extrae-variable (expresion-variable-patron)
  (second expresion-variable-patron))

(defun extrae-llave (ligadura)
  (first ligadura))

(defun extrae-valor (ligadura)
  (second ligadura))

(defun haz-ligaduras (variable dato)
  (list variable dato))

(defun encuentra-ligadura (expresion-variable-patron ligadura)
  (unless (eq '_ (extrae-variable expresion-variable-patron))
    (assoc (extrae-variable expresion-variable-patron) ligadura)))

(defun corresponde-atomos (p d ligaduras)
  ;;verifica si P y D son iguales
  (if (eql p d)
      ;; En caso afirmativo, devuelve el valor de ligaduras
      ligaduras
    ;; En caso contrario, devuelve FALLA
    'falla))

(defun corresponde-variable (p d ligaduras)
  (let ((ligadura (encuentra-ligadura p ligaduras)))
  ;;verifica si se conoce la variable de patrón
    (if ligadura
	;;En caso afirmativo, sustituye su valor e intenta de nuevo
	(corresponde (extrae-valor ligadura) d ligaduras)
        ;;En caso contrario, agrega una nueva asociación
      (agrega-ligadura p d ligaduras))))

;;haz agrega-ligadura

(defun corresponde-partes (p d ligaduras)
  (let ((resultado (corresponde (first p) (first d) ligaduras)))
    ;; verifica si las primeras partes corresponden produciendo
    ;; nuevas ligaduras
    (if (eq 'falla resultado)
	'falla
      ;; En caso de que haya nuevas ligaduras intenta las partes restantes usando
      ;; las ligaduras resultantes
      (corresponde (rest p) (rest d) resultado))))

(defun corresponde (p d &optional ligaduras)
;; la variable debe estar en el primer argumento
  (cond ((and (atom p) (atom d))
	 (corresponde-atomos p d ligaduras))
	((and (listp p) (eq '? (first p)))
	 (corresponde-variable p d ligaduras))
	((and (listp p) (listp d))
	 (corresponde-partes p d ligaduras))
	(t 'falla)))

      
;;Funciones de flujo


(defun final-del-flujo-p (flujo) (eq flujo 'flujo-vacio))

(defun principio-del-flujo (flujo) (first flujo))

(defun resto-del-flujo (flujo) (second flujo))

(defun construye-flujo (objeto flujo) (list objeto flujo))

;; se podría haber construido nuestras funciones utilizando evaluación diferida con las funciones y macros comentados debajo de esta línea, pero para los objetivos de este ejercicio he considerado más sencillo no hacerlo.

;;(defun resto-del-flujo (flujo) (evalua (second flujo)))

;;(defmacro construye-flujo (objeto flujo)
;;  `(list ,objeto (encapsula ,flujo)))

;;(defmacro encapsula (forma)
;;  `#'(lambda () ,forma))

;;(defmacro evalua (procedimiento)
;;  `(funcall ,procedimiento))

(defun agrega-a-flujo (flujo1 flujo2)
  (if (final-del-flujo-p flujo1)
      flujo2
    (construye-flujo (principio-del-flujo flujo1)
		     (agrega-a-flujo (resto-del-flujo flujo1) flujo2))))

(defun concatena-flujo (flujos)
  (if (final-del-flujo-p flujos) 'flujo-vacio
    (if (final-del-flujo-p (principio-del-flujo flujos))
	(concatena-flujo (resto-del-flujo flujos))
      (construye-flujo (principio-del-flujo (principio-del-flujo flujos))
		       (concatena-flujo (construye-flujo (resto-del-flujo (principio-del-flujo flujos))
					(resto-del-flujo flujos)))))))

(defun transforma-flujo (procedimiento flujo)
  (if (final-del-flujo-p flujo) 
      'flujo-vacio
    (construye-flujo (funcall procedimiento (principio-del-flujo flujo))
		     (transforma-flujo procedimiento (resto-del-flujo flujo)))))

(defun miembro-de-flujo (objeto flujo)
  (cond ((final-del-flujo-p flujo) nil)
	((equal objeto (principio-del-flujo flujo)) t)
	(t (miembro-de-flujo objeto (resto-del-flujo flujo)))))

(defmacro recuerda-flujo (objeto variable)
  `(unless (miembro-de-flujo ,objeto ,variable)
    (setf ,variable 
	  (agrega-a-flujo ,variable 
			  (construye-flujo ,objeto 'flujo-vacio)))))

(defun recuerda-afirmacion (afirmacion)
  (recuerda-flujo afirmacion *afirmaciones*))

(defun recuerda-regla (regla)
  (recuerda-flujo regla *reglas*))

(defun nombre-de-la-regla (regla) (first regla))

(defun antecedentes-de-la-regla (regla) (butlast (rest regla)))

(defun consecuente-de-la-regla (regla) (first (last regla)))

(defun comparar (patron afirmacion ligaduras)
  (let ((resultado (corresponde patron afirmacion ligaduras)))
    (if (eq 'falla resultado)
	'flujo-vacio
      (construye-flujo resultado 'flujo-vacio))))

(defun comprobar-hechos (patron ligaduras)
  (concatena-flujo (transforma-flujo #' (lambda (afirmacion) (comparar patron afirmacion ligaduras))
*afirmaciones*)))

(defun filtrar-equiparaciones (patron flujo)
  (concatena-flujo 
   (transforma-flujo
    #'(lambda (ligaduras)
	(comprobar-hechos patron ligaduras))
	flujo)))


(defun aplica-filtros (patrones flujo-inicial-entrada)
  (if (endp patrones)
      flujo-inicial-entrada
    (aplica-filtros (rest patrones)
		    (filtrar-equiparaciones
		     (first patrones)
		     flujo-inicial-entrada))))

(defun reemplazar-variables (patron lista-a)
  (cond
   ((atom patron) patron)
   ((eq '? (first patron)) (extrae-valor (encuentra-ligadura patron lista-a)))
   (t (cons (reemplazar-variables (first patron) lista-a)
	    (reemplazar-variables (rest patron) lista-a)))))

(defun ejecutar-acciones (regla)
  (let ((flujo-ligaduras
	 (aplica-filtros (antecedentes-de-la-regla regla)
			 (construye-flujo nil 'flujo-vacio))))
    (do ((flujo-ligaduras flujo-ligaduras
			  (resto-del-flujo flujo-ligaduras))
	 (bandera-exito nil))
	((final-del-flujo-p flujo-ligaduras) bandera-exito)
	(let ((resultado (reemplazar-variables
			  (consecuente-de-la-regla regla)
			  (principio-del-flujo flujo-ligaduras))))
	  (when (recuerda-afirmacion resultado)
	    (format t "~%La regla ~a indica que ~a."
		    (nombre-de-la-regla regla) resultado)
	    (setf bandera-exito t))))))

(defun encadena-adelante ()
  (do ((flujo-de-reglas *reglas* (resto-del-flujo flujo-de-reglas))
       (bandera-repite nil))
      ((final-del-flujo-p flujo-de-reglas)
       (if bandera-repite
	   (progn
	     (format t "~%Estoy probando las reglas de nuevo.")
	     (encadena-adelante))
	 (progn
	   (format t "~%No he notado nada nuevo.")
	   'realizado)))
      (when (ejecutar-acciones (principio-del-flujo flujo-de-reglas))
	(setf bandera-repite t))))


;; ahora incluyo las afirmaciones y las reglas de la primera parte del ejercicio

(setf *afirmaciones* 'flujo-vacio)
(recuerda-afirmacion '(pablo es hijo de juan))
(recuerda-afirmacion '(pablo es marido de adela))
(recuerda-afirmacion '(jaime es hijo de pablo))
(recuerda-afirmacion '(pablo es hermano de javier))

(setf *reglas* 'flujo-vacio)
(recuerda-regla '(r1
		  ((? hijo) es hijo de (? padre))
		  ((? padre) es hijo de (? abuelo))
		  ((? hijo) es nieto de (? abuelo))))




    
;; BASE DE HECHOS INICIAL

(defstruct persona 
  (nombre nil :type symbol)
  (apellido nil :type symbol)
  (conyuge nil :type symbol)
  (padres nil :type list)
  (hijos nil :type list)
  (vivo T))

(setq ana (make-persona :nombre 'ana :apellido 'lopez
                       :conyuge 'juan :hijos '(elena eva)))
(setq juan (make-persona :nombre 'juan :apellido 'rodriguez
                       :conyuge 'ana :hijos '(elena eva)))
(setq elena (make-persona :nombre 'elena :apellido 'rodriguez :padres '(juan ana)
                       :conyuge 'jose :hijos '(jaime belen alba)))
(setq eva (make-persona :nombre 'eva :apellido 'rodriguez :padres '(juan ana)))
(setq jose (make-persona :nombre 'jose :apellido 'perez :conyuge 'elena 
                        :hijos '(jaime belen alba)))
(setq jaime (make-persona :nombre 'jaime :apellido 'perez :padres '(jose elena))) 
(setq belen (make-persona :nombre 'belen :apellido 'perez :padres '(jose elena))) 
(setq alba (make-persona :nombre 'alba :apellido 'perez :padres '(jose elena))) 

;; REGLAS Y FUNCIONES NECESARIAS PARA DETERMINAR CUÁLES SON LOS HEREDEROS DE UNA DETERMINADA PERSONA.

(defun imprime-persona (persona)
     (let ((nombre (persona-nombre persona))
            (apellido (persona-apellido persona)))
   (progn (format t "~&~&~4T~A  ~A" nombre apellido)
       (values))))

(defun obtener-padres (persona)
     (let ((nombre (persona-nombre persona))
            (apellido (persona-apellido persona))
            (padres (persona-padres persona)))
         (if padres 
            (progn (format t "~&Los padres de ~A ~A son: ~%" nombre apellido)
                (dolist (padre padres t)
                     (imprime-persona (eval padre))))
           (format t "~&No se han encontrado padres de ~A ~A: ~%" nombre apellido))))

(defun obtener-abuelos (persona)
   (let ((nombre (persona-nombre persona))
            (apellido (persona-apellido persona))
            (padres (persona-padres persona))
           (abuelos))
         (if padres 
            (if 
               (dolist (padre padres abuelos)
                    (setq abuelos (append (persona-padres (eval padre)) abuelos)))
               (progn (format t "~&Los abuelos de ~A ~A son: ~%" nombre apellido)
                (dolist (abuelo abuelos t)
                     (imprime-persona (eval abuelo))))       
               (format t  "~&No se han encontrado abuelos de ~A ~A: ~%" nombre apellido))
         (format t  "~&No se han encontrado padres de ~A ~A: ~%" nombre apellido))))

(defun obtener-tios (persona)
   (let ((nombre (persona-nombre persona))
            (apellido (persona-apellido persona))
            (padres (persona-padres persona))
           (abuelos)
          (tios))
         (if padres 
            (if 
               (dolist (padre padres abuelos)
                    (setq abuelos (append (persona-padres (eval padre)) abuelos)))
               (progn 
                (dolist (abuelo abuelos t)
                     (setq tios (append (persona-hijos (eval abuelo)) tios)))
                (if (setq tios (remove-duplicates
                                       (remove-if #'(lambda (posible &aux (lista-padres padres))
                                                             (member posible lista-padres)) tios)))
                   (progn 
                       (format t "~&Los tios de ~A ~A son: ~%" nombre apellido)
                       (dolist (tio tios t)
                            (imprime-persona (eval tio))))
                  (format t  "~&No se han encontrado tios de ~A ~A: ~%" nombre apellido)))
                (format t  "~&No se han encontrado abuelos de ~A ~A: ~%" nombre apellido))
             (format t  "~&No se han encontrado padres de ~A ~A: ~%" nombre apellido))))

(defun obtener-herederos (persona)
   (let* (herederos
           (conyuge (persona-conyuge persona))
           (padres (persona-padres persona))
           (hijos (persona-hijos persona))
           (conyuge-vivo (and conyuge (persona-estar-vivo (eval conyuge))))
           (hijos-vivos (remove-if-not #'(lambda (hijo)
                                                       (persona-estar-vivo (eval hijo)))
                                   hijos))
           (padres-vivos (remove-if-not #'(lambda (padre)
                                                       (persona-estar-vivo (eval padre)))
                                   padres)))
       (if conyuge-vivo (setq herederos (cons conyuge herederos)))
       (if hijos-vivos (setq herederos (append hijos-vivos herederos)))
       (unless (or conyuge-vivo hijos-vivos)
            (and hijos
                    (dolist (hijo hijos t)
                         (dolist (nieto (persona-hijos (eval hijo)) t)
                              (and (persona-estar-vivo (eval nieto))
                                      (setq herederos (cons nieto herederos)))))))
       (unless (and hijos-vivos conyuge-vivo padres-vivos)
            (and padres
                    (let (resultado)
                       (dolist (padre padres t)
                           (dolist (posible-heredero (obtener-herederos (eval padre)) t)
                             (unless (or (member posible-heredero resultado)
                                                  (eq (persona-nombre persona) posible-heredero))
                                  (setq resultado (cons posible-heredero resultado)))))
                            (setq herederos (append resultado herederos)))))
        herederos))
     
(defun matar (persona)
     (setf (persona-estar-vivo persona) nil))

(defun resucitar (persona)
     (setf (persona-estar-vivo persona) t))








