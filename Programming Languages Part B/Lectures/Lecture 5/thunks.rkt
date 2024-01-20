;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname thunks) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#lang racket

; Example of how to thunk an expression in Racket
; The value of x is stored in the closure, and delays the evaluation

(define x 3)
(lambda() (+ x 2))


; Define a conditional function that takes:
; 1. An expression that evaluates to a boolean
; 2. Two thunks
(define (my-if x y z)
	(if x (y) (z)))

; Define a factorial function where each conditional branch is a thunk that
; has not been evaluated
; "my-if" only evaluates one of the thunks based on what x evaluates to
(define (fact n)
	(my-if (= n 0)
				 (lambda() 1)
         (lambda() (* n (fact (- n 1))))))