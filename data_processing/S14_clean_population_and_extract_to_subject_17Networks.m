clear all; clc;

Path = '/media/wuye/UG4/HCP4Atlas';
List = importdata('subject_7T.txt');
addpath('/home/wuye/Software/mrtrix3/matlab');
nodes = importdata('/home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_17Networks_and_sgm_nodes.txt');
outPath = fullfile(Path,'Population_17Networks');
mkdir(outPath);
ns = length(List);
order = 4;

for i = 29:length(nodes)
    disp(i)

    % load group streamline
    h5filename = fullfile(outPath,strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'track_native_rs_in_yeo_space.h5');
    streamlines = h5read(h5filename,'/cosine');

    labelfilename_1 = fullfile(outPath,strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'track_native_rs_in_yeo_space_label_1.h5');
    labelfilename_2 = fullfile(outPath,strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'track_native_rs_in_yeo_space_label_2.h5');

    label_1 = h5read(labelfilename_1,'/train_data');
    label_2 = h5read(labelfilename_2,'/train_data');

    num_1 = max(label_1)+1;
    
    for j = 0:num_1-1
        num_2 = max(label_2(label_1==j)) + 1;

        for k = 0:num_2-1
            ind = find(label_1==j & label_2==k);
            temp = label_2(ind);
            data = streamlines(:,ind);

            if isempty(data)
                continue;
            end

            [~,~,~,D1] = kmeans(data',1,'Distance', 'sqeuclidean','Replicates',2);

            data(11,:) = [];
            data(6,:) = [];
            data(1,:) = [];

            [~,~,~,D3] = kmeans(data',1,'Distance', 'sqeuclidean','Replicates',2);
            DZ1 = zscore(D1);
            DZ3 = zscore(D3);
    
            temp2 = (DZ1 > 0.5 | DZ3 > 0.5);
            temp(temp2) = -1;
            label_2(ind) = temp;
            fprintf('%s: Removed outlier streamline %2d \n',datetime('now'),round(100*sum(temp2)/length(temp2),2));
        
            clear DZ1 DZ3 ind temp temp2
        end
        clear data
    end
    labelfilename = fullfile(outPath,strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'track_native_rs_in_yeo_space_label_3.h5');
    h5create(labelfilename,'/label',size(label_2));
    h5write(labelfilename, '/label', label_2);

    %% extract         

    load(fullfile(outPath,strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'track_native_rs_in_yeo_space.mat'));
    tnum = 1;

    for v = 1:length(List)
        filename = fullfile(Path,List{v},'Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'track_native_rs_in_yeo_space.tck');
        outPath2 = fullfile(Path,List{v},'Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'cluster_in_yeo_space');
        mkdir(outPath2);

        individual_label_1 = label_1(group_fiber{tnum});
        individual_label_2 = label_2(group_fiber{tnum});

        individual_track = read_mrtrix_tracks(filename);
        individual_track = individual_track.data;
        
        for j = 0:num_1-1
            num_2 = max(label_2(label_1==j))+1;

            for k = 0:num_2-1
                ind = find(label_1==j & label_2==k);

                fib = [];
                fib.data = individual_track(individual_label_1==j & individual_label_2==k);
                fib.count = length(fib);
                if fib.count > 0
                    write_mrtrix_tracks(fib,fullfile(outPath2,strcat('cluster_',num2str(j),'_',num2str(k),'.tck')));
                else
                    fib.data = cell(0);
                    fib.count = 0;
                    write_mrtrix_tracks(fib,fullfile(outPath2,strcat('cluster_',num2str(j),'_',num2str(k),'.tck')));
                end
            end
        end
        tnum = tnum + 1;
    end
end

