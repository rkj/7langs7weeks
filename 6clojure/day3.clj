(ns .usr.local.google.home.rkj.misc.7lang.6clojure.day3
  "TODO(rkj): write a description of the package!")

(def queue-chairs (atom []))
(def barber-chair (atom []))
(def barber (agent []))
(def shop (agent []))
(def counter (atom 0))
(def customer-cut (atom 0))
(def HAIRCUT-TIME 2500)
(def SPAWN-TIME 1000)

(def printer (agent []))

(defn err-handler-fn [ag ex]
  (println "error occured: " ex " and we still have value " @ag))
(set-error-handler! printer err-handler-fn)

(defn get-haircut [customer]
  (send printer println customer " is getting haircut")
  (swap! barber-chair conj customer)
  (Thread/sleep HAIRCUT-TIME)
  (send printer println customer " got haircut")
  (reset! barber-chair [])
  (swap! customer-cut inc))

(defn wait-for-haircut [customer]
  )

(defn customer-action [customer]
  (if (= 0 (count @barber-chair))
    (get-haircut customer)
    (wait-for-haircut customer)))

(defn add-customer [state]
  (let [customer (agent (str "Customer " (swap! counter inc)))]
    (set-error-handler! customer err-handler-fn)
    (send-off customer customer-action)
    []))

(defn spawn [time]
  (send printer println "Spawning")
  (Thread/sleep time)
  (send shop add-customer)
  time)

(defn print-world [who]
  (println "\n**********")
  (println "Barber: " @barber-chair)
  (println "Queue: " @queue-chairs)
  (printf "Customer visited: %d, cut: %d\n" @counter @customer-cut)
  (println "=============\n"))

(while true
  (spawn SPAWN-TIME)
  (send printer print-world))
