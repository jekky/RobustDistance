function [corres_score,corres_x,corres_y] = RecordCandiCorres(img1,patches1,img2,patches2,opts)

D=EuDist2(patches1,patches2);
D = exp(-D/(2));
sample_y = floor(opts.psize(1)/2)+1 : opts.offset : size(img1,1)-floor(opts.psize(1)/2);
sample_x = floor(opts.psize(2)/2)+1 : opts.offset : size(img1,2)-floor(opts.psize(2)/2);

corres_score = [];
corres_x = [];
corres_y = [];

for idx = 1 : size(patches1,1)
    y1_idx = floor(idx./length(sample_x));
    x1_idx = idx-length(sample_x).*y1_idx;
    y1_idx(x1_idx==0) = y1_idx(x1_idx==0)-1;
    x1_idx(x1_idx==0) = length(sample_x);
    [s_D,D_idx] = sort(D(idx,:),'descend');
    y2_idx = floor(D_idx(1:opts.k)./length(sample_x));
    x2_idx = D_idx(1:opts.k)-length(sample_x).*y2_idx;
    y2_idx(x2_idx==0) = y2_idx(x2_idx==0)-1;
    x2_idx(x2_idx==0) = length(sample_x);
    
    corres_score = [corres_score;(s_D(1:opts.k))'];
    corres_x = [corres_x;[repmat(sample_x(x1_idx),[opts.k,1]),(sample_x(x2_idx))']];
    corres_y = [corres_y;[repmat(sample_y(y1_idx+1),[opts.k,1]),(sample_y(y2_idx+1))']];
end