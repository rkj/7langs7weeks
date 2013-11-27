(ns .usr.local.google.home.rkj.misc.7lang.6clojure.day3
  "TODO(rkj): write a description of the package!")

(def queue-chairs (atom []))
(def barber-char (atom []))

(defn add-customer [customer]
  (if (< (count @queue-chairs) 3)
    (swap! queue-chairs conj customer)
    @queue-chairs))

(def spawner (agent 1000))

(defn spawn [time]
  (println "Spawning")
  (Thread/sleep time)
  (add-customer 1)
  time)

(loop [nothing nil]
  (send spawner spawn)
  (println @queue-chairs)
  (recur nil))
