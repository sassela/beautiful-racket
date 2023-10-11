#lang br/quicklang


;; reader

(define (read-syntax path port)
  ; read source code from port / incremental input
  (define src-lines (port->lines port))
  ; conver strings into datums
  ; argument string will be substituted into ~a
  (define src-datums (format-datums '(handle ~a) src-lines))
  ; quasiquoted module with multiple values, inserted with `,@`
  ; e.g. '((handle 1) (handle +) (handle 1))
  (define module-datum `(module stacker-mod "stacker.rkt" ,@src-datums))
  ; convert quoted syntax into datum
  (datum->syntax #f module-datum))

; make read-syntax public
(provide read-syntax) 


;; expander

; 1. Provide the special #%module-begin macro.
; HANDLE-EXPR ... will match each line of code passed to macro
; a.k.a `pattern variable`
(define-macro (stacker-module-begin HANDLE-EXPR ...)
  ; optional import of `#%module-begin`
  #'(#%module-begin
     HANDLE-EXPR ...
     (display (first stack))))
(provide (rename-out [stacker-module-begin #%module-begin]))

; 2. Imple­ment a stack, with an inter­face for storing, reading,
; and doing oper­a­tions on argu­ments, that can be used by `handle`.
(define stack empty)

(define (pop-stack!)
  (define arg (first stack))
  (set! stack (rest stack))
  arg)

(define (push-stack! arg)
  (set! stack (cons arg stack)))

; 3. Provide bind­ings for `handle`, `+` and `*` iden­ti­fiers:
;  handle, which deter­mines what to do with each argu­ment;
(define (handle [arg #f]) ; optional arg
  (cond
    ; push numbers onto the stack
    [(number? arg) (push-stack! arg)]
    ; apply operator to the last two numbers on the stack
    [(or (equal? + arg) (equal? * arg))
     (define op-result (arg (pop-stack!) (pop-stack!)))
     (push-stack! op-result)]))
(provide handle)

;  +, a stack oper­ator;
;  *, another stack oper­ator
(provide + *)