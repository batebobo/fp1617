##Задачи като за след втора седмица

Привет :) Радвам се, че голяма част от вас се бяха справили със задачите от
миналата седмица. Стискам палци засега всичко да е ясно, а ако не е - да
не се срамувате да питате.

Задачите, които ви оставям за следващата сряда са от първото контролно на 
Scheme преди 2 години. Първите две, предполагам, няма да ви се сторят сложни като
имплементация, но ви съветвам да обърнете внимание на второто подусловие.
На лекции все още не сте си говорили за оценяване на изрази, но това е важно и
понякога не е интуитивно. Когато стигнете до този материал, ще е хубаво
да се върнете и да пробвате новопридобитите си знания с б).

Утре вечер ще кача още малко задачи с подобна на тези тук сложност. Ще се старая
да отговарям в най-кратки срокове на каквито и да е въпроси.  
Успех със задачите :)
* * *
**Задача 1.** Дадено е естествено число n (n > 0).  
а) Да се напише процедура (num_even n), която намира броя на четните цифри в записа на n.  
б)  Да се оцени чрез модела на средите обръщението (num_even 65432).

```Scheme
(define (num_even n)
  (if (< n 1)
      0
      (if (even? n)
          (+ 1 (num_even (quotient n 10)))
          (num_even (quotient n 10)))))
```

**Задача 2.** Дадено е естествено число n (n > 0).  
а) Да се напише процедура (sum_odd n), която намира сумата на нечетните цифри в записа на n.  
б)  Да се оцени чрез модела на средите обръщението (sum_odd 54321).

```Scheme
(define (sum_odd n)
  (if (< n 1)
      0
      (if (odd? n)
          (+ (remainder n 10) (sum_odd (quotient n 10)))
          (sum_odd (quotient n 10)))))
```

**Задача 3.**  Да се напише процедура, която намира sin(x) по дадената формула.
Пресмятането да продължи докато последното добавено събираемо по модул стане по-малко от e
(достатъчно малко положително число).
![Sine](https://wikimedia.org/api/rest_v1/media/math/render/svg/18f6fcb7589b3e0c2891dacebdcae5408c6a3ceb)
```Scheme
(define (sin x)
    (define e 0.00000001)
    (define (term x n)
        (*
            (/
                (expt -1 n)
                (fact (+ (* n 2) 1)))
            (expt x (+ (* n 2) 1))))
  
    (define (good-enough? term)
      (< (abs term) e))
  
    (define (sin-helper n)
        (if (good-enough? (term x n))
            0
            (+ (term x n) (sin-helper (+ n 1)))))
    
    (sin-helper 0))
```
**Задача 4.** Имплементирайте [ей тази чудесия](https://en.wikipedia.org/wiki/Nth_root_algorithm).
За нея ще трябват няколко вметки, които ще ви спестят главоболия (надявам се), а именно:  
Както виждате, на първа стъпка от алгоритъма се прави guess. Този guess след това се
подобрява с всяка стъпка (всяко пресмятане на x(k+1) подобрява вашият guess).
Окей е да направите помощна процедура
```Scheme
(define (improve guess)
; magic
)
```

```Scheme
(define (root x n)
  (define e 0.00001)
  (define (good-enough? current-guess next)
    (< (abs (- current-guess next)) e))
  (define (improve guess)
    (*
     (/ 1 n)
     (+
      (* (- n 1) guess)
      (/ x (expt guess (- n 1))))))

  (define (root-helper guess)
    (if (good-enough? guess (improve guess))
        guess
        (root-helper (improve guess))))
  (root-helper 1.0))
```
Спирате да пресмятате, когато аболютната стойност на (- (improve guess) guess) е по-малка от
достатъчно малко положително число (като в зад. 3).  
В "Structure and Interpretation of Computer Programs" 1.1.7 ще намерите подобна задача, която е обяснена стъпка по стъпка.
  
  
**Задача 6.** Да се напише процедура (toBinary n), която превръща дадено естествено
число в двоична бройна система:
```Scheme
(toBinary 8) -> 1000
(toBinary 10) -> 1010
(toBinary 254) -> 11111110
```

```Scheme
(define (to-binary n)
  (define (binary-iter n i)
    (if (< n 1)
        0
        (+
         (* (remainder n 2) (expt 10 i))
         (binary-iter (quotient n 2) (+ i 1)))))
  (binary-iter n 0))
```

**Задача 7.** Да се напише функция (ends-with? a b), която проверява дали числото а "завършва" на b:
```Scheme
(ends-with? 4321 21) -> #t
(ends-with? 74593 493) -> #f
```

```Scheme
(define (ends-with? a b)
  (define (number-length x)
    (if (< x 10)
        1
        (+ 1 (number-length (quotient x 10)))))

  (define divisor (expt 10 (number-length b)))

  (= (remainder (- a b) divisor) 0))
```

**Задача 8.** Напишете процедура (GCD a b), която намира най-големият общ делител
на две естествени числа а и b по метода на Евклид.

```Scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```