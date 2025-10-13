Path=/media/wuye/UG4/HCP4Atlas/Population_17Networks
Path2=/home/wuye/lab/Population_17Networks
for i in `ls ${Path}/`
do
    echo ${i}  
    cp ${Path2}/${i}/track_native_rs_in_yeo_space_label_*.h5  ${Path}/${i}/
done
