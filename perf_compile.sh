#! /bin/bash

export CC=gcc
make clean -C linux/tools/perf
make -j`nproc` -C linux/tools/perf
