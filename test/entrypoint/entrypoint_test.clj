(ns entrypoint.entrypoint-test
  (:require [entrypoint :as e]
            [clojure.test :refer [deftest is testing]]))

(def workspace-path "/my/path")

(def params-generate-option
  [
   [:requirements
    "a.txt,b.txt,c.txt"
    "--requirements '/my/path/a.txt' --requirements '/my/path/b.txt' --requirements '/my/path/c.txt'"
    "Requirements paths list"]
   [:external
    "a.plist"
    "--external '/my/path/a.plist'"
    "External single path"]
   [:external
    ""
    "--external '/my/path'"
    "External no path"]
   [:fail
    "NetworkCopyleft,Error,Other"
    "--fail 'NetworkCopyleft' --fail 'Error' --fail 'Other'"
    "Fail opt list"]
   [:fail
    "NetworkCopyleft"
    "--fail 'NetworkCopyleft'"
    "Fail single opt"]
   [:exclude
    "(?i)^aio.*"
    "--exclude '(?i)^aio.*'"
    "Exclude key-val opt"]
   [:totals
    "true"
    "--totals"
    "Boolean flag opt valid value"]
   [:totals
    "whatever,value,does,not,matter"
    "--totals"
    "Boolean flag opt any value"]
   [:report-format
    "json-pretty"
    "--report-format 'json-pretty'"
    "Report formatting option"]
   [:verbose
    "true"
    "--verbose"
    "Boolean flag with accumulator: boolean value as a valid true string"]
   [:verbose
    "TrUe"
    "--verbose"
    "Boolean flag with accumulator: boolean value as any string"]
   [:verbose
    "yes"
    "--verbose"
    "Boolean flag with accumulator: boolean value as a human-readable true string"]
   [:verbose
    "false"
    ""
    "Boolean flag with accumulator: boolean value as a valid false string"]
   [:verbose
    "no"
    ""
    "Boolean flag with accumulator: boolean value as a human-readable false string"]
   ])

(deftest test-generate-option
  (testing "Testing option generation"
    (doseq [[input value expected description] params-generate-option]
      (testing description
        (with-redefs [e/get-workspace-path (constantly workspace-path)]
          (is (= expected (e/generate-option [input value]))))))))

(def params-get-command-opts
  [[[]
    ""
    "Blank CLI opts string"]
   [(apply
     array-map
     (sequence
      cat [[:requirements "a.txt,b.txt,c.txt"]
           [:external "cocoapods.plist"]
           [:totals "true"]
           [:headers "yes"]
           [:verbose "2"]]))
    (format
     "%s %s %s %s %s"
     "--requirements '/my/path/a.txt' --requirements '/my/path/b.txt' --requirements '/my/path/c.txt'"
     "--external '/my/path/cocoapods.plist'"
     "--totals"
     "--headers"
     "--verbose --verbose")
    "Requirements with totals"]])

(deftest test-get-command-opts
  (testing "Testing generation of full CLI opts for external command"
    (doseq [[inputs expected description] params-get-command-opts]
      (testing description
        (with-redefs [e/get-workspace-path (constantly workspace-path)
                      e/get-env (fn [input] (get inputs input))]
          (is (= expected (e/get-command-opts))))))))
