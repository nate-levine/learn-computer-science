#lang racket
;; Programming Languages Homework 5 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and, if necessary, change the filename
(require "hw5.rkt")

(require rackunit)

(define tests
  (test-suite
   "Sample tests for Assignment 5"
   
   ;; check racketlist to mupllist with normal list
   (check-equal? (racketlist->mupllist null) (aunit) "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (int 4))) (apair (int 4) (aunit)) "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (int 3) (int 4))) (apair (int 3) (apair (int 4) (aunit))) "racketlist->mupllist test")
   ;; check mupllist to racketlist with normal list
   (check-equal? (mupllist->racketlist (aunit)) null "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (apair (int 4) (aunit))) (list (int 4)) "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (aunit)))) (list (int 3) (int 4)) "racketlist->mupllist test")

   ;; tests if ifgreater returns (int 2)
   (check-equal? (eval-exp (ifgreater (int 3) (int 4) (int 3) (int 2))) (int 2) "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 2) (ifgreater (int 5) (int 4) (int 1) (int 2)) (int 3) (int 2))) (int 3) "ifgreater test")
   
   ;; mlet test
   (check-equal? (eval-exp (mlet "x" (int 1) (add (int 5) (var "x")))) (int 6) "mlet test")
  
   ;; call test
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (int 1))) (int 8) "call test")
   (check-equal? (eval-exp (mlet "add7" (fun #f "x"
                                             (add (var "x") (int 7)))
                                 (call (var "add7") (int 1))))
                 (int 8) "call test")
   (check-equal? (eval-exp (mlet "num8" (mlet "add7" (fun #f "x" (add (var "x") (int 7))) (call (var "add7") (int 1))) (add (var "num8") (int 1))))
                 (int 9) "call test")
   (check-equal? (mupllist->racketlist (eval-exp (mlet "count_range" (fun "func" "i"
                                                                          (ifgreater (fst (var "i")) (snd (var "i"))
                                                                                     (aunit)
                                                                                     (apair (fst (var "i")) (call (var "func") (apair (add (fst (var "i")) (int 1)) (snd (var "i")))))))
                                                       (call (var "count_range") (apair (int 2) (int 5))))))
                 (list (int 2) (int 3) (int 4) (int 5)) "call test")
   (check-equal? (eval-exp (mlet "sum_list" (fun "func" "i"
                                                 (ifgreater (isaunit (snd (var "i"))) (int 0)
                                                            (fst (var "i"))
                                                            (add (fst (var "i")) (call (var "func") (snd (var "i"))))))
                                 (call (var "sum_list") (racketlist->mupllist (list (int 2) (int 3) (int 4) (int 5))))))
                 (int 14) "call test")
   (check-equal? (eval-exp (mlet "sum_list" (fun "func" "i"
                                                 (ifgreater (isaunit (snd (var "i"))) (int 0)
                                                            (fst (var "i"))
                                                            (add (fst (var "i")) (call (var "func") (snd (var "i"))))))
                                 (call (var "sum_list") (racketlist->mupllist (list (int -1) (int 0) (int 2) (int 5))))))
                 (int 6) "call test")
   
   ;; apair test
   (check-equal? (eval-exp (apair (add (int 3) (int 2)) (int 1))) (apair (int 5) (int 1)) "apair test")
   (check-equal? (eval-exp (apair (int 5) (int 1))) (apair (int 5) (int 1)) "apair test")
   
   ;; fst test
   (check-equal? (eval-exp (fst (apair (int 1) (add (int 3) (int 2))))) (int 1) "snd test")
   (check-equal? (eval-exp (fst (apair (add (int 3) (int 2)) (int 1)))) (int 5) "snd test")
   
   ;; snd test
   (check-equal? (eval-exp (snd (apair (int 1) (add (int 3) (int 2))))) (int 5) "snd test")
   (check-equal? (eval-exp (snd (apair (int 1) (int 1)))) (int 1) "snd test")
 
   ;; isaunit test
   (check-equal? (eval-exp (isaunit (aunit))) (int 1) "isaunit test")
   (check-equal? (eval-exp (isaunit (int 1))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (int 0))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (fst (apair (int 1) (aunit))))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (snd (apair (int 1) (aunit))))) (int 1) "isaunit test")
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (aunit))))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (int 1))))) (int 0) "isaunit test")
  
   ;; ifaunit test
   (check-equal? (eval-exp (ifaunit (int 1) (int 2) (int 3))) (int 3) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (int 0) (int 2) (int 3))) (int 3) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (aunit) (int 2) (int 3))) (int 2) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (fst (apair (aunit) (int 0))) (int 2) (int 3))) (int 2) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (snd (apair (int 4) (aunit))) (int 2) (int 3))) (int 2) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (fst (apair (int 4) (aunit))) (int 2) (int 3))) (int 3) "ifaunit test")

   ;; mlet* test
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10)))
                                  (var "x")))
                 (int 10) "mlet* test")
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10))
                                        (cons "y" (int 15)))
                                  (add (var "x") (var "y"))))
                 (int 25) "mlet* test")
   (check-equal? (eval-exp (mlet* (list (cons "add5" (fun #f "x" (add (var "x") (int 5))))
                                        (cons "n"    (int 13)))
                                  (call (var "add5") (var "n"))))
                 (int 18) "mlet* test")

   ;; ifeq test
   (check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (int 4))) (int 4) "ifeq test")
   (check-equal? (eval-exp (ifeq (int 2) (int 2) (int 3) (int 4))) (int 3) "ifeq test")
   (check-equal? (eval-exp (ifeq (int 0) (int 0) (int 3) (int 4))) (int 3) "ifeq test")
      
   ;; mupl-map test
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (aunit))) 
                 (aunit) "mupl-map test")
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int 1) (aunit)))) 
                 (apair (int 8) (aunit)) "mupl-map test")
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int -7) (apair (int 8) (aunit))))) 
                 (apair (int 0) (apair (int 15) (aunit))) "mupl-map test")

   ;; problems 1, 2, and 4 combined test
   (check-equal? (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 7))
                   (racketlist->mupllist 
                    null)))) null "combined test")
   (check-equal? (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 7))
                   (racketlist->mupllist 
                    (list (int -7)))))) (list (int 0)) "combined test")
   (check-equal? (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 8))
                   (racketlist->mupllist 
                    (list (int 3) (int 4) (int 9)))))) (list (int 11) (int 12) (int 17)) "combined test")

   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
