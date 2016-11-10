#Решения

**Задача 1.** Дефинирайте процедура, която **изглажда** списък.

```Scheme
(define (flatten xs)
    (cond ((null? xs) '())
          ((list? (car xs)) (append (flatten (car xs)) (flatten (cdr xs))))
          (else (append (list (car xs)) (flatten (cdr xs))))))
          
;flatten '(1 3 ("wow" ("nesting") ("overload" 38 91)))) -> '(1 3 "wow" "nesting" "overload 38 91)
;(flatten '(1 2 3)) -> '(1 2 3)
;(flatten '(((3)))) -> '(3)
```

**Задача 2.** Дефинирайте процедура, която проверява дали **поне един** елемент от даден списък
изпълнява някакво условие.

```Scheme
(define (any? pred? xs)
    (cond ((null? xs) #f)
          ((pred? (car xs)) #t)
          (else (any? pred? (cdr xs)))))
          
;(any? odd? '(4 6 8 13 16)) -> #t
;(any? string? '(12 #f (lambda (x) (* x x)))) -> #f
```

**Задача 3.** Дефинирайте процедура, която проверява дали **всички** елементи от даден
списък изпълняват някакво условие.

```Scheme
(define (all? pred? xs)
    (cond ((null? xs) #t)
          ((not (pred? (car xs))) #f)
          (else (all? pred? (cdr xs)))))
          
;(all? even? '(12 16 18 40 166662)) -> #t
;(all? (lambda (x) (= (length x) 3)) '((1 2 3) (3 4 5) (3 2))) -> #f
```

**Задача 4.** Даден е списък от цели числа. Всички негови елементи, без един, са или само
четни или само нечетни. Дефинирайте процедура, която връща елементът, който не е със същата четност като останалите.

```Scheme
(define (remove-odd xs)
    (let ((even-numbers (filter even? xs))
         (odd-numbers (filter odd? xs)))
    (cond ((null? xs) '())
          ((= (length even-numbers) 1) (car even-numbers))
          (else (car odd-numbers)))))
          
;(remove-odd '(1 3 17 25 4 13 55)) -> 4
;(remove-odd '(-5 20 12 88 92)) -> -5

```

**Задача 5.** Дефинирайте процедура, която връща първите n елемента на даден списък.
```Scheme
(define (take n xs)
    (if (or (= n 0) (null? xs)) 
        '()
         (cons (car xs) (take (- n 1) (cdr xs)))))
         
;(take 3 '("irrelevant" "words" "whatever" "i'm sleepy")) -> '("irrelevant" "words" "whatever")
;(take 2 '(9 12 293 23)) -> '(9 12) 
```

**Задача 6.** Дефинирайте процедурата **take-while**, подобна на **take**, но с разликата, че
спираме да добавяме в новия списък, когато дадено условие не е изпълнено.

```Scheme
(define (take-while pred? xs)
    (if (or (null? xs) (not (pred? (car xs))))
        '()
        (cons (car xs) (take-while pred? (cdr xs)))))

;(take-while even? '(2 4 18 40 21 30 22)) -> '(2 4 18 40)
;(take-while (lambda (x) (= (string-length x) 3)) '("okg" "sdp" "fp")) -> '("okg" "sdp")
```

**Задачи 7 - 11 (here comes the fun part)** Дефинирайте процедури за работа с двоично дърво.

Като начален тласък ще се яви процедурата, която създава такова дърво, а именно:
```Scheme
(define (make-tree root left right)
    (list root left right))
```

Това ще рече, че за нас двоичните дървета ще означават списък от 3 неща:
+ корен на дървото
+ ляво поддърво (списък)
+ дясно поддърво (списък)

Идеята е същата като тази с рационалните числа - правим някаква абстракция
с вградени в езика структури (при рационалните числа беше pair, тук използваме list).

**Задача 7.** Дефинирайте процедури, които за дадено двоично дърво връщат:
+ Неговия корен (root tree)
+ Лявото му поддърво (left tree)
+ Дясното му поддърво (right tree)

```Scheme
;Както се разбрахме, за нас дърво означава списък от 3 елемента.
;Първият се явява корен, вторият - ляво поддърво, а третият - дясно поддърво
(define (root tree)
    (car tree))

(define (left-subtree tree)
    (cadr tree))
    
(define (right-subtree tree)
    (caddr tree))
```

**Задача 8.** Дефинирайте процедура, която проверява дали дадено двоично дърво е празно. (empty?)

```Scheme
(define (empty? tree)
    (null? tree))
```

**Задача 9.** Дефинирайте процедура, която проверява дали **x** е елемент на дадено двоично дърво.
(member-tree? tree x)

```Scheme
(define (member-tree? x tree)
    (cond ((empty? tree) #f)
          ((= x (root tree)) #t)
          (else (or
                    (member-tree? x (left-subtree tree))
                    (member-tree? x (right-subtree tree))))))
```

**Задача 10.** Дефинирайте процедура, която проверява дали дадено дърво е листо.
(leaf? tree)

```Scheme
(define (leaf? tree)
    (and (not (empty? tree))
         (and (empty? (left-subtree tree))
              (empty? (right-subtree tree)))))
```

**Задача 11.** Дефинирайте процедура, която проверява дали **х** е листо в дадено двоично дърво.
(member-leaf? tree x)

```Scheme
(define (member-leaf? x tree)
    (if (empty? tree)
        #f
        (if (and (= x (root tree))
                 (leaf? tree))
            #t
            (or (member-leaf? x (left-subtree tree))
                (member-leaf? x (right-subtree tree))))))
```