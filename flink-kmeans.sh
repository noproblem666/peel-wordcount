#!/bin/bash

hdfs namenode -format -force -nonInteractive
OUTPUT="hdfs://loadgen112:8020/$USER/output"
INPUT="hdfs://loadgen112:8020/$USER/input"
GENERATED="generated/kmeans"
mkdir -p $GENERATED
echo "Starting HDFS" 
systems/hadoop-2.7.1/sbin/start-dfs.sh
echo "Configuring HDFS for KMeans"
sleep 2
sleep 2
hdfs dfs -mkdir -p $INPUT
hdfs dfs -mkdir -p $OUTPUT
echo "Starting Flink"
systems/flink-1.0.3/bin/start-cluster.sh
echo "Waiting 5 seconds"
sleep 5
systems/flink-1.0.3/bin/flink run -v -c org.apache.flink.examples.java.clustering.util.KMeansDataGenerator apps/KMeans.jar --points 1000 --k 10 --output $GENERATED
hdfs dfs -put $GENERATED $INPUT
sleep 1
systems/flink-1.0.3/bin/flink run -v -c org.apache.flink.examples.java.clustering.KMeans apps/KMeans.jar --points $INPUT/kmeans/points --centroids $INPUT/kmeans/centers --output $OUTPUT/kmenas --iterations 11
systems/flink-1.0.3/bin/stop-cluster.sh
systems/hadoop-2.7.1/sbin/stop-dfs.sh
