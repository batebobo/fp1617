#Решения
В този файл ще използвам следната сигнатура на accumulate:
**(accumulate operation null-value term a next b)**  
**Задача 1.** Да се дефинира процедура, която намира биномния коефициент 
C<sup>m</sup><sub>n</sub>

```Scheme
(define (binominal-coefficient n k)
    (/
        (accumulate * 1 (lambda (x) x) n (lambda (x) (- x 1)) (+ (- n k) 1))
        (fact k)))
;Или

(define (binominal-coefficient n k)
    (/ (fact n)
       (* (fact k) (fact (- n k)))))
```

**Задача 2.** Да се дефинира процедура, която проверява дали цифрите на
дадено число са наредени в намаляващ ред.
Например - 765432, 4321, 921 са такива числа.

```Scheme
(define (desc-order? number)
    (if (< number 10)
        #t
        (and
            (< (remainder number 10)
               (remainder (quotient number 10) 10))
            (desc-order? (quotient number 10)))))
```

**Задача 3.** Да се дефинира процедура found, която проверява дали 
съществува елемент от редицата
f(0), f(1), ..., f(n), който е в релация с даден елемент х.
Използвайте следната сигнатура:
```Scheme
;(found? f a next b rel x)
(define (found? f a next b rel x)
    (cond ((> a b) #f)
          ((rel (f a) x) #t)
          (else (found? f (next a) next b rel x))))
```
Тук а и b указват начало и край на интервал, next е стъпката, с която
увеличаваме а.

**Задача 4.** Да се дефинира процедура, която установява дали
съществува елемент от серията числа  
**i<sup>2</sup> + 3*i*n + n<sup>2</sup>**, i = 1,2,...,n,
който да е кратен на дадено число х.
Използвайте следната сигнатура:
```Scheme
;(divis? n x)
(define (divis? n x)
    (define (rel a b)
        (= (remainder a b) 0))
    (define (f i)
        (+ (expt i 2) (* 3 i n) (expt n 2)))
    
    (found? f 1 (lambda (x) (+ x 1)) n rel x))
```

**Задача 5.** Нека са дадени естествено число n и номер на цифра k. Да се напише процедура,
която намира числото, получено като се задраска k-тата цифра на n.

```Scheme
(define (cross-out n k)
  (define (cross-iter n k i)
    (if (< n 1)
        0
        (if (= i k)
            (cross-iter (quotient n 10) (- k 1) i)
            (+ (* (remainder n 10) (expt 10 i)) 
               (cross-iter (quotient n 10) k (+ i 1))))))
  (cross-iter n k 0))
```

**Задача 6.** Да се напише процедура, която проверява дали всички цифри на
дадено естествено число са различни.

```Scheme
(define (different-digits? n)
  (define (contains-digit? n d)
    (if (< n 1) #f
        (if (= (remainder n 10) d)
            #t
            (contains-digit? (quotient n 10) d))))
  (define (helper n temp i)
    (cond ((< n 1) #t)
          ((and (= temp 0) (> i 1)) #f) ; Ако сме минали през > 1 цифри на оригиналното число, а в temp се съдържа числото 0, значи оригиналното ни число съдържа > 1 нули в края си => #f
          ((contains-digit? temp (remainder n 10)) #f)
          (else (helper (quotient n 10) (+ temp (* (remainder n 10) (expt 10 i))) (+ i 1)))))
  (helper n 0 0))

```

##Задачи за accumulate
Опитайте да решите следващите задачи единствено и само с accumulate.
Ще помогне да свикнете.  
**(accumulate operation null-value term a next b)**  

**Задача 7.** Да се напише функция (fact-accum n), която изчислява факториела на дадено естествено число.
```Scheme
(define (fact-accum n)
    (accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) n)))
```
**Задача 8.** Да се напише функция (expt-accum x n), която повдига числото x на степен n (n - естествено число).
```Scheme
(define (expt-accum x n)
    (accumulate * 1 (lambda (a) x) 1 (lambda (x) (+ x 1)) n))
```
**Задача 9.** Да се напише функция (func-sum f n), която намира сумата f(0) + f(1) + ... f(n) за дадена функция f и естествено число n.
```Scheme
(define (func-sum f n)
    (accumulate + 0 f 0 (lambda (x) (+ x 1)) n))
```