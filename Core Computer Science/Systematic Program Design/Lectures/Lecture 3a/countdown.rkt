;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define (decrement n)
  (if (> n 0)
      (- n 1)
       n))

(define (draw-number n)
  (place-image (text (number->string n) 24 "black") 50 50 (empty-scene 100 100)))

(big-bang 100
          (on-tick decrement)
          (to-draw draw-number))