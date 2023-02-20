#!/usr/bin/env bb

(ns entrypoint
  (:require
   [clojure.string :as str]
   [babashka.fs :as fs]
   [babashka.process :refer [shell]]))

;; aux fns

(defn get-opt-name
  "Conver input field keyword to string option name"
  [input]
  (-> input
      name))

(defn get-env
  "Get environment variable value for input keyword"
  [input]
  (let [s (-> input
              name
              str/upper-case)
        env (format "INPUT_%s" s)
        value (System/getenv env)
        result (if (str/blank? value) nil value)]
    result))

(defn get-action-debug
  "Is action running in debug mode?"
  []
  (System/getenv "ACTION_DEBUG"))

(defn get-workspace-path
  "Get workdir on a GHA runner mounted as a volume to action container"
  []
  (or (System/getenv "GITHUB_WORKSPACE")
      "/github/workspace"))

(defn get-command-base
  "Get action entrypoint base command.
  Env mostly used for testing purposes:
  ACTION_ENTRYPOINT='java -jar /local/path/to/custom.jar' ./entrypoint ..."
  []
  (or (System/getenv "ACTION_ENTRYPOINT")
      "java -jar /usr/src/app/app.jar"))

(defn get-output-path
  "Get path to append output"
  []
  (System/getenv "GITHUB_OUTPUT"))

(defn output-append!
  "Append multiline string to action output or print to stdout in debug mode"
  [s]
  (let [path (get-output-path)
        output (str/trim s)
        lines ["report<<EOF" output "EOF"]]
    (if (get-action-debug)
      (println output)
      (fs/write-lines path lines {:append true}))))

(defn format-opt
  "Convert internal option name to external CLI option"
  ([opt]
   (format "--%s" opt))
  ([opt value]
   (format "--%s '%s'" opt value)))

;; input values parsing fns

(defn parse-list-path
  "Parse option with array of comma-separated filenames"
  [opt value]
  (let [base-path (get-workspace-path)
        values (-> value (str/split #","))
        result (->> values
                    (map #(fs/path base-path %))
                    (map #(format-opt opt %))
                    (str/join " "))]
    result))

(defn parse-list-opt
  "Parse option with array value (string with comma-separated values).
  E.g. fail: 'NetworkCopyleft,Error' => --fail 'NetworkCopyleft' --fail 'Error'"
  [opt value]
  (let [values (-> value (str/split #","))
        result (->> values
                    (map #(format-opt opt %))
                    (str/join " "))]
    result))

(defn parse-boolean-flag
  "Parse boolean flag options (no value, only option name available).
  E.g. pre: true => --pre"
  [opt _]
  (format-opt opt))

(defn parse-key-val-opt
  "Parse standard option flags with simple string values.
  E.g. external: 'deps.plist' => --external 'deps.plist'"
  [opt value]
  (format-opt opt value))

(defn parse-boolean-accumulator
  "Parse boolean flag option with optional accumulation.
  Valid values: ((true|false|yes|no)|[0..9]+)"
  [opt value]
  (let [s (-> value str/lower-case str/trim)
        level (cond
                (contains? #{"false" "no"} s) 0
                (contains? #{"true" "yes"} s) 1
                :else (Integer/parseInt s))
        repeated (repeat level (format-opt opt))
        result (str/join " " repeated)]
    result))

;; inputs mapping

(def inputs
  "Ordered array-map of input fields to parsing functions mapping.

  NB! Assume input field names match external program's CLI options."
  (apply
   array-map
   (sequence
    cat
    [[:requirements parse-list-path]
     [:external parse-list-path]
     [:external-format parse-key-val-opt]
     [:external-options parse-key-val-opt]
     [:fail parse-list-opt]
     [:fails-only parse-boolean-flag]
     [:exclude parse-key-val-opt]
     [:exclude-license parse-key-val-opt]
     [:pre parse-boolean-flag]
     [:totals parse-boolean-flag]
     [:with-totals parse-boolean-flag]
     [:totals-only parse-boolean-flag]
     [:headers parse-boolean-flag]
     [:table-headers parse-boolean-flag]
     [:formatter parse-key-val-opt]
     [:github-token parse-key-val-opt]
     [:verbose parse-boolean-accumulator]])))

;; generate external command options

(defn generate-option
  "Generate option string for external program by input field and its value"
  [[input value]]
  (let [parse-fn (get inputs input)
        opt (get-opt-name input)]
    (parse-fn opt value)))

(defn get-command-opts
  "Generate command with all arguments and options"
  []
  (let [input-to-value
        (->> inputs
             keys
             (map get-env)
             (map vector (keys inputs)) ;; like zipmap but with order preserved
             (remove (fn [[_ value]] (nil? value))))
        external-opts
        (->>
         input-to-value
         (map generate-option)
         (str/join " "))]
    external-opts))

(defn exec!
  "Run external command with all arguments and options passed into the action"
  []
  (let [cmd (format "%s %s" (get-command-base) (get-command-opts))
        _ (when (get-action-debug) (println (format "Running: %s" cmd)))
        proc (shell {:continue true :out :string} cmd)]
    (output-append! (:out proc))
    (System/exit (:exit proc))))

(when (= *file* (System/getProperty "babashka.file"))
  (exec!))
