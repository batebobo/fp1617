; Streams in Scheme help us represent potentially infinite lists.
; A stream is a pair, whose first element is the one we're "interested in"
; and whose second element is yet to be evaluated (i.e its evaluation is delayed).
; If we do not delay the evaluation of the second part, we will quickly run out of memory,
; because our operating memory is finite.

; Scheme features a special construct "delay".
; It takes a value and "wraps" it in an argumentless function, without evaluating it.
; It's definition looks kinda like that
;(define (delay x)
;  (lambda () x))
; This definiton would actually evaluate x, so it doesn't fit our purposes.
; However it illustrates the idea of "wraping" something in a function.

; The counterpart of "delay" is called "force".
; It takes a delayed value and evaluates it.
; This is our way of saying "Hey, I didn't need this value before, but I need it now."
; Its definition looks kinda like that
; (define (force delayed-expression)
;   (delayed-expression))
; Since any delayed expression is simply an argumentless function that yields a value,
; we can get the value by calling the function.

; Examine this:
(define a (delay 1))
; a is now a function (without arguments) that yields the value of 1.
; (a) will return 1.
; (force a) will do the same.

; Streams are pairs that look like that:
; (head . delayed-tail)
; Let's begin implementing our interface for working with streams.

; (head xs) - gets the "data part" of the stream.
(define head car) ; This is possible, since we can be sure that the first part of every stream is a regular value.

; (tail xs) - evaluates the second part of a stream - its tail.
(define (tail xs)
  (force (cdr xs)))
(define (tail* xs)
  ((cdr xs)))
; The two definitions produce identical results.

; Consider this example:
(define ones (cons 1 (delay ones)))
; It creates the pair (1 . (delay ones))
; If we want to get the first element of the stream, we can write (head ones)
; Executing (tail ones) will result in (1 . (delay ones))
(define (starting-from n) (cons n (delay (starting-from (+ n 1)))))
(define nats (starting-from 1))

; Executing (head nats) will yield 1,
; (head (tail nats)) - 2, etc.

; (stream-ref stream n) - returns the n-th value in the stream. Kinda looks like list-ref.
(define (stream-ref stream n)
  (if (= n 0)
      (head stream)
      (stream-ref (tail stream) (- n 1))))

; (stream-tail stream n) - returns the stream, skipping the first n elements.
(define (stream-tail stream n)
  (if (= n 0)
      stream
      (stream-tail (tail stream) (- n 1))))

; (take stream n) - returns a list, containing the fist n elements of the given stream. Kinda works like take in Haskell
(define (take stream n)
  (if (= n 0)
      '()
      (cons (head stream) (take (tail stream) (- n 1)))))

; (takeWhile stream p) - returns a stream, containing the first elements that satisfy the given predicate
; Note that this function HAS to return a stream, since all of the given stream's elements can possibly satisfy the given predicate.
; In that case we get an infinite list, which, in Scheme is a stream.
(define (takeWhile stream p)
  (if (p (head stream))
      (cons (head stream) (delay (takeWhile (tail stream) p)))
      '()))

; (map* f stream) - applies f to each element of the stream. Naturally, returns a stream
(define (map* f stream)
  (cons (f (head stream)) (delay (map* f (tail stream)))))

; (filter* p stream) - filters the stream by the given predicate
(define (filter* p stream)
  (if (p (head stream))
      (cons (head stream) (delay (filter* p (tail stream))))
      (filter* p (tail stream))))

; (merge-streams stream1 stream2) - merges two "sorted" streams into one.
(define (merge-streams stream1 stream2)
  (if (< (head stream1) (head stream2))
      (cons (head stream1) (delay (merge-streams (tail stream1) stream2)))
      (cons (head stream2) (delay (merge-streams stream1 (tail stream2))))))

; Example test:
; (head (merge-streams (filter* odd? nats) (filter* even? nats))) - should return 1
; (head (tail (merge-streams (filter* odd? nats) (filter* even? nats)))) - 2
; The resulting stream is identical to nats.
