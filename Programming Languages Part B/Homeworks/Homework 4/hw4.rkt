
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; #1
;; int * int * int -> int list
;; produces a list of numbers from lower to high separated by stride in sorted order
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))


;; #2
;; string list * string -> string list
;; produces a list of strings appened with the suffix
(define (string-append-map strings suffix)
  (map (lambda (string) (string-append string suffix)) strings))


;; #3
;; 'a list * int -> 'a
;; produces the 0-indexed list index of (/ n (length list))
(define (list-nth-mod list n)
  (cond [(< n 0)
         (error "list-nth-mod: negative number")]
        [(empty? list)
         (error "list-nth-mod: empty list")]
        [(let ([nth-mod (remainder n (length list))])
           (car (list-tail list nth-mod)))]))


;; #4
;; stream * int -> int list
;; produces a list holding the first n values produced by a stream in order, where (> n 0)
(define (stream-for-n-steps stream n)
  (if (= n 0)
      null
      (let ([stream-head-value (stream)])
        (cons (car stream-head-value) (stream-for-n-steps (cdr stream-head-value) (- n 1))))))


;; #5
;; stream
;; a stream counting the natural numbers up from 1, negating every natural that is divisible by 5
(define funny-number-stream (letrec ([f (lambda (x) (cons (if (= 0 (remainder x 5))
                                                              (* x -1)
                                                              x)
                                                          (lambda () (f (+ x 1)))))])
                              (lambda () (f 1))))


;; #6
;; stream
;; a stream that alternates between the strings "dan.jpg" and "dog.jpg", starting with "dan.jpg"
(define dan-then-dog (lambda () (cons "dan.jpg"
                                      (lambda () (cons "dog.jpg"
                                                       dan-then-dog)))))


;; # 7
;; stream -> stream
;; produce a stream where every element is a pair (0, v), where v is every element of the consumed stream
(define (stream-add-zero s)
  (let ([evaluated-thunk (s)])
    (lambda () (cons (cons 0 (car evaluated-thunk))
                     (stream-add-zero (cdr evaluated-thunk))))))


;; #8
;; list * list -> stream
;; produces a stream of pairs built from the cycling first and second lists consumed
;; assume the lists are non-empty
(define (cycle-lists xs ys)
  (letrec ([helper-counter (lambda (n)
                             (cons (cons (list-nth-mod xs n)
                                         (list-nth-mod ys n))
                                   (lambda () (helper-counter (+ n 1)))))])
    (lambda () (helper-counter 0))))


;; #9
;; vector-length : vector -> int
;;  - produces the length of a vector v
;; vector-ref : vector int -> 'a
;;  - returns the element in slot n of vector v
;; equal? : 'a * 'b -> bool
;;  - check if two values are equal
;; pair? : 'a -> bool
;;  - checks if a value v is a pair

;; 'a * vector -> ('a 'b) | #f
;; produces the first pair in a vector where the car element of that pair is v
;; produce #f (false) if no vector element is a pair with a car element equal to v
(define (vector-assoc v vector)
  (letrec ([helper-counter (lambda (n)
                             (if (= n (vector-length vector))
                                 #f
                                 (let ([element-n (vector-ref vector n)])
                                   ;; if pair? returns false, equal? will not be evaluated
                                   (if (and (pair? element-n)
                                            (equal? (car element-n) v))
                                       element-n
                                       (helper-counter (+ n 1))))))])
    (helper-counter 0)))


;; #10
;; assoc : 'a * list -> ('a 'b) | #f
;;  - produces the first pair in a list where the car element of that pair is v
;; make-vector : int * 'a -> vector
;;  - creates a vector of size n containing the values v
;; vector-set! : vector * int * 'a -> none
;;  - updates the nth position of a vector vec with a value v

;; list * int -> ('a * list -> ('a 'b) | #f
;; produces a function that works like (assoc v xs) with value v and list xs, from a consumed list xs and cache size n (n is positive)
;; when the produces function is called:
;;  1. check the cache for the answer
;;  2. if answer is not there, use assoc on list xs to get the answer
;;    a. if the answer from assoc is #f do not add it to the cache and have the produced function produce #f
;;  3. add the answer to the vector (cache)
;;  4. repeat
;; from my understanding, only the first spot in the cache is used since assoc will always return the answer if there is one
;; therefore, the cycle should 

;; a n-length cache (vector) is used to possibly make the produced function faster than the built-in function assoc
;;  - The vector starts with all elements being #f
;;  - The vector is possibly mutated each time the produced function is called
;;  - The vector values are mutated with vector-set!
;;  - The vector values are updated in a round-robin fashion
;;    - Use a variable i to keep track of what cache slot should be updated

(define (cached-assoc xs n)
  (let ([cache (make-vector n #f)]
        [i 0])
    (lambda (v)
      (let [(cache-result (vector-assoc v cache))
            (answer (assoc v xs))]
        (or cache-result
            (and answer
                 (begin (vector-set! cache i answer)
                        (if (= i (- n 1))
                            0
                            (+ i 1))
                        answer)))))))