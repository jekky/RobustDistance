function accuracy = eval_classification(resultFile)

probeLabels = [];
for idx = 1 : 47
    probeLabels = [probeLabels;idx.*ones(6,1)];
end

galleryLabels = [];
for idx = 1 : 47
    galleryLabels = [galleryLabels;idx.*ones(3,1)];
end

load(resultFile);

nnIdxArray = nnIdxArray-2;
correctNum = sum(galleryLabels(nnIdxArray)-probeLabels==0);
accuracy = correctNum/length(probeLabels);