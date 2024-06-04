(defvar *global-env* (make-hash-table :test 'equal))
(defvar locallist (list nil))

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
          (if (> (length locallist) 1) ;; si esta el entorno local 
            (print (gethash (find val locallist) env)) ;; Imprimo el valor de la variable en el local
            (print (gethash val env))
          )
          (print val)
        ); Si no, imprime el valor directamente
       nil))

    ;; Otras ramas de la función eval-oz...
    (
      (eq (car exp) 'local)
      (let ((varname (cadr exp)))
           (setq locallist (append locallist (list varname)))
      )
    )

    (
      (eq (cadr exp) '=)
      (let ((var (car exp))
           (val (caddr exp)))
           (if (find var locallist)
             (setf (gethash var env) val)
           )
      )
    )

    (
      (eq (car exp) 'end)
      (if (> (length locallist) 1)
        (remhash (car (last locallist)) env)
      )
      (if (> (length locallist) 1)
        (setq locallist (remove (car (last locallist)) locallist))
      )
    )

    (t (error "Expresión no reconocida: ~a" exp)))
)

(defun run-oz (program)
  (mapcar (lambda (exp) (evaluar-oz exp *global-env*)) program)
)