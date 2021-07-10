#!/bin/bash

# working directory is plugged as docker volume
workdir="/github/workspace"

# use all specified options
cmd="--requirements ${workdir}/$1"

if [ ! -z "$2" ] ; then
    cmd="${cmd} --fail $2"
fi

if [ ! -z "$3" ] ; then
    cmd="${cmd} --exclude $3"
fi

if [ ! -z "$4" ] ; then
    cmd="${cmd} --pre"
fi

if [ ! -z "$5" ] ; then
    cmd="${cmd} --with-totals"
fi

if [ ! -z "$6" ] ; then
    cmd="${cmd} --totals-only"
fi

if [ ! -z "$7" ] ; then
    cmd="${cmd} --table-headers"
fi

# run command and save its exit code
echo "Running command: java -jar /usr/src/app/app.jar ${cmd}"
report=$( java -jar /usr/src/app/app.jar $cmd)
status=$?

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
