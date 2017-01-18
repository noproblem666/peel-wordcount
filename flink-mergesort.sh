#!/bin/bash

OUTPUT=$PEEL_OUTPUT"/mergesort"

mkdir -p $OUTPUT

#systems/flink-1.0.3/bin/stop-cluster.sh
#systems/flink-1.0.3/bin/start-cluster.sh

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'

sleep 2
systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.workloads.mergesort.MergeSort apps/MergeSort-1.0.jar --volume 1G --outputFile $OUTPUT --mergeStrategy reduce --listStrategy windowAll
sleep 1

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'

systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.workloads.mergesort.MergeSort apps/MergeSort-1.0.jar --volume 1G --outputFile $OUTPUT --mergeStrategy reduce --listStrategy keyCountWindow
sleep 1

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'

systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.workloads.mergesort.MergeSort apps/MergeSort-1.0.jar --volume 1G --outputFile $OUTPUT --mergeStrategy map --listStrategy windowAll
sleep 1

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'

systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.workloads.mergesort.MergeSort apps/MergeSort-1.0.jar --volume 1G --outputFile $OUTPUT --mergeStrategy map --listStrategy keyCountWindow

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
