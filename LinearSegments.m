function segDiff = LinearSegments(img1, anchor1, img2, anchor2, opts)

% claculate lbp image
mapping = getmapping(8,'u2');
lbpImg1 = lbp(img1,1,8,mapping,'i');
lbpImg2 = lbp(img2,1,8,mapping,'i');

feaInterval = [0:30:255];

sbof = [];
segDiff = 0;
segNum = 0;
for idx_x1 = 1 : size(anchor1,1)
    for idx_x2 = idx_x1+1 : size(anchor1,1)
        %
        p1=[anchor1(idx_x1,1),anchor1(idx_x1,2),1];
        p2=[anchor1(idx_x2,1),anchor1(idx_x2,2),1];
        
        lineseg1 = LineSegment(img1,p1,p2);
        
        p1=[anchor2(idx_x1,1),anchor2(idx_x1,2),1];
        p2=[anchor2(idx_x2,1),anchor2(idx_x2,2),1];
        
        lineseg2 = LineSegment(img2,p1,p2);
        
        %
        if (length(lineseg1)>length(lineseg2))
            step = (length(lineseg2)-1)/(length(lineseg1)-1);
            lineseg2 = interp1([1:length(lineseg2)],lineseg2,[1:step:length(lineseg2)]);
        else
            step = (length(lineseg1)-1)/(length(lineseg2)-1);
            lineseg1 = interp1([1:length(lineseg1)],double(lineseg1),[1:step:length(lineseg1)]);
        end
        
        segDiff = segDiff+sum((lineseg1-lineseg2).^2)/length(lineseg1);
        segNum = segNum+1;
            
    end
end

segDiff = segDiff/segNum;


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


