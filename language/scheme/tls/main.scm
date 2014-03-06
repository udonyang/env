(require racket/include)
(include "tls.scm")

; (write (tls '(cons 1 2)))

; (write (tls '((lambda (x y) (cons x y)) 1 2)))

(define @Y
  '(lambda (f)
     ((lambda (g) (g g))
      (lambda (h) (f (lambda (x) ((h h) x)))))))

(define @Y2
  '(lambda (f)
     ((lambda (g) (g g))
      (lambda (h) (f (lambda (x y) ((h h) x y)))))))

(define @length
  '(lambda (length)
     (lambda (l)
       (cond
         ((null? l) 0)
         (else (add1 (length (cdr l))))))))

(define @pick
  '(lambda (pick)
     (lambda (n lat)
       (cond
         ((zero? n) (car lat))
         (else (pick (sub1 n) (cdr lat)))))))

(define @list
  '(quote (1 2 3 adlfkajdf asklfjasf 2)))

;(write (tls @Y))

; (write (tls @length))

; (write (tls (build (build @Y @length) @list)))

(write (tls (cons (build @Y2 @pick) (build 4 @list))))
