#!/bin/bash
Path=/media/wuye/UG4/UHMCT/HCP

for subj in `ls ${Path}/`
do
    subPath=${Path}/${subj}
    if [ -f ${subPath}/t1_stdalign_center.nii.gz ]; then
    if [ ! -f ${subPath}/5TT.mif ]; then
    5ttgen fsl ${subPath}/t1_stdalign_center.nii.gz ${subPath}/5TT.mif -premasked -nocrop -sgm_amyg_hipp
    5tt2gmwmi ${subPath}/5TT.mif ${subPath}/wmgmi.nii.gz
    fi
    fi
done
