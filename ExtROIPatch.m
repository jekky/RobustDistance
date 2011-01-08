function descriptor = ExtROIPatch(img,mask)

x = [0:20:255];
descriptor = [hist(img(find(mask>0)),x)];