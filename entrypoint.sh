#!/bin/sh -l

cmd="java -jar app.jar --requirements /volume/$1"

if [ ! -z "$2" ] ; then
    cmd="${cmd} --fail $2"
fi

if [ ! -z "$3" ] ; then
    cmd="${cmd} --exclude $3"
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

if [ ! -z "$6" ] ; then
    cmd="${cmd} --table-headers"
fi

echo "Running command: ${cmd}"
report=$(eval $cmd)
echo "::set-output name=report::$report"
