#! /bin/bash

PERF_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PERF_BIN=${PERF_DIR}/linux/tools/perf/perf
OUTDIR=${PERF_DIR}/out/"$(date +"%d-%m-%Y")"
OUTFILE=${OUTDIR}/perf.data

mkdir -p ${OUTDIR}

${PERF_BIN} record -F 99 --call-graph dwarf -o ${OUTFILE} -- $*
${PERF_BIN} script -i ${OUTFILE} | c++filt > ${OUTDIR}/out.perf

${PERF_DIR}/FlameGraph/stackcollapse-perf.pl ${OUTDIR}/out.perf > ${OUTDIR}/out.folded
${PERF_DIR}/FlameGraph/flamegraph.pl ${OUTDIR}/out.folded > ${OUTDIR}/out.svg
