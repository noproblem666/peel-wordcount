#!/bin/bash

OUTPUT="$PEEL_OUTPUT/connectedcomponents"

mkdir -p $OUTPUT
rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
#systems/flink-1.0.3/bin/stop-cluster.sh
#systems/flink-1.0.3/bin/start-cluster.sh

sleep 3

#systems/flink-1.0.3/bin/flink run -v -c org.apache.flink.examples.java.graph.ConnectedComponents apps/ConnectedComponents.jar --output $OUTPUT --iterations 1000000
systems/flink-1.0.3/bin/flink run -v systems/flink-1.0.3/examples/batch/ConnectedComponents.jar --output $OUTPUT --iterations 1000000
