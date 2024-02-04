;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname forming_and_intuition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Example 1


(define p "incendio ")

(local [(define p "accio ")
        (define (fetch n) (string-append p n))]

  (fetch "portkey"))


; Example 2

(define a 1)
(define b 2)

(+ a
   (local [(define b 3)]
     (+ a b))
   b)

; Example 3 - Evaluation rules

; Starting local
(local [(define b 2)]
  (* b b)

; Rename local to a unique name
(local [(define b_0 2)]
  (* b_0 b_0)

; Lift the local to the top-level scope
(define b_0 2)
(local []
  (* b_0 b_0)

; Replace the local with the body of itself
(define b_0 2)
(* b_0 b_0)

; Evaluate normally
(* 2 2)
4