%Seperating RGB channels from an image
close all;
%read image file
img= imread("images/rgb1.png");

%split rgb components using
%R= img(:,:,1); red channel
%G= img(:,:,2); green channel
%B= img(:,:,3); blue channel
%or
[R,G,B]=imsplit(img);

%plotting R,G,B channels alone shows only intensity for each spectrum as a
%grayscale image, compose channel with reduntant black channel

Black= zeros(size(img,1),size(img,2));

% Create color versions of the individual color channels.
Rimg=cat(3,R,Black,Black);
Gimg=cat(3,Black,G,Black);
Bimg=cat(3,Black,Black,B);

%display original image at centre and 3 rgb color images below it
fontSize=20;
subplot(2,3,2);
imshow(img);
title('RGB channels seperated','FontSize',fontSize);

subplot(2,3,4);
imshow(Rimg);
title('Red Channel in Red', 'FontSize', fontSize)

subplot(2,3,5);
imshow(Gimg);
title('Green Channel in Green', 'FontSize', fontSize)

subplot(2,3,6);
imshow(Bimg);
title('Blue Channel in Blue', 'FontSize', fontSize)
