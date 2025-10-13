#!/bin/bash
Path=/media/wuye/UG1/HCP4Atlas
outPath=/media/wuye/UG4/UHMCT/HCP
mkdir -p ${outPath}
cli=/home/wuye/Software/pnlNipype/scripts
while read i
do
    echo ${i}
    mkdir -p ${outPath}/${i}_3T

    # reorienting the image to match the approximate orientation of the standard template images.
	fslreorient2std ${Path}/${i}/3T/${i}/T1w/Diffusion/data.nii.gz ${outPath}/${i}_3T/dwi_std.nii.gz 

    # Axis alignment and centering of a DWI image
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_3T/dwi_std.nii.gz --bvals ${Path}/${i}/3T/${i}/T1w/Diffusion/bvals --bvecs ${Path}/${i}/3T/${i}/T1w/Diffusion/bvecs -o ${outPath}/${i}_3T/dwi_std_align_center 

    mrconvert ${outPath}/${i}_3T/dwi_std_align_center.nii.gz ${outPath}/${i}_3T/dwi_std_align_center.mif -fslgrad ${outPath}/${i}_3T/dwi_std_align_center.bvec ${outPath}/${i}_3T/dwi_std_align_center.bval -datatype float32 -strides 0,0,0,1 -quiet 

    # dMRI denoising using Marchenko-Pastur PCA
    dwidenoise ${outPath}/${i}_3T/dwi_std_align_center.nii.gz ${outPath}/${i}_3T/dwi_std_align_center_denoise.nii.gz -quiet 

    # Remove Gibbs Ringing Artifacts
    mrdegibbs ${outPath}/${i}_3T/dwi_std_align_center_denoise.nii.gz ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring.nii.gz -axes 0,1 -quiet 
    nifti_bet_mask --bvals ${outPath}/${i}_3T/dwi_std_align_center.bval -i ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring.nii.gz -o ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased 

    dwibiascorrect ants ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring.nii.gz ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased.nii.gz -fslgrad ${outPath}/${i}_3T/dwi_std_align_center.bvec ${outPath}/${i}_3T/dwi_std_align_center.bval -quiet 

    dwigradcheck ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased.nii.gz -fslgrad ${outPath}/${i}_3T/dwi_std_align_center.bvec ${outPath}/${i}_3T/dwi_std_align_center.bval -export_grad_fsl ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased.bvec ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased.bval -mask ${outPath}/${i}_3T/dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz -quiet 

    mkdir -p ${outPath}/${i}_7T

    # reorienting the image to match the approximate orientation of the standard template images.
	fslreorient2std ${Path}/${i}/7T/${i}/T1w/Diffusion_7T/data.nii.gz ${outPath}/${i}_7T/dwi_std.nii.gz 

    # Axis alignment and centering of a DWI image
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_7T/dwi_std.nii.gz --bvals ${Path}/${i}/7T/${i}/T1w/Diffusion_7T/bvals --bvecs ${Path}/${i}/7T/${i}/T1w/Diffusion_7T/bvecs -o ${outPath}/${i}_7T/dwi_std_align_center 

    mrconvert ${outPath}/${i}_7T/dwi_std_align_center.nii.gz ${outPath}/${i}_7T/dwi_std_align_center.mif -fslgrad ${outPath}/${i}_7T/dwi_std_align_center.bvec ${outPath}/${i}_7T/dwi_std_align_center.bval -datatype float32 -strides 0,0,0,1 -quiet 

    # dMRI denoising using Marchenko-Pastur PCA
    dwidenoise ${outPath}/${i}_7T/dwi_std_align_center.nii.gz ${outPath}/${i}_7T/dwi_std_align_center_denoise.nii.gz -quiet 

    # Remove Gibbs Ringing Artifacts
    mrdegibbs ${outPath}/${i}_7T/dwi_std_align_center_denoise.nii.gz ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring.nii.gz -axes 0,1 -quiet 
    nifti_bet_mask --bvals ${outPath}/${i}_7T/dwi_std_align_center.bval -i ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring.nii.gz -o ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased 

    dwibiascorrect ants ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring.nii.gz ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.nii.gz -fslgrad ${outPath}/${i}_7T/dwi_std_align_center.bvec ${outPath}/${i}_7T/dwi_std_align_center.bval -quiet 

    dwigradcheck ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.nii.gz -fslgrad ${outPath}/${i}_7T/dwi_std_align_center.bvec ${outPath}/${i}_7T/dwi_std_align_center.bval -export_grad_fsl ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.bvec ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased.bval -mask ${outPath}/${i}_7T/dwi_std_align_center_denoise_unring_unbiased_mask.nii.gz -quiet 

done < /media/wuye/UG1/HCP4Atlas/sub4atlas.txt
