(define CrossingField
  (let ((key (area F F))
        (i 1 (d 7) 1 2 (d 6) , (d 5 6) 1 (d 7) 1 2 )
        (ii (d 6 , 6) 1 5 1 , (d 7 6 5))
        (iii 5 5 1 1 2 1 , (d 7) 1 2)
        (iv 3 1 2 1 (d 5 6) 1 , (d 4) 1 2 1 2 3 4 , 2 1 2 1 2 5 4 , 2 3 1 2)
        (v 1 2 3 5 , 4 3 , 6 5 , 3 4 3 2 4 3 , 2 3 , 2 3 , 2 3)
        (vi 2 3 4 3 6 3)
        (vii 2 5 4 3 6 2 , 1 2 1 5 3 , 4 3 2 2 3 (d 6))
        (viii 3 3 3 , 3 2 1 (d 5) 3 2 (d 7 5) , (d 6 , 6 , 6))
        (ix (b 5 4 3 5 (u 1) 7 6 5 , 3 (u 1) 7 5 3 6 , 5 6 , 7) 1 , 2 3
            1 2 3 2 5 3)
        (x (i
             ii
             i
             iii
             iv
             v
             vi
             v
             vii
             viii)))
    (play x
          x
          ix
          v
          vi
          v
          vii
          vii
          viii)))
