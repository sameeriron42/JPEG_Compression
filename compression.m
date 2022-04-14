clc;
close all;
I=imread("images\flower1.jpg");

%Convert rgb image to YCbCr image
YCbCr=rgb2ycbcr(I);

%Downsampling of blue and red chrominance
%smoothen the image before downsampling
filtr=ones(4,4)/16;
cb=conv2(YCbCr(:,:,2),filtr);
cr=conv2(YCbCr(:,:,2),filtr);
CbDown=zeros(round(size(cb)/2));
CrDown=zeros(round(size(cr)/2));

%In a block of 2x2 taking only the fourth/last value
for i=2:2:size(YCbCr,1)
    for j=2:2:size(YCbCr,2)
        CbDown(i/2,j/2)=cb(i,j);
        CrDown(i/2,j/2)=cr(i,j);
    end
end

%Performing Discrete cosine Transform
Q = [16 11 10 16 24 40 51 61 ;
     12 12 14 19 26 28 60 55 ;
     14 13 16 24 40 57 69 56 ;
     14 17 22 29 51 87 80 62 ;
     18 22 37 56 68 109 103 77 ;
     24 35 55 64 81 104 113 92 ;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
channel=[1:3];
blocksize=8;
[row, col]=size(YCbCr,1,2);
dct_coeff=zeros([row col]);
dct_quantized=dct_coeff;
dct_dequant=dct_coeff;
idct_signal=dct_coeff;

for i=1:blocksize:row
    for j=1:blocksize:col
        %forward DCT on blocks of 8 for luminance
        dct_coeff(i:i+blocksize-1,j:j+blocksize-1)=dct2(YCbCr(i:i+blocksize-1,j:j+blocksize-1,1));
        %quantizing with Q matrix
        dct_quantized(i:i+blocksize-1,j:j+blocksize-1)=round(dct_coeff(i:i+blocksize-1,j:j+blocksize-1)./Q);
        %de-quantizing and performing inverse DCT
        dct_dequant(i:i+blocksize-1,j:j+blocksize-1)=Q.*dct_quantized(i:i+blocksize-1,j:j+blocksize-1);
        idct_signal(i:i+blocksize-1,j:j+blocksize-1)=idct2(dct_dequant(i:i+blocksize-1,j:j+blocksize-1));
    end
end


compressed_img=cat(3,idct_signal,YCbCr(:,:,2),YCbCr(:,:,3));
subplot(1,2,1)
title('orginal')
imshow(I);
subplot(1,2,2)
title('compress')
X=ycbcr2rgb(compressed_img);
imshow(X);
imwrite(X,'compress.jpg');



























