#!/usr/bin/env bb

(require '[clojure.edn :as edn]
         '[clojure.java.shell :as shell]
         '[clojure.string :as str])

(defn expand-home [s]
  (if (.startsWith s "~")
    (str/replace-first s "~" (System/getProperty "user.home"))
    s))

(defn mkdir-p [dir]
  (let [result (shell/sh "mkdir" "-p" dir)]
    (if (zero? (:exit result))
      ()
      (list (str "Failed(" (:exit result) "): " (:err result))))))

(defn cp-r [source dest]
  (let [result (shell/sh "cp" "-r" source dest)]
    (if (zero? (:exit result))
      ()
      (list (str "Failed(" (:exit result) "): " (:err result))))))

(defn copy-statics [source dest]
  (concat (mkdir-p dest) (cp-r source dest)))

(defn copy-all-statics []
  ; Solve static files
  (let [potential-errors (->> (slurp "./static/mappings.edn")
              (edn/read-string)
              (pmap (fn [x] 
                      (copy-statics (str "./static/" (:source x) "/.") (:dest x))))
              (flatten))]
    (if (empty? potential-errors) 
      "Successfully copied all static files"
      potential-errors)) 
 )

(defn -main []
  (println (copy-all-statics)))

(-main)
