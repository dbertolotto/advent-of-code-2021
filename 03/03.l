(de input-read (File)
  (make
    (in File
      (until (eof)
        (link (mapcar format (line)))))))

(def 'SampleA (input-read "sampleA.txt"))

(def 'InputA (input-read "inputA.txt"))

(de gamma (Samples)
  (let (Size (length (car Samples))
        Len (length Samples)
        Sums (need Size 0))
    (for Meas Samples
      (setq Sums (mapcar + Meas Sums)))
    (mapcar '((X) (/ (* 2 X) Len)) Sums)))

(de epsilon (Gamma)
  (mapcar '((X) (case X (0 1) (1 0))) Gamma))

(de to-dec (Bin)
  (bin (pack Bin)))

(de sol-a (Samples)
  (let (Gamma (gamma Samples)
        Eps (epsilon Gamma))
    (* (to-dec Gamma) (to-dec Eps))))

(test 22 (to-dec (gamma SampleA)))
(test 9 (to-dec (epsilon (gamma SampleA))))
(test 198 (sol-a SampleA))
(prinl (sol-a InputA))

(de most-common (Samples Pos)
  (let (Values (mapcar '((Meas) (nth Meas Pos)) Samples)
        Len (length Samples)
        Sum 0)
    (for Meas Values
      (setq Sum (+ (car Meas) Sum)))
    (/ (* 2 Sum) Len)))

(de least-common (Samples Pos)
  (case (most-common Samples Pos) (0 1) (1 0)))

(de generic (Samples Fn)
  (let (SubSamples Samples
        N 1)
    (while (> (length SubSamples) 1)
      (let MC (Fn SubSamples N)
        (setq SubSamples (filter '((Sub) (= MC (car (nth Sub N)))) SubSamples))
        (setq N (+ 1 N))))
    (car SubSamples)))

(de oxygen (Samples) (generic Samples 'most-common))
(de co2 (Samples) (generic Samples 'least-common))

(de sol-b (Samples)
  (let (O2 (oxygen Samples)
        CO2 (co2 Samples))
    (* (to-dec O2) (to-dec CO2))))

(test 23 (to-dec (oxygen SampleA)))
(test 10 (to-dec (co2 SampleA)))
(prinl (sol-b InputA))
