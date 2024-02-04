#lang racket
;; Programming Languages Homework4 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and change HOMEWORK_FILE to the name of your homework file.
(require "hw4.rkt")

(require rackunit)

;; Helper functions
(define ones (lambda () (cons 1 ones)))
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 1))))
(define a 2)

(define tests
  (test-suite
   "Sample tests for Assignment 4"
   
   ; sequence test
   (check-equal? (sequence 0 5 1) (list 0 1 2 3 4 5) "Sequence test")
   (check-equal? (sequence 0 0 1) (list 0) "Sequence test")
   (check-equal? (sequence 0 1 1) (list 0 1) "Sequence test")
   (check-equal? (sequence 0 3 1) (list 0 1 2 3) "Sequence test")
   (check-equal? (sequence 0 2 3) (list 0) "Sequence test")
   (check-equal? (sequence 3 8 3) (list 3 6) "Sequence test")
   (check-equal? (sequence 3 9 3) (list 3 6 9) "Sequence test")
   (check-equal? (sequence 3 2 3) null "Sequence test")
   (check-equal? (sequence 3 0 3) null "Sequence test")

   ; string-append-map test
   (check-equal? (string-append-map 
                  null 
                  "") null)
   (check-equal? (string-append-map 
                  null 
                  ".jpg") null)
   (check-equal? (string-append-map 
                  (list "dan" "dog" "curry" "dog2") 
                  "") '("dan" "dog" "curry" "dog2") "string-append-map test")
   (check-equal? (string-append-map 
                  (list "dan" "dog" "curry" "dog2") 
                  ".jpg") '("dan.jpg" "dog.jpg" "curry.jpg" "dog2.jpg") "string-append-map test")
   (check-equal? (string-append-map 
                  (list "dan") 
                  ".jpg") '("dan.jpg"))
   (check-equal? (string-append-map 
                  (list "dan" "dog" "" "dog2") 
                  ".jpg") '("dan.jpg" "dog.jpg" ".jpg" "dog2.jpg") "string-append-map test")
   
   ; list-nth-mod test
   (check-equal? (list-nth-mod (list 0 1 2 3 4) 0) 0 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4) 2) 2 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4) 18) 3 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1) 2) 0 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0) 2) 0 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3) 7) 3 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4 5) 7) 1 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4 5 6 7 8 9) 0) 0 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4 5 6 7 8 9) 3) 3 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4 5 6 7 8 9) 4) 4 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4 5 6 7 8 9) 7) 7 "list-nth-mod test")
   (check-equal? (list-nth-mod (list 0 1 2 3 4 5 6 7 8 9) 11) 1 "list-nth-mod test")
   
   ; stream-for-n-steps test
   (check-equal? (stream-for-n-steps ones 0) null "stream-for-n-steps test")
   (check-equal? (stream-for-n-steps ones 1) (list 1) "stream-for-n-steps test")
   (check-equal? (stream-for-n-steps ones 2) (list 1 1) "stream-for-n-steps test")
   (check-equal? (stream-for-n-steps powers-of-two 0) null "stream-for-n-steps test")
   (check-equal? (stream-for-n-steps powers-of-two 1) (list 1) "stream-for-n-steps test")
   (check-equal? (stream-for-n-steps powers-of-two 2) (list 1 2) "stream-for-n-steps test")
   (check-equal? (stream-for-n-steps powers-of-two 4) (list 1 2 4 8) "stream-for-n-steps test")
   
   ; funny-number-stream test
   (check-equal? (stream-for-n-steps funny-number-stream 0) null "funny-number-stream test")
   (check-equal? (stream-for-n-steps funny-number-stream 1) (list 1) "funny-number-stream test")
   (check-equal? (stream-for-n-steps funny-number-stream 2) (list 1 2) "funny-number-stream test")
   (check-equal? (stream-for-n-steps funny-number-stream 4) (list 1 2 3 4) "funny-number-stream test")
   (check-equal? (stream-for-n-steps funny-number-stream 6) (list 1 2 3 4 -5 6) "funny-number-stream test")
   (check-equal? (stream-for-n-steps funny-number-stream 16) (list 1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15 16) "funny-number-stream test")
   
   ; dan-then-dog test
   (check-equal? (stream-for-n-steps dan-then-dog 0) null "dan-then-dog test")
   (check-equal? (stream-for-n-steps dan-then-dog 1) (list "dan.jpg") "dan-then-dog test")
   (check-equal? (stream-for-n-steps dan-then-dog 2) (list "dan.jpg" "dog.jpg") "dan-then-dog test")
   (check-equal? (stream-for-n-steps dan-then-dog 3) (list "dan.jpg" "dog.jpg" "dan.jpg") "dan-then-dog test")
   (check-equal? (stream-for-n-steps dan-then-dog 4) (list "dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg") "dan-then-dog test")
   
   ; stream-add-zero test
   (check-equal? (stream-for-n-steps (stream-add-zero ones) 0) null "stream-add-zero test")
   (check-equal? (stream-for-n-steps (stream-add-zero ones) 1) (list (cons 0 1)) "stream-add-zero test")
   (check-equal? (stream-for-n-steps (stream-add-zero ones) 5) (list (cons 0 1) (cons 0 1) (cons 0 1) (cons 0 1) (cons 0 1)) "stream-add-zero test")
   (check-equal? (stream-for-n-steps (stream-add-zero powers-of-two) 3) (list (cons 0 1) (cons 0 2) (cons 0 4)) "stream-add-zero test")
   (check-equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 3) (list (cons 0 "dan.jpg") (cons 0 "dog.jpg") (cons 0 "dan.jpg")) "stream-add-zero test")
   
   ; cycle-lists test
   (check-equal? (stream-for-n-steps (cycle-lists (list 1) (list "a")) 3) (list (cons 1 "a") (cons 1 "a") (cons 1 "a")) 
                 "cycle-lists test")
   (check-equal? (stream-for-n-steps (cycle-lists (list 1 2) (list "a")) 3) (list (cons 1 "a") (cons 2 "a") (cons 1 "a")) 
                 "cycle-lists test")
   (check-equal? (stream-for-n-steps (cycle-lists (list 1) (list "a" "b")) 3) (list (cons 1 "a") (cons 1 "b") (cons 1 "a")) 
                 "cycle-lists test")
   (check-equal? (stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b")) 3) (list (cons 1 "a") (cons 2 "b") (cons 3 "a")) 
                 "cycle-lists test")
   (check-equal? (stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b" "c")) 7) (list (cons 1 "a") (cons 2 "b") (cons 3 "c") (cons 1 "a") (cons 2 "b") (cons 3 "c") (cons 1 "a")) 
                 "cycle-lists test")
   (check-equal? (stream-for-n-steps (cycle-lists (list 1 2 3 4 5) (list "a" "b" "c")) 7) (list (cons 1 "a") (cons 2 "b") (cons 3 "c") (cons 4 "a") (cons 5 "b") (cons 1 "c") (cons 2 "a"))
                 "cycle-lists test")
   
   ; vector-assoc test
   (check-equal? (vector-assoc 0 (vector)) #f "vector-assoc test")
   (check-equal? (vector-assoc 0 (vector (cons 2 1))) #f "vector-assoc test")
   (check-equal? (vector-assoc 0 (vector (cons 2 1) (cons 3 1) (cons 4 1) (cons 5 1))) #f "vector-assoc test")
   (check-equal? (vector-assoc 4 (vector (cons 2 1) (cons 3 1) (cons 4 1) (cons 5 1))) (cons 4 1) "vector-assoc test")
   (check-equal? (vector-assoc "a" (vector (cons 2 1) (cons "a" 1) (cons 4 1) (cons 5 1))) (cons "a" 1) "vector-assoc test")
   (check-equal? (vector-assoc "a" (vector "Hello, World!" (cons "a" 1) 32 (cons 5 1))) (cons "a" 1) "vector-assoc test")
   (check-equal? (vector-assoc "a" (vector (cons "a" 1) (cons 4 1) (cons 5 1))) (cons "a" 1) "vector-assoc test")
   (check-equal? (vector-assoc "a" (vector (cons "b" "a") (cons "a" 1))) (cons "a" 1) "vector-assoc test")
   (check-equal? (vector-assoc "a" (vector 1 (cons "a" 1))) (cons "a" 1) "vector-assoc test")
   
   ; cached-assoc tests
   (check-equal? ((cached-assoc (list (cons 1 2) (cons 3 4)) 1) 3) (cons 3 4) "cached-assoc test")
   (check-equal? ((cached-assoc (list (cons 1 2) (cons 3 4)) 2) 3) (cons 3 4) "cached-assoc test")
   (check-equal? ((cached-assoc (list (cons 1 2) (cons 2 4)) 1) 3) #f "cached-assoc test")
   (check-equal? ((cached-assoc (list (cons 1 2) (cons 2 4)) 3) 3) #f "cached-assoc test")
   (check-equal? ((cached-assoc (list (cons 1 2) (cons 2 4)) 3) 10) #f "cached-assoc test")
   (check-equal? ((cached-assoc (list (cons 1 2) (cons 2 4) (cons 2 4) (cons "a" 4) (cons "Hello, World!" 4) (cons 25 4)) 10) "a") (cons "a" 4) "cached-assoc test")
   #|
   ; while-less test
   (check-equal? (while-less 7 do (begin (set! a (+ a 1)) a)) #t "while-less test")
   |#
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)