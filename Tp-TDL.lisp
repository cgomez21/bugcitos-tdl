(defvar *global-env* (make-hash-table :test 'equal))

(defun evaluar-oz (exp env)
  (cond
    ;; Aca evaluo si la expreción es Declare
    ((eq (car exp) 'declare)
     (let ((var (cadr exp))
           (val (caddr exp)))
       (setf (gethash var env) val)))

    ;; Aca evaluo si la expreción es Browse
    ;; Imprimir en pantalla usando Browse
    ((eq (car exp) 'Browse)
     (let ((val (cadr exp)))
        (if (symbolp val) ; Verifica si es una variable
          (if (boundp '*local-env*) ;; si esta el entorno local 
            (print (gethash val *local-env*)) ;; Imprimo el valor de la variable en el local
            (print (gethash val env))
          )
          (print val)
        ); Si no, imprime el valor directamente
       nil))

    ;; Otras ramas de la función eval-oz...
    (
      (eq (car exp) 'local)
      (let ((val (cadr exp)))
           (defvar *local-env* (make-hash-table :test 'equal))
      )
    )

    (
      (eq (cadr exp) '=)
      (let ((var (car exp))
           (val (caddr exp))) 
           (setf (gethash var *local-env*) val)
      )
    )

    (
      (eq (car exp) 'end)
      (makunbound '*local-env*)
    )

    (t (error "Expresión no reconocida: ~a" exp)))
)

(defun run-oz (program)
  (mapcar (lambda (exp) (evaluar-oz exp *global-env*)) program)
)