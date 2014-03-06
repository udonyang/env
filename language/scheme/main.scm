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

(define member?
  (lambda (a lat)
    (cond ((null? lat) #f)
      (else (or (eq? (car lat) a) 
        (member? a (cdr lat)))))))

; (write (member? 'eggs '(fried eggs and scrambled eggs)))

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
      (else (cons (car l) (rember s (cdr l)))))))

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

(define member?
  (lambda (a lat)
    (cond ((null? lat) #f)
      (else (or (equal? (car lat) a) 
        (member? a (cdr lat)))))))

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

(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) '())
      ((equal? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))))))

(define makeset
  (lambda (lat)
    (cond
      ((null? lat) '())
      (else (cons (car lat)
                  (makeset (multirember (car lat) (cdr lat))))))))

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

(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2)
       (cons (car set1) (intersect (cdr set1) set2)))
      (else (intersect (cdr set1) set2)))))

; (write (intersect '(stewed tomatoes and macaroni) '(macaroni and cheese)))

(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2) (union (cdr set1) set2))
      (else (cons (car set1) (union (cdr set1) set2))))))

; (write (union '(stewed tomatoes and macaroni) '(macaroni and cheese)))

(define difference
  (lambda (set1 set2)
    (cond
      ((null? set1) '())
      ((member? (car set1) set2) (difference (cdr set1) set2))
      (else (cons (car set1) (difference (cdr set1) set2))))))

; (write (difference '(stewed tomatoes and macaroni) '(macaroni and cheese)))

(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set)) (car l-set))
      (else (intersect (car l-set) (intersectall (cdr l-set)))))))

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

(define revrel
  (lambda (rel)
    (cond
      ((null? rel) '())
      (else (cons (build (second (car rel)) (first (car rel)))
                  (revrel (cdr rel)))))))

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

(define rember-f
  (lambda (test? a l)
    (cond
      ((null? l) '())
      ((test? a (car l)) (cdr l))
      (else (cons (car l) (rember-f (cdr l)))))))

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

(define rember
  (lambda (a l)
    ((insert-g (lambda (new old l) l)) #f a l)))

; (write (rember 'lettuce '(bacon lettuce and tomato)))

(define atom-to-function
  (lambda (x)
    (cond
      ((eq? '+ x) o+)
      ((eq? '* x) o*)
      (else o^))))

(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else ((atom-to-function (operator nexp))
             (value (first-sub-exp nexp))
             (value (second-sub-exp nexp)))))))

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

(define length*
  (lambda (lat)
    (cond
      ((null? lat) 0)
      ((atom? (car lat)) (add1 (length* (cdr lat))))
      (else (o+ (length* (car lat)) (length* (cdr lat)))))))

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
  (lambda (le)
    ((lambda (mk-length)
       (mk-length mk-length))
     (lambda (mk-length)
       (le (lambda (x)
             ((mk-length mk-length) x)))))))

; (write ((Y (lambda (length)
;             (lambda (l)
;               (cond
;                 ((null? l) 0)
;                 (else (add1 (length (cdr l)))))))) '(apple fuck you)))

; What is the Value of All of This

(define new-entry build)

(define names1 '(beverage dessert))
(define values1 '((food is) (number one with us)))
(define entry1 (new-entry names1 values1))

; (write entry1)

(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
      ((null? names) (entry-f name))
      ((eq? name (car names)) (car values))
      (else (lookup-in-entry-help
              name (cdr names) (cdr values) entry-f)))))
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help
      name
      (first entry)
      (second entry)
      entry-f)))

; (write (lookup-in-entry 'beverage entry1 (lambda (x) x)))

(define extend-table cons)

(define names2 '(appetizer entree beverage))
(define value2 '(pate boeuf vin))
(define entry2 (new-entry names2 value2))

(define table1 (extend-table entry1 (extend-table entry2 '())))

; (write table1)

(define lookup-in-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else (lookup-in-entry
              name (car table)
              (lambda (name)
                (lookup-in-table
                  name (cdr table)
                  table-f)))))))

; (write (lookup-in-table 'FUCK table1 (lambda (x) (cons x '(not found)))))

(define expreesion-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))

(define atom-to-action
  (lambda (e)
    (cond
      ((number? e) *const)
      ((eq? #t e) *const)
      ((eq? #f e) *const)
      ((eq? 'cons e) *const)
      ((eq? 'car e) *const)
      ((eq? 'cdr e) *const)
      ((eq? 'null? e) *const)
      ((eq? 'eq? e) *const)
      ((eq? 'atom? e) *const)
      ((eq? 'zero? e) *const)
      ((eq? 'add1 e) *const)
      ((eq? 'sub1 e) *const)
      ((eq? 'number? e) *const)
      (else *identifier))))

(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
       (cond
         ((eq? 'quote (car e)) *quote)
         ((eq? 'lambda (car e)) *lambda)
         ((eq? 'cond (car e)) *cond)
         (else *application)))
      (else *application))))

; (write (expreesion-to-action 'atom?))

(define value
  (lambda (e)
    (meaning e '())))

(define meaning
  (lambda (e table)
    ((expreesion-to-action e) e table)))

; (write (value '(quote (1 2))))

(define *const
  (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? #t e) #t)
      ((eq? #f e) #f)
      (else (build 'primitive e)))))

(define *quote
  (lambda (e table)
    (test-of e)))

(define test-of second)

(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))

(define initial-table
  (lambda (name)
    (car '())))

(define *lambda
  (lambda (e table)
    (build (quote non-primitive)
           (cons table (cdr e)))))

(define table-of first)
(define formals-of second)
(define body-of third)

(define third (lambda (l) (car (cdr (cdr l)))))

(define evcon
  (lambda (lines table)
    (cond
      ((else? (question-of (car lines)))
       (meaning (answer-of (car lines)) table))
      ((meaning (question-of (car lines)) table)
       (meaning (answer-of (car lines)) table))
      (else (evcon (cdr lines) table)))))
(define else?
  (lambda (x)
    (cond
      ((atom? x) (eq? x 'else))
      (else #f))))
(define question-of first)
(define answer-of second)
(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))
(define cond-lines-of cdr)

; (write (*cond '(cond (coffee klatsch) (else party))
;               '(((coffee) (#t)) ((klatsch party) (5 (6))))))

; (write (value '(cond (coffee klatsch) (else party))))

(define evlis
  (lambda (args table)
    (cond
      ((null? args) '())
      (else (cons (meaning (car args) table)
                  (evlis (cdr args) table))))))
(define :atom?
  (lambda (x)
    (cond
      ((atom? x) #t)
      ((null? x) #f)
      ((eq? (car x) 'primitive) #t)
      ((eq? (car x) 'non-primitive) #t)
      (else #f))))
(define apply-primitive
  (lambda (name vals)
    (cond
      ((eq? name 'cons)
       (cons (first vals) (second vals)))
      ((eq? name 'car)
       (car (first vals)))
      ((eq? name 'cdr)
       (cdr (first vals)))
      ((eq? name 'null?)
       (null? (first vals)))
      ((eq? name 'eq?)
       (eq? (first vals) (second vals)))
      ((eq? name 'atom?)
       (:atom? (first vals)))
      ((eq? name 'zero?)
       (zero? (first vals)))
      ((eq? name 'add1)
       (add1 (first vals)))
      ((eq? name 'sub1)
       (sub1 (first vals)))
      ((eq? name 'number?)
       (number? (first vals))))))
(define apply-closure
  (lambda (closure vals)
    (meaning (body-of closure)
             (extend-table (new-entry (formals-of closure) vals)
                           (table-of closure)))))
(define primitive?
  (lambda (l)
    (eq? 'primitive (first l))))
(define non-primitive?
  (lambda (l)
    (eq? 'non-primitive (first l))))
(define apply
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive (second fun) vals))
      ((non-primitive? fun)
       (apply-closure (second fun) vals))
      (else 'hehe))))
(define function-of car)
(define arguments-of cdr)
(define *application
  (lambda (e table)
    (apply
      (meaning (function-of e) table)
      (evlis (arguments-of e) table))))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Structure and Intepretation in ComputerPrograms;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
