#lang br/quicklang

(define (read-syntax path port)
  ; read source code from port / incremental input
  (define src-lines (port->lines port))
  ; conver strings into datums
  ; argument string will be substituted into ~a
  (define src-datums (format-datums '(handle ~a) src-lines))
  ; quasiquoted module with multiple values, inserted with `,@`
  ; e.g. '((handle 1) (handle +) (handle 1))
  (define module-datum `(module stacker-mod "stacker.rkt" ,@src-datums))
  ; convert quoted syntax into datumß
  (datum->syntax #f module-datum))

; make read-syntax public
(provide read-syntax) 
