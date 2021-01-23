#! /bin/bash

PERF_BIN=${PWD}/linux/tools/perf/perf
OUTDIR=out/"$(date +"%d-%m-%Y")"
OUTFILE=${OUTDIR}/perf.data

mkdir -p ${OUTDIR}

${PERF_BIN} record -F 99 --call-graph dwarf -o ${OUTFILE} -- $*
${PERF_BIN} script -i ${OUTFILE} | c++filt > ${OUTDIR}/out.perf

${PWD}/FlameGraph/stackcollapse-perf.pl ${OUTDIR}/out.perf > ${OUTDIR}/out.folded
${PWD}/FlameGraph/flamegraph.pl ${OUTDIR}/out.folded > ${OUTDIR}/out.svg
