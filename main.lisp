(load "Tp-TDL.lisp")

(run-oz
 '((Browse "Hola mundo")))

(run-oz
 '((declare x 20)
   (Browse x)))

(
  run-oz '((local A in) (A = 35) (Browse A) (end))
)

(
  run-oz '((local A in) (A = 35) (Browse A) (end) (Browse A))
  ;; pruebo un browse de A fuera del local pq aca deberia no tener valor
)
