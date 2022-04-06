%RGB from image

img= imread("flower1.jpg");

[R,G,B]=imsplit(img);
%plotting R,G,B channels alone shows only intensity for each spectrum as a
%grayscale image, compose channel with reduntant black channel

Black= zeros(size(img,1),size(img,2));

Rimg=cat(3,R,Black,Black);
Gimg=cat(3,Black,G,Black);
Bimg=cat(3,Black,Black,B);
%{
Rimg=R;
Gimg=G;
Bimg=B;
%}
subplot(2,3,2);
imshow(img);
subplot(2,3,4);
imshow(Rimg);
subplot(2,3,5);
imshow(Gimg);
subplot(2,3,6);
imshow(Bimg);
title('RGB channels seperated');