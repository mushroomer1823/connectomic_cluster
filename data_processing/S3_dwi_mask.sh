#!/bin/bash
Path=/media/wuye/UG1/HCP4Atlas
outPath=/media/wuye/UG4/UHMCT/HCP
mkdir -p ${outPath}
cli=/home/wuye/Software/pnlNipype/scripts
while read i
do
    echo ${i}
    mkdir -p ${outPath}/${i}_3T
    rm ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz

    # reorienting the image to match the approximate orientation of the standard template images.
	fslreorient2std ${Path}/${i}/3T/${i}/T1w/Diffusion/nodif_brain_mask.nii.gz ${outPath}/${i}_3T/mask_std.nii.gz 

    # Axis alignment and centering of a DWI image
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_3T/mask_std.nii.gz -o ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased_mask 

    mkdir -p ${outPath}/${i}_7T
    rm ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz

    # reorienting the image to match the approximate orientation of the standard template images.
	fslreorient2std ${Path}/${i}/7T/${i}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz ${outPath}/${i}_7T/mask_std.nii.gz 

    # Axis alignment and centering of a DWI image
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_7T/mask_std.nii.gz -o ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased_mask 

done < /media/wuye/UG1/HCP4Atlas/sub4atlas.txt
