#!/bin/bash
start_time=`date +%s`
Path=/media/wuye/UG4/UHMCT/HCP

[ -e /tmp/fd9 ] || mkfifo /tmp/fd9 
exec 3<>/tmp/fd9
rm -rf /tmp/fd9
for ((i=1;i<=5;i++))
do
    echo >&3
done

for subj in `ls ${Path}/`
do
read -u3
{
    subPath=${Path}/${subj}/proc

    echo ${subPath}
    tckgen -algorithm iFOD1 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -rk4 -seed_dynamic ${subPath}/WM_FODs.mif ${subPath}/WM_FODs.mif ${subPath}/track_ifod1_rk4_dynamic_1M.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD1 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -rk4 -seed_grid_per_voxel ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz 2 ${subPath}/WM_FODs.mif ${subPath}/track_ifod1_rk4_seed_1M.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD1 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -select 1M -rk4 -seed_dynamic ${subPath}/WM_FODs.mif ${subPath}/WM_FODs.mif ${subPath}/track_ifod1_rk4_dynamic_1M_step_30.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD1 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -rk4 -seed_grid_per_voxel ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz 2 ${subPath}/WM_FODs.mif ${subPath}/track_ifod1_rk4_seed_1M_step_30.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD1 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -rk4 -seed_gmwmi ${subPath}/wmgmi.nii.gz ${subPath}/WM_FODs.mif ${subPath}/track_ifod1_rk4_wmgmi_1M.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD1 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -select 1M -rk4 -seed_gmwmi ${subPath}/wmgmi.nii.gz ${subPath}/WM_FODs.mif ${subPath}/track_ifod1_rk4_wmgmi_1M_step_30.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1

    tckgen -algorithm iFOD2 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -seed_dynamic ${subPath}/WM_FODs.mif ${subPath}/WM_FODs.mif ${subPath}/track_ifod2_rk4_dynamic_1M.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD2 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -seed_grid_per_voxel ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz 2 ${subPath}/WM_FODs.mif ${subPath}/track_ifod2_rk4_seed_1M.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1

    tckgen -algorithm iFOD2 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 60 -select 1M -seed_dynamic ${subPath}/WM_FODs.mif ${subPath}/WM_FODs.mif ${subPath}/track_ifod2_rk4_dynamic_1M_step_30.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD2 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 60 -seed_grid_per_voxel ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz 2 ${subPath}/WM_FODs.mif ${subPath}/track_ifod2_rk4_seed_1M_step_30.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD2 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -seed_gmwmi ${subPath}/wmgmi.nii.gz ${subPath}/WM_FODs.mif ${subPath}/track_ifod2_rk4_wmgmi_1M.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1
    tckgen -algorithm iFOD2 -act ${subPath}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 60 -select 1M -seed_gmwmi ${subPath}/wmgmi.nii.gz ${subPath}/WM_FODs.mif ${subPath}/track_ifod2_rk4_wmgmi_1M_step_30.tck -mask ${subPath}/dwi_align_center_denoise_unring_preproc_pad_epi_mask.nii.gz -minlength 20 -maxlength 250  -quiet > /dev/null 2>&1

    echo >&3 
}&
done
wait

stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
exec 3<&-
exec 3>&-

