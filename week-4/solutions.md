#Решения
![Acc-2](http://i.imgur.com/CyBms7c.jpg)
**12)**
``` Scheme
(define (accumulate operation null-value term a next b)
    (if (> a b)
        null-value
        (op (term a) (accumulate operation null-value term (next a) next b))))

(define (weird-mul x p)
    (define (next a)
        (+ a 1))
        
    (define (inner-sum k)
        (define (term k)
            (* (expt (- 0 1) k)
               (/ (expt x (* k 2))
                  (fact (* 2 k))))) ; (-1)^k * (x^2k / (2k)!)
               
        (accumulate + 0 term 1 next k))
        
    (accumulate * 1 inner-sum 1 next p))
```

**Съединяване на списъци**
```Scheme
(define (append xs ys)
    (if (null? xs)
        ys
        (cons (car xs) (append (cdr xs) ys))))
```

**i-ти елемент на списък**
```Scheme
(define (list-ref xs i)
    (if (null? xs)
        (error "Index out of range")
        (if (= i 0)
            (car xs)
            (list-ref (cdr xs) (- i 1)))))
```

**Всички елементи на списък са числа!?**
```Scheme
(define (all-ints? xs)
    (if (null? xs)
        #t
        (if (not (integer? (car xs)))
            #f
            (all-ints? (cdr xs)))))
```

**Обръщане на списък**
```Scheme
(define (reverse xs)
    (if (null? xs)
        '()
        (append (reverse (cdr xs)) (list (car xs)))))
        
; Или

(define (reverse1 xs)
  (fold-right (lambda (x y) (append y (list x))) '() xs))
```

**Списък с думи -> Изречение**
```Scheme
(define (list->string words)
    (if (null? words)
        ""
        (string-append
            (string-append (car words) " ")
            (list->string (cdr words)))))
```