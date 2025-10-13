clear all; clc;
Path = '/media/wuye/UG4/HCP4Atlas/Population_7Networks';
addpath('/home/wuye/Software/mrtrix3/matlab');
addpath('/home/wuye/D_disk/Source/COMEDI/package/COSINE');
nodes = importdata('/home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_7Networks_and_sgm_nodes.txt');
order = 4;

nodeIndex = zeros(100000,1);
node1 = zeros(100000,1);
node2 = zeros(100000,1);
nodeList = cell(100000,1);
tckName = cell(100000,1);
swmProb = zeros(100000,1);
tbl = table(nodeIndex,node1,node2,nodeList,tckName,swmProb);

ntbl = 1;
for i = 1:length(nodes)
    subPath = fullfile(Path,strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3))),'Cluster_clean_in_yeo_space');
    List = dir(fullfile(subPath,'*.tck'));
    num = length(List);
    disp(i)
                
    for u = 1:num
        tbl.nodeIndex(ntbl) = nodes(i,1);
        tbl.node1(ntbl) = nodes(i,2);
        tbl.node2(ntbl) = nodes(i,3);
        tbl.nodeList{ntbl} = strcat(num2str(nodes(i,2)),'_',num2str(nodes(i,3)));

        filename = fullfile(subPath,List(u).name);
        tck = read_mrtrix_tracks(filename);
        tbl.tckName{ntbl} = List(u).name;
        
        try
        fib_length = cellfun(@(x)sum(vecnorm(diff(x),2,2)),tck.data);
        % 
        R = cellfun(@(x)sum(sign(x(:,1))<0),tck.data);
        L = cellfun(@(x)sum(sign(x(:,1))>0),tck.data);
    
        min_RL = min([R;L]);
        max_RL = max([R;L]);
    
        fib_enddis = cellfun(@(x)pdist2(x(1,:),x(end,:)),tck.data);
        fib_middis = cellfun(@(x)pdist2(x(1,:),x(round(end/2),:)),tck.data) + ....
                   cellfun(@(x)pdist2(x(round(end/2),:),x(end,:)),tck.data);
    
        ratio_middis_length = fib_middis./fib_length;
        ratio_middis_enddis = fib_middis./fib_enddis;
        ratio_length_enddis = fib_length./fib_enddis;
        ratio_cc = min_RL./max_RL;
    
        % SWM
        ind_SWM = (ratio_middis_length' <2 & fib_length'>15 & fib_length'<85 & ratio_middis_enddis'>1.1 & ratio_length_enddis'>1.1 & (ratio_cc < 0.01)');
        tbl.swmProb(ntbl) = sum(ind_SWM)/length(ind_SWM);

        if tbl.swmProb(ntbl) > 0.9
            disp(strcat(tbl.nodeList{ntbl},' : ',List(u).name,' : ',num2str(tbl.swmProb(ntbl))));
        end

        catch
            disp(strcat(tbl.nodeList{ntbl},' : ',List(u).name));
        end

        ntbl = ntbl + 1;
    end
end
tbl(ntbl:end,:) = [];
writetable(tbl,'selectSWM.csv')


