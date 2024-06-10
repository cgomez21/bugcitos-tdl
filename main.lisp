(load "Tp-TDL.lisp")

(print "-----------------------------")
(run-oz
 '((Browse "Hola mundo")))

;; Esto esta mal, la sintaxis es declare X in, es como local pero open ended
;; o sea que no tienen scope como local
;; (print "Declare:")
;; (run-oz
;;  '((declare x 20) 
;;    (Browse x)))

(print "-----------------------------")
(print "UN LOCAL:")
(
  run-oz '((local A in) (A = 35) (Browse A) (end))
)

(print "-----------------------------")
(print "DOS LOCALS:")
(
  run-oz '((local A in) (local B in) (A = 35) (B = 40) (Browse A) (Browse B) (end) (end))
)

;; Comento estos casos de error porque sino no sigue la ejecucion

;; (print "-----------------------------")
;; (print "EXPECTED END")
;; (
;;   run-oz '((local A in) (local B in) (A = 35) (B = 40) (Browse A) (Browse B) (end))
;; )

;; (print "-----------------------------")
;; (print "UN LOCAL Y ACCESO AFUERA:")
;; (run-oz '((local A in) (A = 35) (Browse A) (end) (Browse A))
;; )

;; (print "-----------------------------")
;; (print "DOS LOCALS Y ACCESO AFUERA")
;; (run-oz '((local A in) (local B in) (B = 40) (Browse B) (end) (A = 35) (Browse A) (end) (Browse A))
;; )

;; (print "-----------------------------")
;; (print "Variable already bound con =")
;; (
;;   run-oz '((local A in) (A = 35) (A = 20) (Browse A) (end))
;; )

;; (print "-----------------------------")
;; (print "Equality constraint")
;; (
;;   run-oz '((1 = 40))
;; )

(print "-----------------------------")