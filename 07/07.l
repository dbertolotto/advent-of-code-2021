(load "../util.l")

(de read-inp (File)
  (in File
    (mapcar format
      (mapcar pack
        (split (line) ",")))))

(def 'Sample (read-inp "sample.txt"))
(def 'Input (read-inp "input.txt"))

(de fuel-at-pos (Lst Pos)
  (let Fuel 0
    (for L Lst
      (setq Fuel (+ Fuel (abs (- L Pos)))))
    Fuel))

(test 41 (fuel-at-pos Sample 1))
(test 37 (fuel-at-pos Sample 2))
(test 39 (fuel-at-pos Sample 3))
(test 71 (fuel-at-pos Sample 10))

(de sol-a (Inp FuelFn)
  (let (MinFuel (FuelFn Inp 1)
        MinPos 1)
    (for Pos (range 2 (length Inp))
      (let Fuel (FuelFn Inp Pos)
        (when (< Fuel MinFuel)
          (setq MinFuel Fuel MinPos Pos))))
    (cons MinFuel MinPos)))

(test (37 . 2) (sol-a Sample 'fuel-at-pos))
(test (352331 . 349) (sol-a Input 'fuel-at-pos))

(de fuel-at-pos-2 (Lst Pos)
  (let Fuel 0
    (for L Lst
      (when (abs (- L Pos))
        (setq Fuel (+ Fuel (apply + (range 1 @))))))
    Fuel))

(test 168 (fuel-at-pos-2 Sample 5))
(test 209 (fuel-at-pos-2 Sample 2))
(test (168 . 5) (sol-a Sample 'fuel-at-pos-2))
(test (99266250 . 488) (sol-a Input 'fuel-at-pos-2))

