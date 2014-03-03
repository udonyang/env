;; The Little Schemer

;; (write
;;   (cdr '(x)))

;; (write
;   (cons 1 'b))

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; (define Harry 3)
; (write
;   (atom? Harry))

(define fac
  (lambda (n)
    (if (zero? n) 1 (* n (fac (- n 1))))))

; (write (fac 10))

; (define n1 6)
; (define n2 7)
; (write (eq? n1 n2))

(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

; (write (lat? '('() a b c)))

(define member?
  (lambda (a lat)
    (cond ((null? lat) #f)
      (else (or (eq? (car lat) a) 
        (member? a (cdr lat)))))))

; (write (member? 'poached '(fried eggs and scrambled eggs)))

(define rember
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((eq? a (car lat)) (cdr lat))
      (else (cons (car lat) (rember a (cdr lat)))))))

; (write (rember 'bacon '(bacon lettuce and tomato)))

(define firsts
  (lambda (l)
    (cond
      ((null? l) '())
      (else (cons (car (car l)) (firsts (cdr l)))))))

; (write (firsts '((a b) (c d) (e f))))

(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat))
       (cons old (cons new (cdr lat))))
      (else (cons (car lat) (insertR new old (cdr lat)))))))
(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons new lat))
      (else (cons (car lat) (insertL new old (cdr lat)))))))
(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons new (cdr lat)))
      (else (cons (car lat) (subst new old (cdr lat)))))))
(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) '())
      ((eq? o1 (car lat)) (cons new (cdr lat)))
      ((eq? o2 (car lat)) (cons new (cdr lat)))
      (else (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))

; (write (insertR 'e 'd '(a b c d f g d h)))
; (write (insertL 'e 'd '(a b c d f g d h)))
; (write (subst 'e 'd '(a b c d f g d h)))
; (write (subst2 'vanila 'chocolate 'banana
;                '(banana ice cream with cholate topping)))

(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((eq? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))))))

; (write (multirember 'cup '(coffee cup tea cup and hick cup)))

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat))
       (cons old (cons new (multiinsertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat)))))))
(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat))
       (cons new (cons old (multiinsertL new old (cdr lat)))))
      (else (cons (car lat) (multiinsertL new old (cdr lat)))))))
(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) '())
      ((eq? old (car lat)) (cons new (multisubst new old (cdr lat))))
      (else (cons (car lat) (multisubst new old (cdr lat)))))))

; (write (multiinsertR 'e 'd '(a b c d f g d h)))
; (write (multiinsertL 'e 'd '(a b c d f g d h)))
; (write (multisubst 'e 'd '(a b c d f g d h)))

(define add1
  (lambda (n) (+ n 1)))
(define sub1
  (lambda (n) (- n 1)))

; (write (add1 1))

(define o+
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (add1 (o+ n (sub1 m)))))))

; (write (o+ 2 3))

(define o-
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (sub1 (o- n (sub1 m)))))))

; (write (o- 3 2))

(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (o+ (car tup) (addtup (cdr tup)))))))

; (write (addtup '(3 5 2 8)))

(define o*
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (o+ n (o* n (sub1 m)))))))

; (write (o* 3 5))

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (o+ (car tup1) (car tup2))
                  (tup+ (cdr tup1) (cdr tup2)))))))

; (write (tup+ '(1 2 3) '(3 4)))

(define o<
  (lambda (n m)
    (cond
      ((and (zero? n) (zero? m)) #f)
      ((zero? m) #f)
      ((zero? n) #t)
      (else (o< (sub1 n) (sub1 m))))))
(define o>
  (lambda (n m)
    (cond
      ((and (zero? n) (zero? m)) #f)
      ((zero? n) #f)
      ((zero? m) #t)
      (else (o> (sub1 n) (sub1 m))))))
(define o=
  (lambda (n m)
    (cond
      ((o< n m) #f)
      ((o> n m) #f)
      (else #t))))

; (write (o< 3 3))
; (write (o> 3 3))
; (write (o= 3 3))

(define o^
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else (o* n (o^ n (sub1 m)))))))

; (write (o^ 5 3))

(define o/
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else (add1 (o/ (o- n m) m))))))

; (write (o/ 10 5))

(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))

; (write (length '(ham and cheese on rye)))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

; (write (pick 4 '(lasagna spahetti ravioli macaroni meatball)))

(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

; (write (rempick 4 '(lasagna spahetti ravioli macaroni meatball)))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))))))

; (write (no-nums '( 1 lasagna 4 spahetti 66 ravioli macaroni meatball)))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))

; (write (all-nums '( 1 lasagna 4 spahetti 66 ravioli macaroni meatball)))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (o= a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)))))

; (write (eqan? 'eqan? 'eqan?))

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? a (car lat)) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))

; (write (occur 'ravioli '(ravioli lasagna spahetti ravioli macaroni meatball)))

(define one?
  (lambda (n)
    (eqan? n 1)))

;(write (one? 1))

(define rempick
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

; (write (rempick 4 '(lasagna spahetti ravioli macaroni meatball)))

(define rember*
  (lambda (a l)
    (cond
      ((null? l) '())
      ((atom? (car l)) (cond
                         ((eq? a (car l)) (rember* a (cdr l)))
                         (else (cons (car l) (rember* a (cdr l))))))
      (else (cons (rember* a (car l)) (rember* a (cdr l)))))))

; (write (rember* 'sauce '(((tomato sauce))
;                          ((bean) sauce)
;                          (and ((flying)) sauce))))

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l)) (cond
                         ((eq? old (car l))
                          (cons old
                                (cons new
                                      (insertR* new old (cdr l)))))
                         (else (cons (car l)
                                     (insertR* new old (cdr l))))))
      (else (cons (insertR* new old (car l))
                  (insertR* new old (cdr l)))))))

; (write (insertR* 'haha 'sauce '(((tomato sauce))
;                                ((bean) sauce)
;                                (and ((flying)) sauce))))

(define occur* 
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l)) (cond
                         ((eq? a (car l))
                          (add1 (occur* a (cdr l))))
                         (else (occur* a (cdr l)))))
      (else (o+ (occur* a (car l)) (occur* a (cdr l)))))))

; (write (occur* 'sauce '(((tomato sauce))
;                         ((bean) sauce)
;                         (and ((flying)) sauce))))

(define subst*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l)) (cond
                         ((eq? old (car l))
                                (cons new (subst* new old (cdr l))))
                         (else (cons (car l)
                                     (subst* new old (cdr l))))))
      (else (cons (subst* new old (car l))
                  (subst* new old (cdr l)))))))

; (write (subst* 'haha 'sauce '(((tomato sauce))
;                               ((bean) sauce)
;                               (and ((flying)) sauce))))

(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l)) (cond
                         ((eq? old (car l))
                          (cons new
                                (cons old
                                      (insertL* new old (cdr l)))))
                         (else (cons (car l)
                                     (insertL* new old (cdr l))))))
      (else (cons (insertL* new old (car l))
                  (insertL* new old (cdr l)))))))

; (write (insertL* 'haha 'sauce '(((tomato sauce))
;                                 ((bean) sauce)
;                                 (and ((flying)) sauce))))

(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (or (eq? a (car l)) (member* a (cdr l))))
      (else (or (member* a (car l)) (member* a (cdr l)))))))

; (write (member* 'flying '(((tomato sauce))
;                           ((bean) sauce)
;                           (and ((flying)) sauce))))

(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l)) (car l))
      (else (leftmost (car l))))))

; (write (leftmost '(((tomato sauce))
;                    ((bean) sauce)
;                    (and ((flying)) sauce))))

(define list1 '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
(define list2 '((tomato sauce) ((bean) sauce) (and ((flying)) sauce)))

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      ((and (atom? l1) (atom? l2))
       (and (eqan? l1 l2) (eqlist? (cdr l1) (cdr l2))))
      ((or (atom? l1) (atom? l2)) #f)
      (else (and (eqlist? (car l1) (car l2))
                 (eqlist? (cdr l1) (cdr l2)))))))

; (write (eqlist? list1 list2))

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2)))))

; (write (equal? list1 list2))

(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else (and (equal? (car l1) (car l2))
                 (eqlist? (cdr l1) (cdr l2)))))))

; (write (eqlist? list1 list2))

(define rember
  (lambda (s l)
    (cond
      ((null? l) '())
      ((equal? s (car l)) (cdr l))
      (else (cons (car s) (rember s (cdr l)))))))

; (write (rember 'bacon '(bacon lettuce and tomato)))

(define numbered?
  (lambda (aexp)
   (cond
     ((atom? aexp) (number? aexp))
     (else (and (numbered? (car aexp))
                (numbered? (car (cdr (cdr aexp)))))))))

;(write (numbered? '(1 + (3 / 4))))

(define first-sub-exp
  (lambda (aexp)
    (car aexp)))
(define second-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))
(define operator
  (lambda (aexp)
    (car (cdr aexp))))
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? '+ (operator nexp))
       (o+ (value (first-sub-exp nexp))
           (value (second-sub-exp nexp))))
      ((eq? '* (operator nexp))
       (o* (value (first-sub-exp nexp))
           (value (second-sub-exp nexp))))
      ((eq? '^ (operator nexp))
       (o^ (value (first-sub-exp nexp))
           (value (second-sub-exp nexp)))))))

(write (value '(1 + (3 ^ 4))))
