;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname define_struct) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Create a compound data type to describe an <x, y> position


; (define-struct <struct_name> (<data>...))
(define-struct pos (x y))


; Make a position value at <3, 6> and assign that value to P1
(define P1 (make-pos 3 6))


; Select "x" (3) from P1
(pos-x P1)
; Select "y" (6) from P1
(pos-y P1)


; true, is constructed from "pos"
(pos? P1)
; false, is NOT constructed from "pos"
(pos? "Hello"