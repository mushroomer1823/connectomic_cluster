function S10_fiber_encoding()

Path = '/media/wuye/UG4/HCP4Atlas';
List = importdata('subject_7T.txt');
addpath('/home/wuye/Software/mrtrix3/matlab');
addpath('/home/wuye/D_disk/Source/COMEDI/package/COSINE');

nodes = importdata('/home/wuye/D_disk/Atlas/Yeo/MNI/Centroid_coordinates_100/Schaefer2018_100Parcels_17Networks_and_sgm_nodes.txt');

for i = 120:length(List)
    disp(List{i})
    parfor j = 1:length(nodes)
        filename = fullfile(Path,List{i},'Parcels_17Networks',strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3))),'track_native_rs_in_yeo_space.tck');
        h5filename = fullfile(Path,List{i},'Parcels_17Networks',strcat(num2str(nodes(j,2)),'_',num2str(nodes(j,3))),'track_native_rs_in_yeo_space.h5');

        fiber_encoding(filename,h5filename);
    end    
end
end

function fiber_encoding(filename,h5filename)

    tck = read_mrtrix_tracks(filename);
    order = 4;

    tract = tck.data;
    nfib = length(tract);
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
    
    h5create(h5filename,'/cosine',size(data));
    h5write(h5filename, '/cosine', data);
    clear data;
end
