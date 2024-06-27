;; Esta función ejecuta pruebas sobre el intérprete OZ.
(defun ejecutar-pruebas ()
  (handler-case
      (progn
        (ejecutar-oz '((Browse "Hola mundo")))
                    (format t "~%") ; pongo esto para dejar un espacio en blanco en consola
        
                
          (ejecutar-oz '((declare x 20)
                       (Browse x)))
                    (format t "~%") ; pongo esto para dejar un espacio en blanco en consola
        
                
          (ejecutar-oz '((declare y '(1 2 3 4))
                       (Browse y)))
                    (format t "~%") ; un espacio en blanco en consola
                
          (ejecutar-oz '((local A in) (A = 35) (Browse A) (end)))
                (format t "~%")

          (ejecutar-oz '((local A in) (A = 35) (Browse A) (end) (Browse A)))
                (format t "~%")
          
          (ejecutar-oz '((local A in) (Browse A) (A = 35) (Browse A) (end)))
                (format t "~%")

          (ejecutar-oz '((local B in) (B = 49 + 1) (Browse B) (end)))
                (format t "~%")

          (ejecutar-oz '((local B in) (B =  12 - 2 * 2 + 1 * 3) (Browse B) (end)))
                (format t "~%")

;            (ejecutar-oz '((local A in) (local B in) (B = 49 + 1) (Browse B) ;(end) (A = 35) (Browse A) (Browse B) (end) (Browse A)))
;                (format t "~%")
                
;          (ejecutar-oz '())
;                (format t "~%") ; un espacio en blanco en consola
        
               
;          (ejecutar-oz '(Cualquier cosa inválida))
;                    (error (cond)
;                    (print "Error: En esta expresión OZ su codigo de error si quiero saberlo es: ")
;                    (print cond))
)))