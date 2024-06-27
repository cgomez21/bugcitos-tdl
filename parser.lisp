;; ;; Esta función analiza el código OZ y lo convierte en una lista de listas,
;; ;; donde cada sublista representa una instrucción en el código.
;; (defun analizar (codigo)
;;   (mapcar #'(lambda (instruccion)
;;       ;;Se usa mapcar para aplicar una función anónima a cada elemento de la lista codigo
;;               (destructuring-bind (cmd . args) instruccion 
;;       ;;destructuring-bind se utiliza para descomponer la estructura de una lista. En este caso, "instruccion" es una lista donde el primer elemento es el comando (cmd) y el resto de los elementos son los argumentos (args). Osea la divido en esas 2 variables.
            
;;                 (list (intern (string cmd) :keyword) args)))
;;           ;;Convertimos el comando cmd en un símbolo de palabra clave. Luego, list crea una lista con este símbolo de palabra clave y los argumentos args.
;;           codigo))
;; ;;codigo es la lista que contiene las instrucciones de OZ que se van a analizar.
(defun parse (expr)
  ;; En este caso, simplemente devolvemos la expresión tal cual
  expr
)