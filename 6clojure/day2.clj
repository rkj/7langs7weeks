(defmacro unless [condmine body]
  (list 'if (list not condmine) body))

(defmacro unless2 [condmine body]
  (if (not (eval condmine)) body))

(defmacro unless3 [condmine body]
  (list 'if (not condmine) body))

(defmacro unless4 [condmine body]
  '(if (not condmine) body))

(unless2 true (println "bla2"))
(unless2 false (println "bla3"))

(comment
(defn unlessfn [test body]
  (if (not test) (body)))

(unlessfn (> 1 2) (fn [] (println "blah")))
(if (< 1 2) (println "bla"))

(defn create-colors []
  (println "Creating colors")
  ["red", "green", "blue"])
(defn small-word? [x]
  (println "Is small word? " x)
  (< (count x) 4))

(println (for [x (create-colors), :when (small-word? x)]
  (do (println "In a for body")
  (str "I like " x))))
  )
