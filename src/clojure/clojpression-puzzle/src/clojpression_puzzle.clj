(ns clojpression-puzzle
  (:require [clojure.test :refer [is]]))

(def compress (partial transduce (comp (partition-by identity)
                                       (mapcat (fn [[c & _ :as cs]]
                                                 [(count cs) c])))
                                 str))

(defn run [& _]
  (is (= (compress "AAABBAAC") "3A2B2A1C")))
  ;; (println (is (compress "AAABBAAC")))
