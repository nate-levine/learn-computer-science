;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname quiz_1b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Image, Image -> Boolean
;; Produces true if the first image is larger than the second image
(check-expect (is-larger? (rectangle 2 2 "solid" "red") (rectangle 3 3 "solid" "red")) false)
(check-expect (is-larger? (rectangle 3 3 "solid" "red") (rectangle 3 3 "solid" "red")) false)
(check-expect (is-larger? (rectangle 4 4 "solid" "red") (rectangle 3 3 "solid" "red")) true)

; (define (is-larger? img1 img2) false) ; stub

; (define (is-larger? img1 img2) ; template
;   (... img1 img2))

(define (is-larger? img1 img2)
  (> (* (image-width img1) (image-width img1)) (* (image-width img2) (image-height img2))))