#!/bin/bash
Path=/media/wuye/UG1/HCP4Atlas
outPath=/media/wuye/UG4/UHMCT/HCP
mkdir -p ${outPath}
cli=/home/wuye/Software/pnlNipype/scripts
while read i
do
    echo ${i}
    dwibiascorrect ants ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring.nii.gz ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.nii.gz -fslgrad ${outPath}/${i}_7T/dwi_std_align_center.bvec ${outPath}/${i}_7T/bval.txt -quiet 

    dwigradcheck ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.nii.gz -fslgrad ${outPath}/${i}_7T/dwi_std_align_center.bvec ${outPath}/${i}_7T/dwi_std_align_center.bval -export_grad_fsl ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.bvec ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.bval -mask ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz -quiet 

done < /media/wuye/UG1/HCP4Atlas/sub4atlas.txt

