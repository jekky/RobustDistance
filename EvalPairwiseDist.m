function EvalPairwiseDist(sFolder)

opts.k=1;
opts.psize=[11,11];
opts.offset = 2;
class_num = 47;
inst_num_per_class = 9;


cFiles = dir(sFolder);

% ground-truth
labels = [];
for idx = 1 : class_num
    labels = [labels;idx*ones(inst_num_per_class,1)];
end

patches = cell(size(labels));
imgs = cell(size(labels));
filenames = cell(size(labels));
cur_idx = 1;
for idx = 1 : length(cFiles)
    if (cFiles(idx).isdir==0)
        I = imread([sFolder,cFiles(idx).name]);
        imgs{cur_idx} = I;
        patch = ExtPatches(I,opts.psize,opts.offset);
        patches{cur_idx} = patch;        
        filenames{cur_idx} = cFiles(idx).name;
        cur_idx = cur_idx+1;
    end
end

nn_results = [];
for idx1 = 1 : size(labels,1)
    class_sim = zeros(class_num,1);
    inst_num = zeros(class_num,1);
    for idx2 = 1 : size(labels,1)
        if idx1~=idx2
            sim = ScCorres(imgs{idx1},patches{idx1},imgs{idx2},patches{idx2}, opts);
            fprintf('The similarity between %s and %s is %f ...\n',filenames{idx1},filenames{idx2},sim);
            class_sim(labels(idx2)) = class_sim(labels(idx2))+sim;
            inst_num(labels(idx2)) = inst_num(labels(idx2))+1;
        end
    end    
    [nn_sim,nn_class] = max(class_sim./inst_num);
    fprintf('%s is classified to class %d ...\n',filenames{idx1},nn_class);
end