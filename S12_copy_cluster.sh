#!/bin/bash
Path=/media/wuye/UG4/HCP4Atlas
outPath=/media/wuye/UG3/Parcels_17Networks
mkdir -p ${outPath}
mkdir -p ${outPath}/Population_17Networks

while read index node_1 node_2
do
    while read subj 
    do
        echo ${subj}
        mkdir -p ${outPath}/${subj:0:6}
        mkdir -p ${outPath}/${subj:0:6}/${node_1}_${node_2}
        rsync -avzh ${Path}/${subj}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space ${outPath}/${subj:0:6}/${node_1}_${node_2}/
        rsync -avzh ${Path}/${subj}/Parcels_17Networks/${node_1}_${node_2}/Cluster ${outPath}/${subj:0:6}/${node_1}_${node_2}/
        sleep 1s
    done < subject_7T.txt

    mkdir -p ${outPath}/Population_17Networks/${node_1}_${node_2}/
    rsync -avzh ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space ${outPath}/Population_17Networks/${node_1}_${node_2}/
    sleep 1s

done < temp.txt
