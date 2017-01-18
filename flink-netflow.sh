#!/bin/bash

OUTPUT="output/netflow"

mkdir -p $OUTPUT
systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.netflow.FlinkNetflow apps/Netflow-1.0.jar --inputFile datasets/netflow000 --outputFile $OUTPUT --flowCount 1
