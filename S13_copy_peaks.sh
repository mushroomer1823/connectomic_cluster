#!/bin/bash
Path=/home/wuye/E_disk
outPath=/media/wuye/UG3/HCP4TractSeg
mkdir -p ${outPath}

while read subj 
do
    echo ${subj}
    mkdir -p ${outPath}/${subj:0:6}
    sh2peaks ${Path}/${subj:0:6}/proc/WM_FODs_7T_norm.mif ${outPath}/${subj:0:6}/peaks.nii.gz -mask ${Path}/${subj:0:6}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz
    cp ${Path}/${subj:0:6}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz ${outPath}/${subj:0:6}/mask.nii.gz
    sh2power ${Path}/${subj:0:6}/proc/WM_FODs_7T_norm.mif ${outPath}/${subj:0:6}/power.nii.gz 
done < subject_7T.txt

