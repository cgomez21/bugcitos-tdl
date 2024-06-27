(defvar local-refs nil)

;; Esta función evalúa una expresión OZ, teniendo en cuenta el entorno actual.
(defun evaluar-expresion (expresion entorno)
  ;(print expresion)
  (cond
    ((listp expresion) (mapcar #'(lambda (x) (evaluar-expresion x entorno)) expresion))
    (
     (symbolp expresion)
     (or (buscar-variable entorno expresion) "Error: Variable no introducida")
    )
    (t (print "expresion"))
  )
)


;La idea es que si tengo una suma no me aumente lo que resto sino que aumente el total
;EN PROGRESO
(defun next-operation-is-sum (args) 
  (and (listp args) (= (length args) 3) (equal (first args) '+)  
)

(defun math-evaluation (args)
  (print args)
  (case (second args) 
    (+ (+ (first args) (math-evaluation (cdr (cdr args)))))
    (- (if (next-operation-is-sum (cddr args))
           ;algo que haga que se calcule antes, que la suma no agregue (contribuya) a la resta
           (- (first args) (math-evaluation (cdr (cdr args))))
           )
     )

    (* (math-evaluation (cons (* (* (first args) (third args))) (cddr (cdr args)))))
    (/ (/ (first args) (third args) ))

    (t (first args))
  )
)
; 12 - 2 * 2 + 1 * 3 primero daba 2, debería dar 11 ( hace 12 - (2 * (2 + (1 * 3))) )   
; 12 - 2 * 2 + 1 * 3 después daba 5, debería dar 11 ( hace 12 - (2 * 2 + (1 * 3)) )
; ---------------------------------------- ( debería hacer 12 - (2 * 2 ) + (1 * 3) )
;(math-evaluation (cons result (cddr (cdr args))))


; Hace una evaluación recursiva, va de derecha a izquierda. El problema
; es que en * y / necesito que haga primero la operación y después
; vea que hace después
(defun lineal-evaluation (args)
  (case (second args) 
    (+ (+ (first args) (lineal-evaluation (cdr (cdr args)))))
    (- (- (first args) (lineal-evaluation (cdr (cdr args)))))
    (* (* (first args) (lineal-evaluation (cdr (cdr args)))))
    (/ (/ (first args) (lineal-evaluation (cdr (cdr args)))))
    (t (first args))
  )
)

; Solo operaciones simples (A = 1 + 3, o B = 3 * 4)
(defun equality-args (args) 
  (case (second args) 
    (+ (+ (first args) (third args)))
    (- (- (first args) (third args)))
    (* (* (first args) (third args)))
    (/ (/ (first args) (third args)))
    (t (first args))
  )
)

;; Esta función evalúa una instrucción OZ en el entorno actual.
(defun evaluar-instruccion (instruccion entorno)
  (destructuring-bind (cmd args) instruccion
    (case cmd
      (:Browse (print (evaluar-expresion (first args) entorno))) ; acá 'Browse'
      (:DECLARE (apply #'declarar-variable (cons entorno args))) ; acá 'DECLARE'
      (:local (apply #'declarar-local-variable (cons entorno args))) ; acá 'local'
      (:end (apply #'eliminar-variable (cons entorno args))) ; acá 'end'
      (t (case (first args)
           (= (apply #'equality 
                  (cons entorno 
                   (list (string cmd) (math-evaluation (cdr args)))
                  )
            ))
        ))
      ;(t (error "Comando desconocido: ~A" cmd))
)))

;(intern (subseq cmd 1))  

;; Esta función ejecuta el código OZ en el entorno actual.
(defun ejecutar-oz (codigo)
;;Acá utilizo let para crear un ámbito local donde se definen dos variables locales:           "entorno" y "instrucciones", para crear un entorno y analizar dicha instrucción.
  ;;"entorno" se inicializa llamando a la función crear-entorno, que devuelve una nueva tabla de hash vacía, que será utilizada como el entorno de ejecución para el código OZ.
  ;;"instrucciones" se inicializa llamando a la función analizar con el argumento codigo. Esta función analiza el código OZ y devuelve una lista de instrucciones.
  (let ((entorno (crear-entorno)) 
        (instrucciones (analizar codigo)))

       ;(print instrucciones)
       (if (null instrucciones)
        (print "Error: Expresión OZ inexistente.")
;;Se verifica si la lista de instrucciones es nula (es decir, si el código estaba vacío o no se pudo analizar). Si es así, se imprime un mensaje de error indicando que la expresión es inexistente.
           ;;en caso de no ser vacía, se ejecuta un bucle for que recorre cada instrucción en la lista de instrucciones.
        (progn
          (dolist (instruccion instrucciones)
            ;;Dentro del dolist, se verifica si el primer elemento de instruccion es :Browse o :DECLARE. Si no es ninguno de estos, se imprime un mensaje de error donde indicamos que el comando es desconocido. (arreglar esto para otro tipo de instrucciones)
            (if (member (car instruccion) '(:Browse :DECLARE :local :end))
                (evaluar-instruccion instruccion entorno)
                (if (member (first (first (cdr instruccion))) '(=))
                  (progn
                    (evaluar-instruccion instruccion entorno)
                  )
                  (print (format nil "Error: Comando desconocido: ~A" (car instruccion)))
                )
            )
            ;;Luego, se llama a evaluar-instruccion con la instruccion actual y el entorno actua. Esto evalúa la instrucción y ejecuta la acción correspondiente.
            ;; (evaluar-instruccion instruccion entorno)
          )
          ;;Finalmente, después del dolist, se imprime un mensaje indicando que el código OZ se ejecutó correctamente.
          (print "Código OZ ejecutado correctamente.")))))