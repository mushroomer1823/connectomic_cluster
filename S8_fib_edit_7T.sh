#!/bin/bash
Path=/media/wuye/UG1/HCP4Atlas

while read subj 
do
    subPath=${Path}/${subj}/proc
    subj2=${subj/7T/3T}
    subPath2=${Path}/${subj2}/proc
    echo ${subj}

    rm ${Path}/${subj}/temp.tck 
    #rm ${Path}/${subj}/track_native_rs.tck
    #rm -r ${Path}/${subj}/Yeo

    if [ ! -f ${Path}/${subj}/track_native_rs.tck ]; then
        tckedit ${subPath}/*.tck ${Path}/${subj}/temp.tck 
        tckresample ${Path}/${subj}/temp.tck ${Path}/${subj}/track_native_rs.tck -num_points 30 
        rm ${Path}/${subj}/temp.tck 
    fi

    if [ ! -f ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space.tck ]; then
        warp=${subPath2}/Yeo/mrtrix_warp_corrected_for_track_Sub2Atlas.mif
        mkdir -p ${Path}/${subj}/Yeo
        tcktransform ${Path}/${subj}/track_native_rs.tck ${warp} ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space.tck
    fi

    if [ ! -f ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space_connectome_100Parcels_17Networks.csv ]; then
        tck2connectome ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space.tck /home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_17Networks_and_sgm.nii.gz ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space_connectome_100Parcels_17Networks.csv -out_assignments ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space_connectome_100Parcels_17Networks.txt -symmetric 
    fi
    
    if [ ! -f ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space_connectome_100Parcels_7Networks.csv ]; then
        tck2connectome ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space.tck /home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_7Networks_and_sgm.nii.gz ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space_connectome_100Parcels_7Networks.csv -out_assignments ${Path}/${subj}/Yeo/track_native_rs_in_yeo_space_connectome_100Parcels_7Networks.txt -symmetric
    fi
done < subject_7T_tckedit.txt

