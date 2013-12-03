(ns .usr.local.google.home.rkj.misc.7lang.6clojure.day3
  "TODO(rkj): write a description of the package!")

(def queue-chairs (atom (clojure.lang.PersistentQueue/EMPTY)))
(def barber-chair (atom []))
(def barber (agent []))
(def shop (agent []))
(def counter (atom 0))
(def customer-cut (atom 0))
(def HAIRCUT-TIME 2500)
(def SPAWN-TIME 1000)
(def PRINT-TIME 600)
(def printer (agent []))

(defn err-handler-fn [ag ex]
  (println "error occured: " ex " and we still have value " @ag)
  (.printStackTrace ex)
  (println "------------"))

(set-error-handler! barber err-handler-fn)
(set-error-handler! shop err-handler-fn)

(declare do-haircut)

(defn next-client [who]
  (reset! barber-chair [])
  (println "barber is handling next client")
  (if (> (count @queue-chairs) 0)
    (let [next-customer (peek @queue-chairs)]
      (swap! queue-chairs pop)
      (println "Barber will cut " next-customer " and those are waiting" @queue-chairs)
      (do-haircut next-customer))
    (println "barber is going to sleep")))

(defn wake-up [barber customer]
  (do-haircut customer))

(defn do-haircut [customer]
  (println customer "is getting haircut")
  (swap! barber-chair conj customer)
  (Thread/sleep HAIRCUT-TIME)
  (println customer "got haircut")
  (swap! customer-cut inc)
  (send-off barber next-client))

(defn wait-for-haircut [customer]
  (if (< (count @queue-chairs) 3)
    (swap! queue-chairs conj customer)
    (println "Barber is busy and no place for" customer))
  customer)

(defn customer-action [customer]
  (if (= 0 (count @barber-chair))
    (send-off barber wake-up customer)
    (wait-for-haircut customer)))

(defn add-customer [state]
  (let [customer (agent (str "Customer " (swap! counter inc)))
        wrapper (agent customer)]
    (set-error-handler! customer err-handler-fn)
    (send-off wrapper customer-action)
    []))

(defn print-world []
  (println "\n**********")
  (println "Barber: " @barber-chair)
  (println "Queue: " (seq @queue-chairs))
  (printf "Customer visited: %d, cut: %d\n" @counter @customer-cut)
  (println "=============\n"))

(defn print-loop [who]
  (while true
    (print-world)
    (Thread/sleep PRINT-TIME)))

(send printer print-loop)

(defn spawn [time]
  (println "Spawning")
  (Thread/sleep time)
  (send shop add-customer)
  time)

(while true
  (spawn SPAWN-TIME))
