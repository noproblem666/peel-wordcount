#!/bin/bash

DATASETS="/home/$USER/datasets/kmeans"

mkdir -p $DATASETS
systems/flink-1.0.3/bin/flink run -v -c org.apache.flink.examples.java.clustering.util.KMeansDataGenerator apps/KMeans.jar --points 1000000 --k 1000 --output $DATASETS

