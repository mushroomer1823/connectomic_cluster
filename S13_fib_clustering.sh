#!/bin/bash
Path=/data/wuye/Population
SubjectList=/data/wuye/Schaefer2018_100Parcels_7Networks_and_sgm_nodes.txt

while read index node_1 node_2
do
    python runClustering.py ${Path}/${node_1}_${node_2}/track_native_rs_in_yeo_space.h5
done < ${SubjectList}

