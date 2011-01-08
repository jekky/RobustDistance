function dist = StructDistance(imgFile1,imgFile2)

I1=imread(imgFile1);
I1=rgb2gray(I1);
G1=ConnectGraph(I1);
structs1 = GetStructure(G1,I1);
[structCodes1,structLens1] = StructsStatistics(structs1,G1,I1);

I2=imread(imgFile2);
I2=rgb2gray(I2);
G2=ConnectGraph(I2);
structs2 = GetStructure(G2,I2);
[structCodes2,structLens2] = StructsStatistics(structs2,G2,I2);

D=EuDist2(structCodes1,structCodes2);
dist = sum(min(D,[],2));