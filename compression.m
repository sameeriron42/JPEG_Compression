clc;
close all;
I=imread("images\food.jpg");

%Convert rgb image to YCbCr image
YCbCr=rgb2ycbcr(I);

%Downsampling of blue and red chrominance
%smoothen the image before downsampling
filtr=ones(4,4)/16;
cb=conv2(YCbCr(:,:,2),filtr);
cr=conv2(YCbCr(:,:,2),filtr);
%In a block of 2x2 taking only the fourth/last value
for i=2:2:size(YCbCr,1)
    for j=2:2:size(YCbCr,2)
        CbDown(i/2,j/2)=cb(i,j);
        CrDown(i/2,j/2)=cr(i,j);
    end
end

