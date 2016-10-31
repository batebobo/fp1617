#Решения
Напишете процедура, която намира сумата на числа в даден интервал [a, b].  
```Scheme
; Същинска рекурентност
(define (interval-sum a b)
    (if (> a b)
        0
        (+ a (interval-sum (+ a 1) b))
    )
)

; Финална рекурентност
(define (interval-sum1 a b)
    (define (iter start end sum)
        (if (> start end)
            sum
            (iter (+ start 1) end (+ sum start))
        )
    )
    (iter a b 0))
``` 
Напишете процедура, която брои от колко цифри се състои едно число.
```Scheme
; Същинска рекурентност
(define (digits-in number)
    (if (< number 10)
        1
        (+ 1 (digits-in (quotient number 10)))
    )
)
        
; Финална рекурентност
(define (digits-in1 number)
    (define (iter n count)
        (if (< n 10)
            (+ count 1)
            (iter (quotient n 10) (+ count 1))
        )
    )
    (iter number 0))
```
Напишете процедура, която смята произведението от всички цифри на дадено число.
```Scheme
; Същинска рекурентност
(define (product-digits n)
    (if (< n 10)
        n
        (* (remainder n 10)
           (product-digits (quotient n 10))
        )
    )
)

; Финална рекурентност
(define (product-digits1 n)
    (define (iter n product)
        (if (< n 10)
            (* n product)
            (iter (quotient n 10) (* product (remainder n 10)))
        )
    )
    (iter n 1))
```
Напишете процедура, която обръша цифрите на дадено число.
```Scheme
(define (reverse-digits n)
    (define (helper number i)
        (if (< number 1)
            0
            (+ (* (remainder number 10) (expt 10 i))
                (helper (quotient number 10) (- i 1)))))
    (helper n (- (number-length n) 1)))
    
; Или

(define (reverse n)
    (if (< n 10) 
        n
        (+  (* (remainder n 10) (pow 10 (- (length n) 1))) 
            (reverse(quotient n 10)))))
```
Напишете процедура (предикат), която проверява дали едно число е палиндром.
```Scheme
(define (is-palindrome? number)
    (= number (reverse-digits number)))
```
Напишете процедура (предикат), която проверява дали дадено число е просто.
```Scheme
(define (prime? number)
    (define (helper n d)
        (cond ((> d (sqrt n)) #t)
              ((= (remainder n d) 0) #f)
              (else (helper n (+ d 1)))))
    (helper n 2))
    
; Или

(define (prime? number)
    (define (prime-loop n d)
        (if (= d 1) 
        #t
            (if (= (remainder n d) 0) 
                #f
                (prime-loop n (- d 1))
            )
        )
    )
(prime-loop number (quotient number 2))
```
