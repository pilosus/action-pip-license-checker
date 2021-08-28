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


#
# Consts
#

# working directory is plugged as docker volume
workdir="/github/workspace"

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
  cmd="${cmd} --external-options ${4}"
fi

if [ ! -z "${5}" ] ; then
  result_5=$(parse_list_to_array "${5}" "--fail ")
  cmd="${cmd} ${result_5}"
fi

if [ ! -z "${6}" ] ; then
  cmd="${cmd} --fails-only"
fi

if [ ! -z "${7}" ] ; then
  cmd="${cmd} --exclude ${7}"
fi

if [ ! -z "${8}" ] ; then
  cmd="${cmd} --exclude-license ${8}"
fi

if [ ! -z "${9}" ] ; then
  cmd="${cmd} --pre"
fi

if [ ! -z "${10}" ] ; then
  cmd="${cmd} --with-totals"
fi

if [ ! -z "${11}" ] ; then
  cmd="${cmd} --totals-only"
fi

if [ ! -z "${12}" ] ; then
  cmd="${cmd} --table-headers"
fi

if [ -z "${1}" ] && [ -z "${2}" ] ; then
  echo "Error: no files provided for check, --requirements and --external are both empty"
fi

# run command and save its exit code
echo "Running command: java -jar /usr/src/app/app.jar ${cmd}"
report=$( java -jar /usr/src/app/app.jar $cmd)
status=$?

# formatting is broken, used for debugging only
# e.g. validation errors output
echo "Output"
echo $report

# ugly formatting to make multi-line string work
# https://github.community/t/set-output-truncates-multiline-strings/16852
report="${report//'%'/'%25'}"
report="${report//$'\n'/'%0A'}"
report="${report//$'\r'/'%0D'}"

echo "::set-output name=report::$report"

if [ "$status" -eq "0" ] ; then
  exit 0
else
  exit 1
fi
