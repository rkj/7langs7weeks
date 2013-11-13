(ns .usr.local.google.home.rkj.misc.7lang.6clojure.day1
  "Day 1")

(defn collection-type [v]
  (condp #(%1 %2) v
    list? "list"
    vector? "vector"
    map? "map"
    set? "set"
    ))
(println (collection-type (list 1 2 3)))
(println (collection-type [1 2 3]))

(defn big [st n] (> (count st) n))
(println (big "abc" 2))
(println (big "abc" 3))
