#lang racket

;; These structs provide the constructor, tester, and extractor
;; functions all in one line
(struct const (int))
(struct negate (e))
(struct add (e1 e2))
(struct multiply (e1 e2))

;; This function follows from the same structure as before,
;; except it uses structs instead of the multiple helper functions
(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e) (const (- (const-int (eval-exp (negate-e e)))))]
        [(add? e) (let ([v1 (const-int (eval-exp (add-e1 e)))]
                        [v2 (const-int (eval-exp (add-e2 e)))])
                    (const (+ v1 v2)))]
        [(multiply? e) (let ([v1 (const-int (eval-exp (multiply-e1 e)))]
                             [v2 (const-int (eval-exp (multiply-e2 e)))])
                         (const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))