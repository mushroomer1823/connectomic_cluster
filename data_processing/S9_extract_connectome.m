clear all; clc;

Path = '/media/wuye/UG1/HCP4Atlas';
outPath = '/media/wuye/UG4/HCP4Atlas';

List = importdata('subject_7T.txt');
addpath('/home/wuye/Software/mrtrix3/matlab');
nodes = importdata('/home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_17Networks_and_sgm_nodes.txt');

for i = 1:length(List)
    filename = fullfile(Path,List{i},'Yeo','track_native_rs_in_yeo_space.tck');
    if ~exist(filename,'file')
        continue;
    end
    tck = read_mrtrix_tracks(filename);
    tck = tck.data';
    filename = fullfile(Path,List{i},'Yeo','track_native_rs_in_yeo_space_connectome_100Parcels_17Networks.txt');
    ass = importdata(filename);
    ass = ass.data;
    ind = ass(:,1) > ass(:,2);
    ass(ind,:) = fliplr(ass(ind,:));
    
    mkdir(fullfile(outPath,List{i},'Parcels_17Networks'));

    for j = 1:length(nodes)
        disp(strcat(List{i},' : ',num2str(nodes(j,1))));

        ind1 = ismember(ass,[nodes(j,2) nodes(j,3)],'rows');
        mkdir(fullfile(outPath,List{i},'Parcels_17Networks',strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3)))));
        fib = [];
        fib.data = tck(ind1);
        fib.count = length(fib.data);
        write_mrtrix_tracks(fib,fullfile(outPath,List{i},'Parcels_17Networks',strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3))),'track_native_rs_in_yeo_space.tck'));
    end
    clear tck
end

