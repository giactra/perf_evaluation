#! /bin/bash

PERF_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export PATH=${PERF_DIR}/linux/tools/perf:${PATH}
