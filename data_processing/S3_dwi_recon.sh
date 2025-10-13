#!/bin/bash
start_time=`date +%s`

Path=/home/wuye/E_disk

[ -e /tmp/fd8 ] || mkfifo /tmp/fd8 
exec 3<>/tmp/fd8
rm -rf /tmp/fd8
for ((i=1;i<=2;i++))
do
    echo >&3
done

while read i
do
read -u3
{
    subPath=${Path}/${i:0:6}
	mkdir -p ${subPath}/proc
    if [ ! -f ${subPath}/proc/WM_FODs_7T_norm.mif ]; then
        rm ${subPath}/proc/*.mif
        rm ${subPath}/proc/*.txt
        5ttgen freesurfer ${subPath}/T1w/aparc+aseg.nii.gz ${subPath}/proc/5TT.mif -sgm_amyg_hipp -nocrop -lut /usr/local/freesurfer/7.4.1/FreeSurferColorLUT.txt
        mrconvert ${subPath}/T1w/Diffusion_7T/data.nii.gz ${subPath}/proc/DWI_7T.mif -fslgrad ${subPath}/T1w/Diffusion_7T/bvecs ${subPath}/T1w/Diffusion_7T/bvals -datatype float32 -strides 0,0,0,1
        dwi2response msmt_5tt ${subPath}/proc/DWI_7T.mif ${subPath}/proc/5TT.mif ${subPath}/proc/RF_WM_7T.txt ${subPath}/proc/RF_GM_7T.txt ${subPath}/proc/RF_CSF_7T.txt
        dwi2fod msmt_csd ${subPath}/proc/DWI_7T.mif ${subPath}/proc/RF_WM_7T.txt ${subPath}/proc/WM_FODs_7T.mif ${subPath}/proc/RF_GM_7T.txt ${subPath}/proc/GM_7T.mif ${subPath}/proc/RF_CSF_7T.txt ${subPath}/proc/CSF_7T.mif -mask ${subPath}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz
        mtnormalise ${subPath}/proc/WM_FODs_7T.mif ${subPath}/proc/WM_FODs_7T_norm.mif ${subPath}/proc/GM_7T.mif ${subPath}/proc/GM_7T_norm.mif ${subPath}/proc/CSF_7T.mif ${subPath}/proc/CSF_7T_norm.mif -mask ${subPath}/T1w/Diffusion_7T/nodif_brain_mask.nii.gz

        rm ${subPath}/proc/WM_FODs_7T.mif
        rm ${subPath}/proc/GM_7T.mif 
        rm ${subPath}/proc/CSF_7T.mif
    fi

    echo >&3 
}&
done < subject_7T.txt
wait

stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
exec 3<&-
exec 3>&-
 
