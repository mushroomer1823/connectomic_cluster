#!/bin/bash
start_time=`date +%s`

Path=/home/wuye/E_disk
Atlas=/home/wuye/D_disk/Atlas/Yeo/MNI152_T1_1mm_brain.nii.gz

[ -e /tmp/fd9 ] || mkfifo /tmp/fd9 
exec 3<>/tmp/fd9
rm -rf /tmp/fd9
for ((i=1;i<=10;i++))
do
    echo >&3
done

while read i
do
read -u3
{
    subPath=${Path}/${i:0:6}
    mkdir -p ${subPath}/proc

    T1=${subPath}/T1w/T1w_acpc_dc_restore_brain.nii.gz
    rm -r ${subPath}/proc/Yeo
    mkdir -p ${subPath}/proc/Yeo
    ANTS 3 -m PR[${Atlas},${T1},1,2] -o ${subPath}/proc/Yeo/Sub2Atlas.nii -i 30x99x11 -t SyN[0.5] -r Gauss[2,0] --use-Histogram-Matching --continue-affine true  > /dev/null 2>&1
    ANTS 3 -m PR[${T1},${Atlas},1,2] -o ${subPath}/proc/Yeo/Atlas2Sub.nii -i 30x99x11 -t SyN[0.5] -r Gauss[2,0] --use-Histogram-Matching --continue-affine true  > /dev/null 2>&1

    warpinit ${Atlas} ${subPath}/proc/Yeo/identity_warp[].nii   > /dev/null 2>&1
    for j in `seq 0 2`
    do
    WarpImageMultiTransform 3 ${subPath}/proc/Yeo/identity_warp${j}.nii ${subPath}/proc/Yeo/mrtrix_warp${j}.nii -R ${T1} ${subPath}/proc/Yeo/Atlas2SubWarp.nii ${subPath}/proc/Yeo/Atlas2SubAffine.txt > /dev/null 2>&1
    done
    warpcorrect ${subPath}/proc/Yeo/mrtrix_warp[].nii ${subPath}/proc/Yeo/mrtrix_warp_corrected_for_track_Sub2Atlas.mif  > /dev/null 2>&1 
    rm ${subPath}/proc/Yeo/identity_warp*
    rm ${subPath}/proc/Yeo/mrtrix_warp*.nii

    warpinit ${T1} ${subPath}/proc/Yeo/identity_warp[].nii   > /dev/null 2>&1
    for j in `seq 0 2`
    do
    WarpImageMultiTransform 3 ${subPath}/proc/Yeo/identity_warp${j}.nii ${subPath}/proc/Yeo/mrtrix_warp${j}.nii -R ${Atlas} ${subPath}/proc/Yeo/Sub2AtlasWarp.nii ${subPath}/proc/Yeo/Sub2AtlasAffine.txt > /dev/null 2>&1
    done
    warpcorrect ${subPath}/proc/Yeo/mrtrix_warp[].nii ${subPath}/proc/Yeo/mrtrix_warp_corrected_for_track_Atlas2Sub.mif   > /dev/null 2>&1
    rm ${subPath}/proc/Yeo/identity_warp*
    rm ${subPath}/proc/Yeo/mrtrix_warp*.nii

    echo >&3 
}&
done < subject_7T.txt
wait

stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
exec 3<&-
exec 3>&-
