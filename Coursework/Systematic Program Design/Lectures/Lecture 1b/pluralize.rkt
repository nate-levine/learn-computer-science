;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pluralize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; String -> String
;; Produces the plural of a word
(check-expect (pluralize "cat") "cats")
(check-expect (pluralize "table") "tables")

; (define (pluralize s) "") ; this is the stub

; (define (pluralize s) ; this is the template
;   (... s))

(define (pluralize s)
  (string-append s "s"))