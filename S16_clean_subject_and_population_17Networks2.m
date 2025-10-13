clear all; clc;
dataPath = '/media/wuye/UG1/HCP4Atlas';
Path = '/media/wuye/UG4/HCP4Atlas';
List = importdata('subject_7T.txt');
addpath('/home/wuye/Software/mrtrix3/matlab');
addpath('/home/wuye/D_disk/Source/COMEDI/package/COSINE');
nodes = importdata('/home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_17Networks_and_sgm_nodes.txt');

order = 4;

for i = 1:1
    for j = 1:length(List)
        disp(List{j})
        subPath = fullfile(Path,List{j},'Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'cluster_in_yeo_space');
        outPath = fullfile(Path,List{j},'Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'Cluster');
        mkdir(outPath);

        temp = dir(fullfile(subPath,'*.tck'));
        num = length(temp);
                
        for u = 1:num
            filename = fullfile(subPath,temp(u).name);
            filename2 = fullfile(outPath,'temp.tck');

            warp = fullfile(dataPath,strrep(List{j},'7T','3T'),'proc','Yeo','mrtrix_warp_corrected_for_track_Atlas2Sub.mif');
            commandline = ['/home/wuye/Software/miniconda3/bin/tcktransform ',filename,' ',warp,' ',filename2,' -force -quiet'];
            system(commandline);

            tck = read_mrtrix_tracks(filename2);

            tract = tck.data;
            nfib = length(tract);
            if nfib < 2
                copyfile(filename2,fullfile(outPath,temp(u).name));  
                delete(filename2);

                continue;
            end
            m = (order+1)*3;
            data = single(zeros(m,nfib));
            
            for idx = 1:nfib
                fib = tract{idx};
                len = max(size(fib));
                lmax = min(len,order);
            
                if max(size(fib)) < 3
                    continue
                end
            
                fib(isnan(fib)|isinf(fib)) = 0;
            
                if isequal(size(fib,1),3)
                    fib = fib';
                end
            
                [~,para] = parameterize_arclength(fib');
                try
                    [~,X] = WFS_tracts(fib',para,lmax);
                    data(:,idx) = [reshape(X,(lmax+1)*3,1);zeros(m-(lmax+1)*3,1)];
                catch
                    continue;
                end
            end
        
            ind2 = true(nfib,1);
            for k = 1:15
                [~,~,~,D1] = kmeans(data(k,:)',1,'Distance', 'sqeuclidean','Replicates',2);
                ind2 = ind2 & (zscore(D1) < 1.5);
            end

            [~,~,~,D1] = kmeans(data',1,'Distance', 'sqeuclidean','Replicates',2);
        
            data(11,:) = [];
            data(6,:) = [];
            data(1,:) = [];
        
            [~,~,~,D3] = kmeans(data',1,'Distance', 'sqeuclidean','Replicates',2);
        
            DZ1 = zscore(D1);
            DZ3 = zscore(D3);
            ind2 = DZ1 < 0.5 & DZ3 < 0.5 & ind2;
            
            fprintf('%s: Removed outlier streamline %2d \n',datetime('now'),round(100*sum(~ind2)/length(ind2),2));

            fib = [];
            fib.data = tract(ind2);
            fib.count = length(fib.data);
            if fib.count > 0
                write_mrtrix_tracks(fib,fullfile(outPath,temp(u).name));
            else
                fib.data = cell(0);
                fib.count = 0;
                write_mrtrix_tracks(fib,fullfile(outPath,temp(u).name));
            end
            delete(filename2);
        end
    end


    for j = 1:length(List)
        subPath = fullfile(Path,List{j},'Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'Cluster');
        outPath = fullfile(Path,List{j},'Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'Cluster_clean_in_yeo_space');
        mkdir(outPath);

        temp = dir(fullfile(subPath,'*.tck'));
        num = length(temp);
                
        for u = 1:num
            filename = fullfile(subPath,temp(u).name);
            filename2 = fullfile(outPath,temp(u).name);
            warp = fullfile(dataPath,strrep(List{j},'7T','3T'),'proc','Yeo','mrtrix_warp_corrected_for_track_Sub2Atlas.mif');
            commandline = ['/home/wuye/Software/miniconda3/bin/tcktransform ',filename,' ',warp,' ',filename2,' -force -quiet'];
            system(commandline);
        end
    end

    subPath = fullfile(Path,List{1},'Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'Cluster_clean_in_yeo_space');
    outPath = fullfile(Path,'Population_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'Cluster_clean_in_yeo_space');
    mkdir(outPath);

    temp = dir(fullfile(subPath,'*.tck'));
    num = length(temp);

    for u = 1:num
        filename = fullfile(Path,'*','7T','*','Parcels_17Networks',strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'Cluster_clean_in_yeo_space',temp(u).name);
        filename2 = fullfile(outPath,'temp.tck');

        commandline = ['/home/wuye/Software/miniconda3/bin/tckedit ',filename,' ',filename2,' -force -quiet'];
        system(commandline);
        
        tck = read_mrtrix_tracks(filename2);
    
        tract = tck.data;
        nfib = length(tract);
        if nfib < 2
            copyfile(filename2,fullfile(outPath,temp(u).name));  
            delete(filename2);
            
            continue;
        end
        m = (order+1)*3;
        data = single(zeros(m,nfib));
        
        for idx = 1:nfib
            fib = tract{idx};
            len = max(size(fib));
            lmax = min(len,order);
        
            if max(size(fib)) < 3
                continue
            end
        
            fib(isnan(fib)|isinf(fib)) = 0;
        
            if isequal(size(fib,1),3)
                fib = fib';
            end
        
            [~,para] = parameterize_arclength(fib');
            try
                [~,X] = WFS_tracts(fib',para,lmax);
                data(:,idx) = [reshape(X,(lmax+1)*3,1);zeros(m-(lmax+1)*3,1)];
            catch
                continue;
            end
        end
    
        ind2 = true(nfib,1);
        for k = 1:15
            [~,~,~,D1] = kmeans(data(k,:)',1,'Distance', 'sqeuclidean','Replicates',2);
            ind2 = ind2 & (zscore(D1) < 1.5);
        end
    
        [~,~,~,D1] = kmeans(data',1,'Distance', 'sqeuclidean','Replicates',2);
    
        data(11,:) = [];
        data(6,:) = [];
        data(1,:) = [];
    
        [~,~,~,D3] = kmeans(data',1,'Distance', 'sqeuclidean','Replicates',2);
    
        DZ1 = zscore(D1);
        DZ3 = zscore(D3);
        ind2 = DZ1 < 0.5 & DZ3 < 0.5 & ind2;
        
        % fprintf('%s: Removed outlier streamline %2d \n',datetime('now'),round(100*sum(~ind2)/length(ind2),2));
    
        fib = [];
        fib.data = tract(ind2);
        fib.count = length(fib.data);
        if fib.count > 0
            write_mrtrix_tracks(fib,fullfile(outPath,temp(u).name));
        else
            fib.data = cell(0);
            fib.count = 0;
            write_mrtrix_tracks(fib,fullfile(outPath,temp(u).name));
        end

        delete(fullfile(outPath,'temp.tck'));
    end
end
