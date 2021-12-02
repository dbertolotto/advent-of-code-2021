(def 'SampleA
  (make
    (in "sampleA.txt"
      (until (eof)
        (link (format (line T)))))))

(def 'InputA
  (make
    (in "inputA.txt"
      (until (eof)
        (link (format (line T)))))))

(de solA (Lst)
  (length
    (filter gt0
      (mapcar - (cdr Lst) Lst))))

(test 7 (solA SampleA))
(prinl (solA InputA))

(de solB (Lst)
  (solA
    (mapcar + (cddr Lst) (cdr Lst) Lst)))

(test 5 (solB SampleA))
(prinl (solB InputA))

