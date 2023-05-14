#!/bin/bash

path="$1"
if [ -z "$path" ]
then
  echo "must specify path argument"
  exit 1
fi

if [ -d "$path" ]
then
  echo "install location exists: $path"
else
  echo "install location doesn't exist: $path"
  exit 1
fi

if command -v ifort &> /dev/null
then
  echo "Fortran classic compiler found"
else
  echo "Fortran classic compiler not available"
  exit 1
fi

ifort test/hw.f90 -o hw
output=$(./hw '2>&1')
if [[ "$output" == *"hello world"* ]]
then
  echo "Fortran program compilation succeeded"
  echo "$output"
else
  echo "Fortran program gave unexpected output: $output"
  exit 1
fi
