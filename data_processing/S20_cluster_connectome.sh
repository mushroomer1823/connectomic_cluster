Path=/media/wuye/UG3/reserved_fibers
outPath=/media/wuye/UG3/reserved_fibers_connectome
mkdir -p ${outPath}
for i in `ls ${Path}/`
do
    mkdir -p ${outPath}/${i}
    for j in `ls ${Path}/${i}/`
    do
        mkdir -p ${outPath}/${i}/${j}
        for k in `ls ${Path}/${i}/${j}/`
        do
            tck2connectome ${Path}/${i}/${j}/${k} /home/wuye/D_disk/Atlas/MNI/nodes_fixSGM.nii.gz ${outPath}/${i}/${j}/${k%????}.csv -assignment_radial_search 4 -symmetric 
        done
    done 
done
