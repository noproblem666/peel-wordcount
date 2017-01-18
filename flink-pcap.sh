#!/bin/bash

OUTPUT=$PEEL_OUTPUT"/pcap"
INPUT=datasets/200610041400.dump
JAR="apps/Pcap-assembly-1.0.jar"
mkdir -p $OUTPUT

#systems/flink-1.0.3/bin/stop-cluster.sh
#systems/flink-1.0.3/bin/start-cluster.sh

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'

sleep 2
ANALYSIS="bytesPerDestIp"
systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.pcap.FlinkPcap $JAR --inputFile $INPUT --analysis $ANALYSIS --packetCount 1000 --outputFile $OUTPUT
sleep 1

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'

ANALYSIS="bytesPerSrcIp"
systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.pcap.FlinkPcap $JAR --inputFile $INPUT --analysis $ANALYSIS --packetCount 1000 --outputFile $OUTPUT
sleep 1

rm $OUTPUT/*
ssh loadgen113 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen114 '/usr/local/share/peel/peel-wordcount/rm_output.sh'
ssh loadgen115 '/usr/local/share/peel/peel-wordcount/rm_output.sh'

ANALYSIS="bytesPerPorts"
systems/flink-1.0.3/bin/flink run -v -c berlin.bbdc.inet.flink.pcap.FlinkPcap $JAR --inputFile $INPUT --analysis $ANALYSIS --packetCount 1000 --outputFile $OUTPUT
