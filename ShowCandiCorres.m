function ShowCandiCorres(img1,patches1,img2,patches2,opts)

D=EuDist2(patches1,patches2);
D=EuDist2(patches1,patches2);
D = exp(-D/(2));
sample_y = floor(opts.psize(1)/2)+1 : opts.offset : size(img1,1)-floor(opts.psize(1)/2);
sample_x = floor(opts.psize(2)/2)+1 : opts.offset : size(img1,2)-floor(opts.psize(2)/2);

for idx = 1 : size(patches1,1)
    y1_idx = floor(idx./length(sample_x));
    x1_idx = idx-length(sample_x).*y1_idx;
    y1_idx(x1_idx==0) = y1_idx(x1_idx==0)-1;
    x1_idx(x1_idx==0) = length(sample_x);
    [s_D,D_idx] = sort(D(idx,:),'descend');
    s_D(1)
    y2_idx = floor(D_idx(1:opts.k)./length(sample_x));
    x2_idx = D_idx(1:opts.k)-length(sample_x).*y2_idx;
    y2_idx(x2_idx==0) = y2_idx(x2_idx==0)-1;
    x2_idx(x2_idx==0) = length(sample_x);
    close all;
    figure;
    imshow(img1);
    hold on;
    plot(sample_x(x1_idx),sample_y(y1_idx+1),'xr');
    figure;
    imshow(img2);
    hold on;
    plot(sample_x(x2_idx),sample_y(y2_idx+1),'xr');
    pause();
end