(defun get-synset-type (sense-key)
  (destructuring-bind (lemma lex-sense)
      (split-sequence #\% sense-key)
    (destructuring-bind (ss-type lex-filenum lex-id head-word head-id)
        (split-sequence #\: lex-sense)
      (cond ((equal "1" ss-type) "n")
            ((equal "2" ss-type) "v")
            ((equal "3" ss-type) "a")
            ((equal "4" ss-type) "r")
            ((equal "5" ss-type) "a")
            (t nil)))))


(defun process-sense-line (line)
  (destructuring-bind (sense-key synset-offset sense-number tag-cnt)
      (split-sequence #\space line)
    (setf (gethash sense-key *senses*) 
          (format nil "~a-~a" synset-offset (get-synset-type sense-key)))))

