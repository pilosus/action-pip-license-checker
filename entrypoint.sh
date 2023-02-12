#!/bin/bash

#
# Helper functions
#

function parse_list_to_array () {
  # parse string into array
  IFS=',' read -r -a array <<< "$1"

  accumulator=""
  for i in "${array[@]}"
  do
    accumulator="${accumulator} ${2}${i}"
  done
  echo "$accumulator"
}

function verbosity_level_to_string () {
  # trim whitespaces, lowercase
  lower=$( echo "$1" | xargs | tr '[:upper:]' '[:lower:]' )

  # try to match true/false for old way of specifiying verbose option
  # try to match integer for new way of specifying verbosity level
  case $lower in
    true | yes)
      level=1
      ;;
    false | no)
      level=0
      ;;
    *)
      level=$(( ${lower} ))
  esac

  accumulator=""
  for i in $(seq ${level})
  do
    accumulator="${accumulator}v"
  done
  echo "-${accumulator}"
}

#
# Consts
#

# command to run
runner="java -jar /usr/src/app/app.jar"
#runner="java -jar /home/vitaly/git/pip-license-checker/target/uberjar/pip-license-checker-0.38.0-standalone.jar"

# working directory is plugged as docker volume
workdir="/github/workspace"
#workdir="/home/vitaly/git/pip-license-checker/resources"

# use all specified options
cmd=""

if [ ! -z "${1}" ] ; then
  result_1=$(parse_list_to_array "${1}" "--requirements ${workdir}/")
  cmd="${cmd} ${result_1}"
fi

if [ ! -z "${2}" ] ; then
  result_2=$(parse_list_to_array "${2}" "--external ${workdir}/")
  cmd="${cmd} ${result_2}"
fi

if [ ! -z "${3}" ] ; then
  cmd="${cmd} --external-format ${3}"
fi

if [ ! -z "${4}" ] ; then
  cmd="${cmd} --external-options '${4}'"
fi

if [ ! -z "${5}" ] ; then
  result_5=$(parse_list_to_array "${5}" "--fail ")
  cmd="${cmd} ${result_5}"
fi

if [ ! -z "${6}" ] ; then
  cmd="${cmd} --fails-only"
fi

if [ ! -z "${7}" ] ; then
  cmd="${cmd} --exclude '${7}'"
fi

if [ ! -z "${8}" ] ; then
  cmd="${cmd} --exclude-license '${8}'"
fi

if [ ! -z "${9}" ] ; then
  cmd="${cmd} --pre"
fi

if [ ! -z "${10}" ] ; then
  cmd="${cmd} --totals"
fi

if [ ! -z "${11}" ] ; then
  cmd="${cmd} --with-totals"
fi

if [ ! -z "${12}" ] ; then
  cmd="${cmd} --totals-only"
fi

if [ ! -z "${13}" ] ; then
  cmd="${cmd} --headers"
fi

if [ ! -z "${14}" ] ; then
  cmd="${cmd} --table-headers"
fi

if [ ! -z "${15}" ] ; then
  cmd="${cmd} --formatter '${15}'"
fi

if [ ! -z "${16}" ] ; then
  cmd="${cmd} --github-token '${16}'"
fi

if [ ! -z "${17}" ] ; then
  result_17=$(verbosity_level_to_string "${17}")
  cmd="${cmd} ${result_17}"
fi

if [ -z "${1}" ] && [ -z "${2}" ] ; then
  echo "Error: no files provided for check, --requirements and --external are both empty"
fi

# run command and save its exit code
full_command="${runner} ${cmd}"
echo "Running command: ${full_command}"

report=$( eval "$full_command" )
status=$?

# Treat multiline output properly
# https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#multiline-strings
echo "report<<EOF" >> $GITHUB_OUTPUT
echo "$report" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT

if [ "$status" -eq "0" ] ; then
  exit 0
else
  exit 1
fi
