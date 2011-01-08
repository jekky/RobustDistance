function obj_bw_face(sImgFile)

I=imread(sImgFile);
BW = im2bw(I, graythresh(rgb2gray(I)))
figure;
subplot(1,2,1),imshow(I);
subplot(1,2,2),imshow(BW);