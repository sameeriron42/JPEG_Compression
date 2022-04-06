close all;
clc;
a=imread('Screen.png');
r=255;
c=r;
%[r,c]=size(a)
k=0;
img= uint8(zeros(r,c));
for i= 1:r
    for j= 1:c
        img(i,j)=k;
        k=k+1;
    end
    k=0;
end
figure,imshow(img)

