




(define (expt-acc x n)
    (accumulate * (lambda (s) x) 1 1 (lambda (x) (+ x 1)) n))
    
(accumulate * 1 p 1 (lambda (x) (+ x 1))
    (lambda (k)
      (accumulate + 0 k 0 (lambda (x) (+ x 2))
        (lambda (x)
            (* (expt (-1) k)
                (/
                    (expt x (* 2 k))
                    (fact (* k 2))))))))
                    
                 
                
        
 (define (found? term a next b rel x)
    (if (> a b) #f
        (if (rel (term a) x)
            #t
            (found term (next a) next b rel x))))
            
            
 (define (length x)
    (if (null? x)
        0
        (+ 1 (length (cdr x)))))
    ;(1 2 3 4 (5 6 8))
    
 (define (member? n x)
    (if (null? x)
        #f
        (if (= n (car x))
            #t
            (member? n (cdr x)))))
            
            
 (define (sum-all x)
    (if (null? x)
        0
        (+ (car x) (sum-all (cdr x)))))
        
        ;(1 2 3)   
        
 (define (map f x)
    (if (null? x)
        '()
        (cons (f (car x)) (map f (cdr x))))
        
 (define (filter pred? x)
    (if (null? x)
        '()
        (if (pred? (car x))
            (cons (car x) (filter pred? (cdr x)))
            (filter pred? (cdr x))))
    
    
 
    
    
    
    
    
            
