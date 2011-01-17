function [dist1,dist2] = RobustDist(imgFile1,imgFile2)

opts.k = 10;
opts.psize = [7,7];
opts.offset = 2;

I1 = imread(imgFile1);  
if (size(I1,3)>1)
    I1 = rgb2gray(I1);
end
patches1 = ExtPatches(I1,opts.psize,opts.offset);
I2 = imread(imgFile2);  
if (size(I2,3)>1)
    I2 = rgb2gray(I2);
end
patches2 = ExtPatches(I2,opts.psize,opts.offset);

[sim,anchor1,anchor2]=ScCorres(I1,patches1,I2,patches2,opts);
sbof1 = LinearProj(I1,anchor1,opts);
sbof2 = LinearProj(I2,anchor2,opts);
%dist2 = polygon(I1,anchor1,I2,anchor2,opts);

% for idx = 1 : 90 : length(sbof1)
%     intersectDist = sum(min([sbof1(idx:idx+89);sbof2(idx:idx+89)]))
%     l2Dist = norm(sbof1(idx:idx+89)-sbof2(idx:idx+89))
% end
dist1 = sum(min([sbof1;sbof2]))./length(sbof1);
%fprintf('The similarity is %f ...\n',dist1);
dist2 = norm(sbof1-sbof2)/length(sbof1);
%dist2 = norm(double(I1(:))-double(I2(:)));
%fprintf('The dist is %f ...\n',dist2);
%fprintf('The L2 dist is %f ...\n',norm(double(I1(:))-double(I2(:))));


