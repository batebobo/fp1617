(define graph '((1 3 4 5) (2 1 5) (3 4 2 5) (4 4 1) (5 5)))
;The list above represents a graph.
;The first element of each list represents the vertex,
;and the rest - its neighbours.
;Keep in mind that this is a directed graph.

;(vertices graph) - returns a list, containing all the vertices in the given graph
(define (vertices graph)
  (map car graph))

;(neighbours vertex graph) - returns a list, containing all neighbours of a given vertex
(define (neighbours vertex graph)
  (cond ((null? graph) '())
        ((not (member vertex (vertices graph))) '())
        ((equal? vertex (caar graph)) (cdar graph))
        (else (neighbours vertex (cdr graph)))))

;(edges graph) - return a list with pairs, representing all the edges in the given graph
(define (edges graph)
  (define (make-edges lst)
    (map (lambda (n) (cons (car lst) n)) (cdr lst)))
  (define list-with-edges (map make-edges graph))
  (fold-right append '() list-with-edges))

;(edges graph) - same thing as above, but using fancy scheme constructs. Keeping it classy
(define (edges* graph)
  (let* ([make-edges (lambda (lst) (map (lambda (n) (cons (car lst) n)) (cdr lst)))]
         [list-of-edges (map make-edges graph)])
    (fold-right append '() list-of-edges)))

;(out-degree vertex graph) - returns the number of vertices, a given vertex "points" to
(define (out-degree vertex graph)
  (length (neighbours vertex graph)))

;(in-degree vertex graph) - return the number of vertices that "point" to a given vertex
(define (in-degree vertex graph)
  (fold-left + 0 (map (lambda (lst) (length (filter (lambda (x) (equal? vertex x)) (cdr lst)))) graph)))

;(in-degree vertex graph) - same as above but better looking
(define (in-degree* vertex graph)
  (define (vertex-occurences lst)
    (length (filter (lambda (v) (equal? vertex v)) (cdr lst))))
  (define (vertex-occurences-all graph) ;the 'graph' used here is NOT the graph from above. This is a local binding to the vertex-occurences-all function.
    (map vertex-occurences graph))
  (fold-left + 0 (vertex-occurences-all graph))) ;the 'graph' used here IS the graph from the function definition.

;(subgraph? graph1 graph2) - predicate that checks whether graph2 contains graph1
(define (subgraph? graph1 graph2)
  (let* ([first-edges (edges graph1)]
         [second-edges (edges graph2)]
         [all? (lambda (p xs) (fold-left (lambda (acc next) (and acc next)) #t (map p xs)))]
         [subset? (lambda (xs ys) (all? (lambda (x) (member x ys)) xs))])
    (subset? first-edges second-edges)))
(define graph2 '((1 3 4 5 7 6) (2 1 5) (3 4 2 5) (4 4 1) (5 5)))



     
