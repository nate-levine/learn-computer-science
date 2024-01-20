#lang racket

; Define a stream of 1s
; 1 1 1 1 1 ...
(define ones (lambda () (cons 1 ones)))

; Define a stream of integers starting at x
; x (x + 1) (x + 2) ...
(define (f x) (cons x (lambda () (f (+ x 1)))))

; Define a stream of natural numbers starting at 1
; using the more general stream above
(define naturals (lambda () (f 1)))

; Define a stream of powers of 2 starting at 2^0
; 1 2 4 8 16 ...
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 1))))