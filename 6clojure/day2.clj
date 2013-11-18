(defmacro unless [test body]
  (if (not test) body))
