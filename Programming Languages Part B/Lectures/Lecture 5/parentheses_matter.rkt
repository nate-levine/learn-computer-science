;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname parentheses_matter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#lang racket

;; (1) will be called as a function with no arguments,
;; and therefore an error in thrown


; Correct function without exta parentheses around 1
(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

; Incorrect function with exta parentheses around 1
(define (fact_incorrect_a n)
  (if (= n 0)
      (1)
      (* n (fact_incorrect_a (- n 1)))))

; The original function is called by accident,
; so this one works for every input n > 0
(define (fact_incorrect_b n)
  (if (= n 0)
      (1)
      (* n (fact (- n 1)))))

; Syntax error
(define (fact_incorrect_c n)
  (if (= n 0
      (1)
      (* n (fact_incorrect_c (- n 1)))))

; Racket doesn't catch this mistake because it has no type checker
; "*" function will throw a runtime error when (fact_incorrect_d)
; is attempted to be passed in as a number
(define (fact_incorrect_d n)
  (if (= n 0)
      (1)
      (* n (fact_incorrect_d) (- n 1)))))

; Racket reads this as "n" being the function/procedure,
; and "*" being a variable
(define (fact_incorrect_e n)
  (if (= n 0)
      1
      (n * (fact_incorrect_e (- n 1)))))