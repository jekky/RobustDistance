function [nnIdx,distArray] = RobustNNSearch(imgFile,galleryDir)

files = dir(galleryDir);

distArray = [];
nnIdx = 0;
nnDist = inf;
for idx = 1 : length(files)
    if (files(idx).isdir==0)
        %[dist1,dist2] = RobustDist(imgFile,[galleryDir,files(idx).name]);
        %dist2 = StructDistance(imgFile,[galleryDir,files(idx).name]);
        
        I1 = imread(imgFile);
        if (size(I1,3)>1)
            I1 = rgb2gray(I1);
        end
        I2 = imread([galleryDir,files(idx).name]);
        if (size(I2,3)>1)
            I2 = rgb2gray(I2);
        end
        dist2 = norm(double(I1(:))-double(I2(:)));
        
        distArray = [distArray;dist2];
        fprintf('The dist to %s is %f ...\n',files(idx).name,dist2);
        if (dist2<nnDist)
            nnDist = dist2;
            nnIdx = idx;
        end
    end
end

fprintf('The nearest neighbor of %s is %s ...\n',imgFile,files(nnIdx).name);