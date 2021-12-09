(load "../util.l")

(de input-read (File)
  (make
    (in File
      (until (eof)
        (let (Line (split (line) " ")
              Start (mapcar format (mapcar pack (split (car Line) ",")))
              End (mapcar format (mapcar pack (split (caddr Line) ","))))
          (link (list Start End)))))))

(def 'SampleA (input-read "sampleA.txt"))

(def 'InputA (input-read "inputA.txt"))

(de line-pts-hv (LineDef)
  (let ((Start End) LineDef
        (XS YS) Start
        (XE YE) End)
    (cond
      ((and (= XS XE) (<> YS YE)) # horizontal line
        (mapcar '((Y) (cons XS Y)) (range YS YE)))
      ((and (<> XS XE) (= YS YE)) # vertical line
        (mapcar '((X) (cons X YS)) (range XS XE))))))

(de sol-a (Inp)
  (let (Pts (filter and (mapcar line-pts-hv Inp))
        Map (new +BTree))
    (for Line Pts
      (for P Line
        (if (get> Map P)
          (put> Map P (+1 @))
          (put> Map P 1))))
    (length (filter '((V) (> V 1)) (vals> Map)))))

(test 5 (sol-a SampleA))
(prinl (sol-a InputA))

(de line-pts (LineDef)
  (let ((Start End) LineDef
        (XS YS) Start
        (XE YE) End)
    (cond
      ((and (= XS XE) (<> YS YE)) # horizontal line
        (mapcar '((Y) (cons XS Y)) (range YS YE)))
      ((and (<> XS XE) (= YS YE)) # vertical line
        (mapcar '((X) (cons X YS)) (range XS XE)))
      (T (mapcar '((X Y) (cons X Y)) (range XS XE) (range YS YE))))))

(de sol-b (Inp)
  (let (Pts (filter and (mapcar line-pts Inp))
        Map (new +BTree))
    (for Line Pts
      (for P Line
        (if (get> Map P)
          (put> Map P (+1 @))
          (put> Map P 1))))
    (length (filter '((V) (> V 1)) (vals> Map)))))

(test 12 (sol-b SampleA))
(prinl (sol-b InputA))
