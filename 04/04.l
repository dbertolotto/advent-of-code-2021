(de input-read (File)
  (make
    (in File
      (link
        (mapcar '((X) (format (pack X)))
                (split (line) ",")))
      (until (eof)
        (line) # empty
        (link (tab-add-cols (make
          (for N 5
            (link
              (mapcar '((X) (format (pack X)))
                      (filter and (split (line) " "))))))))))))

(de tab-add-cols (Tab)
  (make
    (for R Tab
      (link R))
    (for N 5
      (link
        (mapcar '((X) (car (nth X N))) Tab)))))

(def 'SampleA (input-read "sampleA.txt"))

(def 'InputA (input-read "inputA.txt"))

(de rem-extr (N Tab)
  (mapcar '((Seq) (filter '((X) (<> X N)) Seq)) Tab))

(de printab (Tab)
  (for Row Tab
    (println Row)))

(de sol-a (Inp)
  (let (Extr (car Inp)
        Tabs (cdr Inp)
        Res NIL)
    (while (and Extr (not Res))
      (let N (pop 'Extr)
        (setq Tabs
          (mapcar '((Tab) (rem-extr N Tab)) Tabs))
        (for Tab Tabs
          (when (member NIL Tab)
            (setq Res (* N (apply + (filter and (fish atom (head 5 Tab))))))))))
    Res))

(test 4512 (sol-a SampleA))
(prinl (sol-a InputA))

(de sol-b (Inp)
  (let (Extr (car Inp)
        Tabs (cdr Inp)
        Res NIL)
    (while (and Extr (> (length Tabs) 0))
      (let (N (pop 'Extr)
            NewTabs NIL)
        (setq Tabs
          (mapcar '((Tab) (rem-extr N Tab)) Tabs))
        (for Tab Tabs
          #(prinl)
          #(prinl N)
          #(printab Tab)
          (if (member NIL Tab)
            (setq Res (* N (apply + (filter and (fish atom (head 5 Tab))))))
            (push 'NewTabs Tab)))
        (setq Tabs NewTabs)))
    Res))

(test 1924 (sol-b SampleA))
(prinl (sol-b InputA))

