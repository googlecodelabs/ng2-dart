#!/bin/bash
# Copyright 2016 Google Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


shopt -s nullglob

EXITSTATUS=0
PASSING=0
WARNINGS=0
FAILURES=0

#####
# Type Analysis

#ANA="dart_analyzer --fatal-type-errors --extended-exit-code --type-checks-for-inferred-types"
# use new experimental analyzer
ANA="dartanalyzer --fatal-type-errors"

echo
echo "Type Analysis, running dart_analyzer..."

pub_result=`pub install`
cmd="$ANA --package-root packages"

for dir in web/*
do
  echo $dir
  # Run pub if there is a pubspec in this code directory.
#  if [ -a "$dir/pubspec.yaml" ]; then
#    pub_result=`pushd $dir && pub install && popd`
#    cmd="$ANA --package-root $dir/packages"
#  else
#    cmd="$ANA"
#  fi

  # Loop through each Dart file in this code directory.
  files="$dir/*.dart"
  for file in $files
  do
    results=`$cmd $file 2>&1`
    exit_code=$?
    if [ $exit_code -eq 2 ]; then
      let FAILURES++
      EXITSTATUS=1
      echo "$results"
      echo "$file: FAILURE."
    elif [ $exit_code -eq 1 ]; then
      let WARNINGS++
      echo "$results"
      echo "$file: WARNING."
    elif [ $exit_code -eq 0 ]; then
      let PASSING++
      echo "$results"
      echo "$file: Passed analysis."
    else
      echo "$file: Unknown exit code: $exit_code."
    fi
    # Remove the output directory so that subsequent test runs will still see
    # the warnings and errors.
    rm -rf out/
  done
done

echo
echo "####################################################"
echo "PASSING = $PASSING"
echo "WARNINGS = $WARNINGS"
echo "FAILURES = $FAILURES"
echo "####################################################"
echo 
exit $EXITSTATUS
