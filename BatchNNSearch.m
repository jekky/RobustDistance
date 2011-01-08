function BatchNNSearch(probeDir,galleryDir)

probeFiles = dir(probeDir);

nnIdxArray = [];
for idx = 1 : length(probeFiles)
    if (probeFiles(idx).isdir==0)
        [nnIdx,distArray] = RobustNNSearch([probeDir,probeFiles(idx).name],galleryDir);
        nnIdxArray = [nnIdxArray;nnIdx];
    end
end

save('./youtube_1_l2.mat','nnIdxArray');