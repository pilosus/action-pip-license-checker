#!/usr/bin/env bb

(require '[clojure.test :as t]
         '[babashka.classpath :as cp])

(cp/add-classpath "test")

(require 'entrypoint.entrypoint-test)

(def test-results
  (t/run-tests 'entrypoint.entrypoint-test))

(def failures-and-errors
  (let [{:keys [fail error]} test-results]
    (+ fail error)))

(System/exit failures-and-errors)
