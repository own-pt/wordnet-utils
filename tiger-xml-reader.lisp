(in-package :cl)

(ql:quickload :cxml)
(ql:quickload :xmls)

(defpackage :tiger-xml-reader
  (:use :cl :cxml))

(in-package :tiger-xml-reader)

(defconstant +corpus-tag+ "corpus")
(defconstant +body-tag+ "body")
(defconstant +sentence-tag+ "s")
(defconstant +graph-tag+ "graph")
(defconstant +terminals-tag+ "terminals")
(defconstant +terminal-tag+ "t")
(defconstant +nonterminals-tag+ "nonterminals")
(defconstant +nonterminal-tag+ "nt")
(defconstant +edge-tag+ "edge")
(defconstant +text-attribute+ "text")
(defconstant +word-attribute+ "word")
(defconstant +lemma-attribute+ "lemma")
(defconstant +pos-attribute+ "pos")

(defun run (file)
  (let* ((bosque (parse-file file (cxml-dom:make-dom-builder)))
         (corpus (elt (dom:get-elements-by-tag-name bosque +corpus-tag+) 0))
         (body (elt (dom:get-elements-by-tag-name corpus +body-tag+) 0))
         (sentences (dom:get-elements-by-tag-name body +sentence-tag+)))
    (dom:do-node-list (sentence sentences)
      (when (dom:element-p sentence)
        (let* ((text (dom:get-attribute sentence +text-attribute+))
               (graph (elt (dom:get-elements-by-tag-name sentence +graph-tag+) 0))
               (terminals 
                (dom:get-elements-by-tag-name 
                 (elt (dom:get-elements-by-tag-name graph +terminals-tag+) 0)
                 +terminal-tag+)))
          (dom:do-node-list (tt terminals)
            (let ((lemma (dom:get-attribute tt +lemma-attribute+))
                  (pos (dom:get-attribute tt +pos-attribute+)))
              (format t "~a ~a~%" lemma pos))))))))
              
(defun small-bosque ()
  (run #p"SmallBosque_CF.xml"))

(defun bosque ()
  (run #p"Bosque_CF_8.0.TigerXML.xml")
  (run #p"Bosque_CP_8.0.TigerXML.xml"))
