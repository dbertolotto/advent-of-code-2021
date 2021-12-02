(de input-read (File)
  (make
    (in File
      (until (eof)
        (link (str (line T)))))))

(def 'SampleA (input-read "sampleA.txt"))

(def 'InputA (input-read "inputA.txt"))

(de move-a (Motion Pos)
  (let ((Dir N) Motion
        (Horiz Depth) Pos)
    (case Dir
      (forward (list (+ Horiz N) Depth))
      (up (list Horiz (- Depth N)))
      (down (list Horiz (+ Depth N))))))

(de sol-a (Lst)
  (let Pos (0 0)
    (for Motion Lst
      (setq Pos (move-a Motion Pos)))
    (println Pos)
    (apply * Pos)))

(test 150 (sol-a SampleA))
(prinl (sol-a InputA))

(de move-b (Motion Pos)
  (let ((Dir N) Motion
        (Horiz Depth Aim) Pos)
    (case Dir
      (forward (list (+ Horiz N) (+ Depth (* N Aim)) Aim))
      (up (list Horiz Depth (- Aim N)))
      (down (list Horiz Depth (+ Aim N))))))

(de sol-b (Lst)
  (let Pos (0 0 0)
    (for Motion Lst
      (setq Pos (move-b Motion Pos)))
    (println Pos)
    (apply * (head 2 Pos))))

(test 900 (sol-b SampleA))
(prinl (sol-b InputA))

