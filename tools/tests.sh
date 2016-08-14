#!/bin/bash
called_path=${0%/*}
stripped=${called_path#[^/]*}
real_path=`pwd`$stripped
#echo "called path: $called_path"
#echo "stripped: $stripped"
#echo "pwd: `pwd`"
#echo "real path: $real_path"

mode=$1
if [ -z "$mode" ]; then
    mode="${real_path}/../tools/JSON/VBParams837UF.json"
fi

connstring="--ibname /F${real_path}/../build/ib"
USERPWD=
#connstring=--ibname /F"~/projects/onec/itil"
#USERPWD=--db-user base --db-pwd 234567890
export RUNNER_ENV=production
export VANESSA_commandscreenshot="import -window root " 

oscript $real_path/runner.os vanessa --path "$real_path/../build/out/vanessa-behavior.epf" --pathsettings "$mode" $connstring $USERPWD
