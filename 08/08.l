(load "../util.l")

(de read-inp (File)
  (in File
    (make
      (until (eof)
        (link
          (mapcar '((G) (mapcar sort (filter and (split G " "))))
                  (split (line) "|")))))))

(def 'Sample (read-inp "sample.txt"))
(def 'Input (read-inp "input.txt"))
(def 'Mini (car (read-inp "minisample.txt")))

(de sol-a (Inp)
  (let (Output (mapcar cadr Inp)
        Count 0)
    (for Out Output
      (for Digit Out
        (let L (length Digit)
          (when (or (= 2 L) (= 3 L) (= 4 L) (= 7 L))
            (setq Count (inc Count))))))
    Count))

(test 26 (sol-a Sample))
(test 288 (sol-a Input))

# rules
(de signals (Line)
  (let (Signals (car Line)
        One (car (filter '((S) (= 2 (length S))) Signals))
        Four (car (filter '((S) (= 4 (length S))) Signals)) 
        Seven (car (filter '((S) (= 3 (length S))) Signals))
        Eight (car (filter '((S) (= 7 (length S))) Signals))
        TwoThreeFive (filter '((S) (= 5 (length S))) Signals)
        ZeroSixNine (filter '((S) (= 6 (length S))) Signals)
        Nine (car (filter '((S) (= (length S) (length (uniq (append S Four))))) ZeroSixNine))
        Six (car (filter '((S) (<> (length S) (length (uniq (append S One))))) ZeroSixNine))
        Zero (car (filter '((S) (and (<> S Six) (<> S Nine))) ZeroSixNine))
        Three (car (filter '((S) (= (length S) (length (uniq (append S One))))) TwoThreeFive))
        Five (car (filter '((S) (<> 7 (length (uniq (append S Six))))) TwoThreeFive))
        Two (car (filter '((S) (and (<> S Three) (<> S Five))) TwoThreeFive)))
    (mapcar cons (list Zero One Two Three Four Five Six Seven Eight Nine) (mapcar format (range 0 9)))))

(de digits (Line)
  (let (Signals (signals Line)
        Digits (cadr Line)
        Numbers (mapcar '((D) (cdr (assoc D Signals))) Digits))
    (format (pack Numbers))))

(test 5353 (digits Mini))

(de sol-b (Inp)
  (apply + (mapcar digits Inp)))

(test 61229 (sol-b Sample))
(test 940724 (sol-b Input))

