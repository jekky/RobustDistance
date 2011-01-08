function sbof = LinearProj(img1, anchor1, opts)

% claculate lbp image
mapping = getmapping(8,'u2');
lbpImg1 = lbp(img1,1,8,mapping,'i');
%lbpImg2 = lbp(img2,1,8,mapping,'i');

feaInterval = [15:30:255];

img = img1;
sbof = [];
%segDiff = 0;
%segNum = 0;
for idx_x1 = 1 : size(anchor1,1)
    for idx_x2 = idx_x1+1 : size(anchor1,1)
        %
        p1=[anchor1(idx_x1,1),anchor1(idx_x1,2),1];
        p2=[anchor1(idx_x2,1),anchor1(idx_x2,2),1];
        
%         lineseg1 = LineSegment(img1,p1,p2);
%         
%         p1=[anchor2(idx_x1,1),anchor2(idx_x1,2),1];
%         p2=[anchor2(idx_x2,1),anchor2(idx_x2,2),1];
%         
%         lineseg2 = LineSegment(img2,p1,p2);
%         
%         %
%         if (length(lineseg1)>length(lineseg2))
%             step = (length(lineseg2)-1)/(length(lineseg1)-1);
%             lineseg2 = interp1([1:length(lineseg2)],lineseg2,[1:step:length(lineseg2)]);
%         else
%             step = (length(lineseg1)-1)/(length(lineseg2)-1);
%             lineseg1 = interp1([1:length(lineseg1)],double(lineseg1),[1:step:length(lineseg1)]);
%         end
%         
%         segDiff = segDiff+sum((lineseg1-lineseg2).^2)/length(lineseg1);
%         segNum = segNum+1;
            
        L=p2-p1; U=L/norm(L);
        
        %
        [X, Y] = meshgrid([2:size(img,2)-1],[2:size(img,1)-1]);
        p3 = [X(:),Y(:),ones((size(img,1)-2)*(size(img,2)-2),1)];
        p=repmat(p1,[size(p3,1),1])+(p3-repmat(p1,[size(p3,1),1]))*U'*U;
        x=p(:,1); y=p(:,2); z=p(:,3);
        
        %
        refPoint = [0.5*(anchor1(idx_x1,1)+anchor1(idx_x2,1)),...
            0.5*(anchor1(idx_x1,2)+anchor1(idx_x2,2))];
        dist = sqrt(sum((repmat(refPoint,[size(p,1),1])-[x,y]).^2,2));
        sign = ones(size(p,1),1);
        sign(x<repmat(refPoint(1),[size(p,1),1])) = -1;
        dist = dist.*sign;
        
        %
        p=repmat(p1,[size(p3,1),1])+(p3-repmat(p1,[size(p3,1),1]))-(p3-repmat(p1,[size(p3,1),1]))*U'*U;
        x=p(:,1); y=p(:,2); z=p(:,3);
        %
        dist2 = sqrt(sum((repmat(p1(1:2),[size(p,1),1])-[x,y]).^2,2));
        sign = ones(size(p,1),1);
        sign(x<repmat(p1(1),[size(p,1),1])) = -1;
        dist2 = dist2.*sign;        
        
        %
        binNum = 10;
        spatialInterval = (max(dist)-min(dist))/binNum;
        spatialInterval2 = (max(dist2)-min(dist2))/1;
        for sidx = 1 : binNum
            for sidx2 = 1 : 1
                if (sidx<binNum)
                    %binIdx = find(dist>=min(dist)+(sidx-1)*spatialInterval & dist<min(dist)+sidx*spatialInterval);
                    binIdx = find(dist>=min(dist)+(sidx-1)*spatialInterval & dist<min(dist)+sidx*spatialInterval & ...
                                  dist2>=min(dist2)+(sidx2-1)*spatialInterval2 & dist2<min(dist2)+sidx2*spatialInterval2);
                else
                    %binIdx = find(dist>=min(dist)+(sidx-1)*spatialInterval & dist<=max(dist));
                    binIdx = find(dist>=min(dist)+(sidx-1)*spatialInterval & dist<=max(dist) & ...
                                  dist2>=min(dist2)+(sidx2-1)*spatialInterval2 & dist2<=max(dist2));
                end
                if (length(binIdx)>0)
                    intensityHist = hist(img(binIdx),feaInterval);
                    lbpHist = hist(lbpImg1(binIdx),[0:mapping.num-1]);
                else
                    intensityHist = zeros(1,length(feaInterval));
                    lbpHist = zeros(1,mapping.num);
                end
                %sbof = [sbof,intensityHist];
                sbof = [sbof,intensityHist,lbpHist];
            end
        end
    end
end

%segDiff = segDiff/segNum;


function lineseg = LineSegment(img,p1,p2)

% only check the line segment
if (p1(1)~=p2(1))
    slope = (p2(2)-p1(2))/(p2(1)-p1(1));
    if (p2(1)>p1(1))
        x = [0:p2(1)-p1(1)];
    else
        x = [0:-1:p2(1)-p1(1)];
    end
    y = slope.*x+p1(2);
    y = round(y);
    y(y<1) = 1; y(y>size(img,1)) = size(img,1);
    x = x+p1(1);
else
    if (p1(2)<=p2(2))
        y = [p1(2):p2(2)];
    else
        y = [p1(2):-1:p2(2)];
    end
    x = p1(1).*ones(size(y));
end

idices = sub2ind(size(img),y,x);
lineseg = double(img(idices));
%figure,imshow(lineseg);


