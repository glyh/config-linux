#!/usr/bin/env bb

(require '[clojure.edn :as edn]
         '[clojure.java.shell :as shell]
         '[clojure.string :as str])

(defn expand-dir [s]
  (if (.startsWith s "~")
    (str/replace-first s "~" (System/getProperty "user.home"))
    s))

(defn stow-one [package target]
  (let [result (shell/sh "stow" "-d" "./dot-files" "-t" target "-S" package)] 
    (locking *out*
      (println 
       (str "Result " (:exit result) ": " 
            (if (empty? (:err result)) "Success" (:err result)))))))

(defn stow-all []
  (println "Stowing...")
  (->> (slurp "./dot-files/targets.edn")
       (edn/read-string)
       (pmap (fn [x] (stow-one (:dir x)  
                               (expand-dir (:target x))))))
  (println "Stowed!"))

(stow-all)
