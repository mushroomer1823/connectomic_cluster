#!/bin/bash
start_time=`date +%s`
Path=/media/wuye/UG4/UHMCT/HCP

while read i
do
    subPath=${Path}/${i}_7T
    echo ${i}
    if [ ! -f ${subPath}/AMICO/NODDI/FIT_ICVF.nii.gz ]; then
    python /home/wuye/Source/microstructure/fit_NODDI.py ${subPath} dwi_std_align_center_denoise_unring_unbiased.nii.gz bval.txt dwi_std_align_center_denoise_unring_unbiased.bvec dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz
    fi

    if [ ! -f ${subPath}/AMICO/SANDI/FIT_fsoma.nii.gz ]; then
    python /home/wuye/Source/microstructure/fit_SANDI.py ${subPath} dwi_std_align_center_denoise_unring_unbiased.nii.gz bval.txt dwi_std_align_center_denoise_unring_unbiased.bvec dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz -TE 0.0712
    fi

    if [ ! -f ${subPath}/FWDTI/FW.nii.gz ]; then
    python /home/wuye/Source/microstructure/fit_FreeWater.py ${subPath} dwi_std_align_center_denoise_unring_unbiased.nii.gz bval.txt dwi_std_align_center_denoise_unring_unbiased.bvec dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz 
    fi
    
    if [ ! -f ${subPath}/WMTI/AWF.nii.gz ]; then
    python /home/wuye/Source/microstructure/fit_WMTI.py ${subPath} dwi_std_align_center_denoise_unring_unbiased.nii.gz bval.txt dwi_std_align_center_denoise_unring_unbiased.bvec dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz 
    fi

    if [ ! -f ${subPath}/MSDKI/uFA.nii.gz ]; then
    python /home/wuye/Source/microstructure/fit_MSDKI.py ${subPath} dwi_std_align_center_denoise_unring_unbiased.nii.gz bval.txt dwi_std_align_center_denoise_unring_unbiased.bvec dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz 
    fi
done < /media/wuye/UG1/HCP4Atlas/sub4atlas.txt
