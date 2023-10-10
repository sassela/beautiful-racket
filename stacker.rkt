#lang br/quicklang

(define (read-syntax path port)
  ; read source code from port / incremental input
  (define src-lines (port->lines port))
  ; convert quoted syntax into datum
  (datum->syntax #f
                 ; return `lucy` module, using `br` language exander, evaluating `42`
                 '(module lucy br  
                       42)))

; make read-syntax public
(provide read-syntax) 

