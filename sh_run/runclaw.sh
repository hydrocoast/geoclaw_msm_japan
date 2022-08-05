#!/bin/bash

if [ -z "$1" ]; then
    echo "invalid number of the argument"
    echo "usage: $0 NUM_THREADS" 1>&2
    exit 1
fi

export OMP_NUM_THREADS=$1
make && make data && (make output 2>&1 |tee calc.log)
make juliaall && ./creategif.sh
#make matlabplots
