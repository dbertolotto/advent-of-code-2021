(load "../util.l")

(de read-inp (File)
  (in File
    (mapcar format
      (mapcar pack
        (split (line) ",")))))

(def 'Sample (read-inp "sample.txt"))
(def 'Input (read-inp "input.txt"))

(de load-data (Lst)
  (let B (new +BTree)
    (for L Lst
      (if (get> B L)
        (put> B L (+ 1 @))
        (put> B L 1)))
    B))

(de add (B K V)
  (if (get> B K)
    (put> B K (+ V @))
    (put> B K V)))

(de day-loop (B)
  (let BNew (new +BTree)
    (for K (keys> B)
      (cond
        ((> K 0) (add BNew (- K 1) (get> B K)))
        ((= K 0)
          (add BNew 6 (get> B 0))
          (add BNew 8 (get> B 0)))))
    BNew))

(de sol-a (Inp Days)
  (let B (load-data Inp)
    (for D Days
      (setq B (day-loop B)))
    (apply + (vals> B))))

(test 26 (sol-a Sample 18))
(test 5934 (sol-a Sample 80))
(test 385391 (sol-a Input 80))
(test 26984457539 (sol-a Sample 256))
(test 1728611055389 (sol-a Input 256))
