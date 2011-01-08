function [sim,anchor_points1,anchor_points2] = ScCorres(I1, patches1, I2, patches2, opts)


[corres_score,corres_x,corres_y] = RecordCandiCorres(I1,patches1,I2,patches2,opts);
A = DynAffniMatrix(corres_score,corres_x,corres_y);
% [vColMax,vColIdx] = max(A);
% [fMaxVal,iRowIdx] = max(vColMax);


x0 = ones(size(A,1),1);
% x0(iRowIdx) = 0.5;
% x0(vColIdx(iRowIdx))=0.5;
x0 = x0./sum(x0);

[sim,x] = ReplicatorEq(A,x0);
%sim = length(find(x>0.01));

sim = sum(corres_score);
[a,b] = sort(x,'descend');
anchor_idx = b(1:10);
anchor_points1 = [corres_x(anchor_idx,1),corres_y(anchor_idx,1)];
anchor_points2 = [corres_x(anchor_idx,2),corres_y(anchor_idx,2)];

[b1,m1,n1] = unique(anchor_points1, 'rows');
[b2,m2,n2] = unique(anchor_points2, 'rows');

anchor_points1 = anchor_points1(intersect(m1,m2),:);
anchor_points2 = anchor_points2(intersect(m1,m2),:);


[s_x,s_idx] = sort(x,'descend');
%x(s_idx(31:end)) = 0;
x'*A*x;
sum(x.*corres_score);

dist = 0;
for idx = 1 : length(x)
    patch1 = I1(corres_y(idx,1)-floor(opts.psize(1)/2):corres_y(idx,1)+floor(opts.psize(1)/2),corres_x(idx,1)-floor(opts.psize(2)/2):corres_x(idx,1)+floor(opts.psize(2)/2));
    patch2 = I2(corres_y(idx,2)-floor(opts.psize(1)/2):corres_y(idx,2)+floor(opts.psize(1)/2),corres_x(idx,2)-floor(opts.psize(2)/2):corres_x(idx,2)+floor(opts.psize(2)/2));
    dist = dist + norm(double(patch1(:))-double(patch2(:)));
end


% for idx = 1 : size(anchor_points1,1)
%     close all;
%     figure(1),imshow(I1);
%     hold on;
%     plot(anchor_points1(idx,1)',anchor_points1(idx,2)','xr');
%     figure(2),imshow(I2);
%     hold on;
%     plot(anchor_points2(idx,1)',anchor_points2(idx,2)','xr');
%     corres_score(s_idx(idx))
%     pause();
% end
