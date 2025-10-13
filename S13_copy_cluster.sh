#!/bin/bash
Path=/media/wuye/UG4/HCP4Atlas
outPath=/media/wuye/UG3/Parcels_7Networks
mkdir -p ${outPath}
mkdir -p ${outPath}/Population_7Networks

while read index node_1 node_2
do
    while read subj 
    do
        echo ${subj}
        mkdir -p ${outPath}/${subj:0:6}
        mkdir -p ${outPath}/${subj:0:6}/${node_1}_${node_2}
        rsync -avzh ${Path}/${subj}/Parcels_7Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space ${outPath}/${subj:0:6}/${node_1}_${node_2}/
        rsync -avzh ${Path}/${subj}/Parcels_7Networks/${node_1}_${node_2}/Cluster ${outPath}/${subj:0:6}/${node_1}_${node_2}/
        sleep 1s
    done < subject_7T.txt

    mkdir -p ${outPath}/Population_7Networks/${node_1}_${node_2}/
    rsync -avzh ${Path}/Population_7Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space ${outPath}/Population_7Networks/${node_1}_${node_2}/
    sleep 1s

done < /home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_7Networks_and_sgm_nodes.txt
