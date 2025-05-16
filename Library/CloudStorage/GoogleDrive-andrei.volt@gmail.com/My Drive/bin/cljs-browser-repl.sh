#!/usr/bin/env bb

(require '[clojure.tools.cli :refer [parse-opts]]
         '[clojure.java.io :as io]
         '[clojure.string :as str]
         '[babashka.process :refer [process]]
         '[hiccup.core :as hiccup])

(def cli-options
  [["-p" "--port PORT" "Port number"
    :default 9000
    :parse-fn #(Integer/parseInt %)
    :validate [#(< 0 % 0x10000) "Must be a number between 0 and 65536"]]
   ["-d" "--dir DIR" "Output directory"
    :default (str (io/file (System/getProperty "user.home") ".cache" "clojure-repl"))]
   ["-h" "--help"]])

(defn exit [status msg]
  (println msg)
  (System/exit status))

(defn error-msg [errors]
  (str "The following errors occurred while parsing your command:\n\n"
       (str/join \newline errors)))

(defn usage [options-summary]
  (->> ["This is a script to set up an interactive ClojureScript REPL environment."
        ""
        "Usage: script [options]"
        ""
        "Options:"
        options-summary]
       (str/join \newline)))

(defn create-html [out-dir out-file]
  (let [tmp-file (str (System/getProperty "java.io.tmpdir") "/srepl.html")]
    (spit tmp-file
          (hiccup/html
           [:html
            [:head
             [:meta {:charset "UTF-8"}]]
            [:body
             [:script {:src (str out-dir "/goog/base.js")}]
             [:script {:src out-file}]
             [:script "goog.require('srepl.browser');"]]]))
    tmp-file))

(defn create-deps-edn [out-dir]
  (spit (str out-dir "/deps.edn")
        {:deps {'org.clojure/clojurescript {:mvn/version "1.11.60"}
                'hiccup/hiccup {:mvn/version "1.0.5"}}}))

(defn create-build-script [out-dir out-file port]
  (spit (str out-dir "/build.clj")
        (pr-str
         `(do
            (require '[cljs.build.api :as build])
            (build/build
             '[(~'ns ~'srepl.browser
                (:require [clojure.browser.repl :as brepl]))
               (brepl/connect
                ~(str "http://localhost:" port "/repl"))]
             {:output-to ~out-file
              :output-dir ~out-dir
              :optimizations :none
              :pretty-print true})))))

(defn -main [& args]
  (let [{:keys [options arguments errors summary]} (parse-opts args cli-options)]
    (cond
      (:help options) (exit 0 (usage summary))
      errors (exit 1 (error-msg errors)))

    (let [out-dir (.getAbsolutePath (io/file (:dir options)))
          out-file (.getAbsolutePath (io/file out-dir "srepl.js"))
          port (:port options)]

      (io/make-parents out-file)
      (create-deps-edn out-dir)
      (create-build-script out-dir out-file port)

      (println "Building ClojureScript...")
      @(process {:dir out-dir} "clojure -M -m cljs.main --compile")

      (let [html-file (create-html out-dir out-file)
            url (str "file://" html-file)]

        (println "Starting REPL... (Press Ctrl+C to exit)")

        (let [repl-process (process {:dir out-dir
                                     :inherit true}
                                    "clj -M -m cljs.main --repl")]
          @repl-process)))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
