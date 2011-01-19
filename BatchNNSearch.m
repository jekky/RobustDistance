function BatchNNSearch(probeDir,galleryDir,databaseName)

probeFiles = dir(probeDir);

nnIdxArray = [];
for idx = 1 : length(probeFiles)
    if (probeFiles(idx).isdir==0)
        [nnIdx,distArray] = RobustNNSearch([probeDir,probeFiles(idx).name],galleryDir);
        nnIdxArray = [nnIdxArray;nnIdx];
    end
end

save(['./',databaseName,'_l2.mat'],'nnIdxArray');