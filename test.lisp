(defun ejecutar-pruebas ()
  ;; Ejecuta una serie de pruebas sobre el intérprete OZ.

  ;; Imprime un string
  (format t "Test01 - Browse de un string~%")
  (ejecutar-oz '((Browse "Hola mundo")))
  (format-test)

  ;; Prueba asignación e impresión de variable global
  (format t "Test02 - Declare de variables globales~%")
  (ejecutar-oz '((declare x)
                 (x = 50)
                 (Browse x)))
  (format-test)

  ;; Prueba lista con una variable global
  (format t "Test03 - Listas~%")
  (ejecutar-oz '((declare y)
                 (y = '(1 2 3 4))
                 (Browse y)))
  (format-test)

  (format t "Test04 - Variable local~%")
  (ejecutar-oz '((local ((z))
    (in
      (z = 40)
      (Browse z)
    end))))
  (format-test)
  
  ;; Prueba variable local fuera de ámbito
  (format t "Test05 - Variable local dentro y fuera de ambito~%")
  (ejecutar-oz '((local ((a))
                        (in
                          (a = 29)
                          (Browse a)
                        end))))
  
  ;; Ejecuta la expresión local que debería imprimir 50
  (handler-case
      (ejecutar-oz '((Browse a)))
      ;; Intenta acceder a la variable local 'a' fuera de su ámbito
    (error (c)
      (format t "Error: variable local fuera de ámbito.~%")
    )
  )
  (format-test)
  
  (format t "Test06 - Fallo de igualdad (reasignacion de variable)~%")
  ;;Pruebo redefinir una variable
  (handler-case
    (ejecutar-oz '((local ((a))
      (in
        (a = 29)
        (Browse a)
        (a = 30)
        (Browse a)
      end))))
    (error (c)
      (format t "Error: Failed equality constraint.~%")
    )
  )
  (format-test)

  ;; Prueba de funciones
  (format t "Test07 - Funciones~%")
  (ejecutar-oz '((fun (suma x y) (+ x y))
                  (Browse "Defino una funcion suma, sumo 8 con 7 y me da:")
                  (Browse (suma 8 7))
                )
  )
  ;; Declara una función 'suma' que suma dos números y luego imprime el resultado.
  (format-test)

  ;; Prueba de definición de función y condicional
  (format t "Test08 - Funcion pasando variables como parametros/condicional~%")
  (ejecutar-oz '((local ((A) (B))
                        (in
                          (A = 10)
                          (B = 50)
                          (fun (Mayor X Y)
                            (if (> X Y) X Y)
                          ) 
                          (declare M)
                          (M = (Mayor A B))
                          (Browse "A vale:")
                          (Browse A)
                          (Browse "B vale:")
                          (Browse B)
                          (Browse "El Mayor es:")
                          (Browse M)
                        end)
                ))
  )
  (format-test)

  ;; Prueba de records
  (format t "Test09 - Records~%")
  (ejecutar-oz '((local ((Alumno) (E))
                        (in
                          (E = 50)
                          (Alumno = (record (nombre "Roberto")
                            (app "Sanchez")
                            (edad E))
                          ) ;; Aca habia un declare que estaba de mas.
                          (Browse (field Alumno nombre))
                          (Browse (field Alumno app))
                          (Browse (field Alumno edad))
                        end))))
  (format-test)

  (format t "Test10 - Expresion no reconocida~%")
  (handler-case
    (ejecutar-oz '((printeame A)))
    (error (c)
      (format t "Error: Expresion no reconocida.~%")
    )
  )
  (format-test)
  
  ;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ;; (ejecutar-oz '((local B in) (B = 49 + 1) (Browse B) (end)))
  ;;           (format t "~%")

  ;; (ejecutar-oz '((local B in) (B =  12 - 2 * 2 + 1 * 3) (Browse B) (end)))
  ;;           (format t "~%")
  ;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  ;; ESTO SON PRUEBAS VIEJAS QUE FALTA IMPLEMENTAR ACA
)

(defun format-test ()
  (format t "~%")
  (format t "################################################################")
  (format t "~%")
)