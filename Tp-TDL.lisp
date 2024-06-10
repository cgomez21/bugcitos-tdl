(defvar *global-env* (make-hash-table :test 'equal))
(defvar var-reflist nil) ;; Lista de referencias (nombres de variables)
;; var-reflist es una lista pero pongo las variables como un stack cuando las introduzco

;; Printear valor por pantalla
(defun exec-browse (val env)
  (if (symbolp val) ;; Verifica si es un simbolo (en nuestro caso, una variable)
    (if (find val var-reflist) ;; Si esta en la lista de referencias
      (print (gethash (find val var-reflist) env)) ;; Imprimo el valor de la variable en el local
      (error "Variable not introduced: ~a" val)
    )
    (print val) ;; Si no, imprime el valor directamente
  )
)

;; Operador =
(defun exec-equality (exp env)
  (if (symbolp (car exp))
    (if (find (car exp) var-reflist)
      (if (gethash (car exp) env)
        (error "Failed equality constraint: ~a does not equal ~a" (gethash (car exp) env) (caddr exp))
        (setf (gethash (car exp) env) (caddr exp))
      )
      (error "Variable ~a not introduced" (car exp))
    )
    (if (= (car exp) (caddr exp))
      (nil)
      (error "Failed equality constraint: ~a does not equal ~a" (car exp) (caddr exp))
    )
  )
)

(defun evaluar-oz (exp env)
  (cond
    ;; ;; Aca evaluo si la expreción es Declare
    ;; ((eq (car exp) 'declare)
    ;;  (let ((var (cadr exp))
    ;;        (val (caddr exp)))
    ;;    (setf (gethash var env) val)))

    ;; Aca evaluo si la expreción es Browse
    ;; Imprimir en pantalla usando Browse
    (
      (eq (car exp) 'Browse)
      (exec-browse (cadr exp) env)
    )

    ;; Otras ramas de la función eval-oz...
    (
      (eq (car exp) 'local)
      (push (cadr exp) var-reflist)
    )

    ;; El = en realidad es más complejo
    ;; Hay que chequear que no este definido el valor de la variable
    ;; Descomponer todo lo que esta a la derecha y a la izquierda (puede haber +, -, *, /)
    ;; (Puede haber otras variables)
    (
      (eq (cadr exp) '=)
      (exec-equality exp env)
    )

    (
      (eq (car exp) 'end)
      (if (> (length var-reflist) 0)
        (progn (remhash (first var-reflist) env) (pop var-reflist))
      )
    )
    
    (t (error "Expresión no reconocida: ~a" exp))
  )
)

(defun run-oz (program)
  (mapcar (lambda (exp) (evaluar-oz exp *global-env*)) program)
  
  (if (> (length var-reflist) 0)
    (error "Expected end")
  )
)