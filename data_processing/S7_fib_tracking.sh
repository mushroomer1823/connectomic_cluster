#!/bin/bash
start_time=`date +%s`
Path=/media/wuye/UG1/HCP4Atlas

[ -e /tmp/fd9 ] || mkfifo /tmp/fd9 
exec 3<>/tmp/fd9
rm -rf /tmp/fd9
for ((i=1;i<=5;i++))
do
    echo >&3
done

while read subj 
do
read -u3
{
    subPath=${Path}/${subj}/proc
    subj2=${subj/7T/3T}
    subPath2=${Path}/${subj2}/proc

    echo ${subPath}
    if [ ! -f ${Path}/${subj}/track_native_rs.tck ]; then

        if [ ! -f ${subPath}/track_det_rk4_dynamic_1M.tck ]; then
        tckgen -algorithm SD_STREAM -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -rk4 -seed_dynamic ${subPath}/WM_FODs_norm.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_det_rk4_dynamic_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_det_rk4_seed_1M.tck ]; then
        tckgen -algorithm SD_STREAM -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -rk4 -seed_grid_per_voxel ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz 2 ${subPath}/WM_FODs_norm.mif ${subPath}/track_det_rk4_seed_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_det_rk4_dynamic_1M_step_30.tck ]; then
        tckgen -algorithm SD_STREAM -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -select 1M -rk4 -seed_dynamic ${subPath}/WM_FODs_norm.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_det_rk4_dynamic_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_det_rk4_seed_1M_step_30.tck ]; then
        tckgen -algorithm SD_STREAM -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -rk4 -seed_grid_per_voxel ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz 2 ${subPath}/WM_FODs_norm.mif ${subPath}/track_det_rk4_seed_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_det_rk4_wmgmi_1M.tck ]; then
        tckgen -algorithm SD_STREAM -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -rk4 -seed_gmwmi ${subPath2}/gmwmi.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_det_rk4_wmgmi_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_det_rk4_wmgmi_1M_step_30.tck ]; then
        tckgen -algorithm SD_STREAM -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -select 1M -rk4 -seed_gmwmi ${subPath2}/gmwmi.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_det_rk4_wmgmi_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod1_rk4_dynamic_1M.tck ]; then
        tckgen -algorithm iFOD1 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -rk4 -seed_dynamic ${subPath}/WM_FODs_norm.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod1_rk4_dynamic_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod1_rk4_seed_1M.tck ]; then
        tckgen -algorithm iFOD1 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -rk4 -seed_grid_per_voxel ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz 2 ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod1_rk4_seed_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod1_rk4_dynamic_1M_step_30.tck ]; then
        tckgen -algorithm iFOD1 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -select 1M -rk4 -seed_dynamic ${subPath}/WM_FODs_norm.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod1_rk4_dynamic_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod1_rk4_seed_1M_step_30.tck ]; then
        tckgen -algorithm iFOD1 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -rk4 -seed_grid_per_voxel ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz 2 ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod1_rk4_seed_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod1_rk4_wmgmi_1M.tck ]; then
        tckgen -algorithm iFOD1 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -rk4 -seed_gmwmi ${subPath2}/gmwmi.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod1_rk4_wmgmi_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod1_rk4_wmgmi_1M_step_30.tck ]; then
        tckgen -algorithm iFOD1 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 30 -select 1M -rk4 -seed_gmwmi ${subPath2}/gmwmi.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod1_rk4_wmgmi_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod2_rk4_dynamic_1M.tck ]; then
        tckgen -algorithm iFOD2 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -seed_dynamic ${subPath}/WM_FODs_norm.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod2_rk4_dynamic_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod2_rk4_seed_1M.tck ]; then
        tckgen -algorithm iFOD2 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -seed_grid_per_voxel ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz 2 ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod2_rk4_seed_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod2_rk4_dynamic_1M_step_30.tck ]; then
        tckgen -algorithm iFOD2 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 60 -select 1M -seed_dynamic ${subPath}/WM_FODs_norm.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod2_rk4_dynamic_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod2_rk4_seed_1M_step_30.tck ]; then
        tckgen -algorithm iFOD2 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 60 -seed_grid_per_voxel ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz 2 ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod2_rk4_seed_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod2_rk4_wmgmi_1M.tck ]; then
        tckgen -algorithm iFOD2 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -select 1M -seed_gmwmi ${subPath2}/gmwmi.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod2_rk4_wmgmi_1M.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
        if [ ! -f ${subPath}/track_ifod2_rk4_wmgmi_1M_step_30.tck ]; then
        tckgen -algorithm iFOD2 -act ${subPath2}/5TT.mif -crop_at_gmwmi -cutoff 0.01 -angle 60 -select 1M -seed_gmwmi ${subPath2}/gmwmi.mif ${subPath}/WM_FODs_norm.mif ${subPath}/track_ifod2_rk4_wmgmi_1M_step_30.tck -mask ${Path}/${subj}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz -minlength 20 -maxlength 250 -nthreads 4 -quiet > /dev/null 2>&1
        fi
    fi
    echo >&3 
}&
done < subject_7T.txt
wait

stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
exec 3<&-
exec 3>&-

