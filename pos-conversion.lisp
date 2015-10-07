(defun pos-to-ukb (pos)
  (cond ((starts-with-subseq "N" pos) "n")
        ((starts-with-subseq "V" pos) "v")
        ((starts-with-subseq "J" pos) "a")
        ((starts-with-subseq "R" pos) "r")
        (t nil)))

