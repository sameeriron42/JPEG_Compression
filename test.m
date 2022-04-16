close all;
clc;

%a=imread('images/raw/');
a=raw2rgb('images\raw\raw.NEF');
%imshow(a);
b=imcrop(a,[1 1,size(a,2) size(a,1)]);
figure;
temp=imfinfo('images\raw\_MG_7267.CR2').FileSize;
size1=round(temp/1024^2,2);
size2=round(imfinfo('result.jpg').FileSize/1024^2,2);
string1 = {'the original size',strcat(string(size1),' MB')};
string2 = {'the compressed size',strcat(string(size2),' MB')'};
string3 = {'Compression factor',strcat(string(round(size1/size2)),'X')};
subplot(1,2,1),imshow(a);
title('Original Image','FontSize',16);
annotation('textbox',[0.25 0.01 0.8 0.1],'String',string1,'FitBoxToText','on','FontSize',16);
subplot(1,2,2),imshow(b);
title('Compressed Image','FontSize',16);
annotation('textbox',[0.68 0.01 0.8 0.1],'String',string2,'FitBoxToText','on','FontSize',16);
annotation('textbox',[0.12 0.44 0.8 0.1],'String',string3,'FitBoxToText','on','FontSize',16,'HorizontalAlignment','center');

%{
a=2
b=(zeros(1,16));
for i=[1:16]
    b(i)=a^i;
end
b
%}
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
%figure,imshow(img)

