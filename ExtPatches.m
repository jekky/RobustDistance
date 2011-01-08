function patches = ExtPatches(img,psize,offset)


% claculate lbp image
mapping = getmapping(8,'u2');
lbpImg = lbp(img,1,8,mapping,'i');

patches = [];
x = [0:30:255];
bin = 16;
angle = 360;
L=0;
for j = floor(psize(1)/2)+1 : offset : size(img,1)-floor(psize(1)/2)
    for i = floor(psize(2)/2)+1 : offset : size(img,2)-floor(psize(2)/2)
        patch = img(j-floor(psize(1)/2):j+floor(psize(1)/2),i-floor(psize(2)/2):i+floor(psize(2)/2));
        intensityHist = hist(patch(:),x);
        lbpPatch = lbpImg(j-floor(psize(1)/2)+1:j+floor(psize(1)/2)-1,i-floor(psize(2)/2)+1:i+floor(psize(2)/2)-1);
        lbpHist = hist(lbpPatch(:),[0:mapping.num-1]);
        
        roi = [j-floor(psize(1)/2);j+floor(psize(1)/2);i-floor(psize(2)/2);i+floor(psize(2)/2)];
        p = anna_phog(img,bin,angle,L,roi);
        patches = [patches;[intensityHist,lbpHist]];
    end
end

