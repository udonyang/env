(define-syntax try
  (syntax-rules
    ()
    [(try x a b) (let/cc success
                         (let/cc x
                                 (success a))
                         b)]))

;;;;;;;;;;;;;;;;;;;;;;;;
;; The Little Schemer ;;
;;;;;;;;;;;;;;;;;;;;;;;;

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

; (define member?
;   (lambda (a lat)
;     (cond ((null? lat) #f)
;       (else (or (eq? (car lat) a) 
;         (member? a (cdr lat)))))))

; (write (member? 'eggs '(fried eggs and scrambled eggs)))

; (define rember
;   (lambda (a lat)
;     (cond
;       ((null? lat) '())
;       ((eq? a (car lat)) (cdr lat))
;       (else (cons (car lat) (rember a (cdr lat)))))))

; (write (rember 'bacon '(bacon lettuce and tomato)))

(define firsts
  (lambda (l)
    (cond
      ((null? l) '())
      (else (cons (car (car l)) (firsts (cdr l)))))))

; (write (firsts '((a b) (c d) (e f))))

; (define insertR
;   (lambda (new old lat)
;     (cond
;       ((null? lat) '())
;       ((eq? old (car lat))
;        (cons old (cons new (cdr lat))))
;       (else (cons (car lat) (insertR new old (cdr lat)))))))
; (define insertL
;   (lambda (new old lat)
;     (cond
;       ((null? lat) '())
;       ((eq? old (car lat)) (cons new lat))
;       (else (cons (car lat) (insertL new old (cdr lat)))))))
; (define subst
;   (lambda (new old lat)
;     (cond
;       ((null? lat) '())
;       ((eq? old (car lat)) (cons new (cdr lat)))
;       (else (cons (car lat) (subst new old (cdr lat)))))))
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

; (define multirember
;   (lambda (a lat)
;     (cond
;       ((null? lat) '())
;       ((eq? a (car lat)) (multirember a (cdr lat)))
;       (else (cons (car lat) (multirember a (cdr lat)))))))

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

; (define length
;   (lambda (lat)
;     (cond
;       ((null? lat) 0)
;       (else (add1 (length (cdr lat)))))))

; (write (length '(ham and cheese on rye)))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

; (write (pick 4 '(lasagna spahetti ravioli macaroni meatball)))

; (define rempick
;   (lambda (n lat)
;     (cond
;       ((zero? (sub1 n)) (cdr lat))
;       (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

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

; (define leftmost
;   (lambda (l)
;     (cond
;       ((atom? (car l)) (car l))
;       (else (leftmost (car l))))))

; (write (leftmost '(((tomato sauce))
;                    ((bean) sauce)
;                    (and ((flying)) sauce))))

(define list1 '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
(define list2 '((tomato sauce) ((bean) sauce) (and ((flying)) sauce)))

; (define eqlist?
;   (lambda (l1 l2)
;     (cond
;       ((and (null? l1) (null? l2)) #t)
;       ((or (null? l1) (null? l2)) #f)
;       ((and (atom? l1) (atom? l2))
;        (and (eqan? l1 l2) (eqlist? (cdr l1) (cdr l2))))
;       ((or (atom? l1) (atom? l2)) #f)
;       (else (and (eqlist? (car l1) (car l2))
;                  (eqlist? (cdr l1) (cdr l2)))))))

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

; (define rember
;   (lambda (s l)
;     (cond
;       ((null? l) '())
;       ((equal? s (car l)) (cdr l))
;       (else (cons (car l) (rember s (cdr l)))))))

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
; (define value
;   (lambda (nexp)
;     (cond
;       ((atom? nexp) nexp)
;       ((eq? '+ (operator nexp))
;        (o+ (value (first-sub-exp nexp))
;            (value (second-sub-exp nexp))))
;       ((eq? '* (operator nexp))
;        (o* (value (first-sub-exp nexp))
;            (value (second-sub-exp nexp))))
;       ((eq? '^ (operator nexp))
;        (o^ (value (first-sub-exp nexp))
;            (value (second-sub-exp nexp)))))))
; 
; (write (value '(1 + (3 ^ 4))))

; 6. Shadow
(define sero?
  (lambda (n)
    (null? n)))

(define edd1
  (lambda (n)
    (cons '() n)))

(define zub1
  (lambda (n)
    (cdr n)))

(define p+
  (lambda (n m)
    (cond
      ((sero? m) n)
      (else (edd1 (p+ n (zub1 m)))))))

; (write (p+ '(()) '(()())))

; Friends and Relations

; (define member?
;   (lambda (a lat)
;     (cond ((null? lat) #f)
;       (else (or (equal? (car lat) a) 
;         (member? a (cdr lat)))))))

(define oset?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (oset? (cdr lat))))))

(define list3 '(apple peached apple plum))
; (write (oset? '(apple peached)))

(define makeset
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((member? (car lat) (cdr lat)) (makeset (cdr lat)))
      (else (cons (car lat) (makeset (cdr lat)))))))

; (write (makeset list3))
; (write (makeset '(apple peach pear peach plum apple lemon peach)))

; (define multirember
;   (lambda (a lat)
;     (cond
;       ((null? lat) '())
;       ((equal? a (car lat)) (multirember a (cdr lat)))
;       (else (cons (car lat) (multirember a (cdr lat)))))))

; (define makeset
;   (lambda (lat)
;     (cond
;       ((null? lat) '())
;       (else (cons (car lat)
;                   (makeset (multirember (car lat) (cdr lat))))))))

; (write (makeset list3))
; (write (makeset '(apple peach pear peach plum apple lemon peach)))

(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else (and (member? (car set1) set2)
                 (subset? (cdr set1) set2))))))

; (write (subset? '(4 pounds of horseradish)
;                 '(four pounds chicken and 5 ounces horseadish)))
; (write (subset? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings)))

(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2) (subset? set2 set1))))

; (write (eqset? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings)))
; (write (eqset? '(5 hamburgers 2 pieces fried chicken and light duckling wings)
;                '(chicken 5 hamburgers pieces 2 fried and light duckling wings)))

(define intersect?
  (lambda (set1 set2)
    (cond
      ((null? set1) #f)
      (else (or (member? (car set1) set2)
                (intersect? (cdr set1) set2))))))

; (write (intersect? '(stewed tomatoes and macaroni) '(macaroni and cheese)))

; (define intersect
;   (lambda (set1 set2)
;     (cond
;       ((null? set1) '())
;       ((member? (car set1) set2)
;        (cons (car set1) (intersect (cdr set1) set2)))
;       (else (intersect (cdr set1) set2)))))

; (write (intersect '(stewed tomatoes and macaroni) '(macaroni and cheese)))

; (define union
;   (lambda (set1 set2)
;     (cond
;       ((null? set1) set2)
;       ((member? (car set1) set2) (union (cdr set1) set2))
;       (else (cons (car set1) (union (cdr set1) set2))))))

; (write (union '(stewed tomatoes and macaroni) '(macaroni and cheese)))

(define difference
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2) (difference (cdr set1) set2))
      (else (cons (car set1) (difference (cdr set1) set2))))))

; (write (difference '(stewed tomatoes and macaroni) '(macaroni and cheese)))

; (define intersectall
;   (lambda (l-set)
;     (cond
;       ((null? (cdr l-set)) (car l-set))
;       (else (intersect (car l-set) (intersectall (cdr l-set)))))))

; (write (intersectall '((6 pears and)
;                        (3 peached and 6 peppers)
;                        (8 pears and 6 plums)
;                        (and 6 prunes with some apples))))

(define a-pair?
  (lambda (x)
    (cond
      ((atom? x) #f)
      ((null? (cdr x)) #f)
      ((null? (cdr (cdr x))) #t)
      (else #f))))

; (write (a-pair? '(full (house) haha)))

(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (car (cdr p))))

(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 '()))))

(define fun?
  (lambda (rel)
    (oset? (firsts rel))))

; (write (fun? '((d 4) (a 0) (b 9) (e 5))))
; (write (fun? '((d 4) (b 0) (b 9) (e 5))))

; (define revrel
;   (lambda (rel)
;     (cond
;       ((null? rel) '())
;       (else (cons (build (second (car rel)) (first (car rel)))
;                   (revrel (cdr rel)))))))

; (write (revrel '((d 4) (b 0) (b 9) (e 5))))

(define revpair
  (lambda (p)
    (build (second p) (first p))))

(define revrel
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else (cons (revpair (car rel))
                  (revrel (cdr rel)))))))

; (write (revrel '((d 4) (b 0) (b 9) (e 5))))

(define fullfun?
  (lambda (fun)
    (fun? (revrel fun))))

; (write (fullfun? '((grape raisin)
;                    (plum prune)
;                    (stewed grape))))
; (write (fullfun? '((grape raisin)
;                    (plum raisin)
;                    (stewed grape))))

; 8. Lambda the Ultimate!!!
;; CPS

; (define rember-f
;   (lambda (test? a l)
;     (cond
;       ((null? l) '())
;       ((test? a (car l)) (cdr l))
;       (else (cons (car l) (rember-f (cdr l)))))))

; (write (rember-f equal? 'bacon '(bacon lettuce and tomato)))

(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))

; (define eq?-salad (eq?-c 'salad))
; (write (eq?-salad 'sala))

(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) '())
        ((test? a (car l)) (cdr l))
        (else (cons (car l) ((rember-f test?) (cdr l))))))))

; (write ((rember-f equal?) 'bacon '(bacon lettuce and tomato)))

(define insertR-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
        ((null? lat) '())
        ((test? old (car lat))
         (cons old (cons new (cdr lat))))
        (else (cons (car lat) ((insertR-f test?) new old (cdr lat))))))))

; (write ((insertR-f equal?) 'bacon 'lettuce '(bacon lettuce and tomato)))

; (define left-side
;   (lambda (x1 x2 lat)
;     (cons x1 (cons x2 lat))))
; 
; (define right-side
;   (lambda (x1 x2 lat)
;     (cons x2 (cons x1 lat))))

(define insert-g
  (lambda (seq)
    (lambda (new old lat)
        (cond
          ((null? lat) '())
          ((eq? old (car lat))
           (seq new old (cdr lat)))
          (else (cons (car lat) ((insert-g seq) new old (cdr lat))))))))

(define insertL
  (insert-g
    (lambda (new old l)
      (cons new (cons old l)))))
(define insertR
  (insert-g
    (lambda (new old l)
      (cons old (cons new l)))))

; Another way, but less extension.... T^T
;
; (define insert-g
;   (lambda (g)
;     (lambda (test?)
;       (lambda (new old lat)
;         (cond
;           ((null? lat) '())
;           ((test? old (car lat))
;            (cond
;              ((eq? g 'L) (cons new (cons old (cdr lat))))
;              (else (cons old (cons new (cdr lat))))))
;           (else (cons (car lat) (((insert-g g) test?) new old (cdr lat)))))))))

; (write (insertR 'bacon 'lettuce '(bacon lettuce and tomato)))

(define subst
  (insert-g
    (lambda (new old l)
      (cons new l))))

; (write (subst 'bacon 'lettuce '(bacon lettuce and tomato)))

; (define rember
;   (lambda (a l)
;     ((insert-g (lambda (new old l) l)) #f a l)))

; (write (rember 'lettuce '(bacon lettuce and tomato)))

(define atom-to-function
  (lambda (x)
    (cond
      ((eq? '+ x) o+)
      ((eq? '* x) o*)
      (else o^))))

; (define value
;   (lambda (nexp)
;     (cond
;       ((atom? nexp) nexp)
;       (else ((atom-to-function (operator nexp))
;              (value (first-sub-exp nexp))
;              (value (second-sub-exp nexp)))))))

; (write (atom-to-function (+ 5 3)))
; (write (value '(1 + (3 ^ 4))))

(define multirember-f
  (lambda (test?)
    (lambda (a lat)
      (cond
        ((null? lat) '())
        ((test? a (car lat)) ((multirember-f test?) a (cdr lat)))
        (else (cons (car lat) ((multirember-f test?) a (cdr lat))))))))

(define multirember-eq?
  (multirember-f eq?))

; (write ((multirember-f eq?) 'cup '(coffee cup tea cup and hick cup)))
; (write (multirember-eq? 'cup '(coffee cup tea cup and hick cup)))

(define eq?-cup
  (eq?-c 'cup))

(define multiremberT
  (lambda (test?)
    (lambda (lat)
      (cond
        ((null? lat) '())
        ((test? (car lat)) ((multiremberT test?) (cdr lat)))
        (else (cons (car lat) ((multiremberT test?) (cdr lat))))))))

; (write ((multiremberT eq?-cup) '(coffee cup tea cup and hick cup)))

(define multirember-co
  (lambda (a lat col)
    (cond
      ((null? lat) (col '() '()))
      ((eq? a (car lat))
       (multirember-co
         a (cdr lat)
         (lambda (newlat seen)
           (col newlat (cons (car lat) seen)))))
      (else (multirember-co
          a (cdr lat)
          (lambda (newlat seen)
            (col (cons (car lat) newlat)seen)))))))

(define a-friend
  (lambda (x y)
    (null? y)))

; (write (multirember-co 'tuna '(strawberries tuna and swordfish) a-friend))
(define multiinsertLR
  (lambda (new oldL oldR lat)
    (cond
      ((null? lat) '())
      ((eq? oldL (car lat))
       (cons new (cons oldL (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? oldR (car lat))
       (cons oldR (cons new (multiinsertLR new oldL oldR (cdr lat)))))
      (else (cons (car lat) (multiinsertLR new oldL oldR (cdr lat)))))))

; (write (multiinsertLR 'e 'a 'd '(a b c d f g d h)))

(define multiinsertLR-co
  (lambda (new oldL oldR lat col)
    (cond
      ((null? lat) (col '() 0 0))
      ((eq? oldL (car lat))
       (multiinsertLR-co
         new oldL oldR (cdr lat)
         (lambda (newlat L R)
           (col (cons new (cons oldL newlat))
                (add1 L) R))))
      ((eq? oldR (car lat))
       (multiinsertLR-co
         new oldL oldR (cdr lat)
         (lambda (newlat L R)
           (col (cons oldR (cons new newlat))
                L (add1 R)))))
      (else (multiinsertLR-co
              new oldL oldR (cdr lat)
              (lambda (newlat L R)
                (col newlat L R)))))))

; (write (multiinsertLR-co 'e 'a 'd '(a b c d f g d h) (lambda (newlat L R) (cons newlat (cons L R)))))

(define even?
  (lambda (n)
    (o= (o* (o/ n 2) 2) n)))

(define evens-only*
  (lambda (lat)
    (cond
      ((null? lat) '())
      ((atom? (car lat))
       (cond
         ((even? (car lat)) (cons (car lat) (evens-only* (cdr lat))))
         (else (evens-only* (cdr lat)))))
      (else (cons (evens-only* (car lat)) (evens-only* (cdr lat)))))))

; (write (evens-only* '((9 1 2 8) 3 10 ((9 9) 7 6) 2)))

(define evens-only*-co
  (lambda (lat col)
    (cond
      ((null? lat) (col '() 1 0))
      ((atom? (car lat))
       (cond
         ((even? (car lat))
          (evens-only*-co
            (cdr lat)
            (lambda (newlat P S)
              (col
                (cons (car lat) newlat)
                (o* (car lat) P)
                S))))
         (else (evens-only*-co
            (cdr lat)
            (lambda (newlat P S)
              (col
                newlat
                P
                (o+ (car lat) S)))))))
      (else (evens-only*-co
                (car lat)
                (lambda (newlat P S)
                  (evens-only*-co
                    (cdr lat)
                    (lambda (newlat2 P2 S2)
                      (col
                        (cons newlat newlat2)
                        (o* P P2)
                        (o+ S S2))))))))))

; (write (evens-only*-co '((9 1 2 8) 3 10 ((9 9) 7 6) 2)
;                        (lambda (newlat P S) (cons newlat (cons P S)))))

; 9. ... and Again, and Again, and Again,...
;; Y combinator

(define keep-looking
  (lambda (a b lat)
    (cond
      ((number? b) (keep-looking a (pick b lat) lat))
      (else (eq? a b)))))

(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))

; (write (looking 'caviar '(6 2 4 caviar 5 7 3)))
; (write (looking 'caviar '(6 2 grits caviar 5 7 3)))

(define shift
  (lambda (pair)
    (build (first (first pair))
           (build (second (first pair)) (second pair)))))

; (write (shift '((a b) c)))
; (write (shift '((a b) (c d))))

(define align
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora))
       (align (shift pora)))
      (else (build (first pora)
                   (align (second pora)))))))

; (define length*
;   (lambda (lat)
;     (cond
;       ((null? lat) 0)
;       ((atom? (car lat)) (add1 (length* (cdr lat))))
;       (else (o+ (length* (car lat)) (length* (cdr lat)))))))

(define length*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else (+ (length* (first pora))
               (length* (second pora)))))))

(define weight*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else (o+ (o* (weight* (first pora)) 2)
                (weight* (second pora)))))))

; (write (weight* '((a b) c)))
; (write (weight* '(a (b c))))
; (write (align '((a b) ((c d) ((e f) g)))))

(define shuffle
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora))
       (shuffle (revpair pora)))
      (else (build (first pora)
                   (shuffle (second pora)))))))

; (write (shuffle '((a b) (c d))))

; 3n+1 problem
(define C
  (lambda (n)
    (cond
      ((one? n) 1)
      (else
        (cond
          ((even? n) (C (o/ n 2)))
          (else (C (add1 (o* 3 n)))))))))

(define A
  (lambda (n m)
    (cond
      ((zero? n) (add1 m))
      ((zero? m) (A (sub1 n) 1))
      (else (A (sub1 n) (A n (sub1 m)))))))

(define eternity
  (lambda (x)
    (eternity x)))

; (write (A 3 3))

; length_0
(lambda (l)
  (cond
    ((null? l) 0)
    (else (add1 (eternity (cdr l))))))

; length_{<=1}
(lambda (l)
  (cond
    ((null? l) 0)
    (else
      (add1
        ((lambda (l)
           (cond
             ((null? l) 0)
             (else (add1 (eternity (cdr l))))))
         (cdr l))))))

; length {<=2}
(lambda (l)
  (cond
    ((null? l) 0)
    (else
      (add1
        ((lambda (l)
           (cond
             ((null? l) 0)
             (else
               (add1
                 ((lambda (l)
                    (cond
                      ((null? l) 0)
                      (else (add1 (eternity (cdr l))))))
                  (cdr l))))))
         (cdr l))))))

;; Abstract ver. 1

; ; length_0
; ((lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l)))))))
;  eternity)
; 
; ; length_{<=1}
; (((lambda (f)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (f (cdr l)))))))
;  (lambda (g)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (g (cdr l))))))))
;  eternity)
; 
; ; length_{<=2}
; ((lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l)))))))
;  (lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l)))))))
;  (lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l)))))))
;  eternity)
; 
; ;; Abstract ver. 2
; 
; ; length_0
; ((lambda (mk-length)
;    (mk-length eternity))
;  (lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l))))))))
; 
; ; length_{<=1}
; ((lambda (mk-length)
;    (mk-length
;      (mk-length eternity)))
;  (lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l))))))))
; 
; ; length_{<=2}
; ((lambda (mk-length)
;    (mk-length
;      (mk-length
;        (mk-length eternity))))
;  (lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l))))))))
; 
; ; length_{<=3}
; ((lambda (mk-length)
;    (mk-length
;      (mk-length
;        (mk-length
;          (mk-length eternity)))))
;  (lambda (length)
;    (lambda (l)
;      (cond
;        ((null? l) 0)
;        (else (add1 (length (cdr l))))))))
; 

;; Abstract ver.3

; ; length_0
; (write
;   (((lambda (mk-length)
;       (mk-length mk-length))
;     (lambda (mk-length)
;       (lambda (l)
;         (cond
;           ((null? l) 0)
;           (else (add1 (mk-length (cdr l))))))))
;    '()))

; ; length_{<=1}
; (write
;   (((lambda (mk-length)
;       (mk-length mk-length))
;     (lambda (mk-length)
;       (lambda (l)
;         (cond
;           ((null? l) 0)
;           (else (add1 ((mk-length eternity) (cdr l))))))))
;    '(apple)))

; ; length_{oo}
; (write
;   (((lambda (mk-length)
;       (mk-length mk-length))
;     (lambda (mk-length)
;       (lambda (l)
;         (cond
;           ((null? l) 0)
;           (else (add1 ((mk-length mk-length) (cdr l))))))))
;    '(apple apple fuck your ass)))

; Abstract ver.4 
; (write
;   (((lambda (mk-length)
;       (mk-length mk-length))
;     (lambda (mk-length)
;       ((lambda (length)
;         (lambda (l)
;           (cond
;             ((null? l) 0)
;             (else (add1 (length (cdr l)))))))
;        (lambda (x)
;          ((mk-length mk-length) x)))))
;    '(apple)))

; (write (((lambda (le)
;            ((lambda (mk-length)
;               (mk-length mk-length))
;             (lambda (mk-length)
;               (le (lambda (x)
;                     ((mk-length mk-length) x))))))
;          (lambda (length)
;            (lambda (l)
;              (cond
;                ((null? l) 0)
;                (else (add1 (length (cdr l)))))))) '(apple)))

; Abstract ver.5
; Y combinator
(define Y
  (lambda (f)
    ((lambda (g) (g g))
     (lambda (g)
       (f (lambda (x) ((g g) x)))))))

; (write ((Y (lambda (length)
;             (lambda (l)
;               (cond
;                 ((null? l) 0)
;                 (else (add1 (length (cdr l)))))))) '(apple fuck you)))

; 10. What is the Value of All of This
;; Closure; Function is Value

; (define new-entry build)
; 
; (define names1 '(beverage dessert))
; (define values1 '((food is) (number one with us)))
; (define entry1 (new-entry names1 values1))

; (write entry1)

; (define lookup-in-entry-help
;   (lambda (name names values entry-f)
;     (cond
;       ((null? names) (entry-f name))
;       ((eq? name (car names)) (car values))
;       (else (lookup-in-entry-help
;               name (cdr names) (cdr values) entry-f)))))
; (define lookup-in-entry
;   (lambda (name entry entry-f)
;     (lookup-in-entry-help
;       name
;       (first entry)
;       (second entry)
;       entry-f)))

; (write (lookup-in-entry 'beverage entry1 (lambda (x) x)))

; (define extend-table cons)
; 
; (define names2 '(appetizer entree beverage))
; (define value2 '(pate boeuf vin))
; (define entry2 (new-entry names2 value2))
; 
; (define table1 (extend-table entry1 (extend-table entry2 '())))
; 
; ; (write table1)
; 
; (define lookup-in-table
;   (lambda (name table table-f)
;     (cond
;       ((null? table) (table-f name))
;       (else (lookup-in-entry
;               name (car table)
;               (lambda (name)
;                 (lookup-in-table
;                   name (cdr table)
;                   table-f)))))))
; 
; (write (lookup-in-table 'FUCK table1 (lambda (x) (cons x '(not found)))))

; (define expreesion-to-action
;   (lambda (e)
;     (cond
;       ((atom? e) (atom-to-action e))
;       (else (list-to-action e)))))

; (define atom-to-action
;   (lambda (e)
;     (cond
;       ((number? e) *const)
;       ((eq? #t e) *const)
;       ((eq? #f e) *const)
;       ((eq? 'cons e) *const)
;       ((eq? 'car e) *const)
;       ((eq? 'cdr e) *const)
;       ((eq? 'null? e) *const)
;       ((eq? 'eq? e) *const)
;       ((eq? 'atom? e) *const)
;       ((eq? 'zero? e) *const)
;       ((eq? 'add1 e) *const)
;       ((eq? 'sub1 e) *const)
;       ((eq? 'number? e) *const)
;       (else *identifier))))

; (define list-to-action
;   (lambda (e)
;     (cond
;       ((atom? (car e))
;        (cond
;          ((eq? 'quote (car e)) *quote)
;          ((eq? 'lambda (car e)) *lambda)
;          ((eq? 'cond (car e)) *cond)
;          (else *application)))
;       (else *application))))

; (write (expreesion-to-action 'atom?))

; (define value
;   (lambda (e)
;     (meaning e '())))

; (define meaning
;   (lambda (e table)
;     ((expreesion-to-action e)
;      e table)))

; (write (value '(quote (1 2))))

; (define *const
;   (lambda (e table)
;     (cond
;       ((number? e) e)
;       ((eq? #t e) #t)
;       ((eq? #f e) #f)
;       (else (build 'primitive e)))))

; (define *quote
;   (lambda (e table)
;     (text-of e)))

; (define text-of second)

; (define *identifier
;   (lambda (e table)
;     (lookup-in-table e table initial-table)))

; (define initial-table
;   (lambda (name)
;     (car '())))

; (define *lambda
;   (lambda (e table)
;     (build (quote non-primitive)
;            (cons table (cdr e)))))

; (define table-of first)
; (define formals-of second)
; (define body-of third)
; 
; (define third (lambda (l) (car (cdr (cdr l)))))
; 
; (define evcon
;   (lambda (lines table)
;     (cond
;       ((else? (question-of (car lines)))
;        (meaning (answer-of (car lines)) table))
;       ((meaning (question-of (car lines)) table)
;        (meaning (answer-of (car lines)) table))
;       (else (evcon (cdr lines) table)))))
; (define else?
;   (lambda (x)
;     (cond
;       ((atom? x) (eq? x 'else))
;       (else #f))))
; (define question-of first)
; (define answer-of second)
; (define *cond
;   (lambda (e table)
;     (evcon (cond-lines-of e) table)))
; (define cond-lines-of cdr)

; (write (*cond '(cond (coffee klatsch) (else party))
;               '(((coffee) (#t)) ((klatsch party) (5 (6))))))

; (write (value '(cond (coffee klatsch) (else party))))

; (define evlis
;   (lambda (args table)
;     (cond
;       ((null? args) '())
;       (else (cons (meaning (car args) table)
;                   (evlis (cdr args) table))))))
; (define :atom?
;   (lambda (x)
;     (cond
;       ((atom? x) #t)
;       ((null? x) #f)
;       ((eq? (car x) 'primitive) #t)
;       ((eq? (car x) 'non-primitive) #t)
;       (else #f))))
; (define apply-primitive
;   (lambda (name vals)
;     (cond
;       ((eq? name 'cons)
;        (cons (first vals) (second vals)))
;       ((eq? name 'car)
;        (car (first vals)))
;       ((eq? name 'cdr)
;        (cdr (first vals)))
;       ((eq? name 'null?)
;        (null? (first vals)))
;       ((eq? name 'eq?)
;        (eq? (first vals) (second vals)))
;       ((eq? name 'atom?)
;        (:atom? (first vals)))
;       ((eq? name 'zero?)
;        (zero? (first vals)))
;       ((eq? name 'add1)
;        (add1 (first vals)))
;       ((eq? name 'sub1)
;        (sub1 (first vals)))
;       ((eq? name 'number?)
;        (number? (first vals))))))
; (define apply-closure
;   (lambda (closure vals)
;     (meaning (body-of closure)
;              (extend-table (new-entry (formals-of closure) vals)
;                            (table-of closure)))))
; (define primitive?
;   (lambda (l)
;     (eq? 'primitive (first l))))
; (define non-primitive?
;   (lambda (l)
;     (eq? 'non-primitive (first l))))
; (define apply
;   (lambda (fun vals)
;     (cond
;       ((primitive? fun)
;        (apply-primitive (second fun) vals))
;       ((non-primitive? fun)
;        (apply-closure (second fun) vals))
;       (else 'hehe))))
; (define function-of car)
; (define arguments-of cdr)
; (define *application
;   (lambda (e table)
;     (apply
;       (meaning (function-of e) table)
;       (evlis (arguments-of e) table))))

; (write (value '(sub1 2)))
; (write (value '(((lambda (le)
;                    ((lambda (mk-length)
;                       (mk-length mk-length))
;                     (lambda (mk-length)
;                       (le (lambda (x)
;                             ((mk-length mk-length) x))))))
;                  (lambda (length)
;                    (lambda (l)
;                      (cond
;                        ((null? l) 0)
;                        (else (add1 (length (cdr l)))))))) (quote apple))))

; (write (value '(((lambda (le)
;                    ((lambda (mk-length)
;                       (mk-length mk-length))
;                     (lambda (mk-length)
;                       (le (lambda (x)
;                             ((mk-length mk-length) x))))))
;                  (lambda (length)
;                    (lambda (l)
;                      (cond
;                        ((null? l) 0)
;                        (else (add1 (length (cdr l)))))))) (quote (apple 1 2 3 fuck you)))))

; (write (quote apple))

; (write (eval '((lambda (x y) (+ x y)) 1 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The Seasoned Schemer ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

; 11. Welcome back to the show
;; Use extra arguments to record what have done so far.

; (define two-in-a-row?
;   (lambda (lat)
;     (cond
;       ((null? lat) #f)
;       (else (or (is-first? (car lat) (cdr lat))
;                 (two-in-a-row? (cdr lat)))))))
; 
; (define is-first?
;   (lambda (a lat)
;     (cond
;       ((null? lat) #f)
;       (else (eq? (car lat) a)))))

; (define two-in-a-row?
;   (lambda (lat)
;     (cond
;       ((null? lat) #f)
;       (else (is-first-b? (car lat) (cdr lat))))))
; 
; (define is-first-b?
;   (lambda (a lat)
;     (cond
;       ((null? lat) #f)
;       (else (or (eq? (car lat) a)
;                 (two-in-a-row? lat))))))

; (define two-in-a-row?
;   (lambda (lat)
;     (cond
;       ((null? lat) #f)
;       (else (two-in-a-row-b? (car lat) (cdr lat))))))
; 
; (define two-in-a-row-b?
;   (lambda (a lat)
;     (cond
;       ((null? lat) #f)
;       (else (or (eq? (car lat) a)
;                 (two-in-a-row-b? (car lat) (cdr lat)))))))

; (write (two-in-a-row? '(Italian sardines sardines spaghetti parsley)))
; (write (two-in-a-row? '(Italian sardines more sardines spaghetti)))

; (define sum-of-prefixes
;   (lambda (tup)
;     (sum-of-prefixes-b 0 tup)))
; 
; (define sum-of-prefixes-b
;   (lambda (sonssf tup)
;     (cond
;       ((null? tup) '())
;       (else (cons (o+ (car tup) sonssf)
;                   (sum-of-prefixes-b (o+ (car tup) sonssf)
;                                      (cdr tup)))))))

; (write (sum-of-prefixes '(2 1 9 17 0)))
; (write (sum-of-prefixes '(1 1 1 1 1)))

; (define scramble
;   (lambda (tup)
;     (scramble-b tup '())))
; 
; (define scramble-b
;   (lambda (tup rev-pre)
;     (cond
;       ((null? tup) '())
;       (else (cons (pick (car tup) (cons (car tup) rev-pre))
;                   (scramble-b (cdr tup)
;                               (cons (car tup) rev-pre)))))))

; (write (scramble '(1 1 1 3 4 2 1 1 9 2)))
; (write (scramble '(1 2 3 4 5 6 7 8 9)))
; (write (scramble '(1 2 3 1 2 3 4 1 8 2 10)))

; 12. Take Cover
;; We should use letrec to sperate unchange value from funtion
;; We should use letrec to protect the helper function

; (define multirember
;   (lambda (a lat)
;     ((Y (lambda (mr)
;           (lambda (lat)
;             (cond
;               ((null? lat) '())
;               ((eq? (car lat) a)
;                (mr (cdr lat)))
;               (else (cons (car lat)
;                           (mr (cdr lat))))))))
;      lat)))

; (define multirember
;   (lambda (a lat)
;     ((letrec
;        ((mr (lambda (lat)
;               (cond
;                 ((null? lat) '())
;                 ((eq? (car lat) a)
;                  (mr (cdr lat)))
;                 (else (cons (car lat)
;                             (mr (cdr lat))))))))
;         mr)
;      lat)))

(define multirember
  (lambda (a lat)
    (letrec
      ((mr (lambda (lat)
             (cond
               ((null? lat) '())
               ((eq? (car lat) a)
                (mr (cdr lat)))
               (else (cons (car lat)
                           (mr (cdr lat)))))))
       (fuck mr))
      (fuck lat))))

; (write (multirember 'tuna '(shrimp salad tuna salad and tuna)))

; (define multirember-f
;   (lambda (test?)
;     (lambda (a lat)
;       (cond
;         ((null? lat) '())
;         ((test? (car lat) a)
;          ((multirember-f test?) a (cdr lat)))
;         (else (cons (car lat)
;                     ((multirember-f test?) a (cdr lat))))))))

; (define multirember-f
;   (lambda (test?)
;     (letrec
;       ((m-f (lambda (a lat)
;               (cond
;                 ((null? lat) '())
;                 ((eq? (car lat) a)
;                  (m-f a (cdr lat)))
;                 (else (cons (car lat)
;                             (m-f a (cdr lat))))))))
;       m-f)))

; (write ((multirember-f eq?) 'tuna '(shrimp salad tuna salad and tuna)))

(define member?
  (lambda (a lat)
    (letrec
      ((yes? (lambda (l)
              (cond
                ((null? l) #f)
                (else (or (eq? (car l) a)
                          (yes? (cdr l))))))))
      (yes? lat))))

; (write (member?  'tuna '(shrimp salad tuna salad and tuna)))

(define union
  (lambda (s1 s2)
    (letrec
      ((U (lambda (s)
            (cond
              ((null? s) s2)
              ((M? (car s) s2)
               (U (cdr s)))
              (else (cons (car s) (U (cdr s)))))))
       (M? (lambda (a lat)
             (letrec
               ((N? (lambda (l)
                      (cond
                        ((null? lat) #f)
                        (else (or (eq? (car lat) a)
                                  (M? a (cdr lat))))))))
               (N? lat)))))
      (U s1))))

; (write (union '(tomatoes and macaroni casserole)
;               '(macaroni and cheese)))

(define two-in-a-row-L?
  (letrec
    ((F (lambda (a l)
          (cond
            ((null? l) #f)
            (else (or (eq? (car l) a)
                      (F (car l) (cdr l))))))))
    (lambda (lat)
      (cond ((null? lat) #f)
            (else (F (car lat) (cdr lat)))))))

; (write (two-in-a-row? '(Italian sardines more sardines spaghetti)))

(define sum-of-prefixes
  (letrec
    ((sum-of-prefixes-b
       (lambda (sonssf tup)
         (cond
           ((null? tup) '())
           (else (cons (o+ (car tup) sonssf)
                       (sum-of-prefixes-b (o+ (car tup) sonssf)
                                          (cdr tup))))))))
    (lambda (tup)
      (sum-of-prefixes-b 0 tup))))

; (write (sum-of-prefixes '(1 1 1 1 1)))

; (define scramble
;   (letrec
;     ((scramble-b
;        (lambda (tup rev-pre)
;          (cond
;            ((null? tup) '())
;            (else (cons (pick (car tup) (cons (car tup) rev-pre))
;                        (scramble-b (cdr tup)
;                                    (cons (car tup) rev-pre))))))))
;     (lambda (tup)
;       (scramble-b tup '()))))

; (write (scramble '(1 1 1 3 4 2 1 1 9 2)))

; 13. Hop, Skip, and Jump
;; Use call-with-current-continuation to quit abruptly and promptly.

(define intersect
  (lambda (set1 set2)
    (letrec
      ((main 
         (lambda (set)
           (cond
             ((null? set) '())
             ((member? (car set) set2)
              (cons (car set) (main (cdr set))))
             (else (main (cdr set)))))))
      (cond ((null? set2) '())
            (else (main set1))))))

(define intersectall
  (lambda (lset)
    (call-with-current-continuation
      (lambda (hop)
        (letrec
          ((F (lambda (lset)
                (cond
                  ((null? (car lset)) (hop '()))
                  ((null? (cdr lset)) (car lset))
                  (else (G (car lset) (F (cdr lset)))))))
           (G (lambda (set1 set2)
                (letrec
                  ((main 
                     (lambda (set)
                       (cond
                         ((null? set) '())
                         ((member? (car set) set2)
                          (cons (car set) (main (cdr set))))
                         (else (main (cdr set)))))))
                  (cond ((null? set2) (hop '()))
                        (else (main set1)))))))
          (cond ((null? lset) '())
                (else (F lset))))))))

; (write (intersect '(tomatoes and macaroni)
;                   '(macaroni and cheese)))

; (write (intersectall '((tomatoes and macaroni)
;                        (3)
;                        (macaroni and cheese))))

(define rember
  (lambda (s l)
    (letrec
      ((F (lambda(l)
            (cond
              ((null? l) '())
              ((equal? s (car l)) (cdr l))
              (else (cons (car l) (F (cdr l))))))))
      (F l))))

(define rember-beyond-first
  (lambda (s l)
    (letrec
      ((F (lambda(l)
            (cond
              ((null? l) '())
              ((equal? (car l) s) '())
              (else (cons (car l) (F (cdr l))))))))
      (F l))))

(define rember-upto-last
  (lambda (s l)
    (call-with-current-continuation
      (lambda (skip)
        (letrec
          ((F (lambda(l)
                (cond
                  ((null? l) '())
                  ((equal? s (car l)) (skip (F (cdr l))))
                  (else (cons (car l) (F (cdr l))))))))
          (F l))))))

; (write (rember 'bacon '(bacon lettuce and tomato)))
; (write (rember-beyond-first 'bacon '(lettuce and bacon tomato)))
; (write (rember-upto-last 'bacon '(bacon lettuce and bacon tomato)))

; 14. Let There Be Names
;; Use (let ..) to name the values of repeated expression
;; in a function definition if they may be evaluated twice
;; for one and the same use of the function
;;
;; (if pred true-exp false-exp)
;; (try continuation-tag func fail-func)

; (define leftmost
;   (lambda (lat)
;     (cond
;       ((null? lat) '())
;       ((atom? (car lat)) (car lat))
;       (else (cond
;               ((atom? (leftmost (car lat)))
;                (leftmost (car lat)))
;               (else (leftmost (cdr lat))))))))

; (define leftmost
;   (lambda (lat)
;     (cond
;       ((null? lat) '())
;       ((atom? (car lat)) (car lat))
;       (else (let
;               ((ret (leftmost (car lat))))
;               (cond
;                 ((atom? ret) ret)
;                 (else (leftmost (cdr lat)))))))))

; (write (leftmost '((() a) ())))

; (define rember1*
;   (lambda (a l)
;     (letrec
;       ((main (lambda (l) 
;                (cond
;                  ((null? l) '())
;                  ((atom? (car l))
;                   (cond
;                     ((eq? (car l) a) (cdr l))
;                     (else (cons (car l)
;                                 (main (cdr l))))))
;                  (else (let
;                          ((ret (main (car l))))
;                          (cond
;                            ((eqlist? ret (car l))
;                             (cons (car l) (main (cdr l))))
;                            (else (cons ret (cdr l))))))))))
;       (main l))))

; (write (rember1* 'meat '((pasta meat) pasta (noodles meat sauce meat tomatoes))))

; (define depth*
;   (lambda (l)
;     (cond
;       ((null? l) 1)
;       (else
;         (let
;           ((d (depth* (cdr l))))
;           (cond
;             ((atom? (car l)) d)
;             (else (let
;                     ((a (add1 (depth* (car l)))))
;                     (cond
;                       ((o> d a) d)
;                       (else a))))))))))

; (define depth*
;   (lambda (l)
;     (cond
;       ((null? l) 1)
;       ((atom? (car l)) (depth* (cdr l)))
;       (else (let
;               ((a (add1 (depth* (car l))))
;                (d (depth* (cdr l))))
;               (if (o> d a) d a))))))

(define max
  (lambda (n m)
    (if (o> n m) n m)))

; (define depth*
;   (lambda (l)
;     (cond
;       ((null? l) 1)
;       ((atom? (car l)) (depth* (cdr l)))
;       (else (max (add1 (depth* (car l)))
;                  (depth* (cdr l)))))))

; (write (depth* '((pickled) peppers (peppers pickled))))

(define scramble
  (letrec
    ((scramble-b
       (lambda (tup rev-pre)
         (cond
           ((null? tup) '())
           (else (let
                   ((a (cons (car tup) rev-pre)))
                   (cons (pick (car tup) a)
                         (scramble-b (cdr tup) a))))))))
    (lambda (tup)
      (scramble-b tup '()))))

; (write (scramble '(1 1 1 3 4 2 1 1 9 2)))

; (define leftmost
;   (lambda (lat)
;     (cond
;       ((null? lat) '())
;       ((atom? (car lat)) (car lat))
;       (else (let
;               ((ret (leftmost (car lat))))
;               (cond
;                 ((atom? ret) ret)
;                 (else (leftmost (cdr lat)))))))))

(define leftmost
  (lambda (l)
    (let/cc
      skip
      (letrec
        ((lm (lambda (l)
               (cond
                 ((null? l) '())
                 ((atom? (car l)) (skip (car l)))
                 (else (let ()
                         (lm (car l))
                         (lm (cdr l))))))))
        (lm l)))))

; (write (leftmost '((() a) ())))
; (write (leftmost '(((a)) b (c))))

(define rember1*
  (lambda (a l)
    (letrec
      ((rm (lambda (a l oh)
             (cond
               ((null? l) (oh 'no))
               ((atom? (car l))
                (if (eq? (car l) a)
                  (cdr l)
                  (cons (car l)
                        (rm a (cdr l) oh))))
               (else (try oh2
                         (cons (rm a (car l) oh2) (cdr l))
                         (cons (car l) (rm a (cdr l) oh))))))))
      (try oh (rm a l oh) l))))

; (write (rm 'fuck '((pasta meat) pasta (noodles meat sauce meat tomatoes))
;            (lambda (x) x)))

; (write (rember1* 'noodles '((food) more (food))))

; 15. The Difference Between Men and Boys.
;; Use (set! ...) only with names defined in (let ...)s.
;; Use (set! ...) only when the value that x refers to is no longer needed.
;; Use (set! x ...) for (let ((x ...)) ...) only there is
;;; at least one (lambda ...) between it and the (let ((x ...)) ...). 

(define x
  (cons 'chicago
        (cons 'pizza '())))

; (write x)

(set! x 'gone)

; (write x)

(set! x 'skins)

; (write x)

(define gourmet
  (lambda (food)
    (cons food
          (cons x '()))))

(define y (gourmet 'onion))

; (write y)

(set! x 'rings)

; (write (build y (gourmet 'onion)))

(define gourmand
  (lambda (food)
    (set! x food)
    (cons food
          (cons x '()))))

; (write (build (gourmand 'potato) x))

(define dinerR
  (lambda (food)
    (set! x food)
    (cons 'milkshake
          (cons food '()))))

; (write (build x (dinerR 'potato)))

(dinerR 'onion)


(define omnivore
  (let ([x 'minestrone])
    (lambda (food)
      (set! x food)
      (cons food (cons x '())))))

; (write (omnivore 'bouillabaisse))

(define gobbler
  (let ([x 'minestrone])
    (lambda (food)
      (set! x food)
      (cons food (cons x '())))))

; (write (gobbler 'gumbo))

(define nibbler
  (lambda (food)
    (let ((x  'donut))
      (set! x food)
      (cons food (cons x '())))))

(nibbler 'cheerio)

(define food 'none)

(define glutton
  (lambda (x)
    (set! food x)
    (cons 'more (cons x (cons 'more (cons x '()))))))

; (write (glutton 'onion))

(glutton 'garlic)

(define chez-nous
  (let ([tmp food])
    (lambda ()
      (set! food x)
      (set! x tmp))))

(chez-nous)

; 16. Ready, Set ,Bang!
;; Use (set! ...) to remember valuable things between two
;;; distinct uses of a function.
;; Use (set! x ...) for (let ((x ...)) ...) only if there
;;; is one (lambda ... between it and the (let ...), or
;;; if value for x is a function that refers to x.

; (write (build food x))

; (write (build food x))

(define sweet-tooth
  (lambda (food)
    (cons food (cons 'cake '()))))

(define last 'angelfood)

(define sweet-toothL
  (lambda (food)
    (set! last food)
    (cons food (cons 'cake '()))))

(sweet-toothL 'chocolate)

(sweet-toothL 'fruit)

(sweet-toothL 'cheese)

(sweet-toothL 'carrot)

; (write last)

(define ingredients '())

(define sweet-toothR
  (lambda (food)
    (set! ingredients (cons food ingredients))
    (cons food (cons 'cake '()))))

(sweet-toothR 'chocolate)

(sweet-toothR 'fruit)

(sweet-toothR 'cheese)

(sweet-toothR 'carrot)

; (write ingredients)

; (define deep
;   (lambda (n)
;     (if (zero? n) 'pizza
;       (cons (deep (sub1 n)) '()))))
; 
; (write (deep 7))
; 
; (define Rs '())
; 
; (define Ns '())
; 
; (define deepR
;   (lambda (n)
;     (let ([result (deep n)])
;       (set! Rs (cons result Rs))
;       (set! Ns (cons n Ns))
;       result)))
; 
; (deepR 3)
; 
; (deepR 5)

; (deepR 3)

; (write (build Rs Ns))

; (define find
;   (lambda (n Ns Rs)
;     (letrec
;       ([main (lambda (Ns Rs)
;                (cond
;                  ((o= n (car Ns)) (car Rs))
;                  (else (main (cdr Ns) (cdr Rs)))))])
;       (main Ns Rs))))

; (write (find 3 Ns Rs))

; (define deepM
;   (lambda (n)
;     (if (member? n Ns) (find n Ns Rs)
;       (let ([result (deep n)])
;         (set! Rs (cons result Rs))
;         (set! Ns (cons n Ns))
;         result))))

; (define deep
;   (lambda (n)
;     (if (zero? n) 'pizza
;       (cons (deepM (sub1 n)) '()))))
; 
; (write (build (deepM 9) (build Ns Rs)))

; (define deepM
;   (let ([Rs '()]
;         [Ns '()])
;     (lambda (n)
;       (if (member? n Ns) (find n Ns Rs)
;         (let ([result (deep n)])
;           (set! Rs (cons result Rs))
;           (set! Ns (cons n Ns))
;           result)))))

(define find
  (lambda (n Ns Rs)
    (letrec
      ([main (lambda (Ns Rs)
               (cond
                 ((null? Ns) #f)
                 ((o= n (car Ns)) (car Rs))
                 (else (main (cdr Ns) (cdr Rs)))))])
      (main Ns Rs))))

; (define deepM
;   (let ([Rs '()]
;         [Ns '()])
;     (lambda (n)
;       (let ([exsit (find n Ns Rs)])
;         (if (atom? exsit)
;           (let ([result (deep n)])
;             (set! Rs (cons result Rs))
;             (set! Ns (cons n Ns))
;             result)
;           (find n Ns Rs))))))

; (write (deepM 16))

; (define length
;   (let ((h (lambda (l) 0)))
;     (set! h (lambda (l)
;               (cond
;                 ((null? l) 0)
;                 (else (add1 (h (cdr l)))))))
;     h))

(define L
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l))))))))

; (define length
;   (let ([h (lambda (l) 0)])
;     (set! h (L (lambda (args) (h args))))
;     h))

; (write (length '(1 2 3)))

(define Y!
  (lambda (L)
    (let ([h (lambda (l) 0)])
      (set! h (L (lambda (args) (h args)))) 
      h)))

; (write ((Y! L) '(1 2 3)))

(define Y-bang
  (lambda (f)
    (letrec
      ([h (f (lambda (x) (h x)))])
      h)))

; (write ((Y-bang L)'(1 2 3)))

(define length (Y! L))

; (write (length '(1 2 3)))

(define D
  (lambda (depth*)
    (lambda (l)
      (cond
        ((null? l) 1)
        ((atom? (car l)) (depth* (cdr l)))
        (else (max (add1 (depth* (car l)))
                   (depth* (cdr l))))))))

(define depth* (Y! D))

; (write (depth* '((pickled) peppers (peppers pickled))))

(define biz
  (let ([x 0])
    (lambda (f)
      (set! x (add1 x))
      (write x)
      (newline)
      (lambda (a)
        (if (o= a x)
          0
          (f a))))))

; (write ((Y biz) 5))
; ((Y-bang biz) 1)

; (define test
;   (let ([x '()])
;     (lambda (n)
;       (if (zero? n) (length x)
;         (let ()
;           (set! x (cons 'fuck x))
;           (test (sub1 n)))))))
; 
; (write (test 3))

; 17. We Change, Therefore We Are! 
;; (define f
;;   (let ([x y])
;;     ((lambda ()
;;        ()))))
;;
;; is equal to
;;
;; (define x y)
;; (define f
;;   (lambda ()
;;        ()))
;;
;; but we couldn't see x outside f.

; (define deepM
;   (let ([Rs '()]
;         [Ns '()])
;     (lambda (n)
;       (let ([exsit (find n Ns Rs)])
;         (if (atom? exsit)
;           (let ([result (let ([m 0])
;                           (if (zero? m)
;                             'pizza
;                             (cons (deepM (sub1 m)) '())))])
;             (set! Rs (cons result Rs))
;             (set! Ns (cons n Ns))
;             result)
;           exsit)))))

; (define deepM
;   (let ([Rs '()]
;         [Ns '()])
;     (lambda (n)
;       (let ([exsit (find n Ns Rs)])
;         (if (atom? exsit)
;           (let ([result (if (zero? n)
;                           'pizza
;                           (cons (deepM (sub1 n)) '()))])
;             (set! Rs (cons result Rs))
;             (set! Ns (cons n Ns))
;             result)
;           exsit)))))

; (write (deepM 6))

; (define consC
;   (let ([N 0])
;     (lambda (x y)
;     (set! N (add1 N))
;     (cons x y))))

; (define deep
;   (lambda (m)
;     (if (zero? m)
;       'pizza
;       (consC (deep (sub1 m))
;              '()))))
; 
; (define counter 0)

; (define consC
;   (let ([N 0])
;     (set! counter
;       (lambda () N))
;     (lambda (x y)
;       (set! N (add1 N))
;       (cons x y))))

; (deep 5) 

; (define test
;   (let* ([a 1]
;         [b a])
;     (cons a b)))

; (write test)

; (deep 7)

; (write (counter))

(define supercounter
  (lambda (f)
    (letrec
      ([S (lambda (n)
            (if (zero? n)
              (f n)
              (let ()
                (f n)
                (S (sub1 n)))))])
      (S 1000)
      counter)))

(define counter 'fuck)

(define set-counter 0)

(define consC
  (let ([N 0])
    (set! counter
      (lambda ()
        N))
    (set! set-counter
      (lambda (x)
        (set! N x)))
    (lambda (x y)
      (set! N (add1 N))
      (cons x y))))

(define deep
  (lambda (m)
    (if (zero? m)
      'pizza
      (consC (deep (sub1 m))
             '()))))

(deep 5)

(deep 7)

(set-counter 0)

(supercounter deep)

(define get-Rs 0)

(define deepM
  (let ([Rs '()]
        [Ns '()])
    (set! get-Rs (lambda () Rs))
    (lambda (n)
      (let ([exsit (find n Ns Rs)])
        (if (atom? exsit)
          (let ([result (if (zero? n)
                          'pizza
                          (consC (deepM (sub1 n)) '()))])
            (set! Rs (cons result Rs))
            (set! Ns (cons n Ns))
            result)
          exsit)))))

(set-counter 0)

(deepM 5)

(deepM 7)

; (supercounter deepM)

; (print (counter))

(define rember1*C
  (lambda (a l)
    (letrec
      ((rm (lambda (a l oh)
             (cond
               ((null? l) (oh 'no))
               ((atom? (car l))
                (if (eq? (car l) a)
                  (cdr l)
                  (consC (car l)
                        (rm a (cdr l) oh))))
               (else (try oh2
                         (consC (rm a (car l) oh2) (cdr l))
                         (consC (car l) (rm a (cdr l) oh))))))))
      (try oh (rm a l oh) l))))

(set-counter 0)

; (write (build (rember1*C 'noodles '((food) more (food)))
;               (counter)))

(define rember1*C2
  (lambda (a l)
    (letrec
      ((main (lambda (l) 
               (cond
                 ((null? l) '())
                 ((atom? (car l))
                  (cond
                    ((eq? (car l) a) (cdr l))
                    (else (consC (car l)
                                (main (cdr l))))))
                 (else (let
                         ((ret (main (car l))))
                         (cond
                           ((eqlist? (car l) ret)
                            (consC (car l)
                                   (main (cdr l))))
                           (else (consC ret
                                        (cdr l))))))))))
      (main l))))

; (require racket/trace)
; (trace rember1*C2)
; (trace eqlist?)
; (trace consC)

(set-counter 0)

(rember1*C2 'noodles '((food) more (food)))

; (write (counter))

(set-counter 0)

(consC (consC 'food '())
       (consC 'more
              (consC (consC 'food '())
                     '())))
; (write (counter))

; 18. We Change, Therefore. We Are the Same.
;; I understand why function is value, again, shockly!!!
;;; from the example of cons's shadow.
;; In Scheme, beware of the references, see "long" example.

(require scheme/mpair)

; (define kons mcons)
; 
; (define kar mcar)
; 
; (define kdr mcdr)
; 
; (define set-kdr set-mcdr!)

(define kounter 0)

(define set-kounter 0)

(define konsC
  (let ([N 0])
    (set! kounter
      (lambda () N))
    (set! set-kounter
      (lambda (x)
        (set! N x)))
    (lambda (a b)
      (set! N (add1 N))
      (kons a b))))


(define lots
  (lambda (m)
    (cond
      ((zero? m) '())
      (else (konsC 'egg
                  (lots (sub1 m)))))))

(define lenkth
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (lenkth (kdr l)))))))

; (write (lenkth (lots 5)))

(define add-at-end
  (lambda (l)
    (cond
      ((null? (kdr l))
       (konsC (kar l)
              (konsC 'egg '())))
      (else (konsC (kar l)
                  (add-at-end (kdr l)))))))

; (write (build (add-at-end (lots 3)) (kounter)))

(define add-at-end-too
  (lambda (l)
    (letrec
      ([A (lambda (ls)
            (cond
              ((null? (kdr ls))
               (set-kdr ls
                        (konsC 'egg '())))
              (else (A (kdr ls)))))])
      (A l)
      l)))

(set-kounter 0)

; (write (build (add-at-end-too (lots 3)) (kounter)))

; (define kons
;   (lambda (kar kdr)
;     (lambda (selector)
;       (selector kar kdr))))
; 
; (define kar
;   (lambda (c)
;     (c (lambda (a d) a))))
; 
; (define kdr
;   (lambda (c)
;     (c (lambda (a d) d))))

(define bons
  (lambda (kar)
    (let ([kdr '()])
      (lambda (selector)
        (selector
          (lambda (x) (set! kdr x))
          kar
          kdr)))))

(define kar
  (lambda (c)
    (c (lambda (s a d) a))))

(define kdr
  (lambda (c)
    (c (lambda (s a d) d))))

(define set-kdr
  (lambda (c x)
    ((c (lambda (s a d) s)) x)))

(define kons
  (lambda (a d)
    (let ([c (bons a)])
      (set-kdr c d)
      c)))

; (define test (kons 'egg (kons 'egg '())))
; (set-kdr test (kons 'cake '()))
; (write (kar (kdr test)))

; (set-kounter 0)
; (define test (lots 3))
; (add-at-end-too test)
; (write (kounter))

(set-kounter 0)
(define dozen (lots 12))
(define bakers-dozen (add-at-end dozen))
(define bakers-dozen-too (add-at-end-too dozen))
(define bakers-dozen-again (add-at-end dozen))
; (write (kounter))

(define eklist?
  (lambda (ls1 ls2)
    (cond
      ((null? ls1) (null? ls2))
      ((null? ls2) #f)
      (else
        (and (eq? (kar ls1) (kar ls2))
             (eklist? (kdr ls1) (kdr ls2)))))))

; (write (eklist? bakers-dozen bakers-dozen-too))

(define same?
  (lambda (c1 c2)
    (let ([t1 (kdr c1)]
          [t2 (kdr c2)])
      (set-kdr c1 1)
      (set-kdr c2 2)
      (let ([v (o= (kdr c1) (kdr c2))])
        (set-kdr c1 t1)
        (set-kdr c2 t2)
        v))))

; (write (same? bakers-dozen bakers-dozen-too))

(define last-kons
  (lambda (ls)
    (cond
      ((null? (kdr ls)) ls)
      (else (last-kons (kdr ls))))))

(define long (lots 12))
; (set-kdr (last-kons long) long)
(set-kdr (last-kons long) (kdr long))
; (write (lenkth long))

(define finite-length
  (lambda (p)
    (let/cc
      infinite
      (letrec ([C (lambda (p q)
                    (cond
                      ((same? p q)
                       (infinite #f))
                      ((null? q) 0)
                      ((null? (kdr q)) 1)
                      (else
                        (o+ (C (sl p) (qk q))
                            2))))]
               [qk (lambda (x) (kdr (kdr x)))]
               [sl (lambda (x) (kdr x))])
        (cond
          ((null? p) 0)
          (else (add1 (C p (kdr p)))))))))


; (write (finite-length long))

; (define from-kons
;   (lambda l
;     (if (null? l) '()
;       (cons (kar l) (from-kons (kdr l))))))
; 
; (write (from-kons (lots 3)))

; 19. Absconding with the Jewels.

; (define deep
;   (lambda (m)
;     (cond
;       ((zero? m) 'pizza)
;       (else (cons (deep (sub1 m)) '())))))

; (write (deep 6))

(define toppings 0)

(define deepB
  (lambda (m)
    (cond
      ((zero? m)
       (let/cc
         jump
         (set! toppings jump)
         'pizza))
      (else (cons (deepB (sub1 m))
                  '())))))

; (write (deepB 1))

; (write (toppings 'haha))

; (write (cons (toppings 'cake) '()))

; (write (cons (cons (toppings 'cake) (toppings 'cake))
;             (toppings 'cake)))

; (write (cons '() (cons '() (cons '() (cons (toppings 'cake) '())))))

(define deep-coB
  (lambda (m col)
    (cond
      ((zero? m)
       (let ()
         (set! toppings
           (lambda (x) (col x)))
         (col 'pizza)))
      (else (deep-coB (sub1 m)
                      (lambda (x)
                        (cons (col x) '())))))))

; (write (deep-coB 2 (lambda (x) x)))
; 
; (write (cons (toppings 'cake) (toppings 'cake)))

; (define leave 0)
; 
; (define walk
;   (lambda (l)
;     (cond
;       ((null? l) '())
;       ((atom? (car l))
;        (leave (car l)))
;       (else
;         (let ()
;           (walk (car l))
;           (walk (cdr l)))))))
; 
; (define start-it
;   (lambda (l)
;     (let/cc
;       here
;       (set! leave here)
;       (walk l))))

; (define list4 '((potato) (chips (chips (with))) fish))

; (write (start-it list4))

; (define fill 0)
; 
; (define waddle
;   (lambda (l)
;     (cond
;       ((null? l) '())
;       ((atom? (car l))
;        (let()
;          (let/cc
;            rest
;            (set! fill rest)
;            (leave (car l)))
;          (waddle (cdr l))))
;       (else
;         (let ()
;           (waddle (car l))
;           (waddle (cdr l)))))))

; (define start-it2
;   (lambda (l)
;     (let/cc
;       here
;       (set! leave here)
;       (waddle l))))
; 
; (define list5 '((donuts) (cheerios (cheerios (spaghettios))) donuts))
; 
; (define fuck (start-it2 list5))
; 
; (define list6 '(() (cheerios (cheerios (spaghettios))) donuts))
; 
; (define rest1
;   (lambda (x)
;     (waddle list6)))
; 
; (define get-next
;   (lambda (x)
;     (let/cc
;       here-again
;       (set! leave here-again)
;       (fill 'go)
;       (leave '()))))

; (set! fuck (get-next 'go))
; (set! fuck (get-next 'go))
; (set! fuck (get-next 'go))
; (set! fuck (get-next 'go))
; (write (get-next 'go))

; (define get-first
;   (lambda (l)
;     (let/cc
;       here
;       (set! leave here)
;       (waddle l)
;       (leave '()))))

; (write (get-first list5))

; (define two-in-a-row*?
;   (lambda (l)
;     (let
;       ((fst (get-first l)))
;       (if (atom? fst)
;         (two-in-a-row-b*? fst)
;         #f))))

; (define two-in-a-row-b*?
;   (lambda (x)
;     (let
;       ((y (get-next 'go)))
;       (if (atom? y)
;         (or (eq? x y)
;             (two-in-a-row-b*? y))
;         #f))))

(define list6 '(fish (chips) chips))

; (write (get-first list6))
; (write (get-next 'go))
; (write (get-next 'go))

; (write (two-in-a-row*? list6))

(define two-in-a-row*?
  (lambda (l)
    (letrec
      ([fill (lambda (x) x)]
       [leave (lambda (x) x)]
       [two-in-a-row-b*?
         (lambda (x)
           (let
             ((y (get-next 'go)))
             (if (atom? y)
               (or (eq? x y)
                   (two-in-a-row-b*? y))
               #f)))]
       [get-first
         (lambda (l)
           (let/cc
             here
             (set! leave here)
             (waddle l)
             (leave '())))]
       [get-next
         (lambda (x)
           (let/cc
             here-again
             (set! leave here-again)
             (fill 'go)
             (leave '())))]
       [waddle
         (lambda (l)
           (cond
             ((null? l) '())
             ((atom? (car l))
              (let()
                (let/cc
                  rest
                  (set! fill rest)
                  (leave (car l)))
                (waddle (cdr l))))
             (else
               (let ()
                 (waddle (car l))
                 (waddle (cdr l))))))])
      (let
        ((fst (get-first l)))
        (if (atom? fst)
          (two-in-a-row-b*? fst)
          #f)))))

; (write (two-in-a-row*? list6))

; (define test
;   (lambda (x)
;     (let ([n '()])
;       (set! n (cons '() n))
;       (if (zero? x) n (test (sub1 x))))))
; 
; (write (test 3))
; (write (test 3))

; (define test
;   (let ([n '()])
;     (lambda (x)
;       (set! n (cons '() n))
;       (if (zero? x) n (test (sub1 x))))))
; 
; (write (test 3))
; (write (test 3))
; (write ((Y! L)'(1 2 3)))

; 20. What's in Store?

(define the-empty-table
  (lambda (name)
    (abort
      (cons '(no-answer)
            (cons name '())))))

(define lookup
  (lambda (table name)
    (table name)))

(define extend
  (lambda (name1 value table)
    (lambda (name2)
      (cond
        ((eq? name2 name1) value)
        (else (table name2))))))

(define value
  (lambda (e) 
    (let/cc the-end
            (set! abort the-end)
            (cond
              ((define? e) (*define e))
              (else (the-meaning e))))))

(define define?
  (lambda (e)
    (cond
      ((atom? e) #f)
      ((atom? (car e))
       (eq? (car e) 'define))
      (else #f))))

(define global-table
  the-empty-table)

(define *define
  (lambda (e)
    (set! global-table
      (extend
        (name-of e)
        (box
          (the-meaning
            (right-side-of e)))
        global-table))))

(define box
  (lambda (it)
    (lambda (sel)
      (sel it
           (lambda (new)
             (set! it new))))))

(define setbox
  (lambda (box new)
    (box (lambda (it set) (set new)))))

(define unbox
  (lambda (box)
    (box (lambda (it set) it))))

(define the-meaning
  (lambda (e)
    (meaning e lookup-in-global-table)))

(define lookup-in-global-table
  (lambda (name)
    (lookup global-table name)))

(define meaning
  (lambda (e table)
    ((expression-to-action e)
     e table)))

(define *quote
  (lambda (e table)
    (text-of e)))

(define *set
  (lambda (e table)
    (setbox (lookup table (name-of e))
            (right-side-of e))))

(define *identifier
  (lambda (e table)
    (unbox (lookup table e))))

(define *lambda
  (lambda (e table)
    (lambda (args)
      (beglis
        (body-of e)
        (multi-extend
          (formals-of e)
          (box-all args)
          table)))))

(define beglis
  (lambda (es table)
    (cond
      ((null? (cdr es))
       (meaning (car es) table))
      (else ((lambda (val)
               (beglis (cdr es) table))
             (meaning (car es) table))))))

(define box-all
  (lambda (vals)
    (cond
      ((null? vals) '())
      (else (cons (box (car vals))
                  (box-all (cdr vals)))))))

(define multi-extend
  (lambda (ks vs table)
    (cond
      ((null? ks) table)
      (else (extend (car ks)
                    (car vs)
                    (multi-extend (cdr ks)
                                  (cdr vs)
                                  table))))))

(define oodd?
  (lambda (n)
    (cond
      ((zero? n) #f)
      (else (oeven? (sub1 n))))))

(define oeven?
  (lambda (n)
    (cond
      ((zero? n) #t)
      (else (oodd? (sub1 n))))))

(define *application
  (lambda (e table)
    ((meaning (function-of e) table)
     (evlis (arguments-of e) table))))

(define evlis
  (lambda (args table)
    (cond
      ((null? args) '())
      (else
        ((lambda (val)
           (cons val
                 (evlis (cdr args) table)))
         (meaning (car args) table))))))

(define :car
  (lambda (args-in-a-list)
    (car (car args-in-a-list))))

(define a-prim
  (lambda (p)
    (lambda (args-in-a-list)
      (p (car args-in-a-list)))))

(define b-prim
  (lambda (p)
    (lambda (args-in-a-list)
      (p (car args-in-a-list)
         (car (cdr args-in-a-list))))))

(define *const
  (let ([:cons (b-prim cons)]
        [:car (a-prim car)]
        [:cdr (a-prim cdr)]
        [:eq? (b-prim eq?)]
        [:atom? (a-prim atom?)]
        [:null? (a-prim null?)]
        [:zero? (a-prim zero?)]
        [:add1 (a-prim add1)]
        [:sub1 (a-prim sub1)]
        [:number? (a-prim number?)])
    (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      ((eq? e 'cons) :cons)
      ((eq? e 'car) :car)
      ((eq? e 'cdr) :cdr)
      ((eq? e 'eq?) :eq?)
      ((eq? e 'atom?) :atom?)
      ((eq? e 'null?) :null?)
      ((eq? e 'zero?) :zero?)
      ((eq? e 'add1) :add1)
      ((eq? e 'sub1) :sub1)
      ((eq? e 'number?) :number?)))))

(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))

(define evcon
  (lambda (lines table)
    (cond
      ((else? (question-of (car lines)))
       (meaning (answer-of (car lines))
                table))
      ((meaning (question-of (car lines))
                table)
       (meaning (answer-of (car lines))
                table))
      (else (evcon (cdr lines) table)))))

(define *letcc
  (lambda (e table)
    (let/cc skip
            (beglis (ccbody-of e)
                    (extend
                      (name-of e)
                      (box (a-prim skip))
                      table)))))

(define abort 0)

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
      ((eq? e 'cons) *const)
      ((eq? e 'car) *const)
      ((eq? e 'cdr) *const)
      ((eq? e 'null?) *const)
      ((eq? e 'eq?) *const)
      ((eq? e 'atom?) *const)
      ((eq? e 'zero?) *const)
      ((eq? e 'add1) *const)
      ((eq? e 'sub1) *const)
      ((eq? e 'number?) *const)
      (else *identifier))))

(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (let ([h (car e)])
         (cond
           ((eq? h 'quote) *quote)
           ((eq? h 'lambda) *lambda)
           ((eq? h 'letcc) *letcc)
           ((eq? h 'set!) *set)
           ((eq? h 'cond) *cond)
           (else *application))))
      (else *application))))

(define text-of
  (lambda (x)
    (car (cdr x))))

(define formals-of
  (lambda (x)
    (car (cdr x))))

(define body-of
  (lambda (x)
    (cdr (cdr x))))

(define ccbody-of
  (lambda (x)
    (cdr (cdr x))))

(define name-of
  (lambda (x)
    (car (cdr x))))

(define right-side-of
  (lambda (x)
    (cond
      ((null? (cdr (cdr x))) 0)
      (else (car (cdr (cdr x)))))))

(define cond-lines-of
  (lambda (x)
    (cdr x)))

(define else?
  (lambda (x)
    (cond
      ((atom? x) (eq? x 'else))
      (else #f))))

(define question-of
  (lambda (x)
    (car x)))

(define answer-of
  (lambda (x)
    (car (cdr x))))

(define function-of
  (lambda (x)
    (car x)))

(define arguments-of
  (lambda (x)
    (cdr x)))

; (write (value '()))

; (write (value '(((lambda (le)
;                    ((lambda (mk-length)
;                       (mk-length mk-length))
;                     (lambda (mk-length)
;                       (le (lambda (x)
;                             ((mk-length mk-length) x))))))
;                  (lambda (length)
;                    (lambda (l)
;                      (cond
;                        ((null? l) 0)
;                        (else (add1 (length (cdr l)))))))) (quote (apple 1 2 3 fuck you)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The Reasoned Schemer ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;


