; The Little Scheme
;;
;; Action
;;; *const
;;; *identifier
;;; *quote
;;; *cond
;;; *lambda
;;; *application
;;
;; Architecture
;;; (tls e)
;;;; (meaning e table)
;;;;; (expression-to-action e)
;;;;;; (atom-to-action e)
;;;;;;; (*const e table)
;;;;;;; (*identifier e table)
;;;;;;;; (initial-table name)
;;;;;; (list-to-action e)
;;;;;;; (*quote e table)
;;;;;;; (*cond e table)
;;;;;;;; (evcon e table)
;;;;;;;;; (else? e)
;;;;;;;;; (question-of pair)
;;;;;;;;; (answer-of pair)
;;;;;;; (*lambda e table)
;;;;;;; (*application e table)
;;;;;;;; (*apply-fun e table)
;;;;;;;;; (*apply-primitive fun args)
;;;;;;;;;; (:atom? e)
;;;;;;;;; (*apply-closure fun args)
;;;;;;;;;; (table-of closure)
;;;;;;;;;; (formal-of closure)
;;;;;;;;;; (body-of closure)
;;;;;;;;; (evli e table)
;;
;; Hint:
;;; I. A closure is
;;; a tuple constructed by,
;;; table, formal-list and body.
;;;
;;; II. Applying a closure to arguments is equal to
;;; get the meaning of the body of closure with,
;;; the table of closure extended with,
;;; the new-entry constructed by,
;;; the formal-list of closure and arguments.

; Basic function
(define atom?
  (lambda (a)
    (and (not (pair? a)) (not (null? a)))))

(define add1
  (lambda (x)
    (+ x 1)))

(define sub1
  (lambda (x)
    (- x 1)))

; Pair Operations
(define build
  (lambda (f s)
    (cons f (cons s '()))))

(define first car)

(define second
  (lambda (p) 
    (car (cdr p))))

; Entry Operations
(define new-entry build)

(define look-up-entry
  (lambda (name entry entry-f)
    (look-up-entry-help
      name
      (first entry)
      (second entry)
      entry-f)))

(define look-up-entry-help 
  (lambda (name names values entry-f)
    (cond
      ((null? names) (entry-f name))
      ((eq? name (car names)) (car values))
      (else (look-up-entry-help
              name
              (cdr names)
              (cdr values)
              entry-f)))))

; Table Operation
(define extend-table cons)

(define look-up-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else (look-up-entry
              name
              (car table)
              (lambda (name)
                (look-up-table
                  name
                  (cdr table)
                  table-f)))))))

(define tls
  (lambda (e)
    (meaning e '())))

(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))

(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))

(define atom-to-action
  (lambda (e)
    (cond
      ((number? e) *const)
      ((eq? e #t) *const)
      ((eq? e #f) *const)
      ((eq? e 'atom?) *const)
      ((eq? e 'car) *const)
      ((eq? e 'cdr) *const)
      ((eq? e 'cons) *const)
      ((eq? e 'null?) *const)
      ((eq? e 'eq?) *const)
      ((eq? e 'number?) *const)
      ((eq? e 'zero?) *const)
      ((eq? e 'add1) *const)
      ((eq? e 'sub1) *const)
      (else *identifier))))

(define *const
  (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      (else (build 'primitive e)))))

(define *identifier
  (lambda (e table)
    (look-up-table
      e table initial-table)))

(define initial-table
  (lambda (x)
    (cons 'Yo! (cons x '(undefine)))))

(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (cond
         ((eq? (car e) 'quote) *quote)
         ((eq? (car e) 'cond) *cond)
         ((eq? (car e) 'lambda) *lambda)
         (else *application)))
      (else *application))))

(define *quote
  (lambda (e table)
    (second e)))

(define *cond
  (lambda (e table)
    (evcon (cdr e) table)))

(define evcon
  (lambda (e table)
    (cond
      ((else? (question-of (car e)))
       (meaning (answer-of (car e)) table))
      ((meaning (question-of (car e)) table)
       (meaning (answer-of (car e)) table))
      (else (evcon (cdr e) table)))))

(define else?
  (lambda (e)
    (and (atom? e) (eq? e 'else))))

(define question-of first)
(define answer-of second)

(define *lambda
  (lambda (e table)
    (build 'non-primitive
           (cons table (cdr e)))))

(define *application
  (lambda (e table)
    (apply-fun (meaning (car e) table)
               (evli (cdr e) table))))

(define apply-fun
  (lambda (fun args)
    (cond
      ((eq? (first fun) 'primitive) (apply-primitive (second fun) args))
      ((eq? (first fun) 'non-primitive) (apply-closure (second fun) args)))))

(define apply-primitive
  (lambda (fun args)
    (cond
      ((eq? fun 'atom?)
       (:atom? (first args)))
      ((eq? fun 'car)
       (car (first args)))
      ((eq? fun 'cdr)
       (cdr (first args)))
      ((eq? fun 'cons)
       (cons (first args) (second args)))
      ((eq? fun 'null?)
       (null? (first args)))
      ((eq? fun 'eq?)
       (eq? (first args) (second args)))
      ((eq? fun 'number?)
       (number? (first args)))
      ((eq? fun 'zero?)
       (zero? (first args)))
      ((eq? fun 'add1)
       (add1 (first args)))
      ((eq? fun 'sub1)
       (sub1 (first args))))))

(define :atom?
  (lambda (a)
    (cond
      ((atom? a) #t)
      ((null? a) #f)
      ((eq? (first a) 'primitive) #t)
      ((eq? (first a) 'non-primitive) #t)
      (else #f))))

(define apply-closure
  (lambda (closure args)
    (meaning (body-of closure)
             (extend-table
               (new-entry (formal-of closure) args)
               (table-of closure)))))

(define table-of first)

(define formal-of second)

(define body-of
  (lambda (l)
    (car (cdr (cdr l)))))

(define evli
  (lambda (args table)
    (cond
      ((null? args) '())
      (else (cons (meaning (car args) table)
                  (evli (cdr args) table))))))
