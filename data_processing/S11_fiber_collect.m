clear all; clc;

Path = '/media/wuye/UG4/HCP4Atlas';
List = importdata('subject_7T.txt');
addpath('/home/wuye/Software/mrtrix3/matlab');
nodes = importdata('/home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_17Networks_and_sgm_nodes.txt');
outPath = fullfile(Path,'Population_17Networks');
mkdir(outPath);
ns = length(List);
order = 4;

for j = 1:length(nodes)
    disp(j)
    mkdir(fullfile(outPath,strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3)))));

    group_fiber = cell(1,ns);
    streamline = single(zeros((order+1)*3,2000000*ns));
    num_str = 1;
    num = 1;

    for i = 1:length(List)
        filename = fullfile(Path,List{i},'Parcels_17Networks',strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3))),'track_native_rs_in_yeo_space.h5');

        data = h5read(filename,'/cosine');
        nfib = size(data,2);
        num_end = num_str + nfib - 1;
        group_fiber{1,num} = num_str:num_end;
        streamline(:,num_str:num_end) = data;

        num = num + 1;
        num_str = num_end + 1;
        clear data;
    end

    streamline = streamline(:,1:num_end);
    streamline([1 order+2 2*(order+1)+1],:) = streamline([1 order+2 2*(order+1)+1],:)*2;
    h5filename = fullfile(outPath,strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3))),'track_native_rs_in_yeo_space.h5');
    matfilename = fullfile(outPath,strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3))),'track_native_rs_in_yeo_space.mat');
    save(matfilename,'group_fiber','-v7.3');

    h5create(h5filename,'/cosine',size(streamline));
    h5write(h5filename, '/cosine', streamline);

    clear streamline

end
