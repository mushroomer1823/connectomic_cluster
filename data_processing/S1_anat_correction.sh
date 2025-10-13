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
	fslreorient2std ${Path}/${i}/3T/${i}/T1w/T1w_acpc_dc_restore_brain.nii.gz ${outPath}/${i}_3T/t1_std.nii.gz 
    fslreorient2std ${Path}/${i}/3T/${i}/T1w/T2w_acpc_dc_restore_brain.nii.gz ${outPath}/${i}_3T/t2_std.nii.gz 
    fslreorient2std ${Path}/${i}/3T/${i}/T1w/aparc+aseg.nii.gz ${outPath}/${i}_3T/aparc+aseg_std.nii.gz 
    fslreorient2std ${Path}/${i}/3T/${i}/T1w/wmparc.nii.gz ${outPath}/${i}_3T/wmparc_std.nii.gz 
    fslreorient2std ${Path}/${i}/3T/${i}/T1w/T1wDividedByT2w.nii.gz ${outPath}/${i}_3T/T1wDividedByT2w_std.nii.gz 


    # Axis alignment and centering of a DWI image
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_3T/t1_std.nii.gz -o ${outPath}/${i}_3T/t1_stdalign_center 
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_3T/t2_std.nii.gz -o ${outPath}/${i}_3T/t2_std_align_center 
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_3T/aparc+aseg_std.nii.gz -o ${outPath}/${i}_3T/aparc+aseg_std_align_center 
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_3T/wmparc_std.nii.gz -o ${outPath}/${i}_3T/wmparc_std_align_center 
    ${cli}/align.py --axisAlign --center -i ${outPath}/${i}_3T/T1wDividedByT2w_std.nii.gz -o ${outPath}/${i}_3T/T1wDividedByT2w_std_align_center 

done < /media/wuye/UG1/HCP4Atlas/sub4atlas.txt
