;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname list_mechanisms) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
empty

(define L1 (cons "Flames" empty))                ; a list of one element
(define L2 (cons "Leafs" (cons "Flames" empty))) ; a list of two elements
(define L3(cons 10 (cons 9 (cons 10 empty))))    ; a list of three elements

(first L3) ; Produces the first element of the list
(rest L3) ; Produces the all the elements after the first element of the list

(first (rest L3)) ; Access the second element of the list

(empty? empty) ; true
(empty? L1)    ; false