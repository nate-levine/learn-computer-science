;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 20)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define MISSILE (ellipse 5 15 "solid" "red"))


;; =================
;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loinvader (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-tank (game-tank s))))



(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))



(define-struct invader (x y dir))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader direction Natural[-1, 1]

(define I1 (make-invader 150 100 1))           ;not landed, moving right
(define I2 (make-invader 150 0 -1))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 1)) ;> landed, moving right


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dir invader)))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 700 300))                       ;not hit U1
(define M2 (make-missile 700 (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))



(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))


;; =================
;; Functions:

;; Game -> Game
;; start the world with (main G0), (main G1), (main G2), or (main G3)
;; 
(define (main g)
  (big-bang g                      ; Game
    (on-tick   tock)       ; Game -> Game
    (to-draw   render)     ; Game -> Image
    (on-key  handle-key))) ; Game KeyEvent -> Game

;; Game -> Game
;; produce the next game tick
(check-expect (tock (make-game empty empty (make-tank (/ WIDTH 2) 1)))
              (make-game empty empty (make-tank (+ (/ WIDTH 2) (* TANK-SPEED 1)) 1)))
(check-expect (tock (make-game (list (make-invader 150 100 1))
                               (list (make-missile 150 300))
                               (make-tank 50 1)))
              (make-game (list (make-invader (+ 150 INVADER-X-SPEED) (+ 100 INVADER-Y-SPEED) 1))
                         (list (make-missile 150 (- 300 MISSILE-SPEED)))
                         (make-tank (+ 50 (* TANK-SPEED 1)) 1)))

; (define (tock g) g) ; stub

(define (tock g)
  (make-game (tock-loinvader (game-invaders (hit g)))
             (tock-lom (game-missiles (hit g)))
             (tock-tank (game-tank (hit g)))))


;; listof Invader -> listof Invader
;; produces the next list of invaders for the next game tick
(check-expect (tock-loinvader empty) empty)
(check-expect (tock-loinvader (list (make-invader 150 100 1)))
              (list (make-invader (+ 150 INVADER-X-SPEED) (+ 100 INVADER-Y-SPEED) 1)))
(check-expect (tock-loinvader (list (make-invader 150 100 1)
                                    (make-invader 50 120 1)))
              (list (make-invader (+ 150 INVADER-X-SPEED) (+ 100 INVADER-Y-SPEED) 1)
                    (make-invader (+ 50 INVADER-X-SPEED) (+ 120 INVADER-Y-SPEED) 1)))

; (define (tock-loinvader loinvader) loinvader) ; stub

(define (tock-loinvader loi)
  (cond [(empty? loi)
         empty]
        [else
         (cons (tock-invader (first loi))
               (tock-loinvader (rest loi)))]))


;; Invader -> Invader
;; produces the next invader for the next game tick
(check-expect (tock-invader (make-invader 150 100 1)) (make-invader (+ 150 INVADER-X-SPEED) (+ 100 INVADER-Y-SPEED) 1))
(check-expect (tock-invader (make-invader (+ 0 (/ (image-width INVADER) 2)) 100 1))
              (make-invader (+ (+ 0 (/ (image-width INVADER) 2)) (* INVADER-X-SPEED 1)) (+ 100 INVADER-Y-SPEED) 1)) ; hit left wall
(check-expect (tock-invader (make-invader (- WIDTH (/ (image-width INVADER) 2)) 100 -1))
              (make-invader (+ (- WIDTH (/ (image-width INVADER) 2)) (* INVADER-X-SPEED -1)) (+ 100 INVADER-Y-SPEED) -1)) ; hit right wall

; (define (tock-invader invader) invader) ; stub

(define (tock-invader invader)
  (cond [(> (invader-x invader) (- WIDTH (/ (image-width INVADER) 2)))
         (make-invader (- WIDTH (/ (image-width INVADER) 2)) (+ (invader-y invader) INVADER-Y-SPEED) (* (invader-dir invader) -1))]
        [(< (invader-x invader) (+ 0 (/ (image-width INVADER) 2)))
         (make-invader (+ 0 (/ (image-width INVADER) 2)) (+ (invader-y invader) INVADER-Y-SPEED) (* (invader-dir invader) -1))]
        [else
         (make-invader (+ (invader-x invader) (* INVADER-X-SPEED (invader-dir invader))) (+ (invader-y invader) INVADER-Y-SPEED) (invader-dir invader))]))


;; listof Missile -> listof Missile
;; produces the next list of missiles for the next game tick
(check-expect (tock-lom empty) empty)
(check-expect (tock-lom (list (make-missile 10 15)))
              (list (make-missile 10 (- 15 MISSILE-SPEED))))
(check-expect (tock-lom (list (make-missile 10 15)
                              (make-missile 20 300)))
              (list (make-missile 10 (- 15 MISSILE-SPEED))
                    (make-missile 20 (- 300 MISSILE-SPEED))))

; (define (tock-lom lom) lom) ; stub

(define (tock-lom lom)
  (cond [(empty? lom)
         empty]
        [else
         (cons (tock-missile (first lom))
               (tock-lom (rest lom)))]))


;; Missile -> Missile
;; produces the next missile for the next game tick
(check-expect (tock-missile (make-missile 10 15)) (make-missile 10 (- 15 MISSILE-SPEED)))

; (define (tock-missile m) m) ; stub

(define (tock-missile m)
  (make-missile (missile-x m) (- (missile-y m) MISSILE-SPEED)))


;; Tank -> Tank
;; produces the Tank for the next game tick
(check-expect (tock-tank (make-tank (/ WIDTH 2) 1)) (make-tank (+ (/ WIDTH 2) (* TANK-SPEED 1)) 1))
(check-expect (tock-tank (make-tank (+ 0 (/ (image-width TANK) 2)) -1))
              (make-tank (+ (+ 0 (/ (image-width TANK) 2)) (* TANK-SPEED -1)) -1)) ; left side
(check-expect (tock-tank (make-tank (+ 0 (- WIDTH (/ (image-width TANK) 2))) -1))
              (make-tank (+ (+ 0 (- WIDTH (/ (image-width TANK) 2))) (* TANK-SPEED -1)) -1)) ; right side

; (define (tock-tank t) t) ; stub

(define (tock-tank t)
  (cond [(< (tank-x t) (+ 0 (/ (image-width TANK) 2)))
         (make-tank (+ (tank-x t) (* TANK-SPEED (* (tank-dir t) -1))) (* (tank-dir t) -1))]
        [(> (tank-x t) (- WIDTH (/ (image-width TANK) 2)))
         (make-tank (+ (tank-x t) (* TANK-SPEED (* (tank-dir t) -1))) (* (tank-dir t) -1))]
        [else
         (make-tank (+ (tank-x t) (* TANK-SPEED (tank-dir t))) (tank-dir t))]))


;; Game -> Image
;; render game to screen
(check-expect (render G0) (place-image TANK (tank-x T0) (- HEIGHT TANK-HEIGHT/2) BACKGROUND))
(check-expect (render G3) (place-image TANK (tank-x T1) (- HEIGHT TANK-HEIGHT/2)
                                       (place-image MISSILE (missile-x M2) (missile-y M2)
                                                    (place-image MISSILE (missile-x M1) (missile-y M1)
                                                                 (place-image INVADER (invader-x I2) (invader-y I2)
                                                                              (place-image INVADER (invader-x I1) (invader-y I1) BACKGROUND))))))

; (define (render g) (square 0 "solid" "white")) ; stub

(define (render g)
  (render-tank (game-tank g) (render-lom (game-missiles g) (render-loinvader (game-invaders g)))))


;; listof Invader -> Image
;; render list of invaders
(check-expect (render-loinvader empty) BACKGROUND)
(check-expect (render-loinvader (list I1)) (place-image INVADER (invader-x I1) (invader-y I1) BACKGROUND))
(check-expect (render-loinvader (list I1 I2)) (place-image INVADER (invader-x I1) (invader-y I1)
                                                           (place-image INVADER (invader-x I2) (invader-y I2) BACKGROUND)))
                                       
; (define (render-loinvader loinvader) (square 0 "solid" "white")) ; stub

(define (render-loinvader loi)
  (cond [(empty? loi)
         BACKGROUND]
        [else
         (render-invader (first loi) (render-loinvader (rest loi)))]))


;; Invader InvaderImage -> Image
;; render invader
(check-expect (render-invader I1 BACKGROUND) (place-image INVADER (invader-x I1) (invader-y I1) BACKGROUND))
(check-expect (render-invader I1 (render-invader I2 BACKGROUND)) (place-image INVADER (invader-x I1) (invader-y I1)
                                                                              (place-image INVADER (invader-x I2) (invader-y I2) BACKGROUND)))

; (define (render-invader invader img) (square 0 "solid" "white")) ; stub

(define (render-invader invader img)
  (place-image INVADER (invader-x invader) (invader-y invader) img))


;; listof Missile InvaderImage -> Image
;; render list of missiles
(check-expect (render-lom empty (render-loinvader empty)) BACKGROUND)
(check-expect (render-lom (list M1) (render-loinvader empty)) (place-image MISSILE (missile-x M1) (missile-y M1) BACKGROUND))
(check-expect (render-lom (list M1 M2) (render-loinvader empty)) (place-image MISSILE (missile-x M1) (missile-y M1)
                                                                              (place-image MISSILE (missile-x M2) (missile-y M2) BACKGROUND)))

; (define (render-lom lom i-img) (square 0 "solid" "white")) ; stub

(define (render-lom lom i-image)
  (cond [(empty? lom)
         i-image]
        [else
         (render-missile (first lom) (render-lom (rest lom) i-image))]))


;; Missile MissileImage -> Image
;; render missile
(check-expect (render-missile M1 BACKGROUND) (place-image MISSILE (missile-x M1) (missile-y M1) BACKGROUND))
(check-expect (render-missile M1 (render-missile M2 BACKGROUND)) (place-image MISSILE (missile-x M1) (missile-y M1)
                                                                              (place-image MISSILE (missile-x M2) (missile-y M2) BACKGROUND)))

; (define (render-missile m img) (square 0 "solid" "white")) ; stub

(define (render-missile m img)
  (place-image MISSILE (missile-x m) (missile-y m) img))


;; Tank InvaderAndMissileImage -> Image
;; render tank
(check-expect (render-tank T0 (render-lom empty (render-loinvader empty))) (place-image TANK (tank-x T0) (- HEIGHT TANK-HEIGHT/2) BACKGROUND))

; (define (render-tank t m-and-i-img) (square 0 "solid" "white")) ; stub


(define (render-tank t m-and-i-img)
  (place-image TANK (tank-x t) (- HEIGHT TANK-HEIGHT/2) m-and-i-img))


;; Game KeyEvent -> Game
;; produce tank movement and shooting through key events
(check-expect (handle-key (make-game (list (make-invader 150 100 1))
                                     (list (make-missile 150 300))
                                     (make-tank 50 1))
                          "a")
              (make-game (list (make-invader 150 100 1))
                         (list (make-missile 150 300))
                         (make-tank 50 -1))) ; move left
(check-expect (handle-key (make-game (list (make-invader 150 100 1))
                                     (list (make-missile 150 300))
                                     (make-tank 50 1))
                          "d")
              (make-game (list (make-invader 150 100 1))
                         (list (make-missile 150 300))
                         (make-tank 50 1))) ; move right
(check-expect (handle-key (make-game (list (make-invader 150 100 1))
                                     empty
                                     (make-tank 50 -1))
                          "w")
              (make-game (list (make-invader 150 100 1))
                         (list (make-missile 50 (- HEIGHT TANK-HEIGHT/2)))
                         (make-tank 50 -1))) ; shoot (make a missile)
(check-expect (handle-key (make-game (list (make-invader 150 100 1))
                                     (list (make-missile 150 300))
                                     (make-tank 50 1))
                          "w")
              (make-game (list (make-invader 150 100 1))
                         (list (make-missile 50 (- HEIGHT TANK-HEIGHT/2)) (make-missile 150 300))
                         (make-tank 50 1))) ; shoot (make a second missile)

; (define (handle-key g ke) g) ; stub

; (define (handle-key g ke)
;   (cond [(key=? ke " ") (... g)]
;         [else 
;          (... g)]))

(define (handle-key g ke)
  (cond [(key=? ke "d") ; move right
         (make-game (game-invaders g) (game-missiles g) (make-tank (tank-x (game-tank g)) 1))]
        [(key=? ke "a") ; move left
         (make-game (game-invaders g) (game-missiles g) (make-tank (tank-x (game-tank g)) -1))]
        [(key=? ke "w") ; shoot
         (make-game (game-invaders g) (cons (make-missile (tank-x (game-tank g)) (- HEIGHT TANK-HEIGHT/2)) (game-missiles g)) (make-tank (tank-x (game-tank g)) (tank-dir (game-tank g))))]
        [else 
         g]))


;; Game -> Game
;; removes an invader from game if it is in the same area as a missile
(check-expect (hit (make-game (list (make-invader 150 100 1))
                              (list (make-missile 150 300))
                              (make-tank 50 1)))
              (make-game (list (make-invader 150 100 1))
                         (list (make-missile 150 300))
                         (make-tank 50 1)))
(check-expect (hit (make-game (list (make-invader 150 295 1))
                              (list (make-missile 150 300))
                              (make-tank 50 1)))
              (make-game empty
                         (list (make-missile 150 300))
                         (make-tank 50 1)))

; (define (hit g) g) ; stub

(define (hit g)
  (cond [(empty? (game-invaders g))
         (make-game empty (game-missiles g) (game-tank g))]
        [else
         (make-game
          (if (hit-invader? (first (game-invaders g)) (game-missiles g))
              (rest (game-invaders g))
              (game-invaders g))
          (game-missiles g)
          (game-tank g))]))


;; Invader listof Missile -> Boolean
;; produces true if any of the missiles "hit" (are within proximity) of the invader
(check-expect (hit-invader? (make-invader 150 100 1)
                           (list (make-missile 150 300)))
              false)
(check-expect (hit-invader? (make-invader 150 295 1)
                           (list (make-missile 150 300)))
              true)

; (define (hit-invader? invader lom) false) ; stub

(define (hit-invader? invader lom)
  (cond [(empty? lom)
         false]
        [else
         (if (hit-missile? invader (first lom))
             true
             (hit-invader? invader (rest lom)))]))


;; Invader Missile -> Boolean
;; produces true if the missile "hit" (is within proximity) of the invader
(check-expect (hit-missile? (make-invader 150 100 1)
                           (make-missile 150 300))
              false)
(check-expect (hit-missile? (make-invader 150 295 1)
                           (make-missile 150 300))
              true)

; (define (hit-missile? invader missile) false) ; stub

(define (hit-missile? invader missile)
  (and (and (< (missile-x missile) (+ (invader-x invader) HIT-RANGE))
            (> (missile-x missile) (- (invader-x invader) HIT-RANGE)))
       (and (< (missile-y missile) (+ (invader-y invader) HIT-RANGE))
            (> (missile-y missile) (- (invader-y invader) HIT-RANGE)))))


(main G3)