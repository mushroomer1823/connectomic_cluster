#!/bin/bash
Path=/media/wuye/UG4/HCP4Atlas
dataPath=/media/wuye/UG2/HCP4Atlas

nodeList=/home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_17Networks_and_sgm_nodes.txt
subjList=subject_7T.txt
labelPath=/home/wuye/D_disk/Atlas/Yeo/MNI_with_gm


[ -e /tmp/fd4 ] || mkfifo /tmp/fd4 
exec 3<>/tmp/fd4
rm -rf /tmp/fd4
for ((i=1;i<=15;i++))
do
    echo >&3
done

while read index node_1 node_2
do
read -u3
{
    echo ${index} - ${node_1} - ${node_2}
    while read folder
    do
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/tdimap
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_100Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_200Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_300Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_400Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_500Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_600Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_700Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_800Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_900Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_1000Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_DKT

        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_100Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_200Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_300Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_400Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_500Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_600Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_700Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_800Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_900Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_1000Parcels
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_DKT
        rm -r ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_WMPARC

        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/tdimap
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_100Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_200Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_300Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_400Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_500Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_600Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_700Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_800Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_900Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_1000Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_DKT

        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_100Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_200Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_300Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_400Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_500Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_600Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_700Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_800Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_900Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_1000Parcels
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_DKT
        mkdir -p ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_WMPARC

        
        for i in `ls ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/`
        do
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_100Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_100Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_200Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_200Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_300Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_300Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_400Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_400Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_500Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_500Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_600Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_600Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_700Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_700Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_800Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_800Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_900Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_900Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_1000Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_1000Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} /home/wuye/D_disk/Atlas/MNI/nodes_fixSGM.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_DKT/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1

            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_100Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_100Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_200Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_200Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_300Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_300Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_400Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_400Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_500Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_500Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_600Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_600Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_700Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_700Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_800Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_800Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_900Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_900Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_1000Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_1000Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} /home/wuye/D_disk/Atlas/MNI/nodes_fixSGM.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_DKT/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} /home/wuye/D_disk/Atlas/MNI/wmparc_fixed_number.nii.gz ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_WMPARC/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1

            tckmap ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${Path}/${folder}/Parcels_17Networks/${node_1}_${node_2}/tdimap/${i%????}.nii.gz -template ${labelPath}//home/wuye/D_disk/Atlas/Yeo/MNI152_T1_1mm_brain.nii.gz -datatype bit -quiet > /dev/null 2>&1
        done
    done < ${subjList}

        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/tdimap
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_100Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_200Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_300Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_400Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_500Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_600Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_700Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_800Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_900Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_1000Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_DKT

        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_100Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_200Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_300Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_400Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_500Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_600Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_700Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_800Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_900Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_1000Parcels
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_DKT
        rm -r ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_WMPARC

        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/tdimap
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_100Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_200Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_300Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_400Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_500Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_600Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_700Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_800Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_900Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_1000Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/end_connectivity_DKT

        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_100Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_200Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_300Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_400Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_500Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_600Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_700Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_800Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_900Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_1000Parcels
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_DKT
        mkdir -p ${Path}/Parcels_17Networks/${node_1}_${node_2}/pass_connectivity_WMPARC

        for i in `ls ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/`
        do
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_100Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_100Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_200Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_200Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_300Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_300Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_400Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_400Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_500Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_500Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_600Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_600Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_700Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_700Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_800Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_800Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_900Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_900Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_1000Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_1000Parcels/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} /home/wuye/D_disk/Atlas/MNI/nodes_fixSGM.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/end_connectivity_DKT/${i%????}.csv -symmetric -assignment_radial_search 6 -quiet > /dev/null 2>&1

            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_100Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_100Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_200Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_200Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_300Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_300Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_400Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_400Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_500Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_500Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_600Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_600Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_700Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_700Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_800Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_800Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_900Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_900Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${labelPath}/Schaefer2018_1000Parcels_17Networks_order_FSLMNI152_1mm.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_1000Parcels/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} /home/wuye/D_disk/Atlas/MNI/nodes_fixSGM.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_DKT/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1
            tck2connectome ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} /home/wuye/D_disk/Atlas/MNI/wmparc_fixed_number.nii.gz ${Path}/Population_17Networks/${node_1}_${node_2}/pass_connectivity_WMPARC/${i%????}.csv -symmetric -assignment_all_voxels -quiet > /dev/null 2>&1

            tckmap ${Path}/Population_17Networks/${node_1}_${node_2}/Cluster_clean_in_yeo_space/${i} ${Path}/Population_17Networks/${node_1}_${node_2}/tdimap/${i%????}.nii.gz -template ${labelPath}//home/wuye/D_disk/Atlas/Yeo/MNI152_T1_1mm_brain.nii.gz -datatype bit -quiet > /dev/null 2>&1
        done 
    echo >&3 
}&
done < ${nodeList}
wait

exec 3<&-
exec 3>&-
