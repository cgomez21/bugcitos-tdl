(load "Tp-TDL.lisp")

(run-oz
 '((Browse "Hola mundo")))

(run-oz
 '((declare x 20)
   (Browse x)))

(print "UN LOCAL:")

(
  run-oz '((local A in) (A = 35) (Browse A) (end))
)

(print "UN LOCAL Y ACCESO AFUERA:")

(
  run-oz '((local A in) (A = 35) (Browse A) (end) (Browse A))
  ;; pruebo un browse de A fuera del local pq aca deberia no tener valor
)

(print "DOS LOCALS Y ACCESO AFUERA:")

(
  run-oz '((local A in) (local B in) (B = 40) (Browse B) (end) (Browse B) (A = 35) (Browse A) (end) (Browse A))
  ;; pruebo un browse de A fuera del local pq aca deberia no tener valor
)
