#!/bin/bash
called_path=${0%/*}
stripped=${called_path#[^/]*}
real_path=`pwd`$stripped
dir=`dirname $0`

connstring=--ibname /F"./build/ib"
USERPWD=
#connstring=--ibname /F"~/projects/onec/itil"
#USERPWD=--db-user base --db-pwd 234567890
export RUNNER_ENV=production
pushd $dir
oscript runner.os decompileepf ./build/out/ ./ $connstring $USERPWD
popd
