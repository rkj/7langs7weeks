(ns .usr.local.google.home.rkj.misc.7lang.6clojure.day3
  "TODO(rkj): write a description of the package!")

(def queue-chairs (atom (clojure.lang.PersistentQueue/EMPTY)))
(def barber-chair (atom []))
(def barber (agent []))
(def shop (agent []))
(def counter (atom 0))
(def customer-cut (atom 0))
(def HAIRCUT-TIME 2500)
(def SPAWN-TIME '(1000 2000))

(def HAIRCUT-TIME 20)
(def SPAWN-TIME '(10 30))
(def PRINT-TIME 600)
(def printer (agent 0))
(def LEVEL 20)

(defn myprint [level & more]
  (if (>= level LEVEL)
    (do
      ;(println @printer level)
      ;(send-off printer inc)
      (apply println more)
      ;(send-off printer (fn [msgcount] (apply println more) (inc msgcount)))
      )))

(defn err-handler-fn [ag ex]
  (println "error occured: " ex " and we still have value " @ag)
  (.printStackTrace ex)
  (println "------------"))

(set-error-handler! barber err-handler-fn)
(set-error-handler! shop err-handler-fn)
(set-error-handler! printer err-handler-fn)

(declare do-haircut)

(defn next-client [who]
  (reset! barber-chair [])
  (myprint 10 "barber is handling next client")
  (if (> (count @queue-chairs) 0)
    (let [next-customer (peek @queue-chairs)]
      (swap! queue-chairs pop)
      (myprint 10 "Barber will cut " next-customer " and those are waiting" @queue-chairs)
      (do-haircut next-customer))
    (myprint 10 "barber is going to sleep")))

(defn wake-up [barber customer]
  (do-haircut customer))

(defn do-haircut [customer]
  (myprint 11 customer "is getting haircut")
  (swap! barber-chair conj customer)
  (Thread/sleep HAIRCUT-TIME)
  (myprint 11 customer "got haircut")
  (swap! customer-cut inc)
  (send-off barber next-client))

(defn wait-for-haircut [customer]
  (if (< (count @queue-chairs) 3)
    (swap! queue-chairs conj customer)
    (myprint 12 "Barber is busy and no place for" customer))
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
  (myprint 20 "\n**********")
  (myprint 20 "Barber: " @barber-chair)
  (myprint 20 "Queue: " (seq @queue-chairs))
  (myprint 20 "Customer visited: " @counter "cut: " @customer-cut)
  (myprint 20 "=============\n"))

(def print-loop-agent (agent []))

(defn print-loop [who]
  (while true
    (print-world)
    (Thread/sleep PRINT-TIME)))

(send-off print-loop-agent print-loop)

(defn spawn [times]
  (let [next-sleep (+ (first times) (rand-int (- (second times) (first times))))]
    ;(println "Spawn" times "current" next-sleep)
    (myprint 5 "Spawning" times next-sleep)
    (Thread/sleep next-sleep)
    (send shop add-customer)
    times))

(while true
  (spawn SPAWN-TIME))
